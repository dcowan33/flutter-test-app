class DetailedPlanet {
  final String name;
  final double radius;

  DetailedPlanet({
    required this.name, 
    required this.radius
  });

  factory DetailedPlanet.fromJson(Map<String, dynamic> json) {
    return DetailedPlanet(
      name: json['planetName'],
      radius: json['diameter'] / 2
    );
  }

  @override
  String toString() {
    return '$name - radius: $radius';
  }
}
