
import 'package:dio/dio.dart';
import 'package:marketplace_ui/APIService/ProductModel.dart';

class PanelService
{
  final Dio dio;
  PanelService(this.dio);
  String query = 'Panel';
  Future<List<PanelModel>> getPanelInfo() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/SolarProducts/6?query=$query');
      List<dynamic> jsonData = response.data;

      List<PanelModel> PanelList = [];

      for (var item in jsonData) {
        PanelModel panelModel = PanelModel.fromJson(item);
        PanelList.add(panelModel);
      }

      return PanelList;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }
  Future<void> AddToFavorite(int panelId) async {
    print(panelId);
  try {
    final response = await dio.put(
      'http://solareasegp.runasp.net/api/FavoriteProducts/ToggleFavorite/6/$panelId', // Replace with your API endpoint
      
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
// ------  --------------- ------------------------ --------------------------

class BatteryService
{
  final Dio dio;
  BatteryService(this.dio);
  String query = 'Battery';
  Future<List<BatteryModel>> getBatteryInfo() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/SolarProducts/6?query=$query');
      List<dynamic> jsonData = response.data;

      List<BatteryModel> BatteryList = [];

      for (var item in jsonData) {
        BatteryModel batteryModel = BatteryModel.fromJson(item);
        BatteryList.add(batteryModel);
      }

      return BatteryList;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }
}

//- -----------------------------------------------------------------------------------

class InverterService {
  final Dio dio;
  InverterService( this.dio);
  String query = 'Inverter';
  Future<List<InverterModel>> getInverterInfo() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/SolarProducts/6?query=$query');

      // Assuming response.data is a List of maps
      List<dynamic> jsonData = response.data;

      List<InverterModel> PanelList = [];

      for (var item in jsonData) {
        InverterModel inverterModel = InverterModel.fromJson(item);
        PanelList.add(inverterModel);
        // if (item["categoryName"] == "Inverter") {
        //   InverterModel inverterModel = InverterModel.fromJson(item);
        //   PanelList.add(inverterModel);
        // }
      }

      return PanelList;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }

  //---''
  // favorite_service.dart


  
}


// ---------------------------------------------------------------------------
/*

class NewsServic
{
  final Dio dio ;
  NewsServic({required this.dio});
  Future<List<InverterModel>> getInverterInfo ({required String query})async 
  {
    try {
  Response response = await dio.get('http://solareasegp.runasp.net/api/SolarProducts?query=$query');
  Map<String,dynamic> jsonData = response.data;
  
     List<dynamic> articles=jsonData["articles"];
     List<ArticalModel> articalist=[];
     
  
     for(var artical in articles)
     {
  ArticalModel articalModel = ArticalModel
  (
    image: artical['urlToImage'],
    title: artical['title'],
    subtitle: artical['description']
  );
    articalist.add(articalModel);
     }
     return articalist;
} on Exception {
 return [];
}

  }

}

//      ---------------------------------------------------- 


class InverterService {
  final Dio dio;
  InverterService({required this.dio});

  Future<List<InverterModel>> getInverterInfo({required String query}) async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/SolarProducts?query=$query');

      // Assuming response.data is a List of maps
      List<dynamic> jsonData = response.data;

      List<InverterModel> PanelList = [];

      for (var item in jsonData) {
        if (item["categoryName"] == "Inverter") {
          InverterModel inverterModel = InverterModel.fromJson(item);
          PanelList.add(inverterModel);
        }
      }

      return PanelList;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }
}

 */