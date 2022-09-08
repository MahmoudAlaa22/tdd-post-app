// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Post extends Equatable {
final int id;
final int title;
final int body;
  const Post({
    required this.id,
    required this.title,
    required this.body,
  });
  
  @override
  List<Object?> get props => [id,title,body];

  
}
