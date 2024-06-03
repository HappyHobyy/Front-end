class RecommendationModel {
  final String hobbyType;
  final List<String> hobbies;

  RecommendationModel({required this.hobbyType, required this.hobbies});

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      hobbyType: json['hobbyType']['name'],
      hobbies: List<String>.from(json['hobbies'].map((hobby) => hobby['name'])),
    );
  }
}