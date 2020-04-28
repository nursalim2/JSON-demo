class User {
  String login;
  int id;

  User({
    this.login,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    login: json["login"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
    "id": id,
  };
}