import 'package:clothes_app/users/controllers/order_now_controller.dart';
import 'package:clothes_app/users/order/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderNowScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;
  final List<int>? selectedCartIDs;

  final OrderNowController orderNowController = Get.put(OrderNowController());
  final List<String> deliverySystemNamesList = ["yalidine", "DHL", "Zr Express"];
  final List<String> paymentSystemNamesList = ["baridi mob", "ccp", "cash on delivery"];

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController shipmentAddressController = TextEditingController();
  final TextEditingController noteToSellerController = TextEditingController();

  OrderNowScreen({
    this.selectedCartListItemsInfo,
    this.totalAmount,
    this.selectedCartIDs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Order Now"),
        titleSpacing: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          displaySelectedItemsFromUserCart(),
          SizedBox(height: 30),
          buildTitle("Delivery System:"),
          buildDeliveryOptions(),
          SizedBox(height: 16),
          buildTitle("Payment System:"),
          buildPaymentOptions(),
          SizedBox(height: 16),
          buildTitle("Phone Number:"),
          buildInputField("Enter your Contact Number..", phoneNumberController),
          SizedBox(height: 16),
          buildTitle("Shipment Address:"),
          buildInputField("Enter your Shipment Address..", shipmentAddressController),
          SizedBox(height: 16),
          buildTitle("Note to Seller:"),
          buildInputField("Add any note for the seller..", noteToSellerController),
          SizedBox(height: 30),
          buildPaymentButton(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDeliveryOptions() {
    return Column(
      children: deliverySystemNamesList.map((deliverySystemName) {
        return Obx(() => RadioListTile<String>(
              tileColor: Colors.transparent,
              dense: true,
              activeColor: Colors.black,
              title: Text(
                deliverySystemName,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              value: deliverySystemName,
              groupValue: orderNowController.deliverySys,
              onChanged: (newDeliverySystemValue) {
                orderNowController.setDeliverySystem(newDeliverySystemValue!);
              },
            ));
      }).toList(),
    );
  }

  Widget buildPaymentOptions() {
    return Column(
      children: paymentSystemNamesList.map((paymentSystemName) {
        return Obx(() => RadioListTile<String>(
              tileColor: Colors.transparent,
              dense: true,
              activeColor: Colors.black,
              title: Text(
                paymentSystemName,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              value: paymentSystemName,
              groupValue: orderNowController.paymentSys,
              onChanged: (newPaymentSystemValue) {
                orderNowController.setPaymentSystem(newPaymentSystemValue!);
              },
            ));
      }).toList(),
    );
  }

  Widget buildInputField(String hintText, TextEditingController controller) {
    return TextField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }

  Widget buildPaymentButton() {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          if (phoneNumberController.text.isNotEmpty && shipmentAddressController.text.isNotEmpty) {
            Get.to(OrderConfirmationScreen(
              selectedCartIDs: selectedCartIDs,
              selectedCartListItemsInfo: selectedCartListItemsInfo,
              totalAmount: totalAmount,
              deliverySystem: orderNowController.deliverySys,
              paymentSystem: orderNowController.paymentSys,
              phoneNumber: phoneNumberController.text,
              shipmentAddress: shipmentAddressController.text,
              note: noteToSellerController.text,
            ));
          } else {
            Fluttertoast.showToast(msg: "Please complete the form.");
          }
        },
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$${totalAmount!.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Pay Amount Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displaySelectedItemsFromUserCart() {
    return Column(
      children: List.generate(selectedCartListItemsInfo!.length, (index) {
        Map<String, dynamic> eachSelectedItem = selectedCartListItemsInfo![index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.orange,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: FadeInImage(
                  height: 150,
                  width: 130,
                  fit: BoxFit.cover,
                  placeholder: AssetImage("images/place_holder.png"),
                  image: NetworkImage(eachSelectedItem["image"]),
                  imageErrorBuilder: (context, error, stackTraceError) {
                    return Center(
                      child: Icon(Icons.broken_image_outlined),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eachSelectedItem["product_name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${eachSelectedItem["size"].replaceAll("[", "").replaceAll("]", "")}\n${eachSelectedItem["color"].replaceAll("[", "").replaceAll("]", "")}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "\$ ${eachSelectedItem["totalAmount"]}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${eachSelectedItem["price"]} x ${eachSelectedItem["quantity"]} = ${eachSelectedItem["totalAmount"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Q: ${eachSelectedItem["quantity"]}",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
