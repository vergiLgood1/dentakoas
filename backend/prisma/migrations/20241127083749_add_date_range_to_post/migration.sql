-- AlterTable
ALTER TABLE `posts` ADD COLUMN `date_range_end` DATETIME(3) NULL,
    ADD COLUMN `date_range_start` DATETIME(3) NULL;
