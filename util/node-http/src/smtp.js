const SMTPServer = require("smtp-server").SMTPServer;
const simpleParser = require("mailparser").simpleParser;
const fs = require("fs");

const PORT = process.env.SMTP_PORT || 2525;

var emailCounter = 0;

const server = new SMTPServer({
  hideSTARTTLS: true, // Do not require STARTTLS
  onData(stream, session, callback) {
    // stream.pipe(process.stdout); // print message to console
    // stream.on("end", callback);
    simpleParser(stream, {})
      .then((parsed) => {
        console.log(`smtp/server: received new message from ${parsed.from.text}`);
        var stream = fs.createWriteStream(`public/emails/${++emailCounter}.md`);

        stream.write(`# ${parsed.subject}\n\n`);
        stream.write(`From: ${parsed.from.text}\n\n`);
        stream.write(`To: ${parsed.to.text}\n\n`);
        stream.write(`\`\`\`\n${parsed.text}\n\`\`\``);
        stream.end();
        callback();
      })
      .catch((err) => {
        console.log("smtp/server: Error parsing email", err);
        callback(err);
      });
  },
  onAuth(auth, session, callback) {
    // Support LOGIN method
    if (auth.username !== "admin" || auth.password !== "admin") {
      return callback(new Error("Invalid username or password"));
    }
    callback(null, { user: 123 }); // where 123 is the user id or similar property
  },
});

server.on("error", (err) => {
  console.log("Error %s", err.message);
});

server.listen(PORT, () => {
  console.log(`smtp/server listening on port ${PORT}`);
});
