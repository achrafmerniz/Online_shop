import 'package:clothes_app/users/model/clothes.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatefulWidget {
  
  final Clothes? itemInfo;

  ItemDetailsScreen({this.itemInfo});


  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}