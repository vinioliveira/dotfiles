#!/bin/sh

# read -p "Commit SHA1: " SHA1

PR_NUMBER="5643"
BRANCH="ben/package-bumps"
TEAM="team_nMhna6Q3TW6ksYrX8PRuT8P4"
VERCEL_TOKEN="F7TMGHopC2pdVq0H0blJ9bAt"
TARGET="production"

curl -s -X POST "https://api.vercel.com/v13/now/deployments?teamId=team_nMhna6Q3TW6ksYrX8PRuT8P4&forceNew=1" \
  -H "Authorization: bearer $VERCEL_TOKEN" \
  -H 'Content-Type: application/json; charset=utf-8' \
  --data-raw "{ \
    \"name\": \"web-app\", \
    \"gitSource\": { \
	    \"type\": \"github\", \
	    \"org\": \"copy-ai\", \
	    \"repo\": \"copy-ai\", \
	    \"ref\": \"$BRANCH\", \
      \"prId\": \"$PR_NUMBER\" \
		 } \
	}"
