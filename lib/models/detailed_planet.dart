class DetailedPlanet {
  final String name;
  final double radius;
  final String imagePath;
  final int distanceToSun;
  final int distanceToEarth;

  DetailedPlanet({
    required this.name, 
    required this.radius,
    required this.imagePath,
    required this.distanceToSun,
    required this.distanceToEarth
  });

  factory DetailedPlanet.fromJson(Map<String, dynamic> json) {
    return DetailedPlanet(
      name: json['planetName'],
      radius: json['diameter'] / 2,
      imagePath: json['imageThumbnail'],
      distanceToSun: json['extra']['distanceToSun'],
      distanceToEarth: json['extra']['distanceToEarth']
    );
  }

  @override
  String toString() {
    return '$name - radius: $radius';
  }
}
