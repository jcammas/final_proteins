// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proteins_example/models/signup_form_model.dart';
import 'package:proteins_example/providers/auth_provider.dart';
import 'package:proteins_example/views/auth/login_view.dart';
import 'package:provider/provider.dart';

import '../../utils/config_theme.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const String routeName = '/register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  late SignupForm signupForm;
  FormState? get form => key.currentState;

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  TextEditingController mailController = TextEditingController();

  bool hidePassword = true;
  String date = "";
  String error = "";

  int index = 0;

  DateTime selectedDate = DateTime.now();

  final snackBar = const SnackBar(
    //backgroundColor: Colors.blueGrey,
    content: Text(
      'Votre compte a bien été créé.',
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
    ),
  );

  final snackBarError = const SnackBar(
    backgroundColor: Color.fromARGB(255, 172, 0, 0),
    content: Text(
      "Une erreur s'est produite. Votre compte n'a pas été créé, veuillez vérifier vos informations et réessayer.",
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
    ),
  );

  @override
  void initState() {
    signupForm = SignupForm(
      password: '',
      email: '',
      username: '',
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        currentTheme.addListener(() {
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    mailController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (form!.validate()) {
      form!.save();
      final error = await Provider.of<AuthProvider>(context, listen: false)
          .signup(signupForm);
      if (error == null) {
        Navigator.pushNamed(context, LoginViewController.routename);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isthisDarkMode = box.get('currentTheme');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/logoicon.png',
                  fit: BoxFit.contain,
                ),
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
          // backgroundColor: Colors.blueGrey,
          body: Column(
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
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          shadowColor: Colors.grey[200],
                          //color: Colors.white,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color(0xFFD0D0D0), width: 1.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.02,
                                          bottom: screenHeight * 0.000,
                                          left: screenWidth * 0.00,
                                          right: screenWidth * 0.00),
                                      child: Column(
                                        children: const [
                                          Text(
                                            "Créer mon compte",
                                            style: TextStyle(
                                              //color: Color(0XFF434343),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Form(
                                key: key,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 0),
                                          title: TextFormField(
                                            controller: nameController,
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              labelText: "Nom d'utilisateur",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                error = "";
                                              });
                                            },
                                            onSaved: (newValue) {
                                              signupForm.username = newValue!;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                          )),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 0),
                                          title: TextFormField(
                                            controller: mailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              labelText: 'Email',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                error = "";
                                              });
                                            },
                                            onSaved: (newValue) {
                                              signupForm.email = newValue!;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                          )),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 0),
                                        title: TextFormField(
                                          controller: passwordController,
                                          obscureText: hidePassword == true
                                              ? true
                                              : false,
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
                                            signupForm.password = newValue!;
                                          },
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 0),
                                        title: TextFormField(
                                          controller: repeatPasswordController,
                                          obscureText: hidePassword == true
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            labelText: 'Confirmer mot de passe',
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
                                          onChanged: (value) {
                                            setState(() {
                                              error = "";
                                            });
                                          },
                                          onSaved: (newValue) {
                                            signupForm.password = newValue!;
                                          },
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              ButtonBar(
                                alignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (mailController.text == "") {
                                        setState(() {
                                          error =
                                              "Veuillez rentrer votre adresse mail.";
                                        });
                                        return;
                                      }

                                      if ((passwordController.text == "") ||
                                          (repeatPasswordController.text ==
                                              "")) {
                                        setState(() {
                                          error =
                                              "Veuillez rentrer votre mot de passe.";
                                        });
                                        return;
                                      }
                                      if (passwordController.text !=
                                          repeatPasswordController.text) {
                                        setState(() {
                                          error =
                                              "Les mots de passe ne sont pas égaux.";
                                        });
                                        return;
                                      }

                                      try {
                                        submitForm();
                                      } catch (e) {
                                        rethrow;
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      elevation: 0.0,
                                      primary: const Color(0xFF4078bf),
                                    ),
                                    child: Text(
                                      'Créer mon compte'.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.015,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
