const axios = require("axios");

async function getFileData(filename) {
  require("dotenv").config();

  const repo = process.env.REPO;

  const res = await axios.get(`${repo}${filename}`, {
    headers: {
      Authorization: "Bearer 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",
    },
  });
  const content = Buffer.from(res.data.content, "base64").toString();
  return content;
}

module.exports = {
  getFileData,
};
