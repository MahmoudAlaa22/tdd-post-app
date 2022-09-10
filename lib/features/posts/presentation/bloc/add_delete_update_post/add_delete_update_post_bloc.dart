import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messags.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUsecase addPost;
  final DeletePostUsecase deletePost;
  final UpdatePostUsecase updatePost;

  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await addPost(event.post);
        emit(_mapFailuerOrDoneMessage(
            either: failureOrDoneMessage, message: ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await updatePost(event.post);
        emit(_mapFailuerOrDoneMessage(
            either: failureOrDoneMessage, message: UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());

        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_mapFailuerOrDoneMessage(
            either: failureOrDoneMessage, message: DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _mapFailuerOrDoneMessage({
    required Either<Failure, Unit> either,
    required String message,
  }) {
    return either.fold(
        (failure) => ErrorAddDeleteUpdatePostState(
            message: _mapFailuerToMessage(failure)),
        (_) => MessgaeAddDeleteUpdatePostState(message: message));
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
