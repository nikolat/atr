#!/bin/zsh

d=${0:a:h}
dd=${0:a:h:h}
if [ ! -d $d/atproto/.git ];then
	git clone https://github.com/bluesky-social/atproto
else 
	cd $d/atproto
	git pull
fi

cd $d
cp -rf $d/index.ts $d/atproto/packages/dev-env/src/index.ts
cp -rf $d/.env $d/atproto/packages/pds
cp -rf $d/.env $d/atproto/packages/plc

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
nvm use 18
npm i -g node-gyp
npm i -g npm
npm i -g lerna
npm i
lerna run build

# cd $dd;fly deploy
