import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repo.dart';

class AddPostUsecase{
  final PostRepo postRepo;
  AddPostUsecase({
    required this.postRepo,
  });
  Future<Either<Failure, Unit>> call(Post post){
    return postRepo.addPost(post);
  }
}