import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../../domain/entities/post.dart';
import 'text_form_filed.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);
  final bool isUpdatePost;
  final Post? post;
  @override
  State<FormWidget> createState() => FforWwidgetState();
}

class FforWwidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  void validateFormThenUpdateOrAdd() {
    final keyState = _formKey.currentState;
    if (keyState!.validate()) {
      final Post post = Post(
        id: widget.isUpdatePost ? widget.post!.id : 0,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFromFieldWidget(
              controller: _titleController,
              multiLine: false,
              name: 'Title',
            ),
            TextFromFieldWidget(
              controller: _bodyController,
              multiLine: true,
              name: 'Body',
            ),
            ElevatedButton.icon(
              onPressed: validateFormThenUpdateOrAdd,
              icon: const Icon(Icons.add),
              label: Text(widget.isUpdatePost ? 'Update' : 'Add'),
            )
          ],
        ));
  }
}

