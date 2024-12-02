/**
 * An array of routes that are accessible to the public.
 * These route do not require authentication.
 * @type {string[]}
 */
export const publicRoutes = ["/"];

/**
 * An array of routes that are used for authentication.
 * These routes will redirect logged in user to /settings.
 * @type {string[]}
 */
export const authRoutes = ["/api/auth/signin", "/api/auth/signout"];

/**
 * The prefix for API authentication routes.
 * Routes that start with this prefix are used for API authentication purpose.
 * @type {string}
 */
export const apiAuthPrefix = "/api/auth";

/**
 * An array of routes that are used for public API.
 * These routes do not require authentication.
 * @type {string[]}
 */
export const apiPublicRoutes = ["/api/users"];

/**
 * The default redirect path after loginng in.
 * @type {string}
 */
export const DEFAULT_LOGIN_REDIRECT = "/settings";

/**
 * The default redirect path after logging out.
 * @type {string}
 */
export const DEFAULT_LOGOUT_REDIRECT = "/api/auth/signin";

/**
 * The default redirect path if user access an protected routes.
 * @type {string}
 */
export const DEFAULT_PROTECTED_REDIRECT = "/api/auth/signin";

/**
 * An array of routes for admin role.
 * @type {string[]}
 */
export const ADMIN_ROUTES = [
  "/admin/dashboard",
  "/admin/users",
  "/admin/users/[id]",
  "/admin/koas-profile",
  "/admin/koas-profile/[id]",
  "/admin/pasien-profile",
  "/admin/pasien-profile/[id]",
  "/admin/posts",
  "/admin/posts/[id]",
  "/admin/treatment-types",
  "/admin/treatment-types/[id]",
  "/admin/schedules",
  "/admin/schedules/[id]",
  "/admin/timeslots",
  "/admin/timeslots/[id]",
  "/admin/appointments",
  "/admin/appointments/[id]",
  "/admin/notifications",
  "/admin/notifications/[id]",
  "/admin/likes",
  "/admin/likes/[id]",
];

/**
 * An array of routes for pasien role.
 * @type {string[]}
 */
export const PASIEN_ROUTES = [
  "/pasien/dashboard",
  "/pasien/profile",
  "/pasien/profile/[id]",
  "/pasien/posts",
  "/pasien/posts/[id]",
  "/pasien/appointments",
  "/pasien/appointments/[id]",
  "/pasien/notifications",
  "/pasien/notifications/[id]",
  "/pasien/likes",
  "/pasien/likes/[id]",
  "/pasien/treatment-types",
  "/pasien/treatment-types/[id]",
];

/**
 * An array of routes for koas role.
 * @type {string[]}
 */
export const KOAS_ROUTES = [
  "/koas/dashboard",
  "/koas/profile",
  "/koas/profile/[id]",
  "/koas/posts",
  "/koas/posts/[id]",
  "/koas/appointments",
  "/koas/appointments/[id]",
  "/koas/notifications",
  "/koas/notifications/[id]",
  "/koas/likes",
  "/koas/likes/[id]",
  "/koas/treatment-types",
  "/koas/treatment-types/[id]",
];

/**
 * An object that contains all routes for each role.
 * @type {object}
 */
export const ROUTE_ROLES = {
  Admin: ADMIN_ROUTES,
  Pasien: PASIEN_ROUTES,
  Koas: KOAS_ROUTES,
};
