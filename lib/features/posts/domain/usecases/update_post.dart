import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repo.dart';

class UpdatePostUsecase{
  final PostRepo postRepo;
  UpdatePostUsecase({
    required this.postRepo,
  });
  Future<Either<Failure, Unit>> call(Post post){
    return postRepo.updatePost(post);
  }
}