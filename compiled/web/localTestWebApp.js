const express = require('express'),
  path = require('path'),
  server = express(),
  port = 3003;

// Define route for static files.
server.use('/static', express.static(path.join(__dirname, 'static')));
server.use('/assets', express.static(path.join(__dirname, 'assets')));
  
// Endpoint.
server.get('/', (_, res) => {
  res.sendFile(joinPath(__dirname, 'index.html'));
});
  
// Run server locally.
server.listen(port, () => console.log(`Listening on port ${port}`));
