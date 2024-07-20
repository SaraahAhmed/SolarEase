
import 'package:dio/dio.dart';
import 'package:favorite_ui/APIService/ProductModel.dart';

class PanelService
{
  final Dio dio;
  PanelService(this.dio);
  String query = 'Panel';
  Future<List<FavoritePanel>> getFavoritePanel() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/FavoriteProducts/ByPerson/6?query=$query');
      List<dynamic> jsonData = response.data;

      List<FavoritePanel> PanelList = [];

      for (var item in jsonData) {
        FavoritePanel panelModel = FavoritePanel.fromJson(item);
        PanelList.add(panelModel);
      }

      return PanelList;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }

// ------------ ------------------ ----------------------------

  Future<void> ToggleFavorite(int ID) async {
    print(ID);
  try {
    final response = await dio.put(
      'http://solareasegp.runasp.net/api/FavoriteProducts/ToggleFavorite/6/$ID', // Replace with your API endpoint
      
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
  Future<List<FavoriteBattery>>getFavoriteBattery() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/FavoriteProducts/ByPerson/6?query=$query');
      List<dynamic> jsonData = response.data;

      List<FavoriteBattery> BatteryList = [];

      for (var item in jsonData) {
        FavoriteBattery favoriteBattery = FavoriteBattery.fromJson(item);
        BatteryList.add(favoriteBattery);
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
  Future<List<FavoriteInverter>> getFavoriteInverter() async {
    try {
      Response response = await dio.get('http://solareasegp.runasp.net/api/FavoriteProducts/ByPerson/6?query=$query');

      // Assuming response.data is a List of maps
      List<dynamic> jsonData = response.data;

      List<FavoriteInverter> PanelList = [];

      for (var item in jsonData) {
        FavoriteInverter favoriteInverter = FavoriteInverter.fromJson(item);
        PanelList.add(favoriteInverter);
      }

      return PanelList;
    } on DioException catch (e) {
      throw Exception("Oops, there was an error, try later");
    } catch (e) {
      throw Exception("Oops, there was an error, try later");
    }
  }  
}
