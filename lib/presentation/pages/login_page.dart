import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String username = "";
  final String password = "";

  @override
  void initState() {
    super.initState();
    _usernameController.text = "";
    _passwordController.text = "";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text("Login Page"),
              Row(
                children: [
                  Text("Username"),
                ],
              ),
              TextField(
                onChanged: (value) {
                  _usernameController.text = value;
                },
                controller: _usernameController,
              ),
              Row(
                children: [
                  Text("Password"),
                ],
              ),
              TextField(
                onChanged: (value) {
                  _passwordController.text = value;
                },
                controller: _usernameController,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: Container(
                  child: Text("เข้าสู่ระบบ"),
                ),
                color: Colors.deepOrange,
              )
            ],
          ),
        ),
      ),
    );
  }
}
