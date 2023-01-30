//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Services
import '../services/media_service.dart';
import '../services/database_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/navigation_service.dart';

//Widgets
import 'package:sono_first/widgets/custom_input_field.dart';
// import '../widgets/rounded_button.dart';
import 'package:sono_first/widgets/rounded_image.dart';

//Providers
import '../providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  // final ref =
  //     FirebaseFirestore.instance.collection("otp")
  //     .doc("xFCQvMh40ukjLnPGgyqd");

  String? _otp;
  String? _userOtp;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorage;
  late NavigationService _navigation;

  String? _email;
  String? _password;
  String? _name;
  PlatformFile? _profileImage;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    // print(ref);
    return _buildUI();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildUI() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
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
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.06,
            vertical: _deviceHeight * 0.02,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _profileImageField(),
              const Text(
                "Upload a Picture",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: _deviceHeight * 0.05),
              _registerForm(),
              SizedBox(height: _deviceHeight * 0.05),
              _registerButton(),
              SizedBox(height: _deviceHeight * 0.02),
            ],
          ),
        ));
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
          (_file) {
            setState(
              () {
                _profileImage = _file;
              },
            );
          },
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
              key: UniqueKey(),
              image: _profileImage!,
              size: _deviceHeight * 0.15);
        } else {
          return RoundedImageNetwork(
              key: UniqueKey(),
              imagePath:
                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
              size: _deviceHeight * 0.15);
        }
      }(),
    );
  }

  Widget _registerForm() {
    return Container(
        height: _deviceHeight * 0.46,
        child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  onSaved: (_value) {
                    setState(() {
                      _name = _value;
                    });
                  },
                  regEx: r'.{8,}',
                  hintText: "Firstname Surname",
                  obscureText: false,
                  icons: const Icon(Icons.person,
                      color: Color.fromARGB(221, 97, 103, 190)),
                ),
                CustomTextFormField(
                    onSaved: (_value) {
                      setState(() {
                        setState(() {
                          _email = _value;
                        });
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
                CustomTextFormField(
                    onSaved: (_value) {
                      setState(() {
                        setState(() {
                          _password = _value;
                        });
                      });
                    },
                    regEx: r".{8,}",
                    icons: const Icon(
                      Icons.lock,
                      color: Color.fromARGB(221, 97, 103, 190),
                    ),
                    hintText: "Password",
                    obscureText: true),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'SonoFirst General Password',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                TextFormField(
                    onChanged: (_value) {
                      setState(() {
                        _userOtp = _value;
                      });
                    },
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(221, 97, 103, 190),
                      ),
                      hintText: "SonoFirst General Password",
                    ),
                    obscureText: true),
              ],
            )));
  }

  Widget _registerButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("otp")
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              _otp = doc["password"];
              // print(_otp);
            });
          });
          print(_otp);
          print(_userOtp);
          if (_otp == _userOtp) {
            if (_registerFormKey.currentState!.validate() &&
                _profileImage != null) {
              _registerFormKey.currentState!.save();
              String? _uid = await _auth.registerUserUsingEmailAndPassword(
                  _email!, _password!);
              print(_uid);
              String? _imageURL = await _cloudStorage.saveUserImageToStorage(
                  _uid!, _profileImage!);

              await _db.createUser(_uid, _email!, _name!, _imageURL!);
              await _auth.logout();
              await _auth.loginUsingEmailAndPassword(_email!, _password!);
            }
          }
        },
        child: const Text(
          'Register',
          style: TextStyle(
              color: Color.fromARGB(255, 105, 100, 221),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
