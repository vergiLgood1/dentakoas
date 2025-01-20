import 'package:denta_koas/src/cores/data/repositories/post.repository/post_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/tes.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ExplorePostController extends GetxController {
  static ExplorePostController get instance => Get.find();

  final postRepository = Get.put(PostRepository());
  final isLoading = false.obs;

  RxList<Post> lastChangePost = <Post>[].obs;
  RxList<Post> newestPosts = <Post>[].obs;
  RxList<Post> posts = <Post>[].obs;
  RxList<Post> featuredPosts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final fetchedPosts = await postRepository.getPosts();

      posts.assignAll(fetchedPosts);

      // filter
      featuredPosts.assignAll(
        fetchedPosts.where((post) => post.status == "Open").toList(),
      );

      newestPosts.assignAll(
        fetchedPosts.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt))
          ..take(3),
      );

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
