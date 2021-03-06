import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'get_category_cubit.dart';
import 'get_latest_post_cubit.dart';
import 'wp_repository.dart';
import 'api.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

var getIt = GetIt.I;

void locator(String url){
  Dio dio = Dio();
  // To run json decoding in background
  dio.transformer = FlutterTransformer();
  // For caching data
  /*dio.interceptors.add(
      DioCacheManager(
          CacheConfig(baseUrl: 'https://public-api.wordpress.com/wp/v2/sites/peacesiteanime.wordpress.com/'))
          .interceptor);*/
  getIt.registerLazySingleton(() => dio);

  Api api = Api(getIt.call(), url);
  getIt.registerLazySingleton(() => api);

  WpRepsitory wpRepsitory = WpRepsitory(getIt.call());
  getIt.registerLazySingleton(() => wpRepsitory);

  GetCategoryCubit getCategoryCubit = GetCategoryCubit(getIt.call());
  getIt.registerLazySingleton(() => getCategoryCubit);

  GetLatestPostCubit getLatestPostCubit = GetLatestPostCubit(getIt.call());
  getIt.registerLazySingleton(() => getLatestPostCubit);


}