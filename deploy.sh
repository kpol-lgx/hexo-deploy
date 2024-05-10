#!/bin/bash

sudo apt -y install git curl

# install nvs for manage node.js
export NVS_HOME="$HOME/.nvs"
if [ -d "$NVS_HOME" ]; then
    echo "destination path ${NVS_HOME} already exists and is not an empty directory"
else
    git clone https://github.com/jasongin/nvs "$NVS_HOME"
fi
. "$NVS_HOME/nvs.sh" install

# add node.js and use it
nvs add lts && nvs link lts

# install hexo
npm install -g hexo-cli

# hexo deploy
cd ~
mkdir -v hexo
npx hexo init hexo
cd hexo
    npm install
cd ..

# add node_modules to path
# then replace 'npx hexo' with 'hexo'
if grep -qF 'PATH="$PATH:./node_modules/.bin"' ~/.profile; then
  echo "has exist! node_modules to path in ~/.profile"
else
  echo 'PATH="$PATH:./node_modules/.bin"' >> ~/.profile
  echo "has append! node_modules to path in ~/.profile"
fi
