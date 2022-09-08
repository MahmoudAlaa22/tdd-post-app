import 'package:dartz/dartz.dart';
import 'package:tdd_post_test/core/error/failures.dart';
import 'package:tdd_post_test/features/posts/domain/entities/post.dart';

abstract class PostRepo {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> updatePost(Post post);
}
