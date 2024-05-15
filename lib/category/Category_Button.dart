import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text,required this.ontap});
String text;
VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color: Colors.white,),
        child: Text(text,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),
      ),
    );
  }
}
