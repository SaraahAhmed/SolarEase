import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplace_ui/APIService/post.dart';

// Global Variables
double scw = 0; // 60% of screen width
double sch = 0;
double t = 0;
bool editpostloading = false;
File? imageFile;
bool? isusedChange;
String? categoryChange;
double? priceChange;
//imageChange;
String? brandChange;
double? capacityChange;
String? unitChange;
double? voltChange;
String? locationChange;
String? cityChange;
String? descriptionChange;

// Custom Scroll Behavior
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// Utility Functions
double wid(double w) {
  return scw * (w / 420);
}

double hig(double h) {
  return (h / 592) * sch;
}

//void main() => runApp(AddPostApp());

// Main App Widget
class AddPostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: AddPostScreen(),
    );
  }
}

// AddPostScreen Stateful Widget
class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  void updatePostDats(String label, String value) {
    switch (label) {
      case 'is used':
        isusedChange = value == "yes" ? true : false;
        break;
      case 'Category':
        categoryChange = value;
        break;
      case 'Capacity':
        capacityChange = double.parse(value);
        break;
      case 'Location':
        locationChange = value;
        break;
      case 'City':
        cityChange = value;
        break;
      case 'Brand':
        brandChange = value;
      case 'Unit':
        unitChange = value;

        break;
      case 'Volume':
        voltChange = value == '' ? null : double.parse(value);
        break;
      case 'Price':
        priceChange = double.parse(value);
        break;
      case 'Description':
        descriptionChange = value;
      case 'loading':
        setState(() {
          editpostloading = value == "yes" ? true : false;
          print('okay********************************************************' +
              editpostloading.toString());
        });

        break;
    }
  }

/***************************************************************************** */
//main widget
  @override
  Widget build(BuildContext context) {
    scw = MediaQuery.of(context).size.width; // 60% of screen width
    sch = MediaQuery.of(context).size.height;
    t = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Header(),
                  PostDataForm(updatePostDats),
                  SizedBox(height: hig(5)),
                ],
              ),
            ),
          ),
          if (editpostloading)
            const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black)),
          if (editpostloading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}

/***************************************************************************** */
// Header Widget
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hig(100), //=100
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/addpost/cloud.png',
              fit: BoxFit.fill,
              width: wid(140), //=140
              height: hig(90), //=90
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
                  'assets/addpost/arrow.png',
                  width: wid(78),
                  height: hig(70),
                ),
              ),
              Text(
                'Add Post',
                style: TextStyle(
                  fontSize: 25.0 * t,
                  fontWeight: FontWeight.bold,
                  color: Color(0x0ff063221),
                ),
              ),
              SizedBox(
                width: wid(78),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/***************************************************************************** */
//widget that create input form
class PostDataForm extends StatefulWidget {
  void Function(String, String) change;
  PostDataForm(this.change);
  @override
  _PostDataFormState createState() => _PostDataFormState();
}

class _PostDataFormState extends State<PostDataForm> {
  Uint8List? _image;
  TextEditingController controller = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController voltController = TextEditingController();
  String? selectedCategory;
  String? selectedBrand;
  String profileImagePath = '';
  bool validdata = true;
  bool clicked = false;
  Widget uploadimage() {
    return GestureDetector(
      onTap: pickImage,
      child: Center(
        child: Image(
          image: _image == null
              ? AssetImage('assets/addpost/add.png')
              : MemoryImage(_image!) as ImageProvider,
          fit: BoxFit.fill,
          width: wid(300),
          height: hig(200), //=120
        ),
      ),
    );
  }

  bool databad() {
    return (categoryChange == "Battery" && voltChange == null) |
        (imageFile == null) |
        (isusedChange == null) |
        (categoryChange == null) |
        (priceChange == null) |
        (brandChange == null || brandChange!.isEmpty) |
        (capacityChange == null) |
        (unitChange == null) |
        (voltChange == null) |
        (locationChange == null || locationChange!.isEmpty) |
        (cityChange == null || cityChange!.isEmpty);
  }

  Widget sharebutton() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: hig(30),
          width: wid(168),
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                clicked = true;
              });
              if (databad()) {
                setState(() {
                  validdata = false;
                });
              } else {
                widget.change("loading", "yes");
                Post post = Post(
                    brandChange: brandChange!,
                    capacityChange: capacityChange!,
                    categoryChange: categoryChange!,
                    cityChange: cityChange!,
                    descriptionChange: descriptionChange!,
                    imageFile: imageFile!,
                    isusedChange: isusedChange!,
                    locationChange: locationChange!,
                    priceChange: priceChange!,
                    unitChange: unitChange!,
                    voltChange: voltChange);
                await post.createPost();
                widget.change("loading", "No");
                setState(() {
                  validdata = true;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffED9555), // Set background color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(25), // Set circular border radius
              ),
            ),
            child: Text(
              'Share',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // Set text color
                fontSize: 16 * t,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget builderrorinputtext() {
    return Center(
      child: Text(
        " data is not valid",
        style: TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid(378),
      height: hig(570), //490
      decoration: BoxDecoration(
        color: Color(0xffE1F1D5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: SizedBox(
          width: wid(357),
          height: hig(555),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: hig(9)),
              uploadimage(),
              SizedBox(height: hig(9)),
              /****************is used************************/
              DropdownList(wid(357), hig(30), "is used", wid(82), wid(95),
                  ["yes", "no"], widget.change),
              /****************Category************************/
              DropdownList(
                wid(357),
                hig(30),
                "Category",
                wid(156),
                wid(95),
                ["Solar Panel", "Inverter", "Battery", "Other"],
                (String lable, String value) {
                  setState(() {
                    widget.change("Category", value);
                    selectedCategory = value;
                    widget.change("Brand", '');
                    brandController.text = '';
                    selectedBrand = null;
                    // Reset selected brand when category changes
                  });
                },
              ),
              /****************Volume************************/
              if (selectedCategory == 'Battery')
                Conmponent(wid(357), hig(30), "Volume", wid(67), wid(95),
                    widget.change, voltController),

              Row(
                children: [
                  /****************Capacity************************/
                  Conmponent(wid(190), hig(30), "Capacity", wid(90), wid(95),
                      widget.change, capacityController),
                  SizedBox(width: wid(1)),
                  DropdownList(wid(135), hig(30), "Unit", wid(100), wid(35),
                      ["Waat", "KWh", "Ambeer"], widget.change),
                ],
              ),
              /****************Brand************************/
              Conmponent(wid(357), hig(30), "Brand", wid(156), wid(95),
                  widget.change, brandController),
              /****************Price************************/
              Conmponent(wid(357), hig(30), "Price", wid(90), wid(95),
                  widget.change, priceController),
              /***********************Location************************/
              Conmponent(wid(357), hig(30), "Location", wid(156), wid(95),
                  widget.change, locationController),
              /****************City************************/
              DropdownList(wid(357), hig(30), "City", wid(156), wid(95),
                  ["Cairo", "Alex", "Aswan", "Giza"], widget.change),
              /****************Description************************/
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 15.0 * t,
                  fontWeight: FontWeight.bold,
                  color: Color(0x0ff063221),
                ),
              ), //320
              Conmponent(wid(357), hig(40), "Description", wid(357), 0,
                  widget.change, descriptionController),
              if (!validdata && clicked) builderrorinputtext(),
              if (!(!validdata && clicked)) SizedBox(height: hig(11)),

              sharebutton()
            ],
          ),
        ),
      ),
    );
  }

