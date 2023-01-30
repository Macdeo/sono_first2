import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SaeDeclaration extends StatelessWidget {
  const SaeDeclaration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFF6f67f0),
        title: const Text("SAE DECLARATION"),
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
                  launch('mailto:pvmailbox@clinact.com?subject=Contact SAE');
                },
                child: const Text(
                  'PVMAILBOX@CLINACT.COM',
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
