extern crate reqwest;
use crate::token_toml;
use crate::url;
use serde_json::json;
use iso8601_timestamp::Timestamp;

//use crate::data::Follow;

pub async fn post_request(u: String) -> String {

    let token = token_toml(&"access");
    let did = token_toml(&"did");
    let handle = token_toml(&"handle");

    let url = url(&"record_create");
    let col = "app.bsky.graph.follow".to_string();

    let d = Timestamp::now_utc();
    let d = d.to_string();

    let post = Some(json!({
        "repo": handle.to_string(),
        "did": did.to_string(),
        "collection": col.to_string(),
        "record": {
            "subject": u.to_string(),
            "createdAt": d.to_string(),
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

pub async fn delete_request(u: String, rkey: String) -> String {

    let token = token_toml(&"access");
    let did = token_toml(&"did");
    let handle = token_toml(&"handle");

    let url = url(&"record_delete");
    let col = "app.bsky.graph.follow".to_string();

    let d = Timestamp::now_utc();
    let d = d.to_string();

    let post = Some(json!({
        "repo": handle.to_string(),
        "did": did.to_string(),
        "collection": col.to_string(),
        "rkey": rkey.to_string(),
        "record": {
            "subject": u.to_string(),
            "createdAt": d.to_string(),
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
