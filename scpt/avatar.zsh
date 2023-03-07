#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}
$dd/target/debug/atr a

if [ -z "$1" ];then
	exit
fi
f=$1

mtype=image/png
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

h=https://$host/xrpc/com.atproto.repo.strongRef
h=https://$host/xrpc/com.atproto.sync.getRepo
curl -sL "$h?did=$did"

h=https://$host/xrpc/com.atproto.sync.getRoot
curl -sL "$h?did=$did"

exit
h=https://$host/xrpc/app.bsky.actor.updateProfile
json="{
  \"did\": \"$did\",
  \"avatar\": { 
				  \"images\": [
				    {
				      \"image\": {

				        \"cid\": \"$cid\",
				        \"mimeType\": \"$mtype\"
											}
										}
										]
									}
}"

if echo $json|jq .;then
	curl -sL -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$json" $url|jq .
fi
