#!/usr/bin/env node
const { execFile, exec } = require("child_process");

const path = require("path");
const fs = require("fs");
const { getFileData } = require("./get-files-data");

const filesName = {
  "error-handler.js": "app/utils/error-handler.js",
  "mongoose-connection.js": "app/utils/mongoose-connection.js",
  "server.js": "app/server.js",
  "routes.js": "app/routers/routes.js",
  "index.js": "index.js",
};

// Check for the command
const command = process.argv[2];

// Handling different commands
switch (command) {
  case "init":
    init();
    break;
  case "help":
    console.log(`Usage:
      just type "blazer" and done`);
    break;
  default:
    console.log('Command not recognized. Use "help" for usage instructions.');
    break;
}

async function runBash() {
  const address = path.join(process.cwd(), "file-crateor.sh");
  await exec(`${address}`, (error, stdout, stderr) => {
    if (error) console.log(error.message);
    if (stderr) console.log(stderr);
    console.log(stdout);
  });
}
async function writeCode() {
  for (const key in filesName) {
    if (Object.hasOwnProperty.call(filesName, key)) {
      const filePath = filesName[key];
      const fileName = key;
      const content = await getFileData(fileName);
      await fs.writeFileSync(filePath, content);
      console.log("Write Done: " + fileName);
    }
  }
}
async function init() {
  await runBash();
  await writeCode();
  console.log(
    "please install these packages: bcrypt cookie-parser cors dotenv express http-errors jsonwebtoken mongoose morgan nodemon"
  );
}
