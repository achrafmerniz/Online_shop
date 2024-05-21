import 'dart:convert';

import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order? clickedOrderInfo;

  OrderDetailsScreen({this.clickedOrderInfo});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              FadeInImage(
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.fitWidth,
                placeholder: const AssetImage("images/place_holder.png"),
                image: NetworkImage(
                  API.hostImages + (widget.clickedOrderInfo?.image ?? ""),
                ),
                imageErrorBuilder: (context, error, stackTraceError) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showTitleText(String titleText) {
    return Text(
      titleText,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.orange,
      ),
    );
  }

  Widget showContentText(String contentText) {
    return Text(
      contentText,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget displayClickedOrderItems() {
    List<String> clickedOrderItemsInfo = widget.clickedOrderInfo?.selectedItems?.split("||") ?? [];

    return Column(
      children: List.generate(clickedOrderItemsInfo.length, (index) {
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
            color: Colors.orange.shade100,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              // Image
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
                    itemInfo["image"] ?? "",
                  ),
                  imageErrorBuilder: (context, error, stackTraceError) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    );
                  },
                ),
              ),

              // Name, size, color, price, quantity
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        itemInfo["name"] ?? "N/A",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Size + color
                      Text(
                        (itemInfo["size"]?.replaceAll("[", "").replaceAll("]", "") ?? "N/A") +
                            "\n" +
                            (itemInfo["color"]?.replaceAll("[", "").replaceAll("]", "") ?? "N/A"),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Price
                      Text(
                        "\$ " + (itemInfo["totalAmount"]?.toString() ?? "0"),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        (itemInfo["price"]?.toString() ?? "0") + " x " +
                            (itemInfo["quantity"]?.toString() ?? "0") +
                            " = " + (itemInfo["totalAmount"]?.toString() ?? "0"),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
            ],
          ),
        );
      }),
    );
  }
}
