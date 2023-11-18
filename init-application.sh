#!/bin/bash

# Create files in the current directory

# Run npm init and accept all default values
npm init -y

# Install express package
npm install bcrypt cookie-parser cors dotenv express http-errors jsonwebtoken mongoose morgan nodemon


echo "Initialized npm project and installed Express package."
sleep 0.1

cat <<EOT > index.js
const Application = require("./app/server");

require("dotenv").config();


new Application(process.env.PORT, process.env.DB_URL);
EOT

echo "Created index.js file"
sleep 0.1

cat <<EOT > .gitignore
# .gitignore content here
# Add files/directories to ignore in your repository
node_modules/
.env
EOT

echo "Created .gitignore file"
sleep 0.1

cat <<EOT > .env
PORT=3000
DB_URL=mongodb://localhost:27017/your-database
EOT

echo "Created .env file"
sleep 0.1

# Create the "app" folder if it doesn't exist
mkdir -p app

# Array of folders to create inside "app"
folders=("controller" "validator" "routers" "config" "utils" "models" "middlewares")

# Loop through the array and create folders inside "app"
for folder in "${folders[@]}"
do
    mkdir -p "app/$folder"
    echo "Created folder: app/$folder"
    sleep 0.1
done

# Create server.js file with provided content in the "app" directory
cat <<EOT > app/server.js
const morgan = require("morgan");
const { NotFoundError, ErrorHandler } = require("./utils/error-handler");
const { connectToMongo } = require("./utils/mongoose.connection");
const express = require("express");
const { AllRoutes } = require("./routers/routes");
const cors = require("cors");
const app = express();
const path = require("path");
const cookieParser = require("cookie-parser");

class Application {
  constructor(PORT, DB_URL) {
    this.configServer();
    this.configDatabase(DB_URL);
    this.createServer(PORT);
    this.createRoutes();
    this.errorHandler();
  }
  configServer() {
    app.use(express.static(path.join(__dirname, "public")));
    app.use(cors());
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(cookieParser());
    app.use(morgan("dev"));
  }

  configDatabase(DB_URL) {
    connectToMongo(DB_URL);
  }

  createServer(PORT) {
    app.listen(PORT, () => {
      console.log(\`Server Run on Port: \${PORT}\`);
    });
  }

  createRoutes() {
    app.use(AllRoutes);
  }

  errorHandler() {
    app.use(NotFoundError);
    app.use(ErrorHandler);
  }
}

module.exports = Application;
EOT

echo "Created server.js file in app folder"
sleep 0.1

# Create the "app" folder if it doesn't exist
mkdir -p app/utils

# Write the code into error-handler.js in the "utils" folder
cat <<EOT > app/utils/error-handler.js
const createError = require("http-errors");
const NotFoundError = (req, res, next) => {
  next(createError.NotFound(\`Not Found Route => \${req.url}\`));
};
function validatorHandler(error) {
  const obj = {
    inValidParams: {},
  };

  error?.errors?.forEach((err) => {
    obj.inValidParams[err.path] = err.msg;
  });

  return error.errors ? obj : error;
}
const ErrorHandler = (err, req, res, next) => {
  return res.status(err?.status || 500).json({
    statusCode: res.statusCode,
    error: {
      message: err?.message || \`Internal Server Error\`,
      inValidParams: err.inValidParams ? err.inValidParams : null,
    },
  });
};

module.exports = {
  NotFoundError,
  ErrorHandler,
  validatorHandler,
};
EOT

echo "Created error-handler.js file in utils folder"
sleep 0.1


# Write the code into monoose.connection.js in the "utils" folder
cat <<EOT > app/utils/mongoose.connection.js
const { default: mongoose } = require("mongoose");
mongoose.set("strictQuery", false);
function connectToMongo(DB_URL) {
  const uri = DB_URL;
  mongoose
    .connect(uri)
    .then(() => {
      console.log(\`Connect to MongoDB: \${uri}\`);
    })
    .catch((error) => {
      throw error;
    });
}

module.exports = {
  connectToMongo,
};
EOT

echo "Created monoose.connection.js file in utils folder"
sleep 0.1

# Create the "router" folder if it doesn't exist
mkdir -p app/router

# Write the code into routes.js in the "router" folder
cat <<EOT > app/router/routes.js
const router = require("express").Router();


module.exports = {
  AllRoutes: router,
};
EOT

echo "Created routes.js file in router folder"
sleep 0.1

echo "Folder structure and files created successfully."
sleep 1