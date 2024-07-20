import 'package:flutter/material.dart';
import 'package:remove_post/main.dart';

class RemoveCard extends StatelessWidget {
  const RemoveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 16),
          child: Container(
            width: width(80), height: height(70),
            decoration: BoxDecoration
            (
              color: Color(0xffE1F1D6),
              borderRadius: BorderRadius.circular(16) 
            ),
            child: Row(
              children: [
                //-------------------- Image -----------------
                Image.asset("assets/Removepost-removebg-preview.png",),
                //------------------ Text ---------------------
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Solar Panel",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),
                  Text("5000 EGP     "),
                  Text("3 / 3 / 2020 "),
                  Text("Location     "),
                ],),
                //----------------------- delet Icon ------
              SizedBox(width:width(8)),
               Padding(
                 padding: const EdgeInsets.only(top: 16),
                 child: Column(
                   children: [
                     IconButton(
                     icon: Icon(Icons.delete,color: Colors.orange,),
                     onPressed: (){},
                     ),
                     Text("delete"),
                   ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 16),
                 child: Column(
                   children: [
                     IconButton(
                     icon: Icon(Icons.edit,),
                     onPressed: (){},
                     ),
                     Text("Edit"),
                   ],
                 ),
               ),
               
                              
               
              ],
            ),
            
          
          ),
        )
        ;
  }
}