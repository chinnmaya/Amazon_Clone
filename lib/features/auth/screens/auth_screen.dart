import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/serivices/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum Auth { signin, signup }

class Authscreen extends StatefulWidget {
  const Authscreen({Key? key}) : super(key: key);
  static const String routName = "/auth-screen";

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  Auth _auth = Auth.signup;
  final _signupfromkey = GlobalKey<FormState>();
  final _signinfromkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
  }

  void signupUser() {
    authService.signUpUser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        name: _namecontroller.text);
  }

  void signinUser() {
    authService.signInUser(
      context: context,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Create an account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                )),
            if (_auth == Auth.signup)
              Container(
                padding: EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signupfromkey,
                  child: Column(
                    children: [
                      CustomtextField(
                        textEditingController: _namecontroller,
                        hinttext: "Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomtextField(
                        textEditingController: _emailcontroller,
                        hinttext: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomtextField(
                        textEditingController: _passwordcontroller,
                        hinttext: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomBtn(
                          text: "Sign Up",
                          onpressed: () {
                            if (_signupfromkey.currentState!.validate())
                              signupUser();
                          })
                    ],
                  ),
                ),
              ),
            ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Sign-In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                )),
            if (_auth == Auth.signin)
              Container(
                padding: EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signinfromkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomtextField(
                        textEditingController: _emailcontroller,
                        hinttext: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomtextField(
                        textEditingController: _passwordcontroller,
                        hinttext: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomBtn(
                          text: "Sign IN",
                          onpressed: () {
                            if (_signinfromkey.currentState!.validate())
                              signinUser();
                          })
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
