#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
if [ -z "$1" ];then
	echo arg
	exit
fi
$dd/target/debug/atr a
#brew install coreutils
#PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
date=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
text=$@

host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
col=app.bsky.feed.post
url=https://$host/xrpc/com.atproto.repo.createRecord
type='$type'
json="{\"did\":\"$did\", \"collection\":\"$col\", \"record\": {\"text\":\"$text\",\"createdAt\":\"$date\",\"$type\":\"$col\"}}"
echo $json|jq .
curl -sL -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$json" $url
