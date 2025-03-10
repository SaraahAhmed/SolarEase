import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_ui/APIService/ProductModel.dart';
import 'package:marketplace_ui/APIService/ProductService.dart';
import 'package:marketplace_ui/main.dart';

class PanelCard extends StatefulWidget {
  final PanelModel panelModel;

  PanelCard({required this.panelModel});

  @override
  State<PanelCard> createState() => _PanelCardState();
}
class _PanelCardState extends State<PanelCard> {
  //bool isFavorite = false;
  PanelService? panelService = PanelService(Dio());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(370),
      height: height(140),
      child: Card(
        color: Color(0xffD9EDCA), // #D9EDCA
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                
                onPressed: () async
                {
                  setState(() {
                    widget.panelModel.isFavorite = ! widget.panelModel.isFavorite;
                    // add to favorite
                  });
                  print('jnhsCJHD');
                  await panelService?. AddToFavorite(widget.panelModel.PanelId); 
                  print(widget.panelModel.PanelId);
                },
                icon: Icon(
                 widget.panelModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.panelModel.isFavorite ? Colors.orange : Colors.black,
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _buildImage(panelModel: widget.panelModel),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: _TextBuilder(panelModel: widget.panelModel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/*
             return ListView.builder(
                itemCount: (posts.length / 2).ceil(),
                itemBuilder: (context, index) 
                {
                int firstIndex = index * 2;
                int secondIndex = firstIndex + 1;
                bool hasSecond = secondIndex < posts.length;
               return Row(
                   children: [
                      PostCard(smallpostmodel: posts[firstIndex]),
                      if (hasSecond)
                      PostCard(smallpostmodel: posts[secondIndex]),
                     ],
                   );
               },
              );
 */

class PanelCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PanelModel>>(
      future: PanelService(Dio()).getPanelInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return ListView.builder( // (snapshot.data!.length / 2).ceil()
            itemCount:(snapshot.data!.length / 2).ceil(),
            itemBuilder: (context, index) {
              int firstIndex = index * 2;
                int secondIndex = firstIndex + 1;
                bool hasSecond = secondIndex < snapshot.data!.length;
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: PanelCard(panelModel: snapshot.data![firstIndex]),
                  ),
                   if (hasSecond)
                  PanelCard(panelModel: snapshot.data![secondIndex]),
                  // Remove duplicate PanelCard widget
                ],
              );
            },
          );
        }
      },
    );
  }
}

Widget _TextBuilder({required  panelModel}) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            panelModel.PanelBrandName,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.monetization_on, size: 16),
              Text(
                panelModel.PanelPrice,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16),
              Text(
                panelModel.totalPrice ?? 'N/A',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16),
              Text(
                panelModel.PanelCapacity,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

SizedBox _buildImage({required  panelModel}) {
  return SizedBox(
    width: width(220),
    height: height(50),
    child: Image.network("http://solareasegp.runasp.net/" + panelModel.Panelimage),
  );
}
