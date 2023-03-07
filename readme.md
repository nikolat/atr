my design icon : /icon

### example

```sh
# packages/dev-env/src/index.ts
`http://${process.env.HOSTNAME}:${this.port}`
dbPostgresUrl: process.env.DB_POSTGRES_URL
const db = plc.Database.memory()

$ lerna run verify
availableUserDomains: ['.test','.example.com']
```

http command : https://httpie.io/cli

```sh
$ curl -sL "https://bsky.social/xrpc/com.atproto.repo.describe?user=syui.bsky.social"|jq .
or
$ http get https://bsky.social/xrpc/com.atproto.repo.describe user==syui.bsky.social

$ curl -sL "https://bsky.social/xrpc/com.atproto.repo.listRecords?user=syui.bsky.social&collection=app.bsky.feed.post"|jq .
or
$ http get https://bsky.social/xrpc/com.atproto.repo.listRecords user==syui.bsky.social collection==app.bsky.feed.post
```

```sh
# com.atproto.session.create
$ host=bsky.social
$ user=syui
$ pass=xxx
$ curl -X POST -H "Content-Type: application/json" -d "{\"handle\":\"$user.$host\",\"password\":\"$pass\"}" https://$host/xrpc/com.atproto.session.create
```

```sh
# com.atproto.repo.createRecord
url=https://$host/xrpc/com.atproto.repo.createRecord

json='{
"did": "did:plc:uqzpqmrjnptsxezjx4xuh2mn",
"collection": "app.bsky.feed.post",
"record": {
  "text": "t",
  "createdAt": "2023-02-25T05:06:50.330Z",
  "$type": "app.bsky.feed.post"
 }
}'

echo $json|jq .

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$json" $url
```

media-file : jpg, jpeg

```sh
# com.atproto.blob.upload
# com.atproto.repo.createRecord

# time-iso8601
date=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

mtype=image/jpeg
host=bsky.social
did=`cat ~/.config/atr/token.json|jq -r .did`
token=`cat ~/.config/atr/token.json|jq -r .accessJwt`
col=app.bsky.feed.post
url=https://$host/xrpc/com.atproto.blob.upload
t=`curl -sL -X POST -H "Content-Type: $mtype" -H "Authorization: Bearer $token" --data-binary "@$f" $url`
cid=`echo $t|jq -r .cid`

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

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d "$json" $url
```

post link, mention

```json
{
    "did": "",
        "collection": "",
        "record": {
            "text": "",
            "createdAt": "",
            "entities": [
            {
                "type": "link",
                "index": {
                    "end": 119,
                    "start": 71
                },
                "value": "https://atproto.com/lexicons/com-atproto-session"
            }
            ]
        }
}
```

```json
{
    "did": "",
        "collection": "",
        "record": {
            "text": "",
            "createdAt": "",

            "entities": [
            {
                "type": "mention",
                "index": {
                    "end": 19,
                    "start": 0
                },
                "value": "did:plc:opfkqvrr3g3wazzjqcnxkaqy"
            }
            ]
        }
}
```

### ref

- https://atproto.com

- https://bsky.app

- https://atproto.com/lexicons/com-atproto-session

- https://github.com/bluesky-social/atproto
