import 'package:dio/dio.dart';
import 'package:favorite_ui/APIService/PostModel.dart';
import 'package:favorite_ui/APIService/favoriteModel.dart';
import 'package:favorite_ui/PostView/whenclick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FavoritePostCard extends StatefulWidget {
  final FavoritePostmodel favoritepost;
  final Function(FavoritePostmodel) onDelete;

  const FavoritePostCard({ required this.favoritepost, required this.onDelete });

  @override
  State<FavoritePostCard> createState() => _FavoritePostCardState();
}

class _FavoritePostCardState extends State<FavoritePostCard> {
  bool deleting = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: 130,
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return Postpage(title: '',);

            }));
          },
          child: Card(
            color: Color(0xffD9EDCA),
            child: Row(
              children: [
                // -------------------- Image -----------------
                Container(
                  padding: EdgeInsets.only(left: 16),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
                  child: Image.network("http://solareasegp.runasp.net/"+ widget.favoritepost.FImage),
                 // child: Image.asset('assets/Image.png'),
                ),
                SizedBox(width: 32),
                // ------------------ Text ---------------------
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            widget.favoritepost.FCategory,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text( widget.favoritepost.RemovedDate),
                        Text( widget.favoritepost.Flocation),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                // ----------------------- Delete Icon --------------------------
                SizedBox(width: 64),
                IconButton(
                  onPressed: deleting ? null : () async {
                    setState(() {
                      deleting = true;
                    });
                    await UserPostService(Dio()).ToggleFavorite(widget.favoritepost.ID);
                    setState(() {
                      deleting = false;
                    });
                    widget.onDelete(widget.favoritepost); // Remove from the list
                  },
                  icon: deleting
                      ? CircularProgressIndicator()
                      : Icon(
                          Icons.favorite,
                          color: Colors.orange,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
