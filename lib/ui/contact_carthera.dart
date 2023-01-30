import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCarthera extends StatelessWidget {
  const ContactCarthera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFF6f67f0),
        title: const Text("CARTHERA SCHMITT"),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 60.0)),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
              "E-mail",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 70.0,
              child: ElevatedButton(
                onPressed: () {
                  launch(
                      'mailto:charlotte.schmitt@carthera.eu?subject=CARTHERA');
                },
                child: const Text(
                  'CHARLOTTE.SCHMITT@CARTHERA.EU',
                  style: TextStyle(
                      color: Color.fromARGB(255, 76, 126, 246),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            const Text(
              "Phone Number",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 70.0,
              width: 340.0,
              child: ElevatedButton(
                onPressed: () {
                  launch('tel:+33 665697355');
                },
                child: const Text(
                  '+33665697355',
                  style: TextStyle(
                      color: Color.fromARGB(255, 76, 126, 246),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
