#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="${PROJECT_NAME:-idkit-standalone-partner-flow}"
BRANCH="${BRANCH:-takis/partner-standalone-flow-example}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
ASSETS_DIR="${ASSETS_DIR:-${REPO_ROOT}/examples/with-partner-standalone}"

echo "Cloudflare Pages project: ${PROJECT_NAME}"
echo "Deploy branch: ${BRANCH}"
echo "Assets directory: ${ASSETS_DIR}"

npx --yes wrangler whoami >/dev/null

if npx --yes wrangler pages project list --json | node -e 'const projectName = process.argv[1]; let input = ""; process.stdin.on("data", chunk => (input += chunk)); process.stdin.on("end", () => { const projects = JSON.parse(input); process.exit(projects.some(project => project["Project Name"] === projectName) ? 0 : 1); });' "$PROJECT_NAME"; then
	echo "Pages project already exists."
else
	echo "Creating Pages project..."
	npx --yes wrangler pages project create "$PROJECT_NAME" --production-branch "$BRANCH"
fi

npx --yes wrangler pages deploy "$ASSETS_DIR" \
	--project-name "$PROJECT_NAME" \
	--branch "$BRANCH" \
	--commit-dirty=true \
	"$@"
