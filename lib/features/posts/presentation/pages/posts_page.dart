import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts/posts_bloc.dart';
import 'post_add_update_page.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/post_widgets/message_diplay_widget.dart';
import '../widgets/post_widgets/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<PostsBloc,PostsState>(
          builder: (context,state){
            log('state is $state');
           if(state is LoadedPostsState){
            return RefreshIndicator(
              onRefresh:()async{
                BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
              },
              child: PostListWidget(posts:state.posts));
          }else if(state is ErrorPostState){
            return MessageDiplayWidget(
              message:state.message
            );
          }
          return const LoadingWidget();
        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PostAddUpdatePage(isUpdatePost: false)));
      },child: const Icon(Icons.add),),
    );
  }
}