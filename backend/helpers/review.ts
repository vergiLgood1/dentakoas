/**
 * Parse the search params from the URL and return an object
 * @param searchParams
 * @returns
 */
export function parseSearchParams<T extends Record<string, string>>(
  searchParams: URLSearchParams
): T {
  const query: T = {} as T;

  searchParams.forEach((value, key) => {
    (query as any)[key] = value;
  });

  return query;
}
