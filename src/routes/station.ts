import { Router } from "express";
import {
  createStation,
  deleteStation,
  getStation,
  getStations,
  updateOpeningHours,
  updateStation,
} from "../controllers/station";
import {
  createPump,
  deletePump,
  getPump,
  getPumps,
  updatePump,
} from "../controllers/pump";

const router = Router();

router.get("/", getStations);
router.get("/:id", getStation);
router.post("/", createStation);
router.patch("/:id", updateStation);
router.put("/:id/opening-hours", updateOpeningHours);
router.delete("/:id", deleteStation);

router.get("/:stationId/pumps", getPumps);
router.get("/:stationId/pumps/:pumpId", getPump);
router.post("/:stationId/pumps", createPump);
router.put("/:stationId/pumps/:pumpId", updatePump);
router.delete("/:stationId/pumps/:pumpId", deletePump);

export default router;
