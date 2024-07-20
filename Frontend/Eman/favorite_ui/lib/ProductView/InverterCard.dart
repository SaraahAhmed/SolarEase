import 'package:dio/dio.dart';
import 'package:favorite_ui/APIService/ProductModel.dart';
import 'package:favorite_ui/APIService/ProductService.dart';
import 'package:favorite_ui/main.dart';
import 'package:flutter/material.dart';


class InverterCard extends StatefulWidget {
  final FavoriteInverter inverterModel;
  final VoidCallback onFavoriteToggled;

  InverterCard({required this.inverterModel, required this.onFavoriteToggled});

  @override
  State<InverterCard> createState() => _InverterCardState();
}

class _InverterCardState extends State<InverterCard> {
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
                        await panelService?.ToggleFavorite(widget.inverterModel.InverterID);
                        setState(() {
                          widget.inverterModel.isFavorite = !widget.inverterModel.isFavorite;
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
                  alignment: Alignment.topCenter,
                  child: _buildImageforInverter(inverterModel: widget.inverterModel),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: _TextBuilderForInverter(inverterModel: widget.inverterModel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class InverterCardList extends StatefulWidget {
  @override
  _InverterCardListState createState() => _InverterCardListState();
}

class _InverterCardListState extends State<InverterCardList> {
  late Future<List<FavoriteInverter>> _favoriteInvertersFuture;

  @override
  void initState() {
    super.initState();
    _favoriteInvertersFuture = InverterService(Dio()).getFavoriteInverter();
  }

  void _refreshFavoriteInverters() {
    setState(() {
      _favoriteInvertersFuture = InverterService(Dio()).getFavoriteInverter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavoriteInverter>>(
      future: _favoriteInvertersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data'));
        } else {
          final inverters = snapshot.data!;
          return ListView.builder(
            itemCount: (inverters.length / 2).ceil(),
            itemBuilder: (context, index) {
              int firstIndex = index * 2;
              int secondIndex = firstIndex + 1;
              bool hasSecond = secondIndex < inverters.length;
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InverterCard(
                      inverterModel: inverters[firstIndex],
                      onFavoriteToggled: _refreshFavoriteInverters,
                    ),
                  ),
                  if (hasSecond)
                    InverterCard(
                      inverterModel: inverters[secondIndex],
                      onFavoriteToggled: _refreshFavoriteInverters,
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

Widget _TextBuilderForInverter({required inverterModel}) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.branding_watermark,
                size: 16,
              ),
              Text(
                inverterModel.InverterBrandName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.price_change,
                size: 16,
              ),
              Text(
                inverterModel.InverterPrice,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.power,
                size: 16,
              ),
              Text(
                inverterModel.InverterCapacity,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

SizedBox _buildImageforInverter({required inverterModel}) {
  return SizedBox(
    width: width(220),
    height: height(50),
    child: Image.network("http://solareasegp.runasp.net/" + inverterModel.Inverterimage),
  );
}
