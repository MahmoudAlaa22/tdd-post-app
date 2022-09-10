import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/posts/data/daatasources/post_local_data_source.dart';
import 'features/posts/data/daatasources/post_remote_data_source.dart';
import 'features/posts/data/repositories/post_repo_imp.dart';
import 'features/posts/domain/repositories/post_repo.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
        addPost: sl(),
        deletePost: sl(),
        updatePost: sl(),
      ));

  ///Usecases
  sl.registerLazySingleton(() => AddPostUsecase(postRepo: sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(postRepo: sl()));
  sl.registerLazySingleton(() => GetAllPostsUsecase(postRepo: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(postRepo: sl()));
  ///Repository
  sl.registerLazySingleton<PostRepo>(() => PostRepoImp(networkInfo: sl(),
   postRemoteDataSource: sl(),
    postLocalDataSource: sl(),));
  ///Datasources
sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImp(sharedPreferences: sl()));
sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImp(client: sl()));
  ///Core
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  ///External
  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}
