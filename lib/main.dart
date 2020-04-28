import 'package:flutter/material.dart';
import 'package:flutter_fff/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp((MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List users = List();
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  bool loading = true;

  fetchUser() async {
    setState(() {
      loading = true;
    });
    final response = await http.get('https://api.github.com/users');

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
      });
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      throw Exception('Failed to load album');
    }
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
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            User user = User.fromJson(users[index]);
            return ListTile(
              title: Text(
                user.login,
              ),
            );
          },
        ),
      ),
    );
  }
}
