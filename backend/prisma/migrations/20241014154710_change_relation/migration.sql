/*
  Warnings:

  - A unique constraint covering the columns `[user_id]` on the table `koas_profiles` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id]` on the table `pasien_profiles` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `posts` ADD COLUMN `published` BOOLEAN NOT NULL DEFAULT false;

-- CreateIndex
CREATE UNIQUE INDEX `koas_profiles_user_id_key` ON `koas_profiles`(`user_id`);

-- CreateIndex
CREATE UNIQUE INDEX `pasien_profiles_user_id_key` ON `pasien_profiles`(`user_id`);
