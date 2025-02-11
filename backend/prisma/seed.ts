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

  // for (const treatmentType of TreatmentTypes) {
  //   const createdTreatmentType = await prisma.treatmentType.create({
  //     data: {
  //       ...treatmentType,
  //       name: treatmentType.name,
  //     },
  //   });
  // }

  const existingUniversities = await prisma.university.findMany({
    select: {
      id: true,
      name: true,
    },
  });

  const universityCoordinates = [
    { name: "Universitas Indonesia", latitude: -6.3628, longitude: 106.826 },
    {
      name: "Institut Teknologi Bandung",
      latitude: -6.8915,
      longitude: 107.6107,
    },
    { name: "Universitas Gadjah Mada", latitude: -7.7749, longitude: 110.374 },
    { name: "Institut Pertanian Bogor", latitude: -6.595, longitude: 106.8063 },
    { name: "Universitas Airlangga", latitude: -7.2697, longitude: 112.7585 },
    { name: "Universitas Brawijaya", latitude: -7.9557, longitude: 112.6133 },
    { name: "Universitas Diponegoro", latitude: -7.0544, longitude: 110.4381 },
    { name: "Universitas Padjadjaran", latitude: -6.926, longitude: 107.772 },
    { name: "Universitas Sebelas Maret", latitude: -7.558, longitude: 110.856 },
    {
      name: "Universitas Sumatera Utara",
      latitude: 3.5655,
      longitude: 98.6564,
    },
    {
      name: "Politeknik Negeri Jember",
      latitude: -8.1703,
      longitude: 113.7021,
    },
    {
      name: "Universitas Negeri Jember",
      latitude: -8.1703,
      longitude: 113.7021,
    },
  ];

  for (const university of universityCoordinates) {
    const existingUniversity = existingUniversities.find(
      (u) => u.name === university.name
    );
    if (existingUniversity) {
      await prisma.university.update({
        where: {
          id: existingUniversity.id,
        },
        data: {
          latitude: university.latitude,
          longitude: university.longitude,
        },
      });
    }
  }

  console.log("Updated universities successfully.");
}


main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
