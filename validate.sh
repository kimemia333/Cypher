#!/bin/bash

# Get repository name from Heroku remote (fallback to folder name)
REPO_NAME=$(basename `git rev-parse --show-toplevel`)

# Allowed repo names
ALLOWED1="CypherX"
ALLOWED2="XPLOADER--BOT"

# Check if repo name is allowed
if [[ "$REPO_NAME" != "$ALLOWED1" && "$REPO_NAME" != "$ALLOWED2" ]]; then
  echo "❌ Error: Your repo must be named 'CypherX' or 'XPLOADER--BOT'"
  exit 1
fi

# Check GitHub username
if [ -z "$GITHUB_USERNAME" ]; then
  echo "❌ Error: Missing GITHUB_USERNAME"
  exit 1
fi

# Use GitHub API to verify ownership
REPO_EXISTS=$(curl -s https://api.github.com/repos/$GITHUB_USERNAME/$REPO_NAME | grep full_name)

if [[ "$REPO_EXISTS" == "" ]]; then
  echo "❌ Error: GitHub repo not found under username '$GITHUB_USERNAME'"
  exit 1
fi

echo "✅ All checks passed. Proceeding..."
