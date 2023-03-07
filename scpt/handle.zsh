#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
$dd/target/debug/atr a
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
h=https://$host/xrpc
url="$h/com.atproto.handle.resolve?handle=syui.bsky.social"
curl -sL $url|jq .


