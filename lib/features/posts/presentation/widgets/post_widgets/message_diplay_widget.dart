import 'package:flutter/material.dart';
class MessageDiplayWidget extends StatelessWidget {
  final String message;
  const MessageDiplayWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: Text(message,
      style: const TextStyle(fontSize: 25,),textAlign:TextAlign.center ,),
    );
  }
}