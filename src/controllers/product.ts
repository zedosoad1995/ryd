import { Request, Response } from "express";
import { prismadb } from "../helpers/prismaClient";

export const getProducts = async (req: Request, res: Response) => {
  const page = parseInt(req.query.page as string) || 1;
  const limit = parseInt(req.query.limit as string) || 10;

  const products = await prismadb.product.findMany({
    skip: (page - 1) * limit,
    take: limit,
  });

  const totalProducts = await prismadb.product.count();
  const totalPages = Math.ceil(totalProducts / limit);

  res.status(200).json({
    page,
    totalPages,
    totalProducts,
    products,
  });
};

export const createProduct = async (req: Request, res: Response) => {
  const { name } = req.body;

  const newProduct = await prismadb.product.create({
    data: {
      name,
    },
  });

  return res.status(201).json(newProduct);
};
