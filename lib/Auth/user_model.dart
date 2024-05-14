class User {
  final int? userId;
  final String userEmail;
  final String? password;
  final String? userNickName;
  final String? userName;
  final int? phoneNumber;
  final UserType userType;
  final String? deviceToken;
  final String? birth;
  final Gender? gender;
  final Nationality? nationality;

  User(
      {required this.gender,
      required this.nationality,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.password,
      required this.userNickName,
      required this.phoneNumber,
      required this.userType,
      required this.deviceToken,
      required this.birth});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userEmail: json['userEmail'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      userNickName: json['userNickname'],
      userName: json['userName'],
      userType: parseStringToUserType(json['userType']),
      deviceToken: json['deviceToken'],
      birth: json['birth'],
      gender: parseStringToGender(json['gender']),
      nationality: parseStringToNationality(json['nationality']),
    );
  }

  // 소셜 로그인 왜 전부 null로 인자 받음
  User.withSocialUserLogin(
      {required String userEmail,
      required UserType userType,
      required String deviceToken})
      : this(userId: null, userEmail: userEmail, password: null, phoneNumber: null, userNickName: null,
            userName: null, userType: userType, deviceToken: deviceToken, birth: null, gender: null, nationality: null);
  // 일반 유저 로그인
  User.withDefaultUserLogin(
      {required String userEmail,
        required UserType userType,
        required String password,
        required String deviceToken})
      : this(userId: null, userEmail: userEmail, password: password, phoneNumber: null, userNickName: null,
      userName: null, userType: userType, deviceToken: deviceToken, birth: null, gender: null, nationality: null);

  //회원가입 외 정보 모두 null 처리
  User.withUserRegister({
    required String userEmail,
    required String password,
    required int phoneNumber,
    required String userNickName,
    required String userName,
    required UserType userType,
    required String birth,
    required Gender gender,
    required Nationality nationality,
  }) : this(
            userId: null,
            userEmail: userEmail,
            password: password,
            phoneNumber: phoneNumber,
            userNickName: userNickName,
            userType: userType,
            userName: userName,
            deviceToken: null,
            birth: birth,
            gender: gender,
            nationality: nationality);

  Map<String, dynamic> toSocialLoginJson() {
    return {
      'email': userEmail,
      'oAuth': parseUserTypeToString(userType),
      'deviceToken': deviceToken,
    };
  }

  Map<String, dynamic> toDefaultLoginJson() {
    return {
      'email': userEmail,
      'password': password,
      'oAuth': parseUserTypeToString(userType),
      'deviceToken': deviceToken,
    };
  }

  Map<String, dynamic> toDefaultRegisterJson() {
    return {
      'email': userEmail,
      'password': password,
      'phoneNumber': phoneNumber,
      'nickname': userNickName,
      'userName': userName,
      'oAuth': parseUserTypeToString(userType),
      'birth': birth,
      'gender': parseGenderToString(gender!),
      'nationality': parseNationalityToString(nationality!)
    };
  }

  Map<String, dynamic> toSocialRegisterJson() {
    return {
      'email': userEmail,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'nickname': userNickName,
      'oAuth': parseUserTypeToString(userType),
      'birth': birth,
      'gender': parseGenderToString(gender!),
      'nationality': parseNationalityToString(nationality!)
    };
  }
}

enum UserType { OAUTH_KAKAO, OAUTH_NAVER, OAUTH_GOOGLE, DEFAULT }

enum Gender { MAN, WOMAN }

enum Nationality { DOMESTIC, FOREIGNER }

String parseUserTypeToString(UserType userType) {
  switch (userType) {
    case UserType.OAUTH_KAKAO:
      return 'OAUTH_KAKAO';
    case UserType.OAUTH_NAVER:
      return 'OAUTH_NAVER';
    case UserType.OAUTH_GOOGLE:
      return 'OAUTH_GOOGLE';
    case UserType.DEFAULT:
      return 'DEFAULT';
  }
}

String parseGenderToString(Gender gender) {
  switch (gender) {
    case Gender.MAN:
      return 'MAN';
    case Gender.WOMAN:
      return 'WOMAN';
  }
}

String parseNationalityToString(Nationality nationality) {
  switch (nationality) {
    case Nationality.DOMESTIC:
      return 'DOMESTIC';
    case Nationality.FOREIGNER:
      return 'FOREIGNER';
  }
}

UserType parseStringToUserType(String userType) {
  switch (userType) {
    case 'OAUTH_KAKAO':
      return UserType.OAUTH_KAKAO;
    case 'OAUTH_NAVER':
      return UserType.OAUTH_NAVER;
    case 'OAUTH_GOOGLE':
      return UserType.OAUTH_GOOGLE;
    case 'DEFAULT':
      return UserType.DEFAULT;
    default:
      throw ArgumentError('Invalid user type');
  }
}

Gender parseStringToGender(String gender) {
  switch (gender) {
    case 'MAN':
      return Gender.MAN;
    case 'WOMAN':
      return Gender.WOMAN;
    default:
      throw ArgumentError('Invalid gender');
  }
}

Nationality parseStringToNationality(String nationality) {
  switch (nationality) {
    case 'DOMESTIC':
      return Nationality.DOMESTIC;
    case 'FOREIGNER':
      return Nationality.FOREIGNER;
    default:
      throw ArgumentError('Invalid nationality');
  }
}
