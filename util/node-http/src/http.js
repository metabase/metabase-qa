const escapeHtml = require("escape-html");
const express = require("express");
const marked = require("marked");
const serveIndex = require("serve-index");
const fs = require("fs");
const { repros } = require("./repro_functions");

// Constants
const PORT = process.env.HTTP_PORT || 8080;
const HOST = "0.0.0.0";

// App and default view engine
const app = express();
app.set("view engine", "pug");

// I always want pretty HTML
app.locals.pretty = true;

// Boring default homepage
app.get("/", (req, res) => {
  res.send(
    "<html><body>You've reached the Metabase Utils HTTP Server. Nobody is home right now, please leave a message.<br /><br />" +
      "<a href='/static'>Static tests</a><br /><br />" +
      "<a href='/emails'>List of received emails</a><br /><br />" +
      "</body></html>"
  );
});

// Static assets - if you ever have a simple HTML repro, drop it in `./public` directory
app.use("/static", express.static("public"));
app.use(
  "/static",
  express.static("public"),
  serveIndex("public", { icons: true })
);

// Some repros require a little bit of fancy coding
// Allow us to build up a set of config values that can be passed to the template
app.get("/repros/:github_id(\\d+)", (req, res) => {
  const github_id = parseInt(req.params.github_id);
  repro_params = {
    title: `Repro :: metabase#${github_id}`,
  };
  if (github_id in repros) {
    console.log(`http/repro: Creating custom config for repro ${github_id}`);
    repro_params.config = repros[github_id](req.query);
  }
  res.render(`issue_${github_id}`, repro_params);
});

// Mail messages
app.use(
  "/emails",
  express.static("public/emails"),
  serveIndex("public/emails", { icons: true })
);

app.get("/emails/:id(\\d+)", (req, res) => {
  let markdownIndex = req.params.id;
  let path = `public/emails/${markdownIndex}.md`;
  fs.readFile(path, "utf8", function (err, str) {
    if (err) {
      res.status(404).send("File not found");
      return;
    }
    var html = marked.parse(str).replace(/\{([^}]+)\}/g, function (_, name) {
      return escapeHtml("");
    });
    res.send(html);
  });
});

app.listen(PORT, HOST);
console.log(`http/server listening on port ${PORT}`);
