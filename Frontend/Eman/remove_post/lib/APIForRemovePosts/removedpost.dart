import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:remove_post/main.dart';

class RemovedPost
{
  int ID;
  String RemovedImage;
  String RemovedCategory;
  String RemovedPrice;
  String RemovedDate;
  String RemovedLocation;
  bool PostStatus;


  RemovedPost(
    {
      required this.ID,
      required this.RemovedCategory,
      required this.RemovedDate,
      required this.PostStatus,
      required this.RemovedImage,
      required this.RemovedLocation,
      required this.RemovedPrice,
    }
  );

  factory RemovedPost.fromJson(json)
  {
    return RemovedPost(
      ID: json['id'],
      RemovedCategory: json['categoryName'],
      RemovedDate: json['createdOn'],
      RemovedImage: json['productImageUrl'],
      RemovedLocation: json['city'],
      RemovedPrice: json['priceStr'],
      PostStatus : json['active']
      
    );
  }
}

class RemovedService
{
  final Dio dio;
  RemovedService(this.dio);
  //String sortBy = 'd'; //sortBy=$sortBy
  Future<List<RemovedPost>> getAllPosts() async 
  {
    try 
    {
      Response response = await dio.get(
        'http://solareasegp.runasp.net/api/Posts/PersonInfo/6?sortBy=a');
      List<dynamic> jsonData = response.data;
      List<RemovedPost> listAllPosts = [];

      for (var item in jsonData) 
      {
        RemovedPost removedPost = RemovedPost.fromJson(item);
        listAllPosts.add(removedPost);
        print(response.statusCode);
      } 
      return listAllPosts;

    }
    on DioException catch (e) {
      throw Exception("Oops, there was an dio error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }

  }

  // ----------------------------- 

  Future<void> deletePost(int id) async {
    final String url = 'http://solareasegp.runasp.net/api/Posts/Delete/$id';
    try {
      await dio.delete(url);
      
      print("code run succesfully");
    } on DioException catch (e) {
      throw Exception("Oops, there was a Dio error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }

  // ----------------------------------

}