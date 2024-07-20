import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_ui/main.dart';

class SearchWidgwt extends StatelessWidget {
  //const SearchWidgwt({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                 width:  width(590),height: height(16),
                  child: TextField
                  (
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Color(0xffD9EDCA), 
                      suffixIcon: Container
                      (
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffED9555),
                        ),child: Icon(Icons.search,size: width(40),color: Colors.white,),
                      ),border: OutlineInputBorder
                      (
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:BorderSide.none, 
                      ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: width(10)),),
                    style: TextStyle(fontSize: 14 * t,),
                    textAlign: TextAlign.center, 
                    onChanged: (value){print('Search query: $value');},
          ),
        );
  }
}
 