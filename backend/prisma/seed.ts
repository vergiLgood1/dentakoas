import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";
import { createSeedClient } from "@snaplet/seed";
import { Role } from "@/config/enum";
import { users } from "@/data/users";
import { TreatmentTypes } from "@/data/treatment-type";

const prisma = new PrismaClient();

async function main() {
  // Truncate all tables in the database
  // const seed = await createSeedClient();
  // await seed.$resetDatabase()

  // for (const user of users) {
  //   const hash = await bcrypt.hash(user.password, 10);

  //   // Create user
  //   const createdUser = await prisma.user.create({
  //     data: {
  //       ...user,
  //       name: `${user.givenName}.${user.familyName}`,
  //       password: hash,
  //     },
  //   });

  //   if (user.role === Role.Koas) {
  //     // Create koas
  //     await prisma.koasProfile.create({
  //       data: {
  //         userId: createdUser.id,
  //       },
  //     });
  //   } else if (user.role === Role.Pasien) {
  //     // Create pasien
  //     await prisma.pasienProfile.create({
  //       data: {
  //         userId: createdUser.id,
  //       },
  //     });
  //   }
  // }

  for (const treatmentType of TreatmentTypes) {
    const createdTreatmentType = await prisma.treatmentType.create({
      data: {
        ...treatmentType,
        name: treatmentType.name,
      },
    });
  }

  console.log("Data seed added:", TreatmentTypes);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
