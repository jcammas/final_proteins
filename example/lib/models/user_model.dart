class User {
  String? id;
  String email;

  User({required this.email, this.id});

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        email = json['email'];
}
