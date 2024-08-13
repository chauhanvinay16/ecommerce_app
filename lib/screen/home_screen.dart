import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:e_com_pay/api_services/api_services.dart';
import 'package:e_com_pay/constant/colors.dart';
import 'package:e_com_pay/constant/comman_toast.dart';
import 'package:e_com_pay/constant/common_button.dart';
import 'package:e_com_pay/constant/loading_indigator.dart';
import 'package:e_com_pay/constant/warning_toast.dart';
import 'package:e_com_pay/screen/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../constant/razorpay_handler.dart';
import '../modal/product_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModal> product = [];
  bool isloading = false;

  getproduct() {
    setState(() {
      isloading = true; // set isloading to true
    });
    ApiServices().getAllproduct().then((value) {
      setState(() {
        product = value!; // update the product list
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

  bool isShowsearch=false;
  TextEditingController searchcontroller=TextEditingController();

  @override
  void initState() {
    super.initState();
    getproduct();
  }

  @override
  Widget build(BuildContext context) {

    List<ProductModal> fillterproduct = [];

    if(searchcontroller.text.isEmpty){
        fillterproduct=product;
    }else{
      fillterproduct=product.where((element) => (element.title!.toLowerCase().contains(searchcontroller.text.toLowerCase())|| element.description!.toLowerCase().contains(searchcontroller.text.toLowerCase())),).toList();
    }

    return Scaffold(
      appBar:  isShowsearch?
      AppBar(
        backgroundColor: Colors.indigo,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextFormField(
            controller: searchcontroller,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.indigo,
              ),
            ),
            onChanged: (value) {
              setState(() {

              });
            },
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isShowsearch = false;
              searchcontroller.clear();
            });
          },
        ),
      ):
      AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isShowsearch=true;
            });
          }, icon: Icon(Icons.search_rounded,color: whitecoloe,))
        ],
        title: Text(
          'Home',
          style: GoogleFonts.kanit(
            color: Colors.white,
          ),
        ),
      ),
      body: isloading
          ? Center(child: loadingindigator(Colors.blueAccent))
          : product.isEmpty
          ? Center(child: Text('No products found'))
          : ListView.separated(
        itemCount: fillterproduct.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final data=fillterproduct[index];
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
                                image:NetworkImage(product[index].image??""),
                                fit: BoxFit.fill,
                            )
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product[index].title??"",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // Slightly softer black color
                              ),
                            ),
                            SizedBox(height: 8,),
                            Text(
                              'Price: \₹${product[index].price}',
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
                                  'Rating: ${product[index].rating?.rate??""}',
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
                      product[index].description??"",
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
                         '${product[index].category}',
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
                          Razorpay razorpay = Razorpay();

                          var options = {
                            'key': 'rzp_live_ILgsfZCZoFIKMb',
                            'amount': (data.price * 100).toString(), // amount should be in paise
                            'name': data.title,
                            'description': data.category,
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                            'external': {'wallets': ['paytm']}
                          };

                          void handlePaymentError(PaymentFailureResponse response) {
                            print('Payment Error: ${response.message}');
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(content: Text('Payment Error: ${response.message}')),
                            // );

                            AnimatedSnackBar.rectangle(
                              'Error',
                              'Payment Error: ${response.message}',
                              type: AnimatedSnackBarType.error,
                              brightness: Brightness.dark,
                                mobileSnackBarPosition: MobileSnackBarPosition.bottom
                            ).show(context);
                          }

                          void handlePaymentSuccess(PaymentSuccessResponse response) {
                            print('Payment Success: ${response.paymentId}');
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(content: Text('Payment Success: ${response.paymentId}')),
                            // );

                            AnimatedSnackBar.rectangle(
                              'Success',
                              'Payment Success: ${response.paymentId}',
                              type: AnimatedSnackBarType.success,
                              brightness: Brightness.dark,
                              mobileSnackBarPosition: MobileSnackBarPosition.bottom
                            ).show(context);
                          }

                          void handleExternalWallet(ExternalWalletResponse response) {
                            print('External Wallet: ${response.walletName}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('External Wallet: ${response.walletName}')),
                            );
                          }

                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

                          try {
                            razorpay.open(options);
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Buy now',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
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