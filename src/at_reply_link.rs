extern crate reqwest;
use crate::token_toml;
use crate::url;
use serde_json::json;
use iso8601_timestamp::Timestamp;

pub async fn post_request(text: String, link: String, s: i32, e: i32, cid: String, uri: String) -> String {

    let token = token_toml(&"access");
    let did = token_toml(&"did");
    let handle = token_toml(&"handle");

    let url = url(&"record_create");
    let col = "app.bsky.feed.post".to_string();

    let d = Timestamp::now_utc();
    let d = d.to_string();

    let post = Some(json!({
        "repo": handle.to_string(),
        "did": did.to_string(),
        "collection": col.to_string(),
        "record": {
            "text": link.to_string() + &" ".to_string() + &text.to_string(),
            "createdAt": d.to_string(),
            "reply": {
                "root": {
                    "cid": cid.to_string(),
                    "uri": uri.to_string()
                },
                "parent": {
                    "cid": cid.to_string(),
                    "uri": uri.to_string()
                }
            },
            "entities": [
            {
                "type": "link".to_string(),
                "index": {
                    "end": e,
                    "start": s
                },
                "value": link.to_string()
            }
            ],
        },
    }));

    let client = reqwest::Client::new();
    let res = client
        .post(url)
        .json(&post)
        .header("Authorization", "Bearer ".to_owned() + &token)
        .send()
        .await
        .unwrap()
        .text()
        .await
        .unwrap();

    return res
}
