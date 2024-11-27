/*
  Warnings:

  - Made the column `date_range_end` on table `posts` required. This step will fail if there are existing NULL values in that column.
  - Made the column `date_range_start` on table `posts` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `posts` MODIFY `date_range_end` DATETIME(3) NOT NULL,
    MODIFY `date_range_start` DATETIME(3) NOT NULL;
