// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:marketplace_ui/APIService/ProductModel.dart';
// import 'package:marketplace_ui/APIService/ProductService.dart';
// import 'package:marketplace_ui/main.dart';

// class InverterCard extends StatefulWidget {
//   @override
//   State<InverterCard> createState() => _InverterCardState();
// }

// class _InverterCardState extends State<InverterCard> {
//   bool isFavorite = false;
//   //Future<InverterModel> inverterModel = InverterService(Dio()).getInverterInfo();
//   Future<List<InverterModel>> inverterList =InverterService(Dio()).getInverterInfo();


//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width(370),
//       height: height(130),
//       child: Card(
//         color: Color(0xffD9EDCA), // #D9EDCA
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isFavorite = !isFavorite;
//                   });
//                 },
//                 icon: Icon(
//                   isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: isFavorite ? Colors.orange : Colors.black,
//                 ),
//               ),
//             ),
//             FutureBuilder<InverterModel>(
//               future: inverterModel,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } el(snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.topCenter,
//                         child: _buildImageforInverter(inverterModel: snapshot.data!),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: _TextBuilderForInverter(inverterModel: snapshot.data!),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return Text('No data');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ---------------------Main Inverter Card -------------------------------
// class MainInverterCard extends StatelessWidget {
//   const MainInverterCard();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         InverterCard(),
//         InverterCard(),
//       ],
//     );
//   }
// }

// // --------------- ListView for Inverter Card ---------------------------
// class InverterCardList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: 20,
//         itemBuilder: (context, index) {
//           return MainInverterCard();
//         },
//       ),
//     );
//   }
// }

// // ---------------------------------------------------------------
// Widget _TextBuilderForInverter({required InverterModel inverterModel}) {
//   return Expanded(
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.location_on,
//                 size: 16,
//               ),
//               Text(
//                 inverterModel.InverterBrandName,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.location_on,
//                 size: 16,
//               ),
//               Text(
//                 inverterModel.InverterPrice,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.calendar_today,
//                 size: 16,
//               ),
//               Text(
//                 inverterModel.InverterCapacity,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// SizedBox _buildImageforInverter({required InverterModel inverterModel}) {
//   return SizedBox(
//     width: width(220),
//     height: height(50),
//     child: Image.network("http://solareasegp.runasp.net/" + inverterModel.Inverterimage),
//   );
// }
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_ui/APIService/ProductModel.dart';
import 'package:marketplace_ui/APIService/ProductService.dart';
import 'package:marketplace_ui/main.dart';

class InverterCard extends StatefulWidget {
  final InverterModel inverterModel;
  
  InverterCard({required this.inverterModel});
  
  @override
  State<InverterCard> createState() => _InverterCardState();
}

class _InverterCardState extends State<InverterCard> {
  //bool isFavorite = false;
  PanelService? panelService = PanelService(Dio());


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
              child: IconButton(
                 onPressed: () async
                {
                  setState(() {
                    widget.inverterModel.isFavorite = !widget.inverterModel.isFavorite;
                    // add to favorite
                  });
                  print('jnhsCJHD');
                 await panelService?. AddToFavorite(widget.inverterModel.InverterID); 
                  print(widget.inverterModel.InverterID);
                },
                icon: Icon(
                  widget.inverterModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.inverterModel.isFavorite ? Colors.orange : Colors.black,
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
// --------------- ListView for Inverter Cards ---------------------------
class InverterCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InverterModel>>(
      future: InverterService(Dio()).getInverterInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data'));
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
                    child: InverterCard(inverterModel: snapshot.data![firstIndex]),
                  ),
                   if (hasSecond)
                   InverterCard(inverterModel: snapshot.data![secondIndex]),                  // Remove duplicate PanelCard widget
                ],
              );
            },
          );
          // return ListView.builder(
          //   itemCount: snapshot.data!.length,
          //   itemBuilder: (context, index) {
          //     return Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(left: 10),
          //           child: InverterCard(inverterModel: snapshot.data![index]),
          //         ),
          //         InverterCard(inverterModel: snapshot.data![index]),
          //       ],
          //     );
          //   },
          // );
        }
      },
    );
  }
}

// ---------------------------------------------------------------
Widget _TextBuilderForInverter({required InverterModel inverterModel}) {
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

SizedBox _buildImageforInverter({required InverterModel inverterModel}) {
  return SizedBox(
    width: width(220),
    height: height(50),
    child: Image.network("http://solareasegp.runasp.net/" + inverterModel.Inverterimage),
  );
}
