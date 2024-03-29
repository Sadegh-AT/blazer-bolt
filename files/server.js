const morgan = require("morgan");
const { NotFoundError, ErrorHandler } = require("./utils/error-handler");
const { connectToMongo } = require("./utils/monoose.connection");
const express = require("express");
const { AllRoutes } = require("./routers/routes");
const cors = require("cors");
const app = express();
const path = require("path");

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

    app.use(morgan("dev"));
  }

  configDatabase(DB_URL) {
    connectToMongo(DB_URL);
  }

  createServer(PORT) {
    app.listen(PORT, () => {
      console.log(`Server Run on Port: ${PORT}`);
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
