#!/bin/bash
set -e

ROOT="$HOME/repos/deluxedeals-net"
DATA="$ROOT/products.json"
OUT="$ROOT/pages/products"

echo "[SETUP] mkdir…"
mkdir -p "$OUT"

echo "[BUILD] product pages…"
jq -c '.products[]' "$DATA" | while read item; do
  id=$(echo "$item" | jq -r '.id')
  name=$(echo "$item" | jq -r '.name')
  img=$(echo "$item" | jq -r '.img')
  url=$(echo "$item" | jq -r '.url')

  cat > "$OUT/$id.html" <<HTML
<!DOCTYPE html>
<html><body>
<h1>$name</h1>
<img src="$img" width="300">
<p><a href="$url" target="_blank">Buy on Amazon</a></p>
</body></html>
HTML
done

echo "[GRID] rebuilding product_grid.html"
cat > "$ROOT/pages/product_grid.html" <<HTML
<!DOCTYPE html><html><body><h1>Products</h1><ul>
HTML

for f in "$OUT"/*.html; do
  b=$(basename "$f")
  echo "<li><a href=\"/products/$b\">$b</a></li>" \
    >> "$ROOT/pages/product_grid.html"
done

echo "</ul></body></html>" >> "$ROOT/pages/product_grid.html"

cd "$ROOT"
git add .
git commit -m "Auto-gen product pages"
git push
echo "[OK] Render will redeploy automatically."
