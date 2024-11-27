/*
  Warnings:

  - You are about to drop the column `end_time` on the `schedules` table. All the data in the column will be lost.
  - You are about to drop the column `is_available` on the `schedules` table. All the data in the column will be lost.
  - You are about to drop the column `max_participants` on the `schedules` table. All the data in the column will be lost.
  - You are about to drop the column `participant_count` on the `schedules` table. All the data in the column will be lost.
  - You are about to drop the column `start_time` on the `schedules` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `schedules` table. All the data in the column will be lost.
  - You are about to drop the `participants` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `participants` DROP FOREIGN KEY `participants_schedule_id_fkey`;

-- DropForeignKey
ALTER TABLE `participants` DROP FOREIGN KEY `participants_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `schedules` DROP FOREIGN KEY `schedules_user_id_fkey`;

-- DropIndex
DROP INDEX `schedules_post_id_date_start_time_end_time_key` ON `schedules`;

-- AlterTable
ALTER TABLE `schedules` DROP COLUMN `end_time`,
    DROP COLUMN `is_available`,
    DROP COLUMN `max_participants`,
    DROP COLUMN `participant_count`,
    DROP COLUMN `start_time`,
    DROP COLUMN `user_id`;

-- DropTable
DROP TABLE `participants`;

-- CreateTable
CREATE TABLE `timeslots` (
    `id` VARCHAR(191) NOT NULL,
    `start_time` VARCHAR(191) NOT NULL,
    `end_time` VARCHAR(191) NOT NULL,
    `max_participants` INTEGER NULL,
    `current_participants` INTEGER NOT NULL DEFAULT 0,
    `is_available` BOOLEAN NOT NULL DEFAULT true,
    `schedule_id` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `timeslots_schedule_id_start_time_end_time_key`(`schedule_id`, `start_time`, `end_time`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Appointment` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `schedule_id` VARCHAR(191) NOT NULL,
    `koas_id` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'Pending',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `timeslots` ADD CONSTRAINT `timeslots_schedule_id_fkey` FOREIGN KEY (`schedule_id`) REFERENCES `schedules`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_schedule_id_fkey` FOREIGN KEY (`schedule_id`) REFERENCES `schedules`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Appointment` ADD CONSTRAINT `Appointment_koas_id_fkey` FOREIGN KEY (`koas_id`) REFERENCES `koas-profile`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
