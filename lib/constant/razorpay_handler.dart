import 'package:e_com_pay/constant/succes_toast.dart';
import 'package:e_com_pay/constant/warning_toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void handlePaymentSuccess(PaymentSuccessResponse response) {
  SuccesToast('Payment Success');
}

void handlePaymentError(PaymentFailureResponse response) {
  WarningToast('Opps Payment Fail');
}

void handleExternalWallet(ExternalWalletResponse response) {
  SuccesToast('Wallet Payment Success');
}