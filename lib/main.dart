import 'dart:async';

import 'package:clock1/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: deep(),
  ));
}

class deep extends StatefulWidget {
  const deep({Key? key}) : super(key: key);

  @override
  State<deep> createState() => _deepState();
}

class _deepState extends State<deep> {
  // Timer Clockval() {
  //   return Timer(Duration(seconds: 1), () {
  //     setState(() {
  //       clockval.sec++;
  //       if (clockval.sec > 59) {
  //         clockval.sec = 0;
  //         clockval.min++;
  //       } else if (clockval.min > 59) {
  //         clockval.min = 0;
  //         clockval.hour++;
  //       }
  //     });
  //     Clockval();
  //   });
  // }

  String? timeString;
  String? dateString;
  String? dateString1;
  DateTime today = DateTime.now();
  int hrs = 0;
  int? min;
  int? sec;
  String? obtainedtime;
  String? obtainedtime1;
  String? finaltime;

  List ftime = [];

  @override
  void initState() {
    dateString = "${today.day}-${today.month}-${today.year}";
    dateString1 = "${today.day}-${today.month}-${today.year}";
    timeString =
        "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => getCurrentTime());
    super.initState();
    fitime();
  }

  fitime() async {
    final prefs = await SharedPreferences.getInstance();
    obtainedtime = prefs.getString('time');
    finaltime = prefs.getString('data');
    final List<String>? obtainedtime1 = prefs.getStringList('time');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("obtainedtime:$obtainedtime"),
            Text("obtainedtime1:$obtainedtime1"),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Clock",
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              "https://i.pinimg.com/originals/0a/3a/44/0a3a4471466021e50d091e91f3e76503.gif",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (clockval.digital == true)
                  ? Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${timeString}",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 54,
                                ),
                              ),
                              Text(
                                "${dateString}",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("obtainedtime:$obtainedtime"),
                          Text("finaltime:$finaltime"),
                        ],
                      ),
                    ),
              ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() async {
                      await prefs.setString('time', '${timeString}');
                      await prefs.setString('data', '${dateString}');
                      await prefs
                          .setStringList('time', <String>['${dateString}']);

                      print("finaltime:$finaltime");
                    });
                  },
                  child: Text("Mark My Thought")),
              Padding(padding: EdgeInsets.only(top: 10)),
              InkWell(
                onTap: () {
                  setState(() {
                    clockval.digital = !clockval.digital;
                  });
                },
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void getCurrentTime() {
    setState(() {
      timeString =
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
      dateString = "${today.day}-${today.month}-${today.year}";
      dateString1 = "${today.day}-${today.month}-${today.year}";
    });
  }
}
