import 'package:flutter/material.dart';
import 'package:marketplace_ui/APIService/post.dart';

double scw = 0; // 60% of screen width
double sch = 0;
double t = 0;
String s = "inverter";
Post post = Post(
    brandChange: "brandChange",
    capacityChange: 5,
    categoryChange: "categoryChange",
    cityChange: "cityChange",
    descriptionChange: "descriptionChange",
    imageFile: null,
    isusedChange: true,
    locationChange: "locationChange",
    priceChange: 5,
    unitChange: "unitChange",
    voltChange: 5);

//void main() => runApp(Postpage());

double wid(BuildContext context, double w) {
  return MediaQuery.of(context).size.width * (w / 360);
}

double hig(BuildContext context, double h) {
  return (h / 592) * MediaQuery.of(context).size.height;
}

// class Postpage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Postpage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class Postpage extends StatefulWidget {
  Postpage();

  //final String title;

  @override
  State<Postpage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Postpage> {
  bool isloadingbigPost = true;
  @override
  void initState() {
    super.initState();
    getpost();
  }

  Future<void> getpost() async {
    setState(() {
      isloadingbigPost = true;
    });
    await post.getPost();
    setState(() {
      isloadingbigPost = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    scw = MediaQuery.of(context).size.width;
    sch = MediaQuery.of(context).size.height;
    t = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: hig(context, 100),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/whenclick/cloud.png',
                          fit: BoxFit.fill,
                          width: wid(context, 90),
                          height: hig(context, 90),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              print('Arrow tapped');
                            },
                            child: Image.asset(
                              'assets/whenclick/arrow.png',
                              width: wid(context, 70),
                              height: hig(context, 80),
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 25.0 * t,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff063221),
                            ),
                          ),
                          SizedBox(
                            width: wid(context, 70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MonthContainer(),
              ],
            ),
          ),
          if (isloadingbigPost)
            const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black)),
          if (isloadingbigPost)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}

class MonthContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid(context, 340),
      height: s == "Battery" ? hig(context, 532) : hig(context, 502),
      decoration: BoxDecoration(
        color: Color(0xffE1F1D5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: SizedBox(
          width: wid(context, 320),
          height: s == "Battery" ? hig(context, 522) : hig(context, 492),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    post.ownerPhoto!,
                    width: wid(context, 40),
                    height: hig(context, 40),
                  ),
                  SizedBox(width: wid(context, 15)),
                  Text(
                    post.ownerName ?? "User",
                    style: TextStyle(
                      fontSize: 18.0 * t,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff063221),
                    ),
                  ),
                  Spacer(flex: 5),
                  Text(
                    post.date ?? "-/-/-",
                    style: TextStyle(
                      fontSize: 15.0 * t,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff063221),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
              SizedBox(height: hig(context, 10)),
              Center(
                child: Image.network(
                  post.photo!,
                  fit: BoxFit.fill,
                  width: wid(context, 200),
                  height: hig(context, 120),
                ),
              ),
              SizedBox(height: hig(context, 10)),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "is used",
                w_: wid(context, 70),
                wt: wid(context, 85),
                s: post.isusedChange.toString(),
              ),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "Brand",
                w_: wid(context, 70),
                wt: wid(context, 85),
                s: post.brandChange,
              ),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "category",
                w_: wid(context, 140),
                wt: wid(context, 85),
                s: post.categoryChange,
              ),
              if (s == 'Battery')
                Conmponent(
                  w: wid(context, 280),
                  h: hig(context, 35),
                  txt: "volt",
                  w_: wid(context, 60),
                  wt: wid(context, 85),
                  s: post.voltChange.toString() + "V",
                ),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "Capacity",
                w_: wid(context, 60),
                wt: wid(context, 85),
                s: post.capacityChange.toString() + post.unitChange,
              ),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "Price",
                w_: wid(context, 80),
                wt: wid(context, 85),
                s: post.priceChange.toString(),
              ),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "Phone",
                w_: wid(context, 140),
                wt: wid(context, 85),
                s: post.phone ?? "",
              ),
              Conmponent(
                w: wid(context, 280),
                h: hig(context, 35),
                txt: "Location",
                w_: wid(context, 140),
                wt: wid(context, 85),
                s: post.locationChange.toString() + " ," + post.cityChange,
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 15.0 * t,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff063221),
                ),
              ),
              Conmponent(
                w: wid(context, 320),
                h: hig(context, 45),
                txt: "Description",
                w_: wid(context, 320),
                wt: 0,
                s: post.descriptionChange.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Conmponent extends StatelessWidget {
  final double w;
  final double h;
  final String txt;
  final double w_;
  final double wt;
  final String s;

  Conmponent({
    required this.w,
    required this.h,
    required this.txt,
    required this.w_,
    required this.wt,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      height: h,
      child: Row(
        children: [
          SizedBox(
            width: wt,
            child: Text(
              txt,
              style: TextStyle(
                fontSize: 15.0 * MediaQuery.of(context).textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Color(0xff063221),
              ),
            ),
          ),
          Container(
            width: w_,
            height: hig(context, 20),
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(s),
            ),
          ),
        ],
      ),
    );
  }
}








