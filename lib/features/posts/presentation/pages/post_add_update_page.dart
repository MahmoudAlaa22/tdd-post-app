import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'posts_page.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../domain/entities/post.dart';
import '../widgets/post_add_update_widget/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);
  final Post? post;
  final bool isUpdatePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child:
              BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessgaeAddDeleteUpdatePostState) {
                SnackBarMessage.showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage.showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const LoadingWidget();
              }
              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          ),
        ),
      ),
    );
  }
}
