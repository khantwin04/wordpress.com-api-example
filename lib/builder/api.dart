import 'constant.dart';
import 'category_model.dart';
import 'post_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api.g.dart';

@RestApi(baseUrl: 'https://public-api.wordpress.com/wp/v2/sites/$url/')
abstract class Api{
  factory Api(Dio dio, String url) = _Api;

  @GET('categories?page={page}&per_page=20&_fields=id,count,description,name')
  Future<List<CategoryModel>> getCategory(@Path() int page);

  @GET('posts/?page={page}&per_page=10')
  Future<List<PostModel>> getLatestPost(@Path() int page);

  @GET('posts?categories[]={id}&page={page}&per_page=10')
  Future<List<PostModel>> getPostByCategory(@Path() int id,@Path() int page);

  @GET('posts?search={searchText}&page={page}&per_page=10')
  Future<List<PostModel>> searchPost(@Path() String searchText, @Path() int page);

  @GET('pages/{pageId}')
  Future<PostModel> getaboutUsPage(@Path() int pageId);

}