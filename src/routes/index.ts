import { Router } from "express";
import stationRoute from "./station";
import productRoute from "./product";

const api = Router()
  .use("/stations", stationRoute)
  .use("/products", productRoute);

export default Router().use("/api", api);