/***************************************************************************** */
//When click on upload image
//function onpress on button

  final ImagePicker _picker = ImagePicker();
  // String? profileImageBase64;
  Future<void> pickImage() async {
    widget.change("loading", "yes");
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    widget.change("loading", "No");
    if (pickedFile != null) {
      widget.change("loading", "yes");
      var imageBytes = await pickedFile.readAsBytes();
      widget.change("loading", "no");
      setState(() {
        imageFile = File(pickedFile.path);
        _image = imageBytes;
        print(imageFile);
      });
    }
  }
 
}

/***************************************************************************** */
/// Widget for DropDown List
class DropdownList extends StatefulWidget {
  final double allWidth;
  final double hig;
  final double widthInput;
  final double widthLable;
  final String lable;

  final List<String> dropdownItems;
  final void Function(String, String) changed;

  DropdownList(this.allWidth, this.hig, this.lable, this.widthInput,
      this.widthLable, this.dropdownItems, this.changed);

  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.allWidth,
      height: widget.hig,
      child: Row(
        children: [
          SizedBox(
            width: widget.widthLable,
            child: Text(
              widget.lable,
              style: TextStyle(
                fontSize: 15.0 * t,
                fontWeight: FontWeight.bold,
                color: Color(0x0ff063221),
              ),
            ),
          ),
          Container(
            width: widget.widthInput,
            height: hig(17), //20
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: wid(4.2)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(20),
                  isDense: true,
                  value: dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                    widget.changed(widget.lable, newValue ?? '');
                  },
                  items: widget.dropdownItems
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 13 * t,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  dropdownColor: Color(0xffD9D9D9),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/***************************************************************************** */
//  Widget build Text Field
// Widget build Text Field
class Conmponent extends StatelessWidget {
  void Function(String, String) change;
  final TextEditingController controller;
  final double w;
  final double h;
  final double w_;
  final double wt;
  final String lable;

  Conmponent(this.w, this.h, this.lable, this.w_, this.wt, this.change,
      this.controller);

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
              lable,
              style: TextStyle(
                fontSize: 15.0 * t,
                fontWeight: FontWeight.bold,
                color: Color(0x0ff063221),
              ),
            ),
          ),
          if (lable != "Description")
            Container(
              width: w_, // Set the width
              height: hig(17), // Set the height
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9), // Set the color
                borderRadius:
                    BorderRadius.circular(20), // Set circular border radius
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.0106),
                child: TextField(
                  style: TextStyle(
                    fontSize: 13 * t,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none, // Remove default border
                  ),
                  controller: controller,
                  onChanged: (value) {
                    change(lable, value);
                  },
                ),
              ),
            )
          else
            Container(
              height: h,
              width: w_, // Set the width
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9), // Set the color
                borderRadius:
                    BorderRadius.circular(15), // Set circular border radius
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                ),
                controller: controller,
                onChanged: (value) {
                  change(lable, value);
                },
              ),
            ),
        ],
      ),
    );
  }
}
