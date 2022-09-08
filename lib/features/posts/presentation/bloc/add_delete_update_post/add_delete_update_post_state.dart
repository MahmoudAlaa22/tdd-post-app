part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();
  
  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}
class LoadingAddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}
class ErrorAddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {
  final String error;

const  ErrorAddDeleteUpdatePostInitial({required this.error});
  @override
  List<Object> get props => [error];
}
class MessgaeAddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {
  final String message;

  const MessgaeAddDeleteUpdatePostInitial({required this.message});
    @override
  List<Object> get props => [message];
}
