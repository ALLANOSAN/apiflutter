class Login {
  final int? id;
  final String username;
  final String password;

  const Login({
    this.id,
    required this.username,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json)=> Login(
    id: json['id'],
    username: json['username'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password
  };
}