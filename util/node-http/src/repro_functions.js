const jwt = require("jsonwebtoken");

const METABASE_EMBED_KEY =
  "ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"; // As configured in `default.cy.snap.js`

module.exports = {
  repros: {
    13472: function (request_params) {
      // For metabase #13472, we need to build embed URLs
      // We need the following params:
      // hostname - defaults to "localhost"
      // port - defaults to "3000"
      // questionIDs - no default, comma-separated list
      //
      // we return a list of embed URLs to be iframe'ed
      const hostname = request_params.hostname || "localhost";
      const port = request_params.port || "3000";
      const questionIDs = request_params.question_ids.split(",");

      let embedURLs = [];
      questionIDs.forEach((id) => {
        question_params = {
          resource: {
            question: parseInt(id),
          },
          params: {},
          iat: 1601644831,
          _embedding_params: {},
        };
        jwt_params = jwt.sign(question_params, METABASE_EMBED_KEY);

        embedURLs.push(
          `http://${hostname}:${port}/embed/question/${jwt_params}#bordered=true&titled=true`
        );
      });

      return { embedURLs: embedURLs };
    },
  },
};
