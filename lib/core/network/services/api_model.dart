class ApiModel<T> {
  final bool status;
  final String message;
  final T? data;

  ApiModel({
    required this.status,
    required this.message,
    this.data,
  });
}