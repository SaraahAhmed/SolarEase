import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_ui/APIService/SmallPostModel.dart';
import 'package:marketplace_ui/PostView/CardWidet.dart';
import 'package:marketplace_ui/PostView/UsersPosts.dart';
import 'package:marketplace_ui/main.dart';



// ignore: must_be_immutable
class PostCard extends StatelessWidget {
  Smallpostmodel smallpostmodel;
  PostCard({required this.smallpostmodel});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:4,vertical: 2),
      child: CardWidet(smallpostmodel: smallpostmodel,),
    );
  }
}


