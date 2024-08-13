import 'package:e_com_pay/screen/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../api_services/api_services.dart';
import '../constant/colors.dart';
import '../constant/common_button.dart';
import '../constant/loading_indigator.dart';
import '../constant/warning_toast.dart';
import '../modal/product_modal.dart';

class ProductCategory extends StatefulWidget {
  final String categoryname;
  const ProductCategory({super.key, required this.categoryname});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {

  List<ProductModal> productcategory = [];
  bool isloading = false;

  getcategoryproduct() {
    setState(() {
      isloading = true; // set isloading to true
    });
    ApiServices().getAllproductcategory(widget.categoryname).then((value) {
      setState(() {
        productcategory = value!; // update the product list
        isloading = false; // set isloading to false
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
    getcategoryproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: whitecoloe,),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(widget.categoryname, style: TextStyle(color: Colors.white)),
      ),
      body: isloading
          ? Center(child: SizedBox(
          height: 60,
          width: 60,
          child: LoadingIndicator(indicatorType: Indicator.ballRotateChase)))
          : productcategory.isEmpty
          ? Center(child: Text('No products found'))
          : ListView.separated(
        itemCount: productcategory.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final data=productcategory[index];
          return GestureDetector(
            onTap: () {
              Get.to(()=>ProductDetail(id: data.id, productname: data.title??"",));
            },
            child: Card(
              elevation: 5, // Adds shadow to the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image:NetworkImage(productcategory[index].image??""),
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productcategory[index].title??"",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // Slightly softer black color
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Price: \₹${productcategory[index].price}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green, // Green color for price
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Text(
                                  'Rating: ${productcategory[index].rating?.rate??""}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrange,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),

                    SizedBox(height: 8), // Space between price and description

                    // Product Description
                    Text(
                      productcategory[index].description??"",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54, // Slightly lighter black color for description
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                    ),

                    SizedBox(height: 8), // Space between description and category

                    // Product Category
                    Row(
                      children: [
                        Text(
                          'Category: ',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black, // Blue-grey color for category
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          '${productcategory[index].category}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey, // Blue-grey color for category
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonButton(
                        onTap: () {

                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Buy now',
                              style: TextStyle(color: whitecoloe, fontSize: 16),
                            ),
                            SizedBox(width: 4), // add some space between the text and the icon
                            Icon(
                              Icons.shopping_cart,
                              color: whitecoloe,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
