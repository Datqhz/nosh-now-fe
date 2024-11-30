class ErrorResponse {
  int status;
  String? statusText;
  String? errorMessage;
  String? errorMessageCode;

  ErrorResponse({required this.status, required this.statusText, required this.errorMessage, required this.errorMessageCode});
}