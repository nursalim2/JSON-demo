import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<User> fetchUser() async {
  final response = await http.get('https://api.github.com/users');

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load album');
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

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


void main() => runApp((MyApp()));

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Users'),
            ),
            body: Center(
              child: FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[Text(snapshot.data.login),
                        Divider(),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            )));
  }
}
