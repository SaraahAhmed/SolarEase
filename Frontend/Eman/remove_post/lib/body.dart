// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:remove_post/APIForRemovePosts/removedpost.dart';
// import 'package:remove_post/main.dart';
// import 'package:remove_post/removeCard.dart';

// class RomveBody extends StatelessWidget {
//   //const RomveBody({super.key});
//   Future<RemovedPost> allPosts = RemovedService(Dio()).getAllPosts();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         flexibleSpace: 
//           SizedBox(
//                   height: height(250),
//                   width: double.infinity,
//                   child: Center(
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: 0,
//                           right: 0,
//                           child: Image.asset(
//                             'assets/upper.png',
//                             fit: BoxFit.fill,
//                             width: width(370),
//                             height: height(60),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                              //   Navigator.pop(context);
//                                 print('Arrow tapped');
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 16),
//                                 child: Image.asset(
//                                   'assets/arrow.png',
//                                   width: width(150),
//                                   height: height(150),
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               'Your Posts',
//                               style: TextStyle(
//                                 fontSize: 25.0 * t,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0x0ff063221),
//                               ),
//                             ),
//                             SizedBox(
//                               width: width(166),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//       ),
//         body: Column(
//           children: [
//             Expanded(
//               flex: 7, // Adjust the flex value as needed
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return RemoveCard();
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remove_post/APIForRemovePosts/removedpost.dart';
import 'package:remove_post/removeCard.dart';

class RemoveBody extends StatefulWidget {
  @override
  _RemoveBodyState createState() => _RemoveBodyState();
}

class _RemoveBodyState extends State<RemoveBody> {
  final RemovedService _removedService = RemovedService(Dio());
  late Future<List<RemovedPost>> _allPostsFuture;

  @override
  void initState() {
    super.initState();
    _allPostsFuture = _removedService.getAllPosts();
  }

  void _deletePost(int id) async {
    try {
      await _removedService.deletePost(id);
      setState(() {
        // Refresh the list of posts after deletion
        _allPostsFuture = _removedService.getAllPosts();
      });
    } catch (e) {
      print('Failed to delete post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SizedBox(
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/upper.png',
                    fit: BoxFit.fill,
                    width: 200,
                    height: 80,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pop(context);
                        print('Arrow tapped');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Image.asset(
                          'assets/arrow.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Text(
                      'Your Posts',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff063221),
                      ),
                    ),
                    SizedBox(
                      width: 166,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<RemovedPost>>(
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
                return RemoveCard(
                  removedPost: posts[index],
                  onDelete: _deletePost,
                );
              },
            );
          }
        },
      ),
    );
  }
}
