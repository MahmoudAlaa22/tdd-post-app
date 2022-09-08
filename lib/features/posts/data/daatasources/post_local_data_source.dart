import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cacheDPosts(List<PostModel> postModel);
}

const CACHED_POSTS = 'CACHED_POSTS';

class PostLocalDataSourceImp implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cacheDPosts(List<PostModel> postModel) {
    final postModelToJson =
        postModel.map<Map<String, dynamic>>((e) => e.toJSON()).toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final jsonToString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonToString != null) {
      List decodeJsonData = json.decode(jsonToString);
      List<PostModel> jsonToData =
          decodeJsonData.map<PostModel>((e) => PostModel.fromJSON(e)).toList();
      return Future.value(jsonToData);
    } else {
      throw EmptyCachException();
    }
  }
}
