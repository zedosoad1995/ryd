import { NextFunction, Request, Response } from "express";
import { CustomError } from "../errors/CustomError";

// eslint-disable-next-line @typescript-eslint/no-unused-vars
export const errorHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (err instanceof CustomError) {
    return res.status(err.statusCode).send(err.serializeErrors());
  }

  console.error(err);

  return res.status(400).send({
    message: "Something went wrong",
  });
};
