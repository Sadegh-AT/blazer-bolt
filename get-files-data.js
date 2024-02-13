const axios = require("axios");

async function getFileData(filename) {
  require("dotenv").config();

  const repo = process.env.REPO;

  const res = await axios.get(`${repo}${filename}`);
  const content = Buffer.from(res.data.content, "base64").toString();
  return content;
}

module.exports = {
  getFileData,
};
