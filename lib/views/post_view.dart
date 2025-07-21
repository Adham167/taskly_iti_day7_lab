import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_creen_flutter_app/models/favorites_store.dart';
import 'package:multi_creen_flutter_app/models/post_model.dart';
import 'package:multi_creen_flutter_app/views/favourite_view.dart';
import 'package:multi_creen_flutter_app/widgets/search_widget.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<PostModel> posts = [];
  final String errMessage = "not found";
  @override
  void initState() {
    super.initState();
    _getposts();
  }

  Future<void> _getposts() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.get(uri);
    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<PostModel> fetchedposts =
            data.map((json) => PostModel.fromJson(json)).toList();
        setState(() {
          posts = fetchedposts;
        });
      } else {
        throw ("There was an error please try again");
      }
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Posts", style: TextStyle(color: Colors.white)),
            Spacer(),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(allPosts: posts),
                );
              },
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[900],
      ),

      body:
          posts.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Column(
                        children: [
                          Text(
                            posts[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            posts[index].body,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      posts[index].isfavourite =
                                          !posts[index].isfavourite;
                                      if (posts[index].isfavourite == true) {
                                        FavoritesStore.favoritePosts.add(
                                          posts[index],
                                        );
                                      } else {
                                        FavoritesStore.favoritePosts.remove(
                                          posts[index],
                                        );
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    posts[index].isfavourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
