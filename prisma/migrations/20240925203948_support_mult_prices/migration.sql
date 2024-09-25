/*
  Warnings:

  - You are about to drop the column `currency` on the `FuelProduct` table. All the data in the column will be lost.
  - You are about to drop the column `price` on the `FuelProduct` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "FuelProduct" DROP CONSTRAINT "FuelProduct_pumpId_fkey";

-- AlterTable
ALTER TABLE "FuelProduct" DROP COLUMN "currency",
DROP COLUMN "price";

-- CreateTable
CREATE TABLE "Price" (
    "id" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "currency" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "fuelProductId" TEXT,

    CONSTRAINT "Price_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_FuelProductToPump" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_FuelProductToPump_AB_unique" ON "_FuelProductToPump"("A", "B");

-- CreateIndex
CREATE INDEX "_FuelProductToPump_B_index" ON "_FuelProductToPump"("B");

-- AddForeignKey
ALTER TABLE "Price" ADD CONSTRAINT "Price_fuelProductId_fkey" FOREIGN KEY ("fuelProductId") REFERENCES "FuelProduct"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelProductToPump" ADD CONSTRAINT "_FuelProductToPump_A_fkey" FOREIGN KEY ("A") REFERENCES "FuelProduct"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelProductToPump" ADD CONSTRAINT "_FuelProductToPump_B_fkey" FOREIGN KEY ("B") REFERENCES "Pump"("id") ON DELETE CASCADE ON UPDATE CASCADE;
