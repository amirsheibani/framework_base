class ValidationResult {
  final bool isValid;
  final String? message;

  const ValidationResult({
    required this.isValid,
    this.message,
  });

  static ValidationResult valid() => const ValidationResult(isValid: true);

  static ValidationResult invalid(String message) =>
      ValidationResult(isValid: false, message: message);
}
