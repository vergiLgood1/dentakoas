import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";
import { createSeedClient } from "@snaplet/seed";
import { Role } from "@/config/enum";
import { users } from "@/data/users";
import { genId } from "@/utils/common";

const prisma = new PrismaClient();

async function main() {
  // Truncate all tables in the database
  // const seed = await createSeedClient();
  // await seed.$resetDatabase()

  for (const user of users) {
    const hash = await bcrypt.hash(user.password, 10);
    const newId = await genId("USR", "users");
    // Create user
    const createdUser = await prisma.user.create({
      data: {
        ...user,
        id: newId,
        name: `${user.givenName}.${user.familyName}`,
        password: hash,
      },
    });

    if (user.role === Role.Koas) {
      const newId = await genId("KPS", "koasProfiles");
      // Create koas
      await prisma.koasProfile.create({
        data: {
          id: newId,
          userId: createdUser.id,
        },
      });
    } else if (user.role === Role.Pasien) {
      const newId = await genId("PSN", "pasienProfiles");

      // Create pasien
      await prisma.pasienProfile.create({
        data: {
          id: newId,
          userId: createdUser.id,
        },
      });
    }
  }

  console.log("Data seed added:", users);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
