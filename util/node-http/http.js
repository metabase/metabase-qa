const express = require("express");
const serveIndex = require("serve-index");

// Constants
const PORT = 8080;
const HOST = "0.0.0.0";

// App
const app = express();
app.get("/", (req, res) => {
  res.send(
    "<html><body>You've reached the Metabase Utils HTTP Server. Nobody is home right now, please leave a message.<br /><br /><a href='/static'>Static tests</a></body></html>"
  );
});

// Static assets
app.use("/static", express.static("public"));
app.use(
  "/static",
  express.static("public"),
  serveIndex("public", { icons: true })
);

app.listen(PORT, HOST);
console.log(`http listening on http://${HOST}:${PORT}`);
