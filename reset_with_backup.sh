#!/usr/bin/env bash
set -euo pipefail

ORG="scaredsmoke-star"
REPO="SacredSmoke-backup"
FEATURE_BRANCH="feature/backup"
DEFAULT_BRANCH="copilot/clone-backup-repo"

if git show-ref --verify --quiet "refs/remotes/origin/${FEATURE_BRANCH}"; then
  if git show-ref --verify --quiet "refs/heads/${FEATURE_BRANCH}"; then
    git checkout "${FEATURE_BRANCH}"
    git reset --mixed "origin/${FEATURE_BRANCH}" || true
  else
    git checkout -t "origin/${FEATURE_BRANCH}"
  fi
else
  git fetch origin "${DEFAULT_BRANCH}" || true
  git checkout -b "${FEATURE_BRANCH}" "origin/${DEFAULT_BRANCH}" 2>/dev/null || git checkout -b "${FEATURE_BRANCH}"
fi
