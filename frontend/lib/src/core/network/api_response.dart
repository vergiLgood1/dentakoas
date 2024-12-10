  class ApiResponse<T> {
    final bool success;
    final T? data;
    final String? message;

    ApiResponse({
      required this.success,
      this.data,
      this.message,
    });

    factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic data) fromJsonT,
    ) {
      return ApiResponse(
        success: json['success'] ?? false,
        data: json['data'] != null ? fromJsonT(json['data']) : null,
        message: json['message'],
      );
    }
  }
