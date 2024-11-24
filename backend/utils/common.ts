import { prismaModels } from "@/config/const";
import { TableName } from "@/config/types";

export async function findLastRecord<T extends TableName>(
  tableName: T,
  prefix: string
) {
  const model = prismaModels[tableName];
  return await (model as any).findFirst({
    where: {
      id: {
        startsWith: prefix,
      },
    },
    select: {
      id: true,
    },
    orderBy: {
      id: "desc",
    },
  });
}

// Fungsi untuk menghasilkan ID baru dengan prefix dan auto-increment
export async function genId<T extends TableName>(
  prefix: string,
  tableName: T,
  startValue: number = 1
): Promise<string> {
  const lastRecord = await findLastRecord(tableName, prefix);

  const lastId =
    lastRecord?.id || `${prefix}${String(startValue - 1).padStart(3, "0")}`;
  const currentNumber =
    parseInt(lastId.replace(prefix, ""), 10) || startValue - 1;
  const nextNumber = currentNumber + 1;
  const formattedNumber = nextNumber.toString().padStart(4, "0");

  return `${prefix}${formattedNumber}`;
}
