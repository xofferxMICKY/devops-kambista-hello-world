const http = require('http');

const server = http.createServer((req, res) => {
  console.log(JSON.stringify({
    message: "Hello World from CI/CD",
    method: req.method,
    url: req.url
  }));

  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World from CI/CD\n');
});

server.listen(3000, () => {
  console.log('Server running on port 3000');
});
