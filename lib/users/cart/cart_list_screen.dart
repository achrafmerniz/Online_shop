import 'dart:convert';

import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/controllers/cart_list_controller.dart';
import 'package:clothes_app/users/model/cart.dart';
import 'package:clothes_app/users/model/clothes.dart';
import 'package:clothes_app/users/order/order_now_screen.dart';
import 'package:clothes_app/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../item/item_details_screen.dart';

class CartListScreen extends StatefulWidget {
  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final currentOnlineUser = Get.put(CurrentUser());
  final cartListController = Get.put(CartListController());

  getCurrentUserCartList() async {
    List<Cart> cartListOfCurrentUser = [];

    try {
      var res = await http.post(
        Uri.parse(API.getCartList),
        body: {
          "currentOnlineUserID": currentOnlineUser.user.user_id.toString(),
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfGetCurrentUserCartItems = jsonDecode(res.body);

        if (responseBodyOfGetCurrentUserCartItems['success'] == true) {
          (responseBodyOfGetCurrentUserCartItems['currentUserCartData'] as List)
              .forEach((eachCurrentUserCartItemData) {
            cartListOfCurrentUser
                .add(Cart.fromJson(eachCurrentUserCartItemData));
          });
        } else {
          Fluttertoast.showToast(msg: "Your Cart List is Empty.");
        }

        cartListController.setList(cartListOfCurrentUser);
      } else {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error: " + errorMsg.toString());
    }
    calculateTotalAmount();
  }

  calculateTotalAmount() {
    cartListController.setTotal(0);

    if (cartListController.selectedItemList.isNotEmpty) {
      cartListController.cartList.forEach((itemInCart) {
        if (cartListController.selectedItemList.contains(itemInCart.cart_id)) {
          double eachItemTotalAmount =
              (itemInCart.price!) * (double.parse(itemInCart.quantity.toString()));

          cartListController.setTotal(
              cartListController.total + eachItemTotalAmount);
        }
      });
    }
  }

  deleteSelectedItemsFromUserCartList(int cartID) async {
    try {
      var res = await http.post(
        Uri.parse(API.deleteSelectedItemsFromCartList),
        body: {
          "cart_id": cartID.toString(),
        },
      );

      if (res.statusCode == 200) {
        var responseBodyFromDeleteCart = jsonDecode(res.body);

        if (responseBodyFromDeleteCart["success"] == true) {
          getCurrentUserCartList();
        }
      } else {
        Fluttertoast.showToast(msg: "Error, Status Code is not 200");
      }
    } catch (errorMessage) {
      print("Error: " + errorMessage.toString());

      Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
    }
  }

  updateQuantityInUserCart(int cartID, int newQuantity) async {
    try {
      var res = await http.post(
        Uri.parse(API.updateItemInCartList),
        body: {
          "cart_id": cartID.toString(),
          "quantity": newQuantity.toString(),
        },
      );

      if (res.statusCode == 200) {
        var responseBodyOfUpdateQuantity = jsonDecode(res.body);

        if (responseBodyOfUpdateQuantity["success"] == true) {
          getCurrentUserCartList();
        }
      } else {
        Fluttertoast.showToast(msg: "Error, Status Code is not 200");
      }
    } catch (errorMessage) {
      print("Error: " + errorMessage.toString());

      Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
    }
  }

  List<Map<String, dynamic>> getSelectedCartListItemsInformation() {
    List<Map<String, dynamic>> selectedCartListItemsInformation = [];

    if (cartListController.selectedItemList.isNotEmpty) {
      cartListController.cartList.forEach((selectedCartListItem) {
        if (cartListController.selectedItemList
            .contains(selectedCartListItem.cart_id)) {
          Map<String, dynamic> itemInformation = {
            "id_product": selectedCartListItem.id_product,
            "product_name": selectedCartListItem.name,
            'image': selectedCartListItem.image,
            'color': selectedCartListItem.color,
            'size': selectedCartListItem.size,
            'quantity': selectedCartListItem.quantity,
            'totalAmount': selectedCartListItem.price! *
                selectedCartListItem.quantity!,
            'price': selectedCartListItem.price!,
          };

          selectedCartListItemsInformation.add(itemInformation);
        }
      });
    }

    return selectedCartListItemsInformation;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("My Cart"),
        actions: [
          // to select all items
          Obx(
            () => IconButton(
              onPressed: () {
                cartListController.setIsSelectedAllItems();
                cartListController.clearAllSelectedItems();

                if (cartListController.isSelectedAll) {
                  cartListController.cartList.forEach((eachItem) {
                    cartListController.addSelectedItem(eachItem.cart_id!);
                  });
                }

                calculateTotalAmount();
              },
              icon: Icon(
                cartListController.isSelectedAll
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: cartListController.isSelectedAll
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),

          // to delete selected item/items
          GetBuilder(
            init: CartListController(),
            builder: (c) {
              if (cartListController.selectedItemList.isNotEmpty) {
                return IconButton(
                  onPressed: () async {
                    var responseFromDialogBox = await Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.grey,
                        title: const Text("Delete"),
                        content: const Text(
                            "Are you sure to Delete selected items from your Cart List?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back(result: "yesDelete");
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (responseFromDialogBox == "yesDelete") {
                      cartListController.selectedItemList
                          .forEach((selectedItemUserCartID) {
                        // delete selected items now
                        deleteSelectedItemsFromUserCartList(
                            selectedItemUserCartID);
                      });
                    }

                    calculateTotalAmount();
                  },
                  icon: const Icon(
                    Icons.delete_sweep,
                    size: 26,
                    color: Colors.black,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      body: Obx(
        () => cartListController.cartList.isNotEmpty
            ? ListView.builder(
                itemCount: cartListController.cartList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Cart cartModel = cartListController.cartList[index];

                  Clothes clothesModel = Clothes(
                    id_product: cartModel.id_product,
                    colors: cartModel.colors,
                    image: cartModel.image,
                    name: cartModel.name,
                    price: cartModel.price,
                    rating: cartModel.rating,
                    sizes: cartModel.sizes,
                    description: cartModel.description,
                    tags: cartModel.tags,
                  );

                  return Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == cartListController.cartList.length - 1
                          ? 16
                          : 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[100],
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // checkbox
                        GetBuilder(
                          init: CartListController(),
                          builder: (c) {
                            return IconButton(
                              onPressed: () {
                                if (cartListController.selectedItemList
                                    .contains(cartModel.cart_id)) {
                                  cartListController
                                      .deleteSelectedItem(cartModel.cart_id!);
                                } else {
                                  cartListController
                                      .addSelectedItem(cartModel.cart_id!);
                                }

                                calculateTotalAmount();
                              },
                              icon: Icon(
                                cartListController.selectedItemList
                                        .contains(cartModel.cart_id)
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: cartListController.selectedItemList
                                        .contains(cartModel.cart_id)
                                    ? Colors.orange
                                    : Colors.grey,
                              ),
                            );
                          },
                        ),

                        // item details
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(ItemDetailsScreen(itemInfo: clothesModel));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // item name
                                  Text(
                                    clothesModel.name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // color, size, and price
                                  Row(
                                    children: [
                                      // color and size
                                      Expanded(
                                        child: Text(
                                          "Color: ${cartModel.color!.replaceAll('[', '').replaceAll(']', '')}\nSize: ${cartModel.size!.replaceAll('[', '').replaceAll(']', '')}",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),

                                      // price
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12.0),
                                        child: Text(
                                          "\$${clothesModel.price}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // quantity controls
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // decrease quantity button
                                      IconButton(
                                        onPressed: () {
                                          if (cartModel.quantity! - 1 >= 1) {
                                            updateQuantityInUserCart(
                                              cartModel.cart_id!,
                                              cartModel.quantity! - 1,
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.black87,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // quantity display
                                      Text(
                                        cartModel.quantity.toString(),
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // increase quantity button
                                      IconButton(
                                        onPressed: () {
                                          updateQuantityInUserCart(
                                            cartModel.cart_id!,
                                            cartModel.quantity! + 1,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.black87,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // item image
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: FadeInImage(
                            height: 150,
                            width: 120,
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage("images/place_holder.png"),
                            image: NetworkImage(
                              cartModel.image!,
                            ),
                            imageErrorBuilder:
                                (context, error, stackTraceError) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Center(
                child: Text("Cart is Empty"),
              ),
      ),
      bottomNavigationBar: GetBuilder(
        init: CartListController(),
        builder: (c) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -2),
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // total amount
                const Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Obx(
                  () => Text(
                    "\$ ${cartListController.total.toStringAsFixed(2)}",
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),

                // order now button
                Material(
                  color: cartListController.selectedItemList.isNotEmpty
                      ? Colors.white
                      : Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      cartListController.selectedItemList.isNotEmpty
                          ? Get.to(OrderNowScreen(
                              selectedCartListItemsInfo:
                                  getSelectedCartListItemsInformation(),
                              totalAmount: cartListController.total,
                              selectedCartIDs:
                                  cartListController.selectedItemList,
                            ))
                          : null;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                          color: cartListController.selectedItemList.isNotEmpty
                              ? Colors.orange
                              : Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
