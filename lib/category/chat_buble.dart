import 'package:chat/Models/info_Model.dart';
import 'package:chat/constants.dart';
import 'package:flutter/cupertino.dart';


class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15),
              topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
          color: kPrimaryColor,
        ),
        child: Text(message.message),
      ),
    );
  }
}
