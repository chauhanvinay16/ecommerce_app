import 'package:e_com_pay/app_pref/app_pref.dart';
import 'package:e_com_pay/constant/assets.dart';
import 'package:e_com_pay/screen/bottem_bar_tabs.dart';
import 'package:e_com_pay/singup_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),() {
      AppPref().getUserToken().then((value) {
        if(value==""){
          Get.offAll(()=>LoginScreen());
        }else{
          Get.offAll(()=>BottemBarTabs());
        }
      },);

    },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Image.asset(spashScreenImage),
        ),
    );
  }
}
