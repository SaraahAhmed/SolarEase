import 'package:flutter/material.dart';
import 'package:remove_post/main.dart';
import 'package:remove_post/removeCard.dart';

class RomveBody extends StatelessWidget {
  const RomveBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: 
          SizedBox(
                  height: height(250),
                  width: double.infinity,
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/upper.png',
                            fit: BoxFit.fill,
                            width: width(370),
                            height: height(60),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                             //   Navigator.pop(context);
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
                              'Your Posts',
                              style: TextStyle(
                                fontSize: 25.0 * t,
                                fontWeight: FontWeight.bold,
                                color: Color(0x0ff063221),
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
      ),
        body: Column(
          children: [
            Expanded(
              flex: 7, // Adjust the flex value as needed
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return RemoveCard();
                },
              ),
            ),
          ],
        ),
      );
  }
}