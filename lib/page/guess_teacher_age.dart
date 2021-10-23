import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:http/http.dart' as http;





class GuessTeacherAge extends StatefulWidget {
  const GuessTeacherAge({Key? key}) : super(key: key);

  @override
  _GuessTeacherAgeState createState() => _GuessTeacherAgeState();
}

class _GuessTeacherAgeState extends State<GuessTeacherAge> {
  int Year = 46;

  int Month = 10;

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> submit(Map<String, dynamic> params) async {
    print('$Year $Month');
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/guess_teacher_age');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(params),
    );
    Map<String, dynamic> result = json.decode(response.body);
    print(result);
    Map data = result['data'];
    print(data);
    _showMaterialDialog("ผลการทาย",data['text']);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2CC),
      appBar: AppBar(
        title: const Text('GUESS TEACHER\'S AGE'),
        backgroundColor: const Color(0xFF00A5FF),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text('อายุอาจารย์',
                  style: TextStyle(fontSize: 30.0, color: Color(0xFF777777))),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF777777),
                    width: 5.0,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SpinBox(
                            decoration: const InputDecoration(labelText: 'ปี'),
                            textStyle: const TextStyle(
                                fontSize: 20.0, color: Colors.black),
                            min: 1,
                            max: 100,
                            value: 0, //Year.toDouble(),
                            onChanged: (value) => Year = value.toInt(),
                          ),

                          SpinBox(
                            decoration: const InputDecoration(
                                labelText: 'เดือน'),
                            textStyle: const TextStyle(
                                fontSize: 20.0, color: Colors.black),
                            min: 0,
                            max: 11,
                            value: 0, //Month.toDouble(),
                            onChanged: (value) => Month = value.toInt(),

                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  submit({"year":Year,"month":Month});
                                });
                              },
                              child: const Text(
                                  'ทาย', style: TextStyle(fontSize: 25.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}