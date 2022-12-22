class CastCrewModel {
  final String name;
  final String img;
  const CastCrewModel({required this.name, required this.img});

  factory CastCrewModel.fromJson(Map<String, dynamic> json) {
    return CastCrewModel(
      name: json['name'] ?? 'Unknown',
      img: json['profile_path'] ?? '',
    );
  }

  @override
  String toString() {
    return " name : $name, img : $img";
  }
}
