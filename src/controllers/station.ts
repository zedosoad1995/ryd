import { Request, Response } from "express";
import { NotFoundError } from "../errors/NotFoundError";
import { DayOfWeek } from "@prisma/client";
import { prismadb } from "../helpers/prismaClient";

export const getStations = async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1;
  const limit = parseInt(req.query.limit as string) || 10;

  const stations = await prismadb.station.findMany({
    skip: (page - 1) * limit,
    take: limit,
  });

  const totalStations = await prismadb.station.count();
  const totalPages = Math.ceil(totalStations / limit);

  res.status(200).json({
    page,
    totalPages,
    totalStations,
    stations,
  });
};

export const getStation = async (req: Request, res: Response) => {
  const { id } = req.params;

  const station = await prismadb.station.findUnique({
    where: { id },
  });

  if (!station) {
    throw new NotFoundError("Station does not exist");
  }

  res.status(200).json(station);
};

export const createStation = async (req: Request, res: Response) => {
  const { status, country, zipCode, city, street, houseNumber } = req.body;

  const newStation = await prismadb.station.create({
    data: {
      city,
      country,
      houseNumber,
      status,
      street,
      zipCode,
      isOpenOnHolidays: false,
    },
  });

  return res.status(201).json(newStation);
};

export const updateStation = async (req: Request, res: Response) => {
  const { id } = req.params;

  const station = await prismadb.station.findUnique({
    where: { id },
  });

  if (!station) {
    throw new NotFoundError("Station does not exist");
  }

  const updatedStation = await prismadb.station.update({
    where: {
      id,
    },
    data: req.body,
  });

  return res.status(200).json(updatedStation);
};

export const deleteStation = async (req: Request, res: Response) => {
  const { id } = req.params;

  const station = await prismadb.station.findUnique({
    where: { id },
  });

  if (!station) {
    throw new NotFoundError("Station does not exist");
  }

  await prismadb.station.delete({
    where: {
      id,
    },
  });

  return res.sendStatus(204);
};

export const updateOpeningHours = async (req: Request, res: Response) => {
  const { id } = req.params;
  const {
    isOpenOnHolidays,
    openingHours,
  }: {
    isOpenOnHolidays: boolean;
    openingHours: {
      dayOfWeek: DayOfWeek;
      openTime: string;
      closeTime: string;
    }[];
  } = req.body;

  const station = await prismadb.station.findUnique({
    where: { id },
  });

  if (!station) {
    throw new NotFoundError("Station does not exist");
  }

  await prismadb.openingHour.deleteMany({
    where: {
      stationId: id,
    },
  });

  await Promise.all(
    openingHours.map((val) =>
      prismadb.openingHour.create({
        data: { ...val, stationId: id },
      })
    )
  );

  const updatedStation = await prismadb.station.update({
    where: {
      id,
    },
    data: {
      isOpenOnHolidays,
    },
    include: {
      openingHours: true,
    },
  });

  return res.status(200).json(updatedStation);
};
