




// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:marketplace_ui/APIService/PostModel.dart';
// import 'package:marketplace_ui/PostView/whenclick.dart';

// import 'postComponent.dart';

// String s = "Battery";

// class MainPostBody extends StatefulWidget {
//   @override
//   State<MainPostBody> createState() => _MainPostBodyState();
  
// }

// class _MainPostBodyState extends State<MainPostBody> {
//   UserPostModel ?userpost;
//   @override
  
//  void initState()
//  {
//   super.initState();
//   fun();
//  }
//  Future<void>fun() async
//  {
//     userpost = await UserPostService(Dio()).getPostData();
//  }

//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: wid(340), // Set the width
//       height: s == "Battery" ? hig(532) : hig(500), // Set the height
//       decoration: BoxDecoration(
//         color: Color(0xffE1F1D5), // Set the color
//         borderRadius: BorderRadius.circular(20), // Set circular border radius
//       ),
//       child: Center(
//         child: SizedBox(
//           width: wid(320),
//           height: s == "Battery" ? hig(522) : hig(492),
//           child: FutureBuilder<UserPostModel>(
//             future:  userpost,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text("Error: ${snapshot.error}"));
//               } else if (snapshot.hasData) {
//                 UserPostModel userPost = snapshot.data!;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Image.network("http://solareasegp.runasp.net/" + userPost.UserImage),
//                         SizedBox(width: wid(15)),
//                         Text(
//                           userPost.UserName,
//                           style: TextStyle(
//                             fontSize: 18.0 * t,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0x0ff063221),
//                           ),
//                         ),
//                         Spacer(flex: 5),
//                         Text(
//                           userPost.PostDate,
//                           style: TextStyle(
//                             fontSize: 15.0 * t,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0x0ff063221),
//                           ),
//                         ),
//                         Spacer(flex: 1),
//                       ],
//                     ),
//                     SizedBox(height: hig(10)),
//                     Center(
//                       child: Image.network("http://solareasegp.runasp.net/" + userPost.PostImage),
//                     ),
//                     SizedBox(height: hig(10)),
//                     conmponent(
//                       wid(280), hig(35), "is used", wid(70), wid(85), userPost.IsUsed.toString()),
//                     conmponent(wid(280), hig(35), "Brand", wid(70), wid(85), userPost.PostBrand),
//                     conmponent(wid(280), hig(35), "category", wid(140), wid(85), userPost.PostCategory),
//                     if (s == 'Battery')
//                       conmponent(wid(280), hig(35), "volt", wid(60), wid(85), userPost.Volume),
//                     conmponent(wid(280), hig(35), "Capacity", wid(60), wid(85), userPost.PostCapacity.toString()),
//                     conmponent(wid(280), hig(35), "Price", wid(80), wid(85), userPost.PostPrice.toString()),
//                     conmponent(wid(280), hig(35), "Phone", wid(140), wid(85), userPost.PhoneNumber),
//                     conmponent(wid(280), hig(35), "Location", wid(140), wid(85), userPost.Location),
//                     Text(
//                       "Description",
//                       style: TextStyle(
//                         fontSize: 15.0 * t,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0x0ff063221),
//                       ),
//                     ),
//                     conmponent(wid(320), hig(45), "Description", wid(320), 0, userPost.Description),
//                   ],
//                 );
//               } else {
//                 return Center(child: Text("No data available"));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }














