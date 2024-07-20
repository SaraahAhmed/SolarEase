import 'package:dio/dio.dart';

class Smallpostmodel
{
  int PostID;
  String UserProfileImage;
  String UserName;
  String date;
  String ProductImage;
  String ProductName;
  String ProductPrice;
  String City;
  bool isFavorite;

  Smallpostmodel(
  {
    required this.PostID,
    required this.UserProfileImage,
    required this.UserName,
    required this.date,
    required this.ProductImage,
    required this.ProductName,
    required this.ProductPrice,
    required this.City,
    required this.isFavorite,
   }
  );

  factory Smallpostmodel.fromJson(json)
  {
    return Smallpostmodel(
      PostID             : json['id'],
      UserProfileImage   : json['profileImageUrl'],
      UserName           : json['personName'], 
      date               : json['createdOn'],
      ProductImage       : json['productImageUrl'],
      ProductName        : json['compositeName'], 
      ProductPrice       : json['priceStr'], 
      City               : json['city'],
      isFavorite         : json['isFavorite'],
      
    );
  }
 

  
}


class SmallPostService
{
  //get('http://solareasegp.runasp.net/api/SolarProducts/6?query=$query');
  final Dio dio;
  SmallPostService(this.dio);
  String sortBy = 'd'; //sortBy=$sortBy
 

  Future<List<Smallpostmodel>> getSmallPosts(String category) async {
    print(category);
    try {
      Response response = await dio.get(
        'http://solareasegp.runasp.net/api/Posts/SmallPosts/6?sortBy=d&categoryQuery=$category&cityQuery=');

      List<dynamic> jsonData = response.data;
      List<Smallpostmodel> listOfPosts = [];

      for (var item in jsonData) {
        Smallpostmodel smallpostmodel = Smallpostmodel.fromJson(item);
        listOfPosts.add(smallpostmodel);
        // if (item["categoryName"] == category) {
        //   Smallpostmodel smallpostmodel = Smallpostmodel.fromJson(item);
        //   listOfPosts.add(smallpostmodel);
        // }
      }

      return listOfPosts;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }
}

  // Future<List<Smallpostmodel>> getSmallPosts() async {
  //   try {
  //     Response response = await dio.get(
  //       'http://solareasegp.runasp.net/api/Posts/SmallPosts/6?sortBy=$sortBy');

  //     // Assuming response.data is a List of maps
  //     List<dynamic> jsonData = response.data;

  //     List<Smallpostmodel> ListOfPosts = [];

  //     for (var item in jsonData) {
  //       Smallpostmodel smallpostmodel = Smallpostmodel.fromJson(item);
  //       ListOfPosts.add(smallpostmodel);
  //       // if (item["categoryName"] == "Inverter") {
  //       //   Smallpostmodel Smallpostmodel = Smallpostmodel.fromJson(item);
  //       //   ListOfPosts.add(Smallpostmodel);
  //       // }
  //     }

  //     return ListOfPosts;
  //   } on DioException catch (e) {
  //     throw Exception("Oops, there was an error, try later");
  //   } catch (e) {
  //     throw Exception("Oops, there was an error, try later");
  //   }
  // }


/**
 
class InverterService {
  final Dio dio;
  InverterService( this.dio);
  String query = 'Inverter';
  Future<List<Smallpostmodel>> getInverterInfo() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/SolarProducts?query=$query');

      // Assuming response.data is a List of maps
      List<dynamic> jsonData = response.data;

      List<Smallpostmodel> ListOfPosts = [];

      for (var item in jsonData) {
        Smallpostmodel Smallpostmodel = Smallpostmodel.fromJson(item);
        ListOfPosts.add(Smallpostmodel);
        // if (item["categoryName"] == "Inverter") {
        //   Smallpostmodel Smallpostmodel = Smallpostmodel.fromJson(item);
        //   ListOfPosts.add(Smallpostmodel);
        // }
      }

      return ListOfPosts;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }
}
 */