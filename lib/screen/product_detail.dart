import 'package:e_com_pay/api_services/api_services.dart';
import 'package:e_com_pay/constant/app_style.dart';
import 'package:e_com_pay/constant/colors.dart';
import 'package:e_com_pay/constant/common_button.dart';
import 'package:e_com_pay/modal/single_product_modal.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constant/loading_indigator.dart';

class ProductDetail extends StatefulWidget {
  final int id;
  final  String productname;
  const ProductDetail({super.key, required this.id, required this.productname});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  SingleProductModal singleProductModal=SingleProductModal();
  bool isloading=false;

  singleproduct(){
    setState(() {
      isloading=true;
    });
    ApiServices().getsingleproduct(widget.id).then((value) {
      singleProductModal=value!;
      print(singleProductModal);
      setState(() {
        isloading=false;
      });
    },).onError((error, stackTrace) {
      print('Error:${error..toString()}');
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    singleproduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: BackButton(color: whitecoloe,),
        centerTitle: true,
        title: Text(widget.productname, style: TextStyle(color: Colors.white)),
      ),
      body: isloading
          ? Center(child: SizedBox(
                  height: 60,
                  width: 60,
                  child: LoadingIndicator(indicatorType: Indicator.ballRotateChase))) :
      ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(singleProductModal.image ?? ""),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            children: [
              Divider(thickness: 2, color: Colors.grey[300]),
              Text(
                singleProductModal.title ?? "",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Price : ",
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: bold),
                  ),
                  Text(
                    singleProductModal.price != null
                        ? "\₹${singleProductModal.price.toString()}"
                        : "",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Category : ",
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: bold),
                  ),
                  Text(
                    singleProductModal.category ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                textAlign: TextAlign.justify,
                singleProductModal.description ?? "",
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Rating: ",
                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: bold),
                  ),
                  // Icon(
                  //   Icons.star,
                  //   color: Colors.amber,
                  //   size: 18,
                  // ),
                  Text(
                    singleProductModal.rating != null
                        ? "${singleProductModal.rating?.rate?.toString() ?? ""}/5"
                        : "",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
        width: double.infinity,
        child: CommonButton(onTap: () {
          print('tap');
        },child: Text('BUY NOW',style: TextStyle(fontSize: 14, color: Colors.white),),),
      )
    );
  }
}
