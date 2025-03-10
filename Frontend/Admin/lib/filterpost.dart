import 'dart:async';
import 'package:app/AdminProfile.dart';
import 'package:app/api_objects/post.dart';
import 'package:app/api_objects/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

double scw = 0; // 60% of screen width
double sch = 0;
double t = 0;

double wid(double w) {
  return scw * (w / 310);
}

double hig(double h) {
  return (h / 592) * sch;
}

User user = User(
  username: "username",
  password: "password",
  email: "email",
  location: "location",
  phoneNumber: "phoneNumber",
  city: "city",
);

class FilterPost extends StatefulWidget {
  User u;
  FilterPost({required this.u}) {
    user = u;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FilterPost> {
  String showError = "Ok";
  bool adminpageloading = true;
  void setFalse() {
    setState(() {
      adminpageloading = false;
    });
  }

  void setTrue() {
    setState(() {
      adminpageloading = true;
    });
  }

  List<Post> posts = List.generate(
      5,
      (index) => Post(
          brandChange: "brandChange$index",
          capacityChange: 50,
          categoryChange: "categoryChange",
          cityChange: "cityChange",
          descriptionChange: "descriptionChange",
          imageFile: null,
          isusedChange: true,
          locationChange: "locationChange",
          priceChange: 4,
          unitChange: "unitChange",
          voltChange: 4));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdminPosts();
  }

  Future<void> getAdminPosts() async {
    //get all posts to filter
    showError = await getPoststoFilter(posts);
    setState(() {
      adminpageloading = false;
    });
  }

  // Example list of posts

  @override
  Widget build(BuildContext context) {
    scw = MediaQuery.of(context).size.width; // 60% of screen width
    sch = MediaQuery.of(context).size.height;
    t = MediaQuery.of(context).textScaleFactor;
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Header(showError),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: wid(20), bottom: hig(5)),
                        child: Text(
                          '( ${posts.length} ) Requests',
                          style: TextStyle(
                            fontSize: 18.0 * t,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            MonthContainer(
                                post: posts[index],
                                changePage: () async {
                                  setState(() {
                                    adminpageloading = true;
                                  });
                                  showError = await getPoststoFilter(posts);
                                  setState(() {
                                    adminpageloading = false;
                                  });
                                },
                                setFalse: setFalse,
                                setTrue: setTrue),
                            SizedBox(height: hig(10))
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (adminpageloading)
              const Opacity(
                  opacity: 0.25,
                  child: ModalBarrier(dismissible: false, color: Colors.black)),
            if (adminpageloading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class Header extends StatelessWidget {
  String show;
  Header(this.show);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hig(100),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/filterpost/cloud.png',
              fit: BoxFit.fill,
              width: wid(140),
              height: hig(90),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: wid(70),
                  ),
                  Center(
                    child: Text(
                      'Filter Posts',
                      style: TextStyle(
                        fontSize: 25.0 * t,
                        fontWeight: FontWeight.bold,
                        color: Color(0x0ff063221),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: wid(70),
                    height: hig(75),
                  ),
                ],
              ),
              if (show != "Ok")
                Center(
                  child: Text(
                    "Oops! Something went wrong.",
                    style: TextStyle(fontSize: 15.0, color: Colors.red),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}

class MonthContainer extends StatelessWidget {
  String filter = "Ok";
  Post post;
  void Function() setFalse;
  void Function() setTrue;
  void Function() changePage;
  MonthContainer(
      {required this.post,
      required this.changePage,
      required this.setFalse,
      required this.setTrue});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid(300),
      height: hig(490), //480
      decoration: BoxDecoration(
        color: Color(0xffE1F1D5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: SizedBox(
          width: wid(280),
          height: hig(470), //380
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    // child: Image.network(
                    //   post.ownerPhoto!,
                    //   width: wid(40),
                    //   height: hig(40),
                    // ),
                    child: Image.network(
                      post.ownerPhoto ?? '',
                      fit: BoxFit.fill,
                      width: wid(40),
                      height: hig(40),
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: wid(15),
                  ),
                  Text(
                    post.ownerName ?? "user",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0x0ff063221),
                    ),
                  ),
                  Spacer(flex: 5),
                  Text(
                    post.date ?? "-/-/-",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0x0ff063221),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
              Center(
                // child: Image.network(
                //   post.photo,
                //   fit: BoxFit.fill,
                //   width: wid(250),
                //   height: hig(150), //70
                // ),
                child: Image.network(
                  post.photo ?? '',
                  fit: BoxFit.fill,
                  width: wid(250),
                  height: hig(150),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: hig(10),
              ),
              Row(
                children: [
                  Conmponent(wid(150), hig(30), "is used", wid(70), wid(80),
                      post.isusedChange ? "Yes" : "No"),
                  SizedBox(
                    width: 5,
                  ),
                  Conmponent(wid(125), hig(30), "Brand", wid(90), wid(35),
                      post.brandChange),
                ],
              ),
              Conmponent(wid(220), hig(30), "category", wid(140), wid(80),
                  post.categoryChange),
              Row(
                children: [
                  Conmponent(wid(155), hig(30), "Capacity", wid(75), wid(80),
                      post.capacityChange.toString() + post.unitChange),
                  SizedBox(
                    width: wid(5),
                  ),
                  if (post.categoryChange == "Battery")
                    (Conmponent(wid(120), hig(30), "volt", wid(80), wid(30),
                        post.voltChange.toString() + " V"))
                ],
              ),
              Conmponent(wid(220), hig(30), "Price", wid(80), wid(80),
                  post.priceChange.toString()),
              Conmponent(wid(220), hig(30), "Phone", wid(140), wid(80),
                  post.phone ?? "000000000000"),
              Conmponent(wid(220), hig(30), "Location", wid(140), wid(80),
                  post.locationChange + " ," + post.cityChange),
              Conmponent(wid(280), hig(30), "Description", wid(195), wid(80),
                  post.descriptionChange ?? ''),
              filter == "Ok"
                  ? SizedBox(
                      height: hig(10),
                    )
                  : SizedBox(
                      height: hig(4),
                    ),
              if (filter != "Ok")
                Center(
                  child: Text(
                    "Oops! Something went wrong.",
                    style: TextStyle(fontSize: 15.0, color: Colors.red),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(wid(100), hig(40), Colors.red, "Reject", () async {
                    print(post.id.toString() + "************");
                    //remove api using post.id
                    setTrue();
                    filter = await rejectPost(post.id!);
                    setFalse();
                    changePage();
                  }),
                  Button(wid(100), hig(40), Colors.green, "Accept", () async {
                    print(post.id.toString() + "************");
                    //accept api using post.id
                    setTrue();
                    filter = await acceptPost(post.id!);
                    setFalse();
                    changePage();
                  }),
                ],
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
  final double w_;
  final double wt;
  final String txt;
  final String containt;

  Conmponent(this.w, this.h, this.txt, this.w_, this.wt, this.containt);

  @override
  Widget build(BuildContext context) {
    double t = MediaQuery.of(context).textScaleFactor;
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
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color(0x0ff063221),
              ),
            ),
          ),
          if (txt != "Description")
            Container(
                width: w_,
                height: hig(20),
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Text(containt)),
                ))
          else
            Container(
              constraints: BoxConstraints(
                minHeight: hig(20),
                maxHeight: hig(50),
              ),
              child: Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: Text(containt))),
              width: w_,
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final double w;
  final double h;
  final Color c;
  final String txt;
  Future<void> Function() onpress;

  Button(this.w, this.h, this.c, this.txt, this.onpress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Container(
            width: w - 10,
            height: h - 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                txt,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: c,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffECECEC),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            _buildIconItem(Icons.home, 'Home', () {}),
            Spacer(
              flex: 2,
            ),
            _buildIconItem(Icons.person, 'Profile', () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AdminProfile()));
              // Add onTap functionality for Profile
            }),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

/**********************************************/
//widget for each item in navigation bar
  Widget _buildIconItem(IconData iconData, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: hig(62),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 30,
                color: text == "Home"
                    ? Color.fromARGB(136, 6, 50, 33)
                    : Color(0xff063221),
              ),
              SizedBox(height: 3),
              Text(
                text,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff063221),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
