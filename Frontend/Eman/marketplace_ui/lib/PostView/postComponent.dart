// import 'package:flutter/material.dart';
// import 'package:marketplace_ui/PostView/whenclick.dart';

// class conmponent extends StatelessWidget 
// {
//   TextEditingController controller = TextEditingController();
//   double w; double h; double w_; double wt; String ?txt;
//   dynamic? s;
//   conmponent(this.w, this.h, this.txt, this.w_, this.wt, this.s);
//   @override
//   Widget build(BuildContext context) 
//   {
//     return SizedBox(
//       width: w,  height: h, //40
//       child: Row(
//         children: 
//         [
//           SizedBox(
//             width: wt,
//             child: Text( txt!,
//               style: TextStyle(
//                 fontSize: 15.0 * t,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0x0ff063221),
//               ),
//             ),
//           ),
//           if(txt != "Description")
//             (Container(
//               width: w_,
//               height: hig(20), 
//               decoration: BoxDecoration(color: Color(0xffD9D9D9),borderRadius:BorderRadius.circular(20),),
//               child: Center(child: Text(s)),
//             )
//           )
//           else
//             (
//               Container(
//               height: h, width: w_, 
//               decoration: BoxDecoration
//               (
//                 color: Color(0xffD9D9D9),
//                 borderRadius:BorderRadius.circular(20), ),
//               child: Center(child: Text(s)),
//               )
//             ),
//         ],
//       ),
//     );
//   }
// }
