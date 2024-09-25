import express from "express";
import "express-async-errors";
import { json } from "body-parser";
import { NotFoundError } from "./errors/NotFoundError";
import { errorHandler } from "./middlewares/errorHandler";
import routes from "./routes";

const app = express();
app.use(json());

app.use(routes);
app.all("*", async () => {
  throw new NotFoundError("Invalid route path");
});

app.use(errorHandler);


export { app };
