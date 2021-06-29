import 'dart:async';
import 'post_model.dart';
import 'favPostRepo.dart';

class FavPostBloc {
  final _PostRepository = FavpostRepository();

  final _postsController = StreamController<List<PostModel>>.broadcast();

  Stream<List<PostModel>> get posts => _postsController.stream;

  FavPostBloc() {
    getFavposts();
  }

  Future<List<PostModel>> getFavposts({String query, int page}) async {
    final List<PostModel> posts =
        await _PostRepository.getAllFavpost(query: query, page: page);
    _postsController.sink.add(posts);
    return posts;
  }

  getFavPost(int id) async {
    final PostModel Post = await _PostRepository.getFavpost(id);
    return Post;
  }

  addFavPost(PostModel Post) async {
    await _PostRepository.insertFavpost(Post);
    getFavposts();
  }

  deleteFavPostById(int id) async {
    _PostRepository.deleteFavpostById(id);
    getFavposts();
  }

  dispose() {
    _postsController.close();
  }
}
