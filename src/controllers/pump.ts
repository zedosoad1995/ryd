import { Request, Response } from "express";
import { NotFoundError } from "../errors/NotFoundError";
import { prismadb } from "../helpers/prismaClient";

export const getPumps = async (req: Request, res: Response) => {
  const { stationId } = req.params;
  const page = parseInt(req.query.page as string) || 1;
  const limit = parseInt(req.query.limit as string) || 10;

  const pumps = await prismadb.pump.findMany({
    where: {
      stationId,
    },
    skip: (page - 1) * limit,
    take: limit,
  });

  const totalPumps = await prismadb.pump.count();
  const totalPages = Math.ceil(totalPumps / limit);

  res.status(200).json({
    page,
    totalPages,
    totalPumps,
    pumps,
  });
};

export const getPump = async (req: Request, res: Response) => {
  const { pumpId } = req.params;

  const pump = await prismadb.pump.findUnique({
    where: { id: pumpId },
  });

  if (!pump) {
    throw new NotFoundError("Pump does not exist");
  }

  res.status(200).json(pump);
};

export const createPump = async (req: Request, res: Response) => {
  const { stationId } = req.params;
  const { name }: { name: string } = req.body;

  const newPump = await prismadb.pump.create({
    data: {
      name,
      stationId,
    },
  });

  return res.status(201).json(newPump);
};

export const updatePump = async (req: Request, res: Response) => {
  const { pumpId } = req.params;

  const pump = await prismadb.pump.findUnique({
    where: { id: pumpId },
  });

  if (!pump) {
    throw new NotFoundError("Pump does not exist");
  }

  const updatedPump = await prismadb.pump.update({
    where: {
      id: pumpId,
    },
    data: {
      name: req.body.name,
    },
  });

  return res.status(200).json(updatedPump);
};

export const deletePump = async (req: Request, res: Response) => {
  const { pumpId } = req.params;

  const pump = await prismadb.pump.findUnique({
    where: { id: pumpId },
  });

  if (!pump) {
    throw new NotFoundError("Pump does not exist");
  }

  await prismadb.pump.delete({
    where: {
      id: pumpId,
    },
  });

  return res.sendStatus(204);
};
