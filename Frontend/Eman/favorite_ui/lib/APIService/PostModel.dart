
import 'package:dio/dio.dart';

class UserPostModel
{
  final String UserName;
  final String PostDate;
  final String UserImage;
  final  bool IsUsed;
  final  String PostBrand;
  final  String PostCategory;
  final  String? Volume;
  final  String PostCapacity;
  final  String PostPrice;
  final  String PhoneNumber;
  final  String Location;
  final  String? Description;
  final  String PostImage;   
UserPostModel(
    {
      required this.UserName,
      required this.PostDate,
      required this.UserImage,
      required this.PhoneNumber, 
      required this.PostImage,
      required this.IsUsed,
      required this.PostCategory,
      required this.PostCapacity,
      required this.PostBrand,
      required this.PostPrice,
      required this.Location,
      required this.Description,
      required this.Volume
  }
  );

  factory UserPostModel.fromJson(json)
  {
    return UserPostModel(
      UserName    : json['personName'], 
      PostDate    : json['createdOn'], 
      UserImage   : json['profileImageUrl'], 
      PhoneNumber : json['phoneNumber'], 
      PostImage   : json['productImageUrl'],
      IsUsed      : json['isUsed'], 
      PostCategory: json['categoryName'],
      PostCapacity: json['capacityStr'], 
      PostBrand   : json['brand'],
      PostPrice   : json['priceStr'], 
      Location    : json['compositeLocation'], 
      Description : json['description'], 
      Volume      : json['voltStr']
    );
 
  }
  
}
class UserPostService
{
  final Dio dio;
  UserPostService(this.dio);
  //String sortBy = 'd'; //sortBy=$sortBy
  Future<UserPostModel> getPostData() async {
    try {
      Response response = await dio.get(
        'http://solareasegp.runasp.net/api/Posts/Info/1016');
   
      UserPostModel userPostModel = UserPostModel.fromJson(response);
      print(response.statusCode);
      return userPostModel;
    } on DioException catch (e) {
      throw Exception("Oops, there was an dio error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }

  //       ================ 
  Future<void> ToggleFavorite(int postId) async {
    print(postId);
  try {
    final response = await dio.put(
      'http://solareasegp.runasp.net/api/FavoritePosts/ToggleFavorite/6/$postId', // Replace with your API endpoint
      
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Handle successful response
      print('Favorite status updated successfully');
    } else {
      // Handle other status codes
      print('Failed to update favorite status');
    }
  } catch (e) {
    // Handle error
    print('Error updating favorite status: $e');
  }
}



} 
