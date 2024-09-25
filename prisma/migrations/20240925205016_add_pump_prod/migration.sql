/*
  Warnings:

  - You are about to drop the column `pumpId` on the `FuelProduct` table. All the data in the column will be lost.
  - You are about to drop the column `fuelProductId` on the `Price` table. All the data in the column will be lost.
  - You are about to drop the `_FuelProductToPump` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `pumpProductId` to the `Price` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Price" DROP CONSTRAINT "Price_fuelProductId_fkey";

-- DropForeignKey
ALTER TABLE "Pump" DROP CONSTRAINT "Pump_stationId_fkey";

-- DropForeignKey
ALTER TABLE "_FuelProductToPump" DROP CONSTRAINT "_FuelProductToPump_A_fkey";

-- DropForeignKey
ALTER TABLE "_FuelProductToPump" DROP CONSTRAINT "_FuelProductToPump_B_fkey";

-- AlterTable
ALTER TABLE "FuelProduct" DROP COLUMN "pumpId";

-- AlterTable
ALTER TABLE "Price" DROP COLUMN "fuelProductId",
ADD COLUMN     "pumpProductId" TEXT NOT NULL;

-- DropTable
DROP TABLE "_FuelProductToPump";

-- CreateTable
CREATE TABLE "PumpProduct" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "pumpId" TEXT NOT NULL,
    "fuelProductId" TEXT NOT NULL,

    CONSTRAINT "PumpProduct_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Pump" ADD CONSTRAINT "Pump_stationId_fkey" FOREIGN KEY ("stationId") REFERENCES "Station"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PumpProduct" ADD CONSTRAINT "PumpProduct_pumpId_fkey" FOREIGN KEY ("pumpId") REFERENCES "Pump"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PumpProduct" ADD CONSTRAINT "PumpProduct_fuelProductId_fkey" FOREIGN KEY ("fuelProductId") REFERENCES "FuelProduct"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Price" ADD CONSTRAINT "Price_pumpProductId_fkey" FOREIGN KEY ("pumpProductId") REFERENCES "PumpProduct"("id") ON DELETE CASCADE ON UPDATE CASCADE;
