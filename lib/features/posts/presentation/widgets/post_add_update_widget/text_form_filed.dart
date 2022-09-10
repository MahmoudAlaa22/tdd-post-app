import 'package:flutter/material.dart';

class TextFromFieldWidget extends StatelessWidget {
  const TextFromFieldWidget({
    Key? key,
    required this.name,
    required this.multiLine,
    required this.controller,
  }):super(key: key);

  final TextEditingController controller;
  final String name;
  final bool multiLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: name),
        validator: (value) => value!.isEmpty ? '$name can not be empty' : null,
        maxLines: multiLine ? 6 : 1,
        minLines: multiLine ? 6 : 1,
      ),
    );
  }
}
