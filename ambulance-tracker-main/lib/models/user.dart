class Users {
  Users({
    required this.isAvailable,
    required this.isFree,
    required this.name,
    required this.id,
    required this.regId,
  });
  late final bool isAvailable;
  late final bool isFree;
  late final String name;
  late final int id;
  late final String regId;

  Users.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
    isFree = json['isFree'];
    name = json['name'];
    id = json['id'];
    regId = json['reg_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isAvailable'] = isAvailable;
    data['isFree'] = isFree;
    data['name'] = name;
    data['id'] = id;
    data['reg_id'] = regId;
    return data;
  }
}
