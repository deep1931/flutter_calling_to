import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {


  static launchURL({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static callMe({required String phoneNumber}) async {
    // Android
    var uri = 'tel:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'tel:$phoneNumber';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  static sendMail(
      {required String to,
      required String subject,
      required String body}) async {
    // Android and iOS
    String uri = 'mailto:$to?subject=$subject&body=$body';

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static textMe({required phoneNumber}) async {
    // Android
    var uri = 'sms:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'sms:$phoneNumber';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  static void launchWhatsApp({
    required String phone,
    required String message,
  }) async {
    var whatsappUrl = "whatsapp://send?phone=$phone&text=$message";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : Fluttertoast.showToast(msg: "Whatsapp not installed !");
  }

  static launchMap({required String address}) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  static callScreen(context, screen,
      {bool isReplace = false, PageTransitionType? transitionType}) {
    if (isReplace) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: transitionType == null
              ? PageTransitionType.rightToLeft
              : transitionType,
          child: screen,
        ),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: screen,
        ),
      );
    }
  }

  static Future<bool> checkAndRequestPermission(Permission permission) {
    Completer<bool> completer = new Completer<bool>();
    permission.request().then((status) {
      if (status != PermissionStatus.granted) {
        permission.request().then((_status) {
          bool granted = _status == PermissionStatus.granted;
          completer.complete(granted);
        });
      } else {
        Fluttertoast.showToast(msg: 'Permission Already Granter');

        completer.complete(true);
      }
    });
    return completer.future;
  }
}
