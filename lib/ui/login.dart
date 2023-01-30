import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sono_first/providers/authentication_provider.dart';
import 'package:sono_first/services/navigation_service.dart';
import 'package:sono_first/widgets/custom_input_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //bool isRememberMe = false;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  Widget buildName() {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const Text(
            'Email',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              icons: const Icon(
                Icons.mail,
                color: Color.fromARGB(221, 97, 103, 190),
              ),
              hintText: "name@email.com",
              obscureText: false),
          const SizedBox(height: 40),
          const Text(
            'Password',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              regEx: r".{8,}",
              icons: const Icon(
                Icons.lock,
                color: Color.fromARGB(221, 97, 103, 190),
              ),
              hintText: "Password",
              obscureText: true),
        ],
      ),
    );
  }

  // Widget buildPassword() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       const Text(
  //         'Password',
  //         style: TextStyle(
  //             color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: const [
  //               BoxShadow(
  //                   color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
  //             ]),
  //         height: 60,
  //         child: const TextField(
  //           obscureText: true,
  //           style: TextStyle(color: Color.fromARGB(221, 0, 0, 0)),
  //           decoration: InputDecoration(
  //               border: InputBorder.none,
  //               contentPadding: EdgeInsets.only(top: 14),
  //               prefixIcon: Icon(
  //                 Icons.lock,
  //                 color: Color.fromARGB(221, 97, 103, 190),
  //               ),
  //               hintText: 'Password',
  //               hintStyle: TextStyle(color: Colors.black38)),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget buildForgotPasswordbtn() {
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: TextButton(
  //       onPressed: () => print('Forgot Password pressed'),
  //       child: const Text(
  //         'Forgot Password',
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildRememberCD() {
  //   return Container(
  //       height: 20,
  //       child: Row(
  //         children: <Widget>[
  //           Theme(
  //               data: ThemeData(unselectedWidgetColor: Colors.white),
  //               child: Checkbox(
  //                 value: isRememberMe,
  //                 checkColor: Colors.green,
  //                 activeColor: Colors.white,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     isRememberMe = value!;
  //                   });
  //                 },
  //               )),
  //           const Text('Remember me',
  //               style: TextStyle(
  //                   color: Colors.white, fontWeight: FontWeight.bold)),
  //         ],
  //       ));
  // }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            _auth.loginUsingEmailAndPassword(_email!, _password!);
          }
        },
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Color.fromARGB(255, 105, 100, 221),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () => _navigation.navigatrToRoute('/register'),
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          'Don\'t have an account?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color.fromARGB(255, 105, 204, 191),
                        Color.fromARGB(255, 107, 170, 205),
                        Color.fromARGB(255, 108, 144, 215),
                        Color.fromARGB(255, 105, 100, 221)
                      ])),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),
                        buildName(),
                        const SizedBox(height: 20),
                        // buildForgotPasswordbtn(),
                        // buildRememberCD(),
                        const SizedBox(height: 50),
                        buildLoginBtn(),
                        _registerAccountLink(),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
