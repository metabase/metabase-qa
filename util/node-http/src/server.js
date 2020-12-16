"use strict";

// Intercept ctrl-c so we can gracefully exit out of `docker run`
var process = require("process");
process.on("SIGINT", () => {
  console.info("Interrupted");
  process.exit(0);
});

require("./smtp");
require("./http");
