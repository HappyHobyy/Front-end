class JwtToken {
  final String? accessToken;
  final String? refreshToken;

  JwtToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}