// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proteins_example/models/signin_form_model.dart';
import 'package:proteins_example/models/user_model.dart';
import 'package:proteins_example/providers/auth_provider.dart';
import 'package:proteins_example/providers/user_provider.dart';
import 'package:proteins_example/views/auth/signup_view.dart';
import 'package:proteins_example/views/home/home.dart';
import 'package:provider/provider.dart';

import '../../utils/config_theme.dart';

class LoginViewController extends StatefulWidget {
  const LoginViewController({Key? key}) : super(key: key);

  static const String routename = '/login';

  @override
  State<LoginViewController> createState() => _LoginViewControllerState();
}

class _LoginViewControllerState extends State<LoginViewController> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late SigninForm signinForm;
  FormState? get form => key.currentState;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  String error = "";

  @override
  void initState() {
    signinForm = SigninForm(email: '', password: '');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        currentTheme.addListener(() {
          setState(() {});
        });
      }
    });
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      final response = await Provider.of<AuthProvider>(context, listen: false)
          .signin(signinForm);
      if (response is User) {
        Provider.of<UserProvider>(context, listen: false).updateUser(response);
        Navigator.pushNamed(context, HomeViewController.routename);
      } else {
        setState(() {
          error = response['error'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isthisDarkMode = box.get('currentTheme');
    //print(isthisDarkMode);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/logoicon.png',
              fit: BoxFit.contain,
            ),
          ),
          title: const Text('Fluttery Gelatine'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.dark_mode_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                currentTheme.switchTheme();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Container(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: screenWidth * 0.5,
                  child: Image.asset(
                    isthisDarkMode
                        ? 'assets/images/logodark.png'
                        : 'assets/images/logolight.png',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  color:
                      isthisDarkMode ? const Color(0XFF434343) : Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(color: Color(0xFFD0D0D0), width: 1.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      const Text("Se connecter",
                          style: TextStyle(
                            // ignore: use_full_hex_values_for_flutter_colors
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Form(
                        key: key,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                title: TextFormField(
                                  autocorrect: false,
                                  autofillHints: const [AutofillHints.email],
                                  controller: usernameController,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                  ),
                                  onSaved: (newValue) {
                                    signinForm.email = newValue!;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                title: TextFormField(
                                  controller: passwordController,
                                  obscureText:
                                      hidePassword == true ? true : false,
                                  decoration: InputDecoration(
                                    labelText: 'Mot de passe',
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7),
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: hidePassword == true
                                          ? const Icon(
                                              Icons.visibility,
                                              color: Color(0xFF4078bf),
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ),
                                  onSaved: (newValue) {
                                    signinForm.password = newValue!;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: error != ""
                            ? Text(
                                error,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : null,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: submitForm,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.65,
                                    1),
                                primary: const Color(0xFF4078bf),
                                elevation: 0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'se connecter'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 10),
                        child: Column(
                          children: [
                            const Text(
                              "Vous n'avez pas de compte ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                // ignore: use_full_hex_values_for_flutter_colors
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, Register.routeName),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      primary: const Color(0xFF4078bf),
                                      elevation: 0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "s'inscrire".toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.002),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
