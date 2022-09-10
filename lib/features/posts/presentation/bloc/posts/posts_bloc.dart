import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      log('event is $event');
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailuerToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailuerToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailuerToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostState(message: _mapFailuerToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailuerToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCachFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error ,Please try again later";
    }
  }
}
