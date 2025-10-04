#!/bin/bash
[ -d /opt/websockproxy/nodejs ] && ( cd /opt/websockproxy/nodejs;unset npm_config_prefix;. ~/.nvm/nvm.sh;nvm install;nvm use;npm install)