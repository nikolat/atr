#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
#$dd/target/debug/atr a
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
host=https://$host/xrpc
url=$host/app.bsky.feed.getTimeline
curl -sL -X GET -H "Authorization: Bearer $token" $url|jq .
