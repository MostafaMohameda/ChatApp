
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../category/Category_Button.dart';
import '../category/Category_TextField.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snackbar.dart';

class RegisterPage extends StatefulWidget {
   RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
String? email,password;

bool isLoading =false;

GlobalKey<FormState>formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 80,),
                Container(height: 100,child: Image.asset(kLogo)),
                Text('ScolarChat',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 30,fontFamily: 'Pacifico'),),
                SizedBox(height: 80,),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Register',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ],
                ),
                const SizedBox(height: 10,),
                CustomTextFormField(hintText: 'Email',
                onChange: (value){
                  email=value;
                },
                ),
                const SizedBox(height: 10,),
                CustomTextFormField(
                  obscuretext: true,
                  hintText: 'Password',
                  onChange: (value){
                    password=value;
                  },),
                const SizedBox(height: 20,),
                CustomButton(text: 'Register',
                  ontap: ()async{
                  if (formKey.currentState!.validate()) {
                    isLoading=true;
                    setState((){
                    });
                    try {
                      await RegisterUser();
                      ShowSnackBar(context,'Success');
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ShowSnackBar(context,'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        ShowSnackBar(context,'The account already exists for that email.');
                      }
                    } catch (e) {
                      ShowSnackBar(context,'${e.toString()}');
                      print(e.toString());
                    }
                  }
                  isLoading=false;
                  setState((){});
                  Navigator.pushNamed(context, 'ChatPage',arguments: email);
                  },),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('dont have an account?  ',style: TextStyle(color: Colors.white,fontSize: 15),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:Text('Login',style: TextStyle(color: Color(0xfffC7EDE6),fontSize: 15),),),
                    SizedBox(height: 80,),
                  ],)
              ],
            ),
          ),
        ) ,

      ),
    );
  }

  Future<void> RegisterUser() async {
    UserCredential user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
