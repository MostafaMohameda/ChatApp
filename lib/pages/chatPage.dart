import 'package:chat/Models/info_Model.dart';
import 'package:chat/category/chat_buble.dart';
import 'package:chat/constants.dart';
import 'package:chat/pages/chatBubleforfriend.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatPage extends StatefulWidget {
   ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessageCollection);

  TextEditingController controller =TextEditingController();
  final _controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder:(context, snapshot){
        if(snapshot.hasData){
          List<Message> MessagesList=[];
          for(int i=0;i<snapshot.data!.docs.length;i++){
            MessagesList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo),
                  Text('Chat'),
                ],
              ),
            ),
            body:Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                      controller: _controller,
                      itemCount: MessagesList.length,
                      itemBuilder:(context,index){
                        return MessagesList[index].id==email? ChatBuble(message: MessagesList[index],)
                        :ChatBubleforfriend(message: MessagesList[index]);
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data){
                      messages.add({
                        kMessage:data,
                        kCreatedAt:DateTime.now(),
                        'id':email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn
                      );
                    },
                    decoration:InputDecoration(
                        suffixIcon: Icon(Icons.send,color: kPrimaryColor,),
                        hintText: 'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        )

                    ),
                  ),
                ),
              ],
            ) ,
          );
        }
        else {
         return Text('Loading...');
        }
      },
    );
  }
}
