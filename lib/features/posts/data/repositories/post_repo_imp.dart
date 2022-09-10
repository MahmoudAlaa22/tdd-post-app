import 'dart:developer';

import '../../../../core/error/exception.dart';
import '../daatasources/post_local_data_source.dart';
import '../daatasources/post_remote_data_source.dart';
import '../models/post_model.dart';
import '../../domain/entities/post.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/post_repo.dart';

import '../../../../core/network/network_info.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepoImp implements PostRepo {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;

  PostRepoImp({
    required this.networkInfo,
    required this.postRemoteDataSource,
    required this.postLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotPosts = await postRemoteDataSource.getAllPosts();
        log('remotPosts is ${remotPosts.first.title}');
        await postLocalDataSource.cacheDPosts(remotPosts);
        return Right(remotPosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCachException {
        return Left(EmptyCachFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(title: post.title, body: post.body);
    return _getMessage(() => postRemoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return _getMessage(() => postRemoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
