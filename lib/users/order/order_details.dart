import 'dart:convert';

import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/model/order.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order? clickedOrderInfo;

  OrderDetailsScreen({this.clickedOrderInfo});
=======
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class OrderDetailsScreen extends StatefulWidget
{
  final Order? clickedOrderInfo;

  OrderDetailsScreen({this.clickedOrderInfo,});
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

<<<<<<< HEAD
class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          DateFormat("dd MMMM, yyyy - hh:mm a")
              .format(widget.clickedOrderInfo?.dateTime ?? DateTime.now()),
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
=======


class _OrderDetailsScreenState extends State<OrderDetailsScreen>
{
  RxString _status = "new".obs;
  String get status => _status.value;

  updateParcelStatusForUI(String parcelReceived)
  {
    _status.value = parcelReceived;
  }

  showDialogForParcelConfirmation() async
  {
    if(widget.clickedOrderInfo!.status == "new")
    {
      var response = await Get.dialog(
        AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Confirmation",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          content: const Text(
            "Have you received your parcel?",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: ()
              {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: ()
              {
                Get.back(result: "yesConfirmed");
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      );

      if(response == "yesConfirmed")
      {
        updateStatusValueInDatabase();
      }
    }
  }

  updateStatusValueInDatabase() async
  {
    try
    {
      var response = await http.post(
          Uri.parse(API.updateStatus),
          body:
          {
            "order_id": widget.clickedOrderInfo!.order_id.toString(),
          }
      );

      if(response.statusCode == 200)
      {
        var responseBodyOfUpdateStatus = jsonDecode(response.body);

        if(responseBodyOfUpdateStatus["success"] == true)
        {
          updateParcelStatusForUI("arrived");
        }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateParcelStatusForUI(widget.clickedOrderInfo!.status.toString());
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          DateFormat("dd MMMM, yyyy - hh:mm a").format(widget.clickedOrderInfo!.dateTime!),
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
            child: Material(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: ()
                {
                  if(status == "new")
                  {
                    showDialogForParcelConfirmation();
                  }
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      const Text(
                        "Received",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Obx(()=>
                      status == "new"
                          ? const Icon(Icons.help_outline, color: Colors.redAccent,)
                          : const Icon(Icons.check_circle_outline, color: Colors.greenAccent,)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              // Display items belonging to the clicked order
              displayClickedOrderItems(),

              const SizedBox(height: 16),

              // Phone number
              showTitleText("Phone Number:"),
              const SizedBox(height: 8),
              showContentText(widget.clickedOrderInfo?.phoneNumber ?? "N/A"),

              const SizedBox(height: 26),

              // Shipment Address
              showTitleText("Shipment Address:"),
              const SizedBox(height: 8),
              showContentText(widget.clickedOrderInfo?.shipmentAddress ?? "N/A"),

              const SizedBox(height: 26),

              // Delivery System
              showTitleText("Delivery System:"),
              const SizedBox(height: 8),
              showContentText(widget.clickedOrderInfo?.deliverySystem ?? "N/A"),

              const SizedBox(height: 26),

              // Payment System
              showTitleText("Payment System:"),
              const SizedBox(height: 8),
              showContentText(widget.clickedOrderInfo?.paymentSystem ?? "N/A"),

              const SizedBox(height: 26),

              // Note to Seller
              showTitleText("Note to Seller:"),
              const SizedBox(height: 8),
              showContentText(widget.clickedOrderInfo?.note ?? "N/A"),

              const SizedBox(height: 26),

              // Total Amount
              showTitleText("Total Amount:"),
              const SizedBox(height: 8),
              showContentText(widget.clickedOrderInfo?.totalAmount?.toString() ?? "0"),

              const SizedBox(height: 26),

              // Proof of Payment/Transaction
              showTitleText("Proof of Payment/Transaction:"),
              const SizedBox(height: 8),
=======

              //display items belongs to clicked order
              displayClickedOrderItems(),

              const SizedBox(height: 16,),

              //phoneNumber
              showTitleText("Phone Number:"),
              const SizedBox(height: 8,),
              showContentText(widget.clickedOrderInfo!.phoneNumber!),

              const SizedBox(height: 26,),

              //Shipment Address
              showTitleText("Shipment Address:"),
              const SizedBox(height: 8,),
              showContentText(widget.clickedOrderInfo!.shipmentAddress!),

              const SizedBox(height: 26,),

              //delivery
              showTitleText("Delivery System:"),
              const SizedBox(height: 8,),
              showContentText(widget.clickedOrderInfo!.deliverySystem!),

              const SizedBox(height: 26,),

              //payment
              showTitleText("Payment System:"),
              const SizedBox(height: 8,),
              showContentText(widget.clickedOrderInfo!.paymentSystem!),

              const SizedBox(height: 26,),

              //note
              showTitleText("Note to Seller:"),
              const SizedBox(height: 8,),
              showContentText(widget.clickedOrderInfo!.note!),

              const SizedBox(height: 26,),

              //total amount
              showTitleText("Total Amount:"),
              const SizedBox(height: 8,),
              showContentText(widget.clickedOrderInfo!.totalAmount.toString()),

              const SizedBox(height: 26,),

              //payment proof
              showTitleText("Proof of Payment/Transaction:"),
              const SizedBox(height: 8,),
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
              FadeInImage(
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.fitWidth,
                placeholder: const AssetImage("images/place_holder.png"),
                image: NetworkImage(
<<<<<<< HEAD
                  API.hostImages + (widget.clickedOrderInfo?.image ?? ""),
                ),
                imageErrorBuilder: (context, error, stackTraceError) {
=======
                  API.hostImages + widget.clickedOrderInfo!.image!,
                ),
                imageErrorBuilder: (context, error, stackTraceError)
                {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                    ),
                  );
                },
              ),
<<<<<<< HEAD
=======

>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget showTitleText(String titleText) {
=======
  Widget showTitleText(String titleText)
  {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
    return Text(
      titleText,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
<<<<<<< HEAD
        color: Colors.orange,
=======
        color: Colors.grey,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
      ),
    );
  }

<<<<<<< HEAD
  Widget showContentText(String contentText) {
    return Text(
      contentText,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
=======
  Widget showContentText(String contentText)
  {
    return Text(
      contentText,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white38,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
      ),
    );
  }

<<<<<<< HEAD
  Widget displayClickedOrderItems() {
    List<String> clickedOrderItemsInfo = widget.clickedOrderInfo?.selectedItems?.split("||") ?? [];

    return Column(
      children: List.generate(clickedOrderItemsInfo.length, (index) {
=======
  Widget displayClickedOrderItems()
  {
    List<String> clickedOrderItemsInfo = widget.clickedOrderInfo!.selectedItems!.split("||");

    return Column(
      children: List.generate(clickedOrderItemsInfo.length, (index)
      {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
        Map<String, dynamic> itemInfo = jsonDecode(clickedOrderItemsInfo[index]);

        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 8,
            16,
            index == clickedOrderItemsInfo.length - 1 ? 16 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
<<<<<<< HEAD
            color: Colors.orange.shade100,
            boxShadow: const [
=======
            color: Colors.white24,
            boxShadow:
            const [
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
<<<<<<< HEAD
              // Image
=======

              //image
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: FadeInImage(
                  height: 150,
                  width: 130,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage("images/place_holder.png"),
                  image: NetworkImage(
<<<<<<< HEAD
                    itemInfo["image"] ?? "",
                  ),
                  imageErrorBuilder: (context, error, stackTraceError) {
=======
                    itemInfo["image"],
                  ),
                  imageErrorBuilder: (context, error, stackTraceError)
                  {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                    return const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    );
                  },
                ),
              ),

<<<<<<< HEAD
              // Name, size, color, price, quantity
=======
              //name
              //size
              //price
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
<<<<<<< HEAD
                      // Name
                      Text(
                        itemInfo["name"] ?? "N/A",
=======

                      //name
                      Text(
                        itemInfo["name"],
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
<<<<<<< HEAD
                          color: Colors.black,
=======
                          color: Colors.white70,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

<<<<<<< HEAD
                      // Size + color
                      Text(
                        (itemInfo["size"]?.replaceAll("[", "").replaceAll("]", "") ?? "N/A") +
                            "\n" +
                            (itemInfo["color"]?.replaceAll("[", "").replaceAll("]", "") ?? "N/A"),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
=======
                      //size + color
                      Text(
                        itemInfo["size"].replaceAll("[", "").replaceAll("]", "") + "\n" + itemInfo["color"].replaceAll("[", "").replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white54,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                        ),
                      ),

                      const SizedBox(height: 16),

<<<<<<< HEAD
                      // Price
                      Text(
                        "\$ " + (itemInfo["totalAmount"]?.toString() ?? "0"),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
=======
                      //price
                      Text(
                        "\$ " + itemInfo["totalAmount"].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.purpleAccent,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
<<<<<<< HEAD
                        (itemInfo["price"]?.toString() ?? "0") + " x " +
                            (itemInfo["quantity"]?.toString() ?? "0") +
                            " = " + (itemInfo["totalAmount"]?.toString() ?? "0"),
=======
                        itemInfo["price"].toString() + " x "
                            + itemInfo["quantity"].toString()
                            + " = " + itemInfo["totalAmount"].toString(),
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
<<<<<<< HEAD
=======


>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                    ],
                  ),
                ),
              ),

<<<<<<< HEAD
              // Quantity
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Q: " + (itemInfo["quantity"]?.toString() ?? "0"),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                  ),
                ),
              ),
=======
              //quantity
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Q: " + itemInfo["quantity"].toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),


>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
            ],
          ),
        );
      }),
    );
  }
}
