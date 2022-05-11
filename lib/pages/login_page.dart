import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nine_song/api/auth.dart';
import 'package:nine_song/api/backend_service.dart';
import 'package:nine_song/app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    return super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  height: 420,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            width: 250.0,
                            child: TextFormField(
                              controller: usernameController,
                              autocorrect: false,
                              decoration: const InputDecoration(labelText: "用户名"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "User name can not be empty.";
                                }
                                if (!GetUtils.isUsername(value)) {
                                  return "Invalid username format.";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            width: 250.0,
                            child: TextFormField(
                              controller: passwordController,
                              autocorrect: false,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: "密码"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password can not be empty.";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CupertinoButton.filled(
                              pressedOpacity: 0.6,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 110.0),
                              child: const Text("登录"),
                              onPressed: () async {
                                FocusScope.of(context).requestFocus(
                                  FocusNode(),
                                );
                                final currentState = formKey.currentState;
                                if (currentState != null && currentState.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("正在发送登录信息..."))
                                  );
                                  var authAccessInfo = await Auth.postLoginInfo(usernameController.text, passwordController.text);
                                  if (authAccessInfo != null) {
                                    BackendService.loginUser(authAccessInfo.accessToken);
                                    Get.offAll(const NineSongApp());
                                  } else {
                                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("登录失败"))
                                    );
                                  }
                                }
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CupertinoButton(
                                    child: const Text("重置密码", style: TextStyle(color: Colors.black54),),
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(
                                        FocusNode(),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("暂无法重置密码"),
                                        ),
                                      );
                                    }
                                ),
                                CupertinoButton(
                                    child: const Text("注册", style: TextStyle(color: Colors.blueAccent),),
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(
                                        FocusNode(),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("暂无法注册"),
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}