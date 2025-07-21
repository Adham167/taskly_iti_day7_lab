import 'package:flutter/material.dart';
import 'package:multi_creen_flutter_app/models/favorites_store.dart';
import 'package:multi_creen_flutter_app/models/post_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<PostModel> allPosts;

  CustomSearchDelegate({required this.allPosts});

  List<PostModel> filteredPosts = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filteredPosts = allPosts
        .where((post) =>
            post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.body.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return StatefulBuilder(
      builder: (context, setState) {
        return ListView.builder(
          itemCount: filteredPosts.length,
          itemBuilder: (context, index) {
            final post = filteredPosts[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.body,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            post.isfavourite ? Icons.favorite : Icons.favorite_border,
                            color: post.isfavourite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              post.isfavourite = !post.isfavourite;
                              if (post.isfavourite) {
                                FavoritesStore.favoritePosts.add(post);
                              } else {
                                FavoritesStore.favoritePosts.remove(post);
                              }
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
