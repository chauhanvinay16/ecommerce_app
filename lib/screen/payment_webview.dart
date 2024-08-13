// import 'dart:convert';
// import 'package:dealshaq/components/print_value.dart';
// import 'package:dealshaq/helpers/color_helper.dart';
// import 'package:dealshaq/routes/routes_name.dart';
// import 'package:dealshaq/utils/loading_indicator.dart';
// import 'package:dealshaq/utils/toast_message.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../../../helpers/constant_helper.dart';
// import '../../../../models/create_place_order.dart';
//
//
// class PaymentWebView extends StatefulWidget {
//   final Map args;
//   const PaymentWebView({super.key, required this.args});
//
//   @override
//   State<PaymentWebView> createState() => _PaymentWebViewState();
// }
//
// class _PaymentWebViewState extends State<PaymentWebView> {
//
//   final WebViewController controller = WebViewController();
//
//   bool loading = true;
//   @override
//   void initState() {
//
//     if(widget.args.containsKey('checkout')){
//
//       CreateOrderPlaceModel createOrderPlaceModel = widget.args['checkout'];
//       printValue(tag: 'Have Data On Payment WebView Screen : ',jsonEncode(createOrderPlaceModel));
//
//       controller
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..setBackgroundColor(const Color(0x00000000))
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {debugPrint('Loading progress : $progress%');},
//             onPageStarted: (String url) {debugPrint('Page started loading: $url');},
//             onPageFinished: (String url) {
//               loading = false;
//               setState(() {});
//               debugPrint('Page finished loading: $url');
//             },
//             onWebResourceError: (WebResourceError error) {
//               debugPrint(
//                   "Page resource error: code: ${error.errorCode}\n"
//                       "description: ${error.description}\n"
//                       "errorType: ${error.errorType}\n"
//                       "isForMainFrame: ${error.isForMainFrame}");
//             },
//             onNavigationRequest: (NavigationRequest request) {
//               debugPrint('allowing navigation to ${request.url}');
//
//               if(request.url.contains(ConstantHelper.paymentSuccessStatus)){
//
//                 Navigator.popAndPushNamed(context, RouteName.placeOrderScreen,
//                     arguments:{'orderId': createOrderPlaceModel.data?.myOrder??""});
//
//                 return NavigationDecision.prevent;
//
//               }else if (request.url.contains(ConstantHelper.paymentFailedStatus)){
//                 Navigator.popAndPushNamed(context, RouteName.paymentFailed);
//                 return NavigationDecision.prevent;
//               }
//
//               return NavigationDecision.navigate;
//             },
//             onHttpError: (HttpResponseError error) {
//               debugPrint('Error occurred on page: ${error.response?.statusCode}');
//             },
//             onUrlChange: (UrlChange change) {
//               debugPrint('url change to ${change.url}');
//             },
//             onHttpAuthRequest: (HttpAuthRequest request) {debugPrint('url change to ${request.host}');},
//           ),
//         )
//         ..addJavaScriptChannel(
//           'Toaster',
//           onMessageReceived: (JavaScriptMessage message) {
//             debugPrint('JavaScript Message ${message.message}');
//             /*ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(message.message)),
//             );*/
//           },
//         )
//         ..loadRequest(Uri.parse(createOrderPlaceModel.url??""));
//
//     }else{
//       Navigator.pop(context);
//       toastMessage('Something went wrong');
//     }
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: ColorHelper.whiteColor,
//       child: SafeArea(
//         child: Scaffold(
//           body: loading?loadingIndicator():
//
//           WebViewWidget(controller: controller),
//         ),
//       ),
//     );
//   }
// }
