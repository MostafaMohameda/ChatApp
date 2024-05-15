import 'package:chat/category/Category_TextField.dart';
import 'package:chat/category/Category_Button.dart';
import 'package:chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snackbar.dart';
import 'Register_Page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                    height: 100,
                    child: Image.asset(kLogo)),
                Text(
                  'ScolarChat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Pacifico'),
                ),
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'Email',
                  onChange: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                     obscuretext: true,
                  hintText: 'Password',
                  onChange: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'LOGIN',
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await LoginUser();
                        Navigator.pushNamed(context,'ChatPage',arguments: email);
                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ShowSnackBar(context, 'User Not Found');
                        } else if (e.code == 'wrong-password') {
                          ShowSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        ShowSnackBar(context, e.toString());
                        print(e.toString());
                      }
                    }
                    isLoading = false;
                    setState(() {
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont have an account?  ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: Text(
                        'Register',
                        style:
                            TextStyle(color: Color(0xfffC7EDE6), fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> LoginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
