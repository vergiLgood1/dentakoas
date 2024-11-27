/*
  Warnings:

  - You are about to drop the column `user_id` on the `appointment` table. All the data in the column will be lost.
  - You are about to alter the column `status` on the `appointment` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Enum(EnumId(4))`.
  - You are about to drop the column `date_range_end` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `date_range_start` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `date` on the `schedules` table. All the data in the column will be lost.
  - Added the required column `date` to the `Appointment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pasien_id` to the `Appointment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `date_end` to the `schedules` table without a default value. This is not possible if the table is not empty.
  - Added the required column `date_start` to the `schedules` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `schedules` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `appointment` DROP FOREIGN KEY `Appointment_user_id_fkey`;

-- AlterTable
ALTER TABLE `appointment` DROP COLUMN `user_id`,
    ADD COLUMN `date` DATETIME(3) NOT NULL,
    ADD COLUMN `pasien_id` VARCHAR(191) NOT NULL,
    MODIFY `status` ENUM('Pending', 'Confirmed', 'Ongoing', 'Completed', 'Canceled') NOT NULL DEFAULT 'Pending';

-- AlterTable
ALTER TABLE `posts` DROP COLUMN `date_range_end`,
    DROP COLUMN `date_range_start`;

-- AlterTable
ALTER TABLE `schedules` DROP COLUMN `date`,
    ADD COLUMN `date_end` DATETIME(3) NOT NULL,
    ADD COLUMN `date_start` DATETIME(3) NOT NULL,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_pasien_id_fkey` FOREIGN KEY (`pasien_id`) REFERENCES `pasien-profile`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
