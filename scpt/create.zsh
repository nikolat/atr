#!/bin/zsh
d=${0:a:h}
dd=${0:a:h:h}

if [ -z "$1" || -z "$2" || -z "$3" || -z "$4"];then
	echo arg
	exit
fi
host=bsky.social
url=https://$host/xrpc/com.atproto.account.create
json="{
\"handle\": \"$1\",
\"password\": \"$2\",
\"email\": \"$3\",
\"inviteCode\": \"$4\"
}"

echo $json|jq .
curl -sL -X POST -H "Content-Type: application/json" -d "$json" $url
