#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
$dd/target/debug/atr a
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
h=https://$host/xrpc
if [ -z "$1" ];then
	url="$h/app.bsky.actor.getProfile?actor=syui.$host"
else
	url="$h/app.bsky.actor.getProfile?actor=$1.$host"
fi
curl -sL -X GET -H "Authorization: Bearer $token" $url|jq .
