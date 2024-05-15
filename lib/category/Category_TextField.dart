import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key, required this.hintText,required this.onChange,obscuretext=false});
 final String hintText;
 Function(String)? onChange;
 bool? obscuretext;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: obscuretext!,
      validator: (data){
        if(data!.isEmpty){
          return 'Field is required ';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText:hintText ,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,),
        ),
      ),);
  }
}
