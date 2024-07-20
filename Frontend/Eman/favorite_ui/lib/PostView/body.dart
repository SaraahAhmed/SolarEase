
// // import 'package:dio/dio.dart';
// // import 'package:favorite_ui/APIService/favoriteModel.dart';
// // import 'package:favorite_ui/PostView/favoriteCard.dart';
// // import 'package:flutter/material.dart';


// // class FavoritBody extends StatefulWidget {
// //   @override
// //   _FavoritBodyState createState() => _FavoritBodyState();
// // }

// // class _FavoritBodyState extends State<FavoritBody> {
// //   final FavoriteService _favoriteService = FavoriteService(Dio());
// //   late Future<List<FavoritePostmodel>> _allPostsFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _allPostsFuture = _favoriteService.getFavoritePosts();
// //   }

// //   // Function to handle deletion of favorite post
// //   void onDelete(FavoritePostmodel post) {
// //     setState(() {
// //       // Update state to remove the deleted post
// //       _allPostsFuture = _allPostsFuture.then((posts) {
// //         return posts.where((p) => p.ID != post.ID).toList();
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: FutureBuilder<List<FavoritePostmodel>>(
// //         future: _allPostsFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('No posts available'));
// //           } else {
// //             final posts = snapshot.data!;
// //             return ListView.builder(
// //               itemCount: posts.length,
// //               itemBuilder: (context, index) {
// //                 return FavoritePostCard(
// //                   favoritepost: posts[index],
// //                   onDelete: onDelete, // Pass onDelete callback
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:dio/dio.dart';
// import 'package:favorite_ui/PostView/favoriteCard.dart';
// import 'package:flutter/material.dart';
// import 'package:marketplace_ui/PostView/APIForRemovePosts/favoriteModel.dart';
// import 'package:marketplace_ui/PostView/favoriteCard.dart';

// class FavoritBody extends StatefulWidget {
//   @override
//   _FavoritBodyState createState() => _FavoritBodyState();
// }

// class _FavoritBodyState extends State<FavoritBody> {
//   final FavoriteService _favoriteService = FavoriteService(Dio());
//   late Future<List<FavoritePostmodel>> _allPostsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _allPostsFuture = _favoriteService.gatFavoritePosts();
//   }

//   void _deletePost(int id) async {
//     try {
//       await _favoriteService.deletePost(id);
//       setState(() {
//         _allPostsFuture = _favoriteService.gatFavoritePosts();
//       });
//     } catch (e) {
//       print('Failed to delete post: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<FavoritePostmodel>>(
//         future: _allPostsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No posts available'));
//           } else {
//             final posts = snapshot.data!;
//             return ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 post.isFavorite = true; // Set isFavorite to true
//                 return FavoritePostCard(favoritepost: post, onDelete: (FavoritePostmodel ) {  },);
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:favorite_ui/APIService/favoriteModel.dart';
import 'package:favorite_ui/PostView/favoriteCard.dart';
import 'package:flutter/material.dart';


class FavoritBody extends StatefulWidget {
  @override
  _FavoritBodyState createState() => _FavoritBodyState();
}

class _FavoritBodyState extends State<FavoritBody> {
  final FavoriteService _favoriteService = FavoriteService(Dio());
  late Future<List<FavoritePostmodel>> _allPostsFuture;

  @override
  void initState() {
    super.initState();
    _allPostsFuture = _favoriteService.getFavoritePosts();
  }

  // Function to handle deletion of favorite post
  void onDelete(FavoritePostmodel post) {
    setState(() {
      // Update state to remove the deleted post
      _allPostsFuture = _allPostsFuture.then((posts) {
        return posts.where((p) => p.ID != post.ID).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FavoritePostmodel>>(
        future: _allPostsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return FavoritePostCard(
                  favoritepost: posts[index],
                  onDelete: onDelete, // Pass onDelete callback
                );
              },
            );
          }
        },
      ),
    );
  }
}
