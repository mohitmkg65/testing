#!/bin/bash

echo "==> Syncing main project to submodule (shared-lib)..."

# Step 1: Use rsync to copy everything (excluding submodule itself and git configs)
rsync -av --delete ./ ./shared-lib \
  --exclude shared-lib \
  --exclude .git \
  --exclude .gitmodules \
  --exclude sync-to-submodule.sh

# Step 2: Commit changes inside submodule
cd shared-lib
git add .
git commit -m "Auto-sync from main project"
git push origin main

# Step 3: Return and update submodule pointer in main project
cd ..
git add shared-lib
git commit -m "Update submodule to latest synced commit"
git push origin main

echo "✅ Sync complete."