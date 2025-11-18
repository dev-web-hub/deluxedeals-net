#!/bin/bash
set -e

echo "[STRUCTURE] Creating folder tree…"

mkdir -p pages campaigns/stage_A campaigns/stage_B campaigns/stage_C campaigns/stage_D
mkdir -p assets/chess/v1/png
mkdir -p static css js

echo "[PLACEHOLDERS] Adding minimal files…"

# Pages
touch pages/index.html pages/chess_v1_preview.html pages/funnel_landing.html pages/product_grid.html

# Campaigns
touch campaigns/qualified_funnel_architecture.md
cat > campaigns/campaign_index.json <<'JEOF'
{
  "campaigns": [
    { "id": "chess-gear", "stage": "A", "path": "stage_A/" },
    { "id": "study-planner", "stage": "B", "path": "stage_B/" },
    { "id": "mini-course", "stage": "C", "path": "stage_C/" }
  ]
}
JEOF

# Static
echo "/* base styles */" > static/styles.css
touch static/favicon.ico

# Render config
cat > render.yaml <<'REOF'
services:
  - type: web
    name: deluxedeals-net
    env: static
    buildCommand: ""
    staticPublishPath: "pages"
    routes:
      - src: /.*
        dest: /index.html
REOF

echo "[DONE] Scaffold ready."
