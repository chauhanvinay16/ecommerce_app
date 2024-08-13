import 'package:e_com_pay/api_services/api_services.dart';
import 'package:e_com_pay/app_pref/app_pref.dart';
import 'package:e_com_pay/constant/app_style.dart';
import 'package:e_com_pay/constant/colors.dart';
import 'package:e_com_pay/constant/comman_toast.dart';
import 'package:e_com_pay/constant/common_button.dart';
import 'package:e_com_pay/constant/loading_indigator.dart';
import 'package:e_com_pay/screen/bottem_bar_tabs.dart';
import 'package:e_com_pay/screen/home_screen.dart';
import 'package:e_com_pay/singup_screen/user_register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  FocusNode userFocusNode=FocusNode();
  FocusNode passwordFocusNode=FocusNode();

  ValueNotifier obsecurePassword=ValueNotifier(true);
  final _formkey=GlobalKey<FormState>();
  bool isloading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',style: TextStyle(color: whitecoloe),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome",style: TextStyle(fontSize: 20,fontWeight: bold),),

                TextFormField(
                  controller: usernamecontroller,
                  focusNode: userFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter Emil',
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
                SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: obsecurePassword,
                  builder: (context,value,child) {
                    return TextFormField(
                      controller: passwordcontroller,
                      focusNode: passwordFocusNode,
                      obscureText: obsecurePassword.value,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {
                                obsecurePassword.value=! obsecurePassword.value;
                              },
                              child: obsecurePassword.value==true?
                                     Icon(Icons.visibility_off_outlined): Icon(Icons.visibility_outlined)),
                          hintText: 'Enter Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty|| value.length<6) {
                          return value!.isEmpty?'Please enter Password' : 'Please enter six diigit Password';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(userFocusNode);
                      },
                    );
                  }
                ),
                SizedBox(height: 20,),

                CommonButton(
                  onTap: () {
                      if(_formkey.currentState!.validate()){
                        print('Validate');
                      }
                      setState(() {
                        isloading=true;
                      });
                      ApiServices().userLogin(
                          usernamecontroller.text.toString(),
                          passwordcontroller.text.toString()
                      ).then((value) {
                        debugPrint(value.toString());
                        setState(() {
                          isloading=false;
                        });
                        AppPref().setUserTocek(value['token']);
                        Get.offAll(()=>const HomeScreen());
                      },).onError((error, stackTrace) {
                        setState(() {
                          isloading=false;
                          print("Error:${error.toString()}");
                          CommenToast('Opps Error Found');
                        });
                      },);
                  },child: isloading? Center(child: loadingindigator(Colors.white),):
                           Text('Login',style: TextStyle(color: whitecoloe,fontSize: 16),)
                ),
                
                SizedBox(height: 15,),
                
                GestureDetector(
                  onTap: () {
                    Get.to(()=>UserRegister());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New User ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16),),
                      Text("Register ? ",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold,fontSize: 16),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
