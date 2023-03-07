#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
$dd/target/debug/atr a
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
rkey=`cat ~/.config/atr/token.json|jq -r .refreshJwt`
h=https://$host/xrpc

col=app.bsky.feed.post
cid=3jq3wukkfg22r
u=syui.bsky.social
url="$h/com.atproto.repo.getRecord?user=$u&collection=$col&rkey=$rkey&cid=$cid"
curl -sL -X GET -H "Authorization: Bearer $token" $url|jq .
