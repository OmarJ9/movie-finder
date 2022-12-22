class VideoModel {
  final String key;
  final String name;
  const VideoModel({required this.key, required this.name});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      key: json['key'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
