#!/bin/bash

set -x

BASE_PATH="/home/dany/git"
PULL_REPO="${BASE_PATH}/dimo-tv"
POST_PULL_SCRIPT="${BASE_PATH}/scripts/replace_old_channel_urls.sh"

COMMIT_REPO="${BASE_PATH}/dany-tv"
FILE_TO_ADD="${COMMIT_REPO}/Russia.m3u8"
COMMIT_MSG="updatet channels"

echo "Checking repo to pull: $PULL_REPO"
cd "$PULL_REPO"

git rev-parse --is-inside-work-tree >/dev/null 2>&1
git fetch

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [[ "$LOCAL" == "$REMOTE" ]]; then
  echo "Already up to date. Nothing to do."
  exit 0
elif [[ "$LOCAL" == "$BASE" ]]; then
  echo "Remote has changes. Pulling..."
  git pull
else
  echo "No pull possible automatically (local ahead or diverged)."
  exit 1
fi

echo "Running post-pull script..."
bash "$POST_PULL_SCRIPT"

echo "Switching to commit repo: $COMMIT_REPO"
cd "$COMMIT_REPO"

git rev-parse --is-inside-work-tree >/dev/null 2>&1

git add "$FILE_TO_ADD"

if ! git diff --cached --quiet; then
  git commit -m "$COMMIT_MSG"
  git push
  echo "Changes committed and pushed in second repo."
else
  echo "No changes to commit in second repo."
fi