import 'dart:convert';

import 'package:clothes_app/users/model/order.dart';
import 'package:clothes_app/users/order/order_details.dart';
import 'package:clothes_app/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../api_connection/api_connection.dart';
<<<<<<< HEAD

class OrderFragmentScreen extends StatelessWidget {
  final currentOnlineUser = Get.put(CurrentUser());

  Future<List<Order>> getCurrentUserOrdersList() async {
    List<Order> ordersListOfCurrentUser = [];

    try {
      var res = await http.post(
        Uri.parse(API.readOrders),
        body: {
          "currentOnlineUserID": currentOnlineUser.user.user_id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfCurrentUserOrdersList = jsonDecode(res.body);

        if (responseBodyOfCurrentUserOrdersList['success'] == true) {
          (responseBodyOfCurrentUserOrdersList['currentUserOrdersData'] as List)
              .forEach((eachCurrentUserOrderData) {
            ordersListOfCurrentUser
                .add(Order.fromJson(eachCurrentUserOrderData));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return ordersListOfCurrentUser;
  }
=======


class OrderFragmentScreen extends StatelessWidget
{
  final currentOnlineUser = Get.put(CurrentUser());


  Future<List<Order>> getCurrentUserOrdersList() async
  {
    List<Order> ordersListOfCurrentUser = [];

    try
    {
      var res = await http.post(
          Uri.parse(API.readOrders),
          body:
          {
            "currentOnlineUserID": currentOnlineUser.user.user_id.toString(),
          }
      );

      if (res.statusCode == 200)
      {
        var responseBodyOfCurrentUserOrdersList = jsonDecode(res.body);

        if (responseBodyOfCurrentUserOrdersList['success'] == true)
        {
          (responseBodyOfCurrentUserOrdersList['currentUserOrdersData'] as List).forEach((eachCurrentUserOrderData)
          {
            ordersListOfCurrentUser.add(Order.fromJson(eachCurrentUserOrderData));
          });
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    }
    catch(errorMsg)
    {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return ordersListOfCurrentUser;
  }

>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
=======
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Order image       //history image
          //myOrder title     //history title
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
<<<<<<< HEAD
=======

                //order icon image
                // my orders
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                Column(
                  children: [
                    Image.asset(
                      "images/orders_icon.png",
                      width: 140,
                    ),
                    const Text(
                      "My Orders",
                      style: TextStyle(
<<<<<<< HEAD
                        color: Colors.orange,
=======
                        color: Colors.purpleAccent,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
<<<<<<< HEAD
                GestureDetector(
                  onTap: () {
=======

                //history icon image
                // history
                GestureDetector(
                  onTap: ()
                  {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                    //send user to orders history screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/history_icon.png",
                          width: 45,
                        ),
                        const Text(
                          "History",
                          style: TextStyle(
<<<<<<< HEAD
                            color: Colors.orange,
=======
                            color: Colors.purpleAccent,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
<<<<<<< HEAD
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
=======

              ],
            ),
          ),

          //some info
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
            child: Text(
              "Here are your successfully placed orders.",
              style: TextStyle(
                fontSize: 16,
<<<<<<< HEAD
                color: Colors.black,
=======
                color: Colors.white,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
<<<<<<< HEAD
          Expanded(
            child: displayOrdersList(context),
          ),
=======

          //displaying the user orderList
          Expanded(
            child: displayOrdersList(context),
          ),

>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget displayOrdersList(context) {
    return FutureBuilder(
      future: getCurrentUserOrdersList(),
      builder: (context, AsyncSnapshot<List<Order>> dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  "Connection Waiting...",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        if (dataSnapshot.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  "No orders found yet...",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        if (dataSnapshot.data!.length > 0) {
=======
  Widget displayOrdersList(context)
  {
    return FutureBuilder(
      future: getCurrentUserOrdersList(),
      builder: (context, AsyncSnapshot<List<Order>> dataSnapshot)
      {
        if(dataSnapshot.connectionState == ConnectionState.waiting)
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "Connection Waiting...",
                  style: TextStyle(color: Colors.grey,),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        if(dataSnapshot.data == null)
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "No orders found yet...",
                  style: TextStyle(color: Colors.grey,),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        if(dataSnapshot.data!.length > 0)
        {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
          List<Order> orderList = dataSnapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
<<<<<<< HEAD
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              );
            },
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              Order eachOrderData = orderList[index];

              return Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: ListTile(
                    onTap: () {
=======
            separatorBuilder: (context, index)
            {
              return const Divider(
                height: 1,
                thickness: 1,
              );
            },
            itemCount: orderList.length,
            itemBuilder: (context, index)
            {
              Order eachOrderData = orderList[index];

              return Card(
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: ListTile(
                    onTap: ()
                    {
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                      Get.to(OrderDetailsScreen(
                        clickedOrderInfo: eachOrderData,
                      ));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID # " + eachOrderData.order_id.toString(),
                          style: const TextStyle(
                            fontSize: 16,
<<<<<<< HEAD
                            color: Colors.black,
=======
                            color: Colors.grey,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Amount: \$ " + eachOrderData.totalAmount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
<<<<<<< HEAD
                            color: Colors.orange,
=======
                            color: Colors.purpleAccent,
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
<<<<<<< HEAD
=======

                        //date
                        //time
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
<<<<<<< HEAD
                            Text(
                              DateFormat("dd MMMM, yyyy")
                                  .format(eachOrderData.dateTime!),
=======

                            //date
                            Text(
                              DateFormat(
                                  "dd MMMM, yyyy"
                              ).format(eachOrderData.dateTime!),
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
<<<<<<< HEAD
                            const SizedBox(height: 4),
                            Text(
                              DateFormat("hh:mm a")
                                  .format(eachOrderData.dateTime!),
=======

                            const SizedBox(height: 4),

                            //time
                            Text(
                              DateFormat(
                                  "hh:mm a"
                              ).format(eachOrderData.dateTime!),
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
<<<<<<< HEAD
                          ],
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.navigate_next,
                          color: Colors.orange,
                        ),
=======

                          ],
                        ),

                        const SizedBox(width: 6),

                        const Icon(
                          Icons.navigate_next,
                          color: Colors.purpleAccent,
                        ),

>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
                      ],
                    ),
                  ),
                ),
              );
            },
          );
<<<<<<< HEAD
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  "Nothing to show...",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
=======
        }
        else
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "Nothing to show...",
                  style: TextStyle(color: Colors.grey,),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
>>>>>>> f76d07599b89205dba78d051d8c91811d22fe148
          );
        }
      },
    );
  }
}
