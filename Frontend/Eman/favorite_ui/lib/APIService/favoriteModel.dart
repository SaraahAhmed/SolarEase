import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FavoritePostmodel
{
  int ID;
  String FImage;
  String FCategory;
  String Fprice;
  String RemovedDate;
  String Flocation;
  bool PostStatus;


  FavoritePostmodel(
    {
      required this.ID,
      required this.FCategory,
      required this.RemovedDate,
      required this.PostStatus,
      required this.FImage,
      required this.Flocation,
      required this.Fprice,
    }
  );

  factory FavoritePostmodel.fromJson(json)
  {
    return FavoritePostmodel(
      ID: json['id'],
      FCategory: json['categoryName'],
      RemovedDate: json['createdOn'],
      FImage: json['productImageUrl'],
      Flocation: json['city'],
      Fprice: json['priceStr'],
      PostStatus : json['active']
      
    );
  }
}

class FavoriteService
{
  final Dio dio;
  FavoriteService(this.dio);
  //String sortBy = 'd'; //sortBy=$sortBy
  Future<List<FavoritePostmodel>> getFavoritePosts() async 
  {
    try 
    {
      Response response = await dio.get(
        'http://solareasegp.runasp.net/api/FavoritePosts/ByPerson/6');
      List<dynamic> jsonData = response.data;
      List<FavoritePostmodel> listAllPosts = [];

      for (var item in jsonData) 
      {
        FavoritePostmodel removedPost = FavoritePostmodel.fromJson(item);
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

  // Future<void> deleteFromFavoritr(int id) async {
  //   final String url = 'http://solareasegp.runasp.net/api/Posts/Delete/$id';
  //   try {
  //     await dio.delete(url);
      
  //     print("code run succesfully");
  //   } on DioException catch (e) {
  //     throw Exception("Oops, there was a Dio error, try later");
  //   } catch (e) {
  //     throw Exception("Oops, there was an error, try later");
  //   }
  // }

  // ----------------------------------

}