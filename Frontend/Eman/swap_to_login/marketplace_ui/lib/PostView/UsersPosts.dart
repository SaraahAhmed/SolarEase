// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:marketplace_ui/PostView/PostCard.dart';
// import 'package:marketplace_ui/PostView/dropdownlistforpost.dart';
// import 'package:marketplace_ui/ProductView/Search.dart';


// import 'package:marketplace_ui/main.dart';


// class UsersPosts extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {

//     return Column(
      
      
//         children: [
//               DownListPost(),
//         //------------------------- Card -----------------------
//         SizedBox(height: height(6),),
//         Expanded(
//           child: ListView.builder(
//             itemCount: ,
//             itemBuilder: (context, index) 
//             {
//               return ;
//             },
            
//           ),
//         ),
        
//         //-----------------------------------------------
       
        
//         ],
//      );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_ui/APIService/SmallPostModel.dart';
import 'package:marketplace_ui/PostView/CardWidet.dart';
import 'package:marketplace_ui/PostView/PostCard.dart';
import 'package:marketplace_ui/PostView/dropdownlistforpost.dart';
import 'package:marketplace_ui/ProductView/Search.dart';
import 'package:marketplace_ui/main.dart';
import 'package:dio/dio.dart';

// Add your SmallPostService initialization here
// final smallPostService = SmallPostService(Dio());

// class UsersPosts extends StatefulWidget {
//   @override
//   _UsersPostsState createState() => _UsersPostsState();
// }

// class _UsersPostsState extends State<UsersPosts> {
//   late Future<List<Smallpostmodel>> futurePosts;

//   @override
//   void initState() {
//     super.initState();
//     //futurePosts = smallPostService.getSmallPosts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     futurePosts = smallPostService.getSmallPosts();//

//     return Column(
//       children: [
//         DownListPost(),
//         SizedBox(height: height(6)),
//         Expanded(
//           child: FutureBuilder<List<Smallpostmodel>>(
//             future: futurePosts,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text("Error: ${snapshot.error}"));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text("No posts available"));
//               } else {
//               List<Smallpostmodel> posts = snapshot.data!;
//               return ListView.builder(
//                 itemCount: (posts.length / 2).ceil(),
//                 itemBuilder: (context, index) 
//                 {
//                 int firstIndex = index * 2;
//                 int secondIndex = firstIndex + 1;
//                 bool hasSecond = secondIndex < posts.length;
//                return Row(
//                    children: [
//                       PostCard(smallpostmodel: posts[firstIndex]),
//                       if (hasSecond)
//                       PostCard(smallpostmodel: posts[secondIndex]),
//                      ],
//                    );
//                },
//               );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
class UsersPosts extends StatefulWidget {
  @override
  _UsersPostsState createState() => _UsersPostsState();
}

class _UsersPostsState extends State<UsersPosts> {
  late Future<List<Smallpostmodel>> futurePosts;
  final smallPostService = SmallPostService(Dio());
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    futurePosts = smallPostService.getSmallPosts(_selectedCategory);
  }

  void _onCategoryChanged(String category) {
    setState(() {
      if(category=="all"){_selectedCategory='';}
      else{_selectedCategory = category;}
      
      futurePosts = smallPostService.getSmallPosts(_selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DownListPost(onCategoryChanged: _onCategoryChanged),
        SizedBox(height: height(6)),
        Expanded(
          child: FutureBuilder<List<Smallpostmodel>>(
            future: futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No posts available"));
              } else {
                List<Smallpostmodel> posts = snapshot.data!;
                return ListView.builder(
                  itemCount: (posts.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int firstIndex = index * 2;
                    int secondIndex = firstIndex + 1;
                    bool hasSecond = secondIndex < posts.length;
                    return Row(
                      children: [
                        PostCard(smallpostmodel: posts[firstIndex]),
                        if (hasSecond)
                          PostCard(smallpostmodel: posts[secondIndex]),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

// class Model
// {
//   final String image;
//   final String name;
//   final String price;
//   final String Location;
//   final String date;
//   Model({required this.image,required this.name,required this.price,required this.Location,
//   required this.date
//   });
// }
