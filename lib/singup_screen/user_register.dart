import 'package:e_com_pay/api_services/api_services.dart';
import 'package:e_com_pay/constant/succes_toast.dart';
import 'package:e_com_pay/constant/warning_toast.dart';
import 'package:e_com_pay/modal/user_register_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app_pref/app_pref.dart';
import '../constant/app_style.dart';
import '../constant/colors.dart';
import '../constant/comman_toast.dart';
import '../constant/common_button.dart';
import '../constant/loading_indigator.dart';
import '../screen/home_screen.dart';
import '../screen/bottem_bar_tabs.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController citycontroller=TextEditingController();
  FocusNode userFocusNode=FocusNode();
  FocusNode passwordFocusNode=FocusNode();
  FocusNode emailFocusNode=FocusNode();
  FocusNode cityFocusNode=FocusNode();

  final _formkey=GlobalKey<FormState>();
  bool isloading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        title: Text('Register',style: TextStyle(color: whitecoloe),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Increased padding for better spacing
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Make children take full width
                children: [
                  // Text(
                  //   "Register",
                  //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent), // Improved header
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailcontroller,
                    focusNode: emailFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12), // Padding inside the text field
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(userFocusNode);
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: usernamecontroller,
                    focusNode: userFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter Username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Username';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordcontroller,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return value!.isEmpty ? 'Please enter Password' : 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(cityFocusNode);
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: citycontroller,
                    focusNode: cityFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Enter City',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter City';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print('Validated');
                      }
                      setState(() {
                        isloading=true;
                      });
                      UserRegisterModal userRegisterModal=UserRegisterModal();
                      userRegisterModal.email=emailcontroller.text.toString();
                      userRegisterModal.username=usernamecontroller.text.toString();
                      userRegisterModal.username=usernamecontroller.text.toString();
                      userRegisterModal.password=passwordcontroller.text.toString();
                      userRegisterModal.address?.city=citycontroller.text.toString();

                      userRegisterModal.name?.firstname='Vinay';
                      userRegisterModal.name?.lastname='Chauhan';
                      userRegisterModal.address?.street='7835 new road';
                      userRegisterModal.address?.number= 3;
                      userRegisterModal.address?.zipcode='12926-3874';
                      userRegisterModal.address?.geolocation?.lat='-37.3159';
                      userRegisterModal.address?.geolocation?.long='81.1496';
                      userRegisterModal.phone='1-570-236-7033';

                      ApiServices().registerUser(userRegisterModal).then((value) {
                        AppPref().setUserTocek(value['id'].toString());
                        Get.offAll(()=>const BottemBarTabs());

                        setState(() {
                          isloading=false;
                        });
                        SuccesToast('User Register Succesfull');
                      },).onError((error, stackTrace) {
                        setState(() {
                          isloading=false;
                          print("Error:${error.toString()}");
                          WarningToast('Opps Error Found');
                        });
                      },);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      padding: EdgeInsets.symmetric(vertical: 16), // Button padding
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners
                    ),
                    child: isloading
                        ? Center(child: CircularProgressIndicator(color: Colors.white))
                        : Text('Register', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}
