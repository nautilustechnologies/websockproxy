const express = require('express');
const Gun = require('gun');

const app = express();
const port = 8765;
require('dotenv').config();

const server = app.listen(port, () => {
  console.log(`GunDB relay server listening on http://localhost:${port}`);
});

const gun = Gun({ 
  web: server,
});




