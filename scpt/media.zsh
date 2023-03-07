#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
if [ -z "$1" ];then
	echo arg
	exit
fi

#$dd/target/debug/atr a
#brew install coreutils
#PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
date=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

f=$1
text=$2

mtype=image/jpeg
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
col=app.bsky.feed.post
url=https://$host/xrpc/com.atproto.blob.upload
if [ ! -f $d/media.json ];then
	t=`curl -sL -X POST -H "Content-Type: $mtype" -H "Authorization: Bearer $token" --data-binary "@$f" $url`
	echo "$t"|jq . >! $d/media.json
fi
cid=`cat $d/media.json|jq -r .cid`

url=https://$host/xrpc/com.atproto.repo.createRecord
type='$type'
types=app.bsky.embed.images
json="{
  \"did\": \"$did\",
  \"collection\": \"$col\",
  \"record\": {
    \"text\": \"$text\",
    \"createdAt\": \"$date\",
    \"$type\": \"$col\",
				\"embed\": {
				  \"$type\": \"$types\",
				  \"images\": [
				    {
				      \"image\": {
				        \"cid\": \"$cid\",
				        \"mimeType\": \"$mtype\"
				      },
				      \"alt\": \"\"
				    }
				  ]
				}
  }
}"

if echo $json|jq . > /dev/null;then
	curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$json" $url
	rm $d/media.json
fi
