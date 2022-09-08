// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tdd_post_test/features/posts/domain/repositories/post_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUsecase {
  final PostRepo postRepo;
  GetAllPostsUsecase({
    required this.postRepo,
  });
  Future<Either<Failure, List<Post>>> call(){
    return postRepo.getAllPosts();
  }
}
