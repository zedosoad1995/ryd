/*
  Warnings:

  - You are about to drop the `FuelProduct` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PumpProduct` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Price" DROP CONSTRAINT "Price_pumpProductId_fkey";

-- DropForeignKey
ALTER TABLE "PumpProduct" DROP CONSTRAINT "PumpProduct_fuelProductId_fkey";

-- DropForeignKey
ALTER TABLE "PumpProduct" DROP CONSTRAINT "PumpProduct_pumpId_fkey";

-- DropTable
DROP TABLE "FuelProduct";

-- DropTable
DROP TABLE "PumpProduct";

-- CreateTable
CREATE TABLE "StationProduct" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "productId" TEXT NOT NULL,
    "stationId" TEXT NOT NULL,

    CONSTRAINT "StationProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PumpToStationProduct" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_PumpToStationProduct_AB_unique" ON "_PumpToStationProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_PumpToStationProduct_B_index" ON "_PumpToStationProduct"("B");

-- AddForeignKey
ALTER TABLE "StationProduct" ADD CONSTRAINT "StationProduct_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StationProduct" ADD CONSTRAINT "StationProduct_stationId_fkey" FOREIGN KEY ("stationId") REFERENCES "Station"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Price" ADD CONSTRAINT "Price_pumpProductId_fkey" FOREIGN KEY ("pumpProductId") REFERENCES "StationProduct"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PumpToStationProduct" ADD CONSTRAINT "_PumpToStationProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Pump"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PumpToStationProduct" ADD CONSTRAINT "_PumpToStationProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "StationProduct"("id") ON DELETE CASCADE ON UPDATE CASCADE;
