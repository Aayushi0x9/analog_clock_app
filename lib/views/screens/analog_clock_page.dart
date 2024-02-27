import 'dart:math';

import 'package:analog_clock_app/utils/MyRoute.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  DateTime d = DateTime.now();
  int currentindex = 0;

  void AnalogStart() {
    Future.delayed(const Duration(seconds: 1), () {
      d = DateTime.now();
      setState(() {});
      AnalogStart();
    });
  }

  @override
  void initState() {
    super.initState();
    AnalogStart();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analog Clock"),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu_open),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTExL3Jhd3BpeGVsb2ZmaWNlMTBfYV9kaXZlcnNpdHlfYmxhY2tfYnJpY2tzX2FyZV9hcnJhbmdlZF9vbl9hbl9lbV9mOWI0ODljYy1kMjU4LTQ3OGUtYmVhNC00MWQwMTVkM2MzNjFfMS5qcGc.jpg",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Transform.rotate(
              angle: pi / 2,
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                height: size.height * 6,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    shape: BoxShape.circle),
                child: Stack(
                  children: [
                    ...List.generate(
                      60,
                      (index) => Transform.rotate(
                        angle: index * (pi * 2) / 60,
                        child: Divider(
                            endIndent: index % 5 == 0
                                ? size.width * 0.88
                                : size.width * 0.9,
                            thickness: index % 5 == 0 ? 7 : 2,
                            color:
                                index % 15 == 0 ? Colors.yellow : Colors.white),
                      ),
                    ),
                    // hour :----------
                    Transform.rotate(
                      angle: d.hour * (pi * 2) / 12,
                      child: Divider(
                        indent: 70,
                        endIndent: size.width * 0.5 - 23,
                        thickness: 4,
                        color: Colors.white,
                      ),
                    ),
                    //minute :---------
                    Transform.rotate(
                      angle: d.minute * (pi * 2) / 60,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 23,
                        thickness: 3,
                        color: Colors.white,
                      ),
                    ),
                    //seconds :------------
                    Transform.rotate(
                      angle: d.second * (pi * 2) / 60,
                      child: Divider(
                        indent: 30,
                        endIndent: size.width * 0.5 - 23,
                        thickness: 2,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(MyRoutes.DigitalPage);
              },
              child: Icon(Icons.timer),
            ),
            label: "Timer",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: "Me",
          ),
        ],
      ),
    );
  }
}
