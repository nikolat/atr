#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
$dd/target/debug/atr a
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
col=app.bsky.feed.post
url=https://$host/xrpc/com.atproto.handle.update
json="{\"handle\":\"syui.cf\"}"
echo $json|jq .
curl -sL -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$json" $url
