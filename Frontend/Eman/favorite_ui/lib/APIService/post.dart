import 'dart:io';

import 'package:dio/dio.dart';

class Post {
  Dio dio = Dio();
  bool isusedChange;
  String categoryChange;
  double priceChange;
  File? imageFile;
  String brandChange;
  double capacityChange;
  String unitChange;
  double? voltChange;
  String locationChange;
  String? phone;
  String photo = "http://solareasegp.runasp.net/ProfileImages/profile.png";
  String cityChange;
  String descriptionChange;
  String? ownerPhoto =
      "http://solareasegp.runasp.net/ProfileImages/profile.png";
  String? date;
  String? ownerName;
  Post(
      {required this.brandChange,
      required this.capacityChange,
      required this.categoryChange,
      required this.cityChange,
      required this.descriptionChange,
      required this.imageFile,
      required this.isusedChange,
      required this.locationChange,
      required this.priceChange,
      required this.unitChange,
      required this.voltChange});

  //api create post
  Future<bool> createPost() async {
    print("is used" + isusedChange.toString());
    print("categoryChange" + categoryChange.toString());
    print("priceChange" + priceChange.toString());
    print("brandChange" + brandChange.toString());
    print("unitChange" + unitChange.toString());
    print("voltChange" + voltChange.toString());
    print("locationChange" + locationChange.toString());
    print("cityChange" + cityChange.toString());
    print("descriptionChange" + descriptionChange.toString());
    print("image" + imageFile.toString());
    print("capcity" + capacityChange.toString());
    try {
      var response =
          await dio.post("http://solareasegp.runasp.net/api/Posts/Create/6",
              data: FormData.fromMap({
                "CategoryName": this.categoryChange,
                "Price": this.priceChange,
                "Location": this.locationChange,
                "City": this.cityChange,
                "IsUsed": this.isusedChange,
                "Description": this.descriptionChange,
                "Brand": this.brandChange,
                "Capacity": this.capacityChange,
                "MeasuringUnit": this.unitChange,
                "Volt": this.voltChange,
                "ProductImageUrl": await MultipartFile.fromFile(imageFile!.path,
                    filename: imageFile?.path.split('/').last),
              }));

      print("done*********************");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //i change image file to be nullable
  //api edit
  Future<bool> edditPost() async {
    print("is used" + isusedChange.toString());
    print("categoryChange" + categoryChange.toString());
    print("priceChange" + priceChange.toString());
    print("brandChange" + brandChange.toString());
    print("unitChange" + unitChange.toString());
    print("voltChange" + voltChange.toString());
    print("locationChange" + locationChange.toString());
    print("cityChange" + cityChange.toString());
    print("descriptionChange" + descriptionChange.toString());
    print("image" + imageFile.toString());
    print("capcity" + capacityChange.toString());
    print(imageFile);
    try {
      var response =
          await dio.put("http://solareasegp.runasp.net/api/Posts/Update/1046",
              data: FormData.fromMap({
                "CategoryName": this.categoryChange,
                "Price": this.priceChange,
                "Location": this.locationChange,
                "City": this.cityChange,
                "IsUsed": this.isusedChange,
                "Description": this.descriptionChange,
                "Brand": this.brandChange,
                "Capacity": this.capacityChange,
                "MeasuringUnit": this.unitChange,
                "Volt": this.voltChange,
                "ProductImageUrl": imageFile == null
                    ? null
                    : await MultipartFile.fromFile(imageFile!.path,
                        filename: imageFile!.path.split('/').last),
              }));

      print("done*********************");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //api getpost
  Future<bool> getPost() async {
    try {
      var response = await dio.get(
        "http://solareasegp.runasp.net/api/Posts/Info/1016",
      );
      print(response);
      this.isusedChange = response.data["isUsed"];

      this.categoryChange = response.data["categoryName"];

      this.priceChange = response.data["price"].toDouble();
      print("***************************************************");
      this.brandChange = response.data["brand"];

      this.capacityChange = response.data["capacity"].toDouble();
      this.unitChange = response.data["measuringUnit"];

      if (this.categoryChange == "Battery")
        this.voltChange = response.data["volt"].toDouble();
      this.locationChange = response.data["location"];
      this.phone = response.data["phoneNumber"];
      this.ownerPhoto =
          "http://solareasegp.runasp.net/" + response.data["profileImageUrl"];
      this.date = response.data["createdOn"];
      this.ownerName = response.data["personName"];
      this.photo =
          "http://solareasegp.runasp.net/" + response.data["productImageUrl"];
      print(this.photo);
      this.cityChange = response.data["city"];
      if (response.data["description"] != null)
        this.descriptionChange = response.data["description"];
      print("done*********************");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
