/*
  Warnings:

  - You are about to drop the column `accessToken` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `expiresAt` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `idToken` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `providerAccountId` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `refreshToken` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `refreshTokenExpiresIn` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `sessionState` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `tokenType` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `accounts` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `koas-profile` table. All the data in the column will be lost.
  - You are about to drop the column `koasNumber` on the `koas-profile` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `koas-profile` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `koas-profile` table. All the data in the column will be lost.
  - You are about to drop the column `whatsappLink` on the `koas-profile` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `likes` table. All the data in the column will be lost.
  - You are about to drop the column `postId` on the `likes` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `likes` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `isRead` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `notifications` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `pasien-profile` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `pasien-profile` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `pasien-profile` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `koasId` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `patientRequirement` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `treatmentId` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `posts` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the column `sessionToken` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `sessions` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `treatment-types` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `treatment-types` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[provider,provider_account_id]` on the table `accounts` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id]` on the table `koas-profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[koas_number]` on the table `koas-profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[user_id]` on the table `pasien-profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[session_token]` on the table `sessions` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `provider_account_id` to the `accounts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `accounts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `koas-profile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `koas-profile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `post_id` to the `likes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `likes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `notifications` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `pasien-profile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `pasien-profile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `koas_id` to the `posts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `treatment_id` to the `posts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `posts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `posts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `session_token` to the `sessions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `sessions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `treatment-types` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX `accounts_provider_providerAccountId_key` ON `accounts`;

-- DropIndex
DROP INDEX `accounts_userId_idx` ON `accounts`;

-- DropIndex
DROP INDEX `accounts_userId_key` ON `accounts`;

-- DropIndex
DROP INDEX `koas-profile_userId_key` ON `koas-profile`;

-- DropIndex
DROP INDEX `postId` ON `likes`;

-- DropIndex
DROP INDEX `userId` ON `likes`;

-- DropIndex
DROP INDEX `userId` ON `notifications`;

-- DropIndex
DROP INDEX `pasien-profile_userId_key` ON `pasien-profile`;

-- DropIndex
DROP INDEX `koasId` ON `posts`;

-- DropIndex
DROP INDEX `treatmentId` ON `posts`;

-- DropIndex
DROP INDEX `userId` ON `posts`;

-- DropIndex
DROP INDEX `sessions_sessionToken_key` ON `sessions`;

-- DropIndex
DROP INDEX `sessions_userId_idx` ON `sessions`;

-- AlterTable
ALTER TABLE `accounts` DROP COLUMN `accessToken`,
    DROP COLUMN `createdAt`,
    DROP COLUMN `expiresAt`,
    DROP COLUMN `idToken`,
    DROP COLUMN `providerAccountId`,
    DROP COLUMN `refreshToken`,
    DROP COLUMN `refreshTokenExpiresIn`,
    DROP COLUMN `sessionState`,
    DROP COLUMN `tokenType`,
    DROP COLUMN `updatedAt`,
    DROP COLUMN `userId`,
    ADD COLUMN `access_token` TEXT NULL,
    ADD COLUMN `expires_at` INTEGER NULL,
    ADD COLUMN `id_token` TEXT NULL,
    ADD COLUMN `provider_account_id` VARCHAR(191) NOT NULL,
    ADD COLUMN `refresh_token` TEXT NULL,
    ADD COLUMN `session_state` VARCHAR(191) NULL,
    ADD COLUMN `token_type` VARCHAR(191) NULL,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `koas-profile` DROP COLUMN `createdAt`,
    DROP COLUMN `koasNumber`,
    DROP COLUMN `updateAt`,
    DROP COLUMN `userId`,
    DROP COLUMN `whatsappLink`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `koas_number` VARCHAR(191) NULL,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL,
    ADD COLUMN `whatsapp_link` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `likes` DROP COLUMN `createdAt`,
    DROP COLUMN `postId`,
    DROP COLUMN `userId`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `post_id` VARCHAR(191) NOT NULL,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `notifications` DROP COLUMN `createdAt`,
    DROP COLUMN `isRead`,
    DROP COLUMN `userId`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `is_read` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `pasien-profile` DROP COLUMN `createdAt`,
    DROP COLUMN `updateAt`,
    DROP COLUMN `userId`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `posts` DROP COLUMN `createdAt`,
    DROP COLUMN `koasId`,
    DROP COLUMN `patientRequirement`,
    DROP COLUMN `treatmentId`,
    DROP COLUMN `updateAt`,
    DROP COLUMN `userId`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `koas_id` VARCHAR(191) NOT NULL,
    ADD COLUMN `patient_requirement` JSON NULL,
    ADD COLUMN `treatment_id` VARCHAR(191) NOT NULL,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `sessions` DROP COLUMN `createdAt`,
    DROP COLUMN `sessionToken`,
    DROP COLUMN `updatedAt`,
    DROP COLUMN `userId`,
    ADD COLUMN `session_token` VARCHAR(191) NOT NULL,
    ADD COLUMN `user_id` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `treatment-types` DROP COLUMN `createdAt`,
    DROP COLUMN `updateAt`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `email_verified` DATETIME(3) NULL;

-- CreateIndex
CREATE UNIQUE INDEX `accounts_provider_provider_account_id_key` ON `accounts`(`provider`, `provider_account_id`);

-- CreateIndex
CREATE UNIQUE INDEX `koas-profile_user_id_key` ON `koas-profile`(`user_id`);

-- CreateIndex
CREATE UNIQUE INDEX `koas-profile_koas_number_key` ON `koas-profile`(`koas_number`);

-- CreateIndex
CREATE INDEX `post_id` ON `likes`(`post_id`);

-- CreateIndex
CREATE INDEX `user_id` ON `likes`(`user_id`);

-- CreateIndex
CREATE INDEX `user_id` ON `notifications`(`user_id`);

-- CreateIndex
CREATE UNIQUE INDEX `pasien-profile_user_id_key` ON `pasien-profile`(`user_id`);

-- CreateIndex
CREATE INDEX `user_id` ON `posts`(`user_id`);

-- CreateIndex
CREATE INDEX `koas_id` ON `posts`(`koas_id`);

-- CreateIndex
CREATE INDEX `treatment_id` ON `posts`(`treatment_id`);

-- CreateIndex
CREATE UNIQUE INDEX `sessions_session_token_key` ON `sessions`(`session_token`);

-- AddForeignKey
ALTER TABLE `accounts` ADD CONSTRAINT `accounts_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sessions` ADD CONSTRAINT `sessions_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `koas-profile` ADD CONSTRAINT `koas-profile_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pasien-profile` ADD CONSTRAINT `pasien-profile_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `posts` ADD CONSTRAINT `posts_koas_id_fkey` FOREIGN KEY (`koas_id`) REFERENCES `koas-profile`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `posts` ADD CONSTRAINT `posts_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `likes` ADD CONSTRAINT `likes_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `likes` ADD CONSTRAINT `likes_post_id_fkey` FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `notifications` ADD CONSTRAINT `notifications_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
