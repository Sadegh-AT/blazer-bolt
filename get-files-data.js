const { Octokit } = require("octokit");
const octokit = new Octokit({
  auth: process.env.TOKEN,
});
async function getFileData(filename) {
  require("dotenv").config();

  const res = await octokit.request(
    `GET /repos/{owner}/{repo}/contents/{path}`,
    {
      owner: "Sadegh-AT",
      repo: "blazer-bolt",
      path: `files/${filename}`,
    }
  );
  const content = Buffer.from(res.data.content, "base64").toString();
  return content;
}

module.exports = {
  getFileData,
};
