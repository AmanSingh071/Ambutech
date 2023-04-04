class Requests {
  Requests({
    required this.name,
    required this.location,
  });
  late final String name;
  late final String location;

  Requests.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['location'] = location;

    return data;
  }
}
