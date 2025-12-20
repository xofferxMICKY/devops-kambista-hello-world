const http = require("http");

const server = http.createServer((req, res) => {
  const log = {
    message: "Request received",
    method: req.method,
    url: req.url,
    timestamp: new Date().toISOString()
  };

  console.log(JSON.stringify(log));

  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Hello World\n");
});

server.listen(3000, () => {
  console.log(JSON.stringify({
    message: "Server started",
    port: 3000
  }));
});
