import 'package:get/get.dart';

class OrderNowController extends GetxController
{
  RxString _deliverySystem = "yalidine".obs;
  RxString _paymentSystem = "cash on delivery".obs;

  String get deliverySys => _deliverySystem.value;
  String get paymentSys => _paymentSystem.value;

  setDeliverySystem(String newDeliverySystem)
  {
    _deliverySystem.value = newDeliverySystem;
  }

  setPaymentSystem(String newPaymentSystem)
  {
    _paymentSystem.value = newPaymentSystem;
  }
}