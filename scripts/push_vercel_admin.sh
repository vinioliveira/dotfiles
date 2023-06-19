#!/bin/sh

read -p "Commit SHA1: " SHA1
read -p "branch SHA1: " BRANCH
read -p "target TARGET: " TARGET

# BRANCH="ENG-1595-no-subs"
TEAM="team_nMhna6Q3TW6ksYrX8PRuT8P4"
VERCEL_TOKEN="F7TMGHopC2pdVq0H0blJ9bAt"
# TARGET="preview"

curl -s -X POST "https://api.vercel.com/v13/now/deployments?teamId=team_nMhna6Q3TW6ksYrX8PRuT8P4&forceNew=1" \
  -H "Authorization: bearer $VERCEL_TOKEN" \
  -H 'Content-Type: application/json; charset=utf-8' \
  --data-raw "{ \
    \"name\": \"admin\", \
    \"target\": \"$TARGET\", \
    \"gitSource\": { \
	    \"type\": \"github\", \
	    \"org\": \"copy-ai\", \
	    \"repo\": \"copy-ai\", \
	    \"ref\": \"$BRANCH\", \
	    \"sha\": \"$SHA1\" \
		 } \
	}"
