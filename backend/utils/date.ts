export function getDateRange(
  filter: string
): { gte: string; lte: string } | null {
  const now = new Date();
  let startDate: Date;
  let endDate: Date;

  switch (filter) {
    case "today":
      startDate = new Date(now.setHours(0, 0, 0, 0));
      endDate = new Date(now.setHours(23, 59, 59, 999));
      break;

    case "this_week":
      startDate = new Date(new Date().setDate(now.getDate() - now.getDay()));
      startDate.setHours(0, 0, 0, 0);
      endDate = new Date(new Date().setDate(now.getDate() - now.getDay() + 6));
      endDate.setHours(23, 59, 59, 999);
      break;

    case "this_month":
      startDate = new Date(now.getFullYear(), now.getMonth(), 1);
      endDate = new Date(
        now.getFullYear(),
        now.getMonth() + 1,
        0,
        23,
        59,
        59,
        999
      );
      break;

    case "this_year":
      startDate = new Date(now.getFullYear(), 0, 1);
      endDate = new Date(now.getFullYear(), 11, 31, 23, 59, 59, 999);
      break;

    default:
      return null;
  }

  return {
    gte: startDate.toISOString(),
    lte: endDate.toISOString(),
  };
}
