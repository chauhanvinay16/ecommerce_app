import 'package:e_com_pay/constant/colors.dart';
import 'package:e_com_pay/screen/product_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../api_services/api_services.dart';

class CategoryScren extends StatefulWidget {
  const CategoryScren({super.key});

  @override
  State<CategoryScren> createState() => _CategoryScrenState();
}

class _CategoryScrenState extends State<CategoryScren> {

  dynamic category;
  bool isloading=false;

  productallcategory(){
    setState(() {
      isloading=true;
    });
    ApiServices().getallcategory().then((value) {
      category=value;
      setState(() {
        isloading=false;
      });
    },);
  }

  @override
  void initState() {
    productallcategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: whitecoloe,),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          'Category',
          style: GoogleFonts.kanit(
            color: Colors.white,
          ),
        ),
      ),
      body: isloading ? Center(child: SizedBox(
            height: 60,
            width: 60,
            child: LoadingIndicator(indicatorType: Indicator.ballRotateChase))) :
      ListView.separated(
        itemCount: category.length,
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductCategory(categoryname: category[index].toString()));
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                category[index].toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Category ${index + 1}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey[600],
              ),
            ),
          );
        },
      )
    );
  }
}