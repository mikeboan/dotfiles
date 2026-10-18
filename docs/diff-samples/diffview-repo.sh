#!/usr/bin/env bash
# Builds a throwaway git repo with before.ts committed and after.ts as the
# working-tree change, plus a brand-new file, then opens Diffview on it.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
repo="$(mktemp -d)/diff-samples"
mkdir -p "$repo" && cd "$repo"
git init -q
cp "$here/before.ts" invite.ts
git add . && git commit -qm before
cp "$here/after.ts" invite.ts
cp "$here/after.ts" new-file.ts && git add -N new-file.ts
exec nvim -c DiffviewOpen
