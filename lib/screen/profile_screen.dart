import 'package:e_com_pay/modal/user_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../api_services/api_services.dart';
import '../constant/warning_toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserDetail userdata=UserDetail();
  bool isloading = false;

  getuserdetail() {
    setState(() {
      isloading = true; // set isloading to true
    });
    ApiServices().userdetail(1).then((value) {
      setState(() {
        userdata = value;
        print("User Detail Response===>${userdata}");
        isloading = false;
      });
    }).onError((error, stackTrace) {
      print('Error:${error.toString()}');
      WarningToast('Opps somthing want to wrong');
      setState(() {
        isloading = false; // set isloading to false
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getuserdetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.kanit(
            color: Colors.white,
          ),
        ),
      ),
      body: isloading
          ? Center(child: SizedBox(
          height: 60,
          width: 60,
          child: LoadingIndicator(indicatorType: Indicator.ballRotateChase))) :
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Personal Details
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.name?.firstname??""} ${userdata.name?.lastname??""}',
                          style: TextStyle(fontSize: 18,),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.phone??""}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.email??""}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Address
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_city, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.address?.city}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.streetview, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.address?.street}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.code, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.address?.number}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.map, color: Colors.indigo,size: 22,),
                        SizedBox(width: 10),
                        Text(
                          '${userdata.address?.geolocation?.lat}° N, ${userdata.address?.geolocation?.long}° W',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}
