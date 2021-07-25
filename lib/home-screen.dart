import 'package:flutter/material.dart';
import 'package:flutter_calling_to/second-screen.dart';
import 'package:flutter_calling_to/utils.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Call Tos'),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Utils.launchWhatsApp(
                          phone: '000000000', message: 'From App');
                    },
                    child: Text('Open Whats App')),
                ElevatedButton(
                    onPressed: () {
                      Utils.launchMap(address: 'Sector 22c, Chandigarh');
                    },
                    child: Text('Open Map')),
                ElevatedButton(
                    onPressed: () {
                      Utils.launchURL(url: 'https://flutterfumes.com');
                    },
                    child: Text('Open Website')),
                ElevatedButton(
                    onPressed: () {
                      Utils.callMe(phoneNumber: '1234567890');
                    },
                    child: Text('Call Me')),
                ElevatedButton(
                    onPressed: () {
                      Utils.sendMail(
                          to: 'info@flutterfumes.com',
                          subject: 'From App',
                          body:
                              'Hello Flutter Fumes, thanks for the awesome tutorial');
                    },
                    child: Text('Email')),
                ElevatedButton(
                    onPressed: () {
                      Utils.textMe(phoneNumber: '00000000000');
                    },
                    child: Text('Text Messages')),
                ElevatedButton(
                    onPressed: () {
                      Utils.callScreen(context, SecondScreen());
                    },
                    child: Text('Open other screen')),
                ElevatedButton(
                    onPressed: () {
                      Utils.callScreen(context, SecondScreen(),
                          transitionType: PageTransitionType.bottomToTop);
                    },
                    child: Text('Open other screen with transition')),
                ElevatedButton(
                    onPressed: () async {
                      Permission permission = Permission.storage;

                      await Utils.checkAndRequestPermission(permission);
                    },
                    child: Text('Check Permission')),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Linkify(
                textScaleFactor: 1,
                text:
                "Made by https://flutterfumes.com\n\nMail: info@flutterfumes.com",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
