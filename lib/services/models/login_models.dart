class LoginInput {
  final String userNameOrEmailAddress;
  final String password;
  final bool rememberMe;

  LoginInput({
    required this.userNameOrEmailAddress,
    required this.password,
    this.rememberMe = false,
  });

  factory LoginInput.fromJson(Map<String, dynamic> json) {
    return LoginInput(
      userNameOrEmailAddress: json['userNameOrEmailAddress'],
      password: json['password'],
      rememberMe: json['rememberMe'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNameOrEmailAddress': userNameOrEmailAddress,
      'password': password,
      'rememberMe': rememberMe,
    };
  }
}

class AuthenticationResultDto {
  final String accessToken;
  late final String encryptedToken;
  final String refreshToken;
  final DateTime? expirationDate;

  AuthenticationResultDto({
    required this.accessToken,
    // required this.encryptedToken,
    required this.refreshToken,
    this.expirationDate,
  });

  factory AuthenticationResultDto.fromJson(Map<String, dynamic> json) {
    return AuthenticationResultDto(
      accessToken: json['accessToken'],
      // encryptedToken: json['encryptedToken'],
      refreshToken: json['refreshToken'],
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'encryptedToken': encryptedToken,
      'refreshToken': refreshToken,
      'expirationDate': expirationDate?.toIso8601String(),
    };
  }
}