/*import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

double scw = 0; // 60% of screen width
double sch = 0;
double t = 0;

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() => runApp(MyApp());

double wid(double w) {
  return scw * (w / 360);
}

double hig(double h) {
  return (h / 592) * sch;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Postpage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Postpage extends StatefulWidget {
  Postpage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Postpage> {
  String dropdownValue = 'Electricity Bills';

  @override
  Widget build(BuildContext context) {
    scw = MediaQuery.of(context).size.width; // 60% of screen width
    sch = MediaQuery.of(context).size.height;
    t = MediaQuery.of(context).textScaleFactor;
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: hig(100),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/whenclick/cloud.png',
                          fit: BoxFit.fill,
                          width: wid(90),
                          height: hig(90),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Align items vertically
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Function to be executed when the arrow is tapped
                              print('Arrow tapped');
                            },
                            child: Image.asset(
                              'assets/whenclick/arrow.png',
                              width: wid(70),
                              height: hig(80),
                            ),
                          ),
                          // Add space between the icon and text

                          Text(
                            'MarketPlace',
                            style: TextStyle(
                              fontSize: 25.0 * t,
                              fontWeight: FontWeight.bold,
                              color: Color(0x0ff063221),
                            ),
                          ),

                          SizedBox(
                            width: wid(70),
                          ),
                          // To take all remaining space
                        ],
                      ),
                    ],
                  ),
                ),
                MonthContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String s = "Battery";

class MonthContainer extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: wid(340), // Set the width
        height: s == "Battery" ? hig(532) : hig(502), // Set the height
        decoration: BoxDecoration(
          color: Color(0xffE1F1D5), // Set the color
          borderRadius: BorderRadius.circular(20), // Set circular border radius
        ),
        child: Center(
          child: SizedBox(
            width: wid(320),
            height: s == "Battery" ? hig(522) : hig(492),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/whenclick/profile.png',
                      width: wid(40),
                      height: hig(40),
                    ),
                    SizedBox(
                      width: wid(15),
                    ),
                    Text(
                      'user1',
                      style: TextStyle(
                        fontSize: 18.0 * t,
                        fontWeight: FontWeight.bold,
                        color: Color(0x0ff063221),
                      ),
                    ),
                    Spacer(flex: 5),
                    Text(
                      '3/3/2020',
                      style: TextStyle(
                        fontSize: 15.0 * t,
                        fontWeight: FontWeight.bold,
                        color: Color(0x0ff063221),
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
                SizedBox(
                  height: hig(10),
                ),
                Center(
                  child: Image.asset(
                    'assets/whenclick/four.png',
                    fit: BoxFit.fill,
                    width: wid(200),
                    height: hig(120),
                  ),
                ),
                SizedBox(
                  height: hig(10),
                ),
                conmponent(
                    wid(280), hig(35), "is used", wid(70), wid(85), "yes"),
                conmponent(wid(280), hig(35), "Brand", wid(70), wid(85), "aaa"),
                conmponent(wid(280), hig(35), "category", wid(140), wid(85), s),
                if (s == 'Battery')
                  (conmponent(
                      wid(280), hig(35), "volt", wid(60), wid(85), '500')),
                conmponent(
                    wid(280), hig(35), "Capacity", wid(60), wid(85), '500'),
                conmponent(
                    wid(280), hig(35), "Price", wid(80), wid(85), '5000'),
                conmponent(wid(280), hig(35), "Phone", wid(140), wid(85),
                    '011123456789'),
                conmponent(
                    wid(280), hig(35), "Location", wid(140), wid(85), 'Cairo'),
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 15.0 * t,
                    fontWeight: FontWeight.bold,
                    color: Color(0x0ff063221),
                  ),
                ),
                conmponent(wid(320), hig(45), "Description", wid(320), 0,
                    "ddddddddddddddddddddddddddddddddd"),
              ],
            ),
          ),
        ));
  }
}

class conmponent extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  double w;
  double h;
  double w_;
  double wt;
  String txt;
  String s;
  conmponent(this.w, this.h, this.txt, this.w_, this.wt, this.s);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w, //150
      height: h, //40
      child: Row(
        children: [
          SizedBox(
            width: wt,
            child: Text(
              txt,
              style: TextStyle(
                fontSize: 15.0 * t,
                fontWeight: FontWeight.bold,
                color: Color(0x0ff063221),
              ),
            ),
          ),
          if (txt != "Description")
            (Container(
              width: w_, // Set the width
              height: hig(20), // Set the height
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9), // Set the color
                borderRadius:
                    BorderRadius.circular(20), // Set circular border radius
              ),
              child: Center(child: Text(s)),
            ))
          else
            (Container(
              height: h,
              width: w_, // Set the width
              // Set the height
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9), // Set the color
                borderRadius:
                    BorderRadius.circular(20), // Set circular border radius
              ),
              child: Center(child: Text(s)),
            )),
        ],
      ),
    );
  }
}
*/