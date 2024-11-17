/*
  Warnings:

  - You are about to drop the column `family_name` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `given_name` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `users` DROP COLUMN `family_name`,
    DROP COLUMN `given_name`,
    ADD COLUMN `familyName` VARCHAR(191) NULL,
    ADD COLUMN `givenName` VARCHAR(191) NULL;
