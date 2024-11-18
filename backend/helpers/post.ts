import { PostQueryString } from "@/config/types";
import { getDateRange } from "@/utils/date";

export function parseSearchParams(
  searchParams: URLSearchParams
): PostQueryString {
  const queStr: PostQueryString = {};

  searchParams.forEach((value, key) => {
    if (key === "createdAt" || key === "updatedAt") {
      const dateRange = getDateRange(value);

      if (dateRange) {
        queStr[key] = JSON.stringify(dateRange);
      }
    } else {
      queStr[key] = value;
    }
  });

  return queStr;
}
