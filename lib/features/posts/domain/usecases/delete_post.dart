import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repo.dart';

class DeletePostUsecase{
  final PostRepo postRepo;
  DeletePostUsecase({
    required this.postRepo,
  });
  Future<Either<Failure, Unit>> call(int postId){
    return postRepo.deletePost(postId);
  }
}