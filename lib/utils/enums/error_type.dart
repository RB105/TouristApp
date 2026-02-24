/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

enum ErrorType {
  // timeout errors
  timeout,

  connectionError,

  // clint errors
  badRequest_400,

  unAuthorized_401,

  forbidden_403,

  // server errors
  internalServer_500,

  badGateway_502,

  serviceUnavailable_503,

  /// unknown error
  other
}
