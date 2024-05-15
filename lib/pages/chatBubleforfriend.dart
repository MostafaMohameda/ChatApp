import 'package:chat/Models/info_Model.dart';
import 'package:chat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatBubleforfriend extends StatelessWidget {
  const ChatBubleforfriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
              topRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
          color: Color(0xff006D84),
        ),
        child: Text(message.message),
      ),
    );
  }
}
