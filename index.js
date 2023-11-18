#!/usr/bin/env node
const { execFile, exec } = require("child_process");

// Check for the command
const command = process.argv[2];

// Handling different commands
switch (command) {
  case "init":
    runBash();
    break;
  case "help":
    console.log(`Usage:
      just type "blazer" and done`);
    break;
  default:
    console.log('Command not recognized. Use "help" for usage instructions.');
    break;
}
function getAccess() {
  exec("chmod -x");
}
function runBash() {
  exec("echo dwadwa", (error, stdout, stderr) => {
    if (error) console.log(error.message);
    if (stderr) console.log(stderr);
    console.log(stdout);
  });
}
