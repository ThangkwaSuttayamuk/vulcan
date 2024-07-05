import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/datasources/local/database_helper.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_state.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool username = false;
  bool password = false;

  bool isRemember = false;

  late DatabaseHelper databaseHelper;

  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    _usernameController.text = "";
    _passwordController.text = "";
    checkRemember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const Text("Login Page"),
              Row(
                children: [
                  const Text("Username "),
                  username
                      ? const Text(
                          "*required username",
                          style: TextStyle(color: Colors.red),
                        )
                      : user.status == UserStatus.failure
                          ? const Text(
                              '*wrong username or password',
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  _usernameController.text = value;
                  username = false;
                  // userState.statusInit();
                },
                controller: _usernameController,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Password "),
                  password
                      ? const Text(
                          "*required password",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) {
                  _passwordController.text = value;
                  password = false;
                },
                controller: _passwordController,
              ),
              Row(
                children: [
                  Checkbox(
                      value: isRemember,
                      onChanged: (bool? value) {
                        setState(() {
                          isRemember = value!;
                        });
                      }),
                  const Text('Remember me')
                ],
              ),
              MaterialButton(
                onPressed: () async {
                  if (_usernameController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    ref.read(userProvider.notifier).getUser(
                        _usernameController.text, _passwordController.text);
                    if (user.user?.username != '') {
                      loginData = await SharedPreferences.getInstance();
                      loginData.setBool('login', false);
                      loginData.setInt('id', user.user?.id ?? 0);
                      loginData.setString('username', _usernameController.text);
                      loginData.setString('password', _passwordController.text);
                      if (isRemember) {
                        loginData.setString(
                            'username', _usernameController.text);
                        loginData.setString(
                            'password', _passwordController.text);
                      } else {
                        await loginData.remove('username');
                        await loginData.remove('password');
                      }

                      Navigator.pushReplacementNamed(context, '/home');
                    } else {}
                  }
                  if (_usernameController.text.isEmpty) {
                    setState(() {
                      username = true;
                    });
                  }
                  if (_passwordController.text.isEmpty) {
                    setState(() {
                      password = true;
                    });
                  }
                },
                child: const Text("เข้าสู่ระบบ"),
                color: Colors.deepOrange,
              )
            ],
          ),
        ),
      ),
    );
  }

  

  void checkRemember() async {
    loginData = await SharedPreferences.getInstance();
    String remember = (loginData.getString('username') ?? '');
    if (remember != '') {
      _usernameController.text = loginData.getString('username') ?? '';
      _passwordController.text = loginData.getString('password') ?? '';
    }
  }
}
