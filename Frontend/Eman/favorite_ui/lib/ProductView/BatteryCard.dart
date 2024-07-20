import 'package:dio/dio.dart';
import 'package:favorite_ui/APIService/ProductModel.dart';
import 'package:favorite_ui/APIService/ProductService.dart';
import 'package:favorite_ui/main.dart';
import 'package:flutter/material.dart';


class BatteryCard extends StatefulWidget {
  final FavoriteBattery batteryModel;
  final VoidCallback onFavoriteToggled;

  BatteryCard({required this.batteryModel, required this.onFavoriteToggled});

  @override
  State<BatteryCard> createState() => _BatteryCardState();
}

class _BatteryCardState extends State<BatteryCard> {
  PanelService? panelService = PanelService(Dio());
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(370),
      height: height(130),
      child: Card(
        color: Color(0xffD9EDCA), // #D9EDCA
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _isProcessing
                  ? CircularProgressIndicator()
                  : IconButton(
                      onPressed: () async {
                        setState(() {
                          _isProcessing = true;
                        });
                        await panelService?.ToggleFavorite(widget.batteryModel.BatteryID);
                        setState(() {
                          widget.batteryModel.isFavorite = !widget.batteryModel.isFavorite;
                          _isProcessing = false;
                        });
                        widget.onFavoriteToggled();
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.orange,
                      ),
                    ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _buildImageforBattery(batteryModel: widget.batteryModel),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: _TextBuilderForBattery(batteryModel: widget.batteryModel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class BatteryCardList extends StatefulWidget {
  @override
  _BatteryCardListState createState() => _BatteryCardListState();
}

class _BatteryCardListState extends State<BatteryCardList> {
  late Future<List<FavoriteBattery>> _favoriteBatteriesFuture;

  @override
  void initState() {
    super.initState();
    _favoriteBatteriesFuture = BatteryService(Dio()).getFavoriteBattery();
  }

  void _refreshFavoriteBatteries() {
    setState(() {
      _favoriteBatteriesFuture = BatteryService(Dio()).getFavoriteBattery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavoriteBattery>>(
      future: _favoriteBatteriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final batteries = snapshot.data!;
          return ListView.builder(
            itemCount: (batteries.length / 2).ceil(),
            itemBuilder: (context, index) {
              int firstIndex = index * 2;
              int secondIndex = firstIndex + 1;
              bool hasSecond = secondIndex < batteries.length;
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: BatteryCard(
                      batteryModel: batteries[firstIndex],
                      onFavoriteToggled: _refreshFavoriteBatteries,
                    ),
                  ),
                  if (hasSecond)
                    BatteryCard(
                      batteryModel: batteries[secondIndex],
                      onFavoriteToggled: _refreshFavoriteBatteries,
                    ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

Widget _TextBuilderForBattery({required batteryModel}) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            batteryModel.BatteryBrandName,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.monetization_on, size: 16),
              Text(
                batteryModel.BatteryPrice,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16),
              Text(
                batteryModel.BatteryCapacity,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

SizedBox _buildImageforBattery({required batteryModel}) {
  return SizedBox(
    width: width(220),
    height: height(50),
    child: Image.network("http://solareasegp.runasp.net/" + batteryModel.Batteryimage),
  );
}
