import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'JSONPlaceholderAPI',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class Post {
  int id;
  int userId;
  String title;
  String body;

  Post(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class HomeController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;

  final int postsPerPage = 10;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var response = await Dio()
          .get('https://jsonplaceholder.typicode.com/posts', queryParameters: {
        '_start': (currentPage.value - 1) * postsPerPage,
        '_limit': postsPerPage,
      });
      var list = response.data as List;
      if (list.isEmpty) {
        // No more posts to fetch, disable next page button
        currentPage.value = 10;
        Get.snackbar('No more posts', 'You have reached the end of the list.');
      } else {
        posts.value = list.map((e) => Post.fromJson(e)).toList();
      }
    } catch (e) {
      currentPage.value = 1;
      Get.snackbar(
        'Error',
        'An error occurred while fetching posts: No internet Connection',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.defaultDialog(
          title: "Retry",
          onConfirm: () {
            Navigator.of(Get.overlayContext as BuildContext).pop();
            fetchPosts();
          },
          onCancel: () =>
              Navigator.of(Get.overlayContext as BuildContext).pop(),
          textConfirm: "Retry",
          middleText: "Check your internet connection");
    } finally {
      isLoading(false);
    }
  }

  void nextPage() {
    currentPage.value++;
    fetchPosts();
  }

  void prevPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      fetchPosts();
    }
  }
}

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSONPlaceholderAPI'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  var post = controller.posts[index];
                  return Card(
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: controller.prevPage,
                disabledColor: Colors.grey,
                color: Colors.blue,
              ),
              Text('Page ${controller.currentPage}'),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: controller.nextPage,
                disabledColor: Colors.grey,
                color: Colors.blue,
              ),
            ],
          )),
    );
  }
}
