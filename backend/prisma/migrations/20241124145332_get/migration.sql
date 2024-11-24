/*
  Warnings:

  - You are about to drop the column `post_id` on the `participants` table. All the data in the column will be lost.
  - Added the required column `schedule_id` to the `participants` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `participants` DROP FOREIGN KEY `participants_post_id_fkey`;

-- AlterTable
ALTER TABLE `participants` DROP COLUMN `post_id`,
    ADD COLUMN `schedule_id` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE INDEX `schedule_id` ON `participants`(`schedule_id`);

-- AddForeignKey
ALTER TABLE `participants` ADD CONSTRAINT `participants_schedule_id_fkey` FOREIGN KEY (`schedule_id`) REFERENCES `schedules`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
