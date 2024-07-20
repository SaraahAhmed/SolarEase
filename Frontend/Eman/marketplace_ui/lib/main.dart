import 'package:flutter/material.dart';
import 'package:marketplace_ui/PostView/UsersPosts.dart';
import 'package:marketplace_ui/ProductView/ProductPrice.dart';

import 'PostView/addpost.dart';

double scw = 0; // 60% of screen width
double sch = 0;
double t = 0;

double width(double w) {
  return scw * (w / 783);
}

double height(double h) {  
  return (h / 393) * sch;
}

void main() {
  runApp(MarketPlace());
}

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    
    scw = MediaQuery.of(context).size.width;
    sch = MediaQuery.of(context).size.height;
    t = MediaQuery.of(context).textScaleFactor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            flexibleSpace: SizedBox(
              height: height(150),
              width: double.infinity,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/cloud.png',
                        fit: BoxFit.fill,
                        width: width(350),
                        height: height(60),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Arrow tapped');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Image.asset(
                              'assets/arrow.png',
                              width: width(150),
                              height: height(150),
                            ),
                          ),
                        ),
                        Text(
                          'MarketPlace',
                          style: TextStyle(
                            fontSize: 25.0 * t,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff063221),
                          ),
                        ),
                        SizedBox(
                          width: width(166),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.orange,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Product Prices',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TabBarView(
              children: [
                UsersPosts(), /// 
                ProductPrices(), /// 
              ],
            ),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return AddPostApp(); // Fixed the class name to match convention
                }));
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
