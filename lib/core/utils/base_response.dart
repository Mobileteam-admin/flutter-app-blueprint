class BaseResponse<T> {
  final bool status;
  final String? message;
  final T? data;
  final Map<String, List<String>>? errors;
  BaseResponse({
    required this.status,
    this.message,
    this.data,
    this.errors,
  });
  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic> json)? fromJsonT,
      ) {
    final rawErrors = json['errors'] as Map<String, dynamic>?;
    return BaseResponse<T>(
      status: json['status'] ?? false,
      message: json['message'],
      data: fromJsonT != null ? fromJsonT(json) : null,
      errors: rawErrors?.map(
            (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }
  /// Shortcut: First field error message if present
  String? get firstError {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.entries.first.value.first;
    }
    return null;
  }
  /// Shortcut: status == true
  bool get isSuccess => status;
  /// Shortcut: has field-level errors
  bool get hasErrors => errors != null && errors!.isNotEmpty;
}