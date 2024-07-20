import 'package:dio/dio.dart';
import 'package:favorite_ui/APIService/ProductModel.dart';
import 'package:favorite_ui/APIService/ProductService.dart';
import 'package:favorite_ui/main.dart';
import 'package:flutter/material.dart';


// class PanelCard extends StatefulWidget {
//   final FavoritePanel panelModel;
//   final VoidCallback onFavoriteToggled;

//   PanelCard({required this.panelModel, required this.onFavoriteToggled});

//   @override
//   State<PanelCard> createState() => _PanelCardState();
// }

// class _PanelCardState extends State<PanelCard> {
//   PanelService? panelService = PanelService(Dio());

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width(370),
//       height: height(140),
//       child: Card(
//         color: Color(0xffD9EDCA), // #D9EDCA
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: IconButton(
//                 onPressed: () async {
//                   setState(() {
//                     widget.panelModel.isFavorite = !widget.panelModel.isFavorite;
//                   });
//                   await panelService?.ToggleFavorite(widget.panelModel.PanelId);
//                   if (!widget.panelModel.isFavorite) {
//                     widget.onFavoriteToggled();
//                   }
//                 },
//                 icon: Icon(
//                   widget.panelModel.isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: widget.panelModel.isFavorite ? Colors.orange : Colors.black,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: _buildImage(panelModel: widget.panelModel),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: _TextBuilder(panelModel: widget.panelModel),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class PanelCardList extends StatefulWidget {
//   @override
//   _PanelCardListState createState() => _PanelCardListState();
// }

// class _PanelCardListState extends State<PanelCardList> {
//   late Future<List<FavoritePanel>> _favoritePanelsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _favoritePanelsFuture = PanelService(Dio()).getFavoritePanel();
//   }

//   void _refreshFavoritePanels() {
//     setState(() {
//       _favoritePanelsFuture = PanelService(Dio()).getFavoritePanel();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<FavoritePanel>>(
//       future: _favoritePanelsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No data available'));
//         } else {
//           final panels = snapshot.data!;
//           return ListView.builder(
//             itemCount: (panels.length / 2).ceil(),
//             itemBuilder: (context, index) {
//               int firstIndex = index * 2;
//               int secondIndex = firstIndex + 1;
//               bool hasSecond = secondIndex < panels.length;
//               return Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: PanelCard(
//                       panelModel: panels[firstIndex],
//                       onFavoriteToggled: _refreshFavoritePanels,
//                     ),
//                   ),
//                   if (hasSecond)
//                     PanelCard(
//                       panelModel: panels[secondIndex],
//                       onFavoriteToggled: _refreshFavoritePanels,
//                     ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

// Widget _TextBuilder({required panelModel}) {
//   return Expanded(
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             panelModel.PanelBrandName,
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//           Row(
//             children: [
//               Icon(Icons.monetization_on, size: 16),
//               Text(
//                 panelModel.PanelPrice,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(Icons.location_on, size: 16),
//               Text(
//                 panelModel.totalPrice ?? 'N/A',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(Icons.calendar_today, size: 16),
//               Text(
//                 panelModel.PanelCapacity,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// SizedBox _buildImage({required panelModel}) {
//   return SizedBox(
//     width: width(220),
//     height: height(50),
//     child: Image.network("http://solareasegp.runasp.net/" + panelModel.Panelimage),
//   );
// }


// class PanelCard extends StatefulWidget {
//   final FavoritePanel panelModel;
//   final VoidCallback onFavoriteToggled;

//   PanelCard({required this.panelModel, required this.onFavoriteToggled});

//   @override
//   State<PanelCard> createState() => _PanelCardState();
// }

// class _PanelCardState extends State<PanelCard> {
//   PanelService? panelService = PanelService(Dio());

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width(370),
//       height: height(140),
//       child: Card(
//         color: Color(0xffD9EDCA),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: IconButton(
//                 onPressed: () async {
//                   setState(() {
//                     widget.panelModel.isFavorite = !widget.panelModel.isFavorite;
//                   });
//                   await panelService?.ToggleFavorite(widget.panelModel.PanelId);
//                   if (!widget.panelModel.isFavorite) {
//                     widget.onFavoriteToggled();
//                   }
//                 },
//                 icon: Icon(
//                   // widget.panelModel.isFavorite ? Icons.favorite : Icons.favorite_border,
//                   // color: widget.panelModel.isFavorite ? Colors.orange : Colors.black,
//                   Icons.favorite,
//                     color:Colors.orange  ,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: _buildImage(panelModel: widget.panelModel),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 16),
//                   child: _TextBuilder(panelModel: widget.panelModel),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _TextBuilder({required panelModel}) {
//   return Expanded(
//     child: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             panelModel.PanelBrandName,
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//           Row(
//             children: [
//               Icon(Icons.monetization_on, size: 16),
//               Text(
//                 panelModel.PanelPrice,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(Icons.location_on, size: 16),
//               Text(
//                 panelModel.totalPrice ?? 'N/A',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Icon(Icons.calendar_today, size: 16),
//               Text(
//                 panelModel.PanelCapacity,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// SizedBox _buildImage({required panelModel}) {
//   return SizedBox(
//     width: width(220),
//     height: height(50),
//     child: Image.network("http://solareasegp.runasp.net/" + panelModel.Panelimage),
//   );
// }

// class PanelCardList extends StatefulWidget {
//   @override
//   _PanelCardListState createState() => _PanelCardListState();
// }

// class _PanelCardListState extends State<PanelCardList> {
//   late Future<List<FavoritePanel>> _favoritePanelsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _favoritePanelsFuture = PanelService(Dio()).getFavoritePanel();
//   }

//   void _refreshFavoritePanels() {
//     setState(() {
//       _favoritePanelsFuture = PanelService(Dio()).getFavoritePanel();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<FavoritePanel>>(
//       future: _favoritePanelsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No data available'));
//         } else {
//           final panels = snapshot.data!;
//           return ListView.builder(
//             itemCount: (panels.length / 2).ceil(),
//             itemBuilder: (context, index) {
//               int firstIndex = index * 2;
//               int secondIndex = firstIndex + 1;
//               bool hasSecond = secondIndex < panels.length;
//               return Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: PanelCard(
//                       panelModel: panels[firstIndex],
//                       onFavoriteToggled: _refreshFavoritePanels,
//                     ),
//                   ),
//                   if (hasSecond)
//                     PanelCard(
//                       panelModel: panels[secondIndex],
//                       onFavoriteToggled: _refreshFavoritePanels,
//                     ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }



class PanelCard extends StatefulWidget {
  final FavoritePanel panelModel;
  final VoidCallback onFavoriteToggled;

  PanelCard({required this.panelModel, required this.onFavoriteToggled});

  @override
  State<PanelCard> createState() => _PanelCardState();
}

class _PanelCardState extends State<PanelCard> {
  PanelService? panelService = PanelService(Dio());
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(370),
      height: height(140),
      child: Card(
        color: Color(0xffD9EDCA),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _isLoading
                ? CircularProgressIndicator()
                : IconButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await panelService?.ToggleFavorite(widget.panelModel.PanelId);
                      setState(() {
                        widget.panelModel.isFavorite = !widget.panelModel.isFavorite;
                        _isLoading = false;
                      });
                      widget.onFavoriteToggled();
                    } catch (e) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  icon: Icon(
                      Icons.favorite,
                    color:Colors.orange  ,
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

class PanelCardList extends StatefulWidget {
  @override
  _PanelCardListState createState() => _PanelCardListState();
}

class _PanelCardListState extends State<PanelCardList> {
  late Future<List<FavoritePanel>> _favoritePanelsFuture;

  @override
  void initState() {
    super.initState();
    _favoritePanelsFuture = PanelService(Dio()).getFavoritePanel();
  }

  void _refreshFavoritePanels() {
    setState(() {
      _favoritePanelsFuture = PanelService(Dio()).getFavoritePanel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavoritePanel>>(
      future: _favoritePanelsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final panels = snapshot.data!;
          return ListView.builder(
            itemCount: (panels.length / 2).ceil(),
            itemBuilder: (context, index) {
              int firstIndex = index * 2;
              int secondIndex = firstIndex + 1;
              bool hasSecond = secondIndex < panels.length;
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: PanelCard(
                      panelModel: panels[firstIndex],
                      onFavoriteToggled: _refreshFavoritePanels,
                    ),
                  ),
                  if (hasSecond)
                    PanelCard(
                      panelModel: panels[secondIndex],
                      onFavoriteToggled: _refreshFavoritePanels,
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

Widget _TextBuilder({required panelModel}) {
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

SizedBox _buildImage({required panelModel}) {
  return SizedBox(
    width: width(220),
    height: height(50),
    child: Image.network("http://solareasegp.runasp.net/" + panelModel.Panelimage),
  );
}
