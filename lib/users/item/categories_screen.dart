import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../model/clothes.dart';
import 'item_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  Future<List<Clothes>> getTrendingClothItems() async {
    List<Clothes> trendingClothItemsList = [];

    try {
      var res = await http.post(
        Uri.parse(API.getTrendingMostPopularClothes),
      );

      if (res.statusCode == 200) {
        var responseBodyOfTrending = jsonDecode(res.body);
        if (responseBodyOfTrending["success"] == true) {
          (responseBodyOfTrending["clothItemsData"] as List).forEach((eachRecord) {
            trendingClothItemsList.add(Clothes.fromJson(eachRecord));
          });
        }
      } else {
        Fluttertoast.showToast(msg: "Error, status code is not 200");
      }
    } catch (errorMsg) {
      print("Error:: " + errorMsg.toString());
    }

    return trendingClothItemsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: trendingMostPopularClothItemWidget(context),
      ),
    );
  }

  Widget trendingMostPopularClothItemWidget(BuildContext context) {
    return FutureBuilder(
      future: getTrendingClothItems(),
      builder: (context, AsyncSnapshot<List<Clothes>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.hasError) {
          return Center(
            child: Text("Error loading trending items"),
          );
        }
        if (!dataSnapShot.hasData || dataSnapShot.data!.isEmpty) {
          return Center(
            child: Text("No Trending items found"),
          );
        }
        return ListView.separated(
          itemCount: dataSnapShot.data!.length,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            Clothes eachClothItemData = dataSnapShot.data![index];
            return ListTile(
              onTap: () {
                Get.to(ItemDetailsScreen(itemInfo: eachClothItemData));
              },
              leading: Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(eachClothItemData.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(eachClothItemData.name!),
              subtitle: Row(
                children: [
                  RatingBar.builder(
                    initialRating: eachClothItemData.rating!,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 16,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(width: 4),
                  Text('(${eachClothItemData.rating})'),
                ],
              ),
              trailing: Text(
                '\$${eachClothItemData.price}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
