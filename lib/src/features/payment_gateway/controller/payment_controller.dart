import 'package:chahel_web_1/src/features/payment_gateway/model/payment_model.dart';
import 'package:chahel_web_1/src/repository/common_repository.dart';
import 'package:flutter/material.dart';

class PaymentController extends ChangeNotifier {
  final Repository _repo = Repository.instance;

  final TextEditingController controllerSaltKey = TextEditingController();
  final TextEditingController controllerSaltIndex = TextEditingController();
  final TextEditingController controllerMerchantKey = TextEditingController();
  PaymentModel? paymentDetails;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  bool fetchloading = true;
  bool fetchfullScreen = true;
//add payment keys
  Future<void> addPaymentDetails({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    fetchloading = false;
    notifyListeners();
    paymentDetails = PaymentModel(
      saltIndex: controllerSaltIndex.text,
      saltKey: controllerSaltKey.text,
      merchantId: controllerMerchantKey.text,
    );
    await _repo.setPayment(
        paymentDetails: paymentDetails ?? PaymentModel(),
        onSucess: (value) {
          onSucess.call(value);
          paymentDetails = null;
        },
        onFailure: onFailure);
    fetchloading = true;
    notifyListeners();
  }

//get payment keys

  Future<void> getPaymentDetails({
    required void Function(String) onSucess,
    required void Function(String) onFailure,
  }) async {
    if (paymentDetails == null) {
      paymentDetails =
          await _repo.getPayment(onSucess: onSucess, onFailure: onFailure);
      controllerSaltKey.text = paymentDetails?.saltKey ?? 'No salt id added';
      controllerSaltIndex.text =
          paymentDetails?.saltIndex ?? 'No salt index added';
      controllerMerchantKey.text = paymentDetails?.merchantId ?? '';
    }
    fetchfullScreen = false;
    notifyListeners();
  }
}
