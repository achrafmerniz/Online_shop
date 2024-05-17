import 'dart:convert';

import 'package:clothes_app/users/controllers/item_details_controller.dart';
import 'package:clothes_app/users/model/clothes.dart';
import 'package:clothes_app/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Clothes? itemInfo;

  ItemDetailsScreen({this.itemInfo});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final itemDetailsController = Get.put(ItemDetailsController());
  final currentOnlineUser = Get.put(CurrentUser());

  addItemToCart() async {
    try {
      var res = await http.post(
        Uri.parse(API.addToCart),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "id_product": widget.itemInfo!.id_product.toString(),
          "quantity": itemDetailsController.quantity.toString(),
          "color": widget.itemInfo!.colors![itemDetailsController.color],
          "size": widget.itemInfo!.sizes![itemDetailsController.size],
        },
      );

      if (res.statusCode == 200) {
        var resBodyOfAddCart = jsonDecode(res.body);
        if (resBodyOfAddCart['success'] == true) {
          Fluttertoast.showToast(msg: "Item saved to Cart Successfully.");
        } else {
          Fluttertoast.showToast(
              msg: "Error Occurred. Item not saved to Cart. Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Item image
          FadeInImage(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: const AssetImage("images/place_holder.png"),
            image: NetworkImage(
              widget.itemInfo!.image!,
            ),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.orange,
                ),
              );
            },
          ),

          // Item information
          Align(
            alignment: Alignment.bottomCenter,
            child: itemInfoWidget(),
          ),
        ],
      ),
    );
  }

  Widget itemInfoWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.orange,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Item name
            Text(
              widget.itemInfo!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Rating, tags, price, quantity item counter
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating, tags, price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rating + rating number
                      Row(
                        children: [
                          // Rating bar
                          RatingBar.builder(
                            initialRating: widget.itemInfo!.rating!,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, c) => const Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            onRatingUpdate: (updateRating) {},
                            ignoreGestures: true,
                            unratedColor: Colors.grey,
                            itemSize: 20,
                          ),
                          const SizedBox(width: 8),
                          // Rating number
                          Text(
                            "(${widget.itemInfo!.rating.toString()})",
                            style: const TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Tags
                      Text(
                        widget.itemInfo!.tags!
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price
                      Text(
                        "\$${widget.itemInfo!.price.toString()}",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Quantity item counter
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // +
                      IconButton(
                        onPressed: () {
                          itemDetailsController.setQuantityItem(
                              itemDetailsController.quantity + 1);
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        itemDetailsController.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // -
                      IconButton(
                        onPressed: () {
                          if (itemDetailsController.quantity - 1 >= 1) {
                            itemDetailsController.setQuantityItem(
                                itemDetailsController.quantity - 1);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Quantity must be 1 or greater than 1");
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Sizes
            const Text(
              "Size:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(widget.itemInfo!.sizes!.length, (index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      itemDetailsController.setSizeItem(index);
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: itemDetailsController.size == index
                              ? Colors.transparent
                              : Colors.black,
                        ),
                        color: itemDetailsController.size == index
                            ? Colors.orange
                            : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.itemInfo!.sizes![index]
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        style: TextStyle(
                          fontSize: 16,
                          color: itemDetailsController.size == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Colors
            const Text(
              "Color:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(widget.itemInfo!.colors!.length, (index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      itemDetailsController.setColorItem(index);
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: itemDetailsController.color == index
                              ? Colors.transparent
                              : Colors.grey,
                        ),
                        color: itemDetailsController.color == index
                            ? Colors.orange
                            : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.itemInfo!.colors![index]
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        style:TextStyle(
                          fontSize: 16,
                          color: itemDetailsController.color == index
                              ? Colors.white
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Description
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemInfo!.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // Add to cart button
            Material(
              elevation: 4,
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  addItemToCart();
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
