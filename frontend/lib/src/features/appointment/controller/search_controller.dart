// search_post_controller.dart
import 'package:denta_koas/src/features/appointment/controller/explore.controller/explore_post_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/tes.dart';
import 'package:get/get.dart';

class SearchPostController extends GetxController {
  final RxString query = ''.obs;
  final RxString selectedSort = 'Name'.obs;
  final RxList<String> suggestions = <String>[].obs;

  // Reference ke ExplorePostController untuk mengakses data posts
  final ExplorePostController exploreController =
      Get.put(ExplorePostController());

  void setSort(String sort) {
    selectedSort.value = sort;
    query.value = '';
    suggestions.clear();
    updateSuggestions('');
  }

  void updateSearch(String newQuery) {
    query.value = newQuery;
    updateSuggestions(newQuery);
  }

  void updateSuggestions(String searchQuery) {
    List<String> newSuggestions = [];
    final posts = exploreController.posts;

    switch (selectedSort.value) {
      case 'Name':
        newSuggestions = posts
            .map((post) => post.user.fullName)
            .where((name) =>
                name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        break;
      case 'University':
        newSuggestions = posts
            .map((post) => post.user.koasProfile?.university ?? '')
            .where(
                (uni) => uni.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        break;
      case 'Treatment':
        newSuggestions = posts
            .map((post) => post.treatment.alias)
            .where((treatment) =>
                treatment.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        break;
      case 'Title':
        newSuggestions = posts
            .map((post) => post.title)
            .where((title) =>
                title.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        break;
    }

    suggestions.value = newSuggestions.toSet().toList(); // Remove duplicates
  }

  List<Post> getSortedPosts() {
    List<Post> sortedPosts = List.from(exploreController.posts);

    switch (selectedSort.value) {
      case 'Popularity':
        sortedPosts.sort((a, b) => (b.likes.length).compareTo(a.likes.length));
        break;
      case 'Newest':
        sortedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Oldest':
        sortedPosts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
    }

    if (query.value.isNotEmpty &&
        ['Name', 'University', 'Treatment', 'Title']
            .contains(selectedSort.value)) {
      sortedPosts = sortedPosts.where((post) {
        switch (selectedSort.value) {
          case 'Name':
            return post.user.fullName
                .toLowerCase()
                .contains(query.value.toLowerCase());
          case 'University':
            return (post.user.koasProfile?.university ?? '')
                .toLowerCase()
                .contains(query.value.toLowerCase());
          case 'Treatment':
            return post.treatment.alias
                .toLowerCase()
                .contains(query.value.toLowerCase());
          case 'Title':
            return post.title.toLowerCase().contains(query.value.toLowerCase());
          default:
            return false;
        }
      }).toList();
    }

    return sortedPosts;
  }
}
