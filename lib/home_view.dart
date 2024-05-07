import 'package:clothes_app/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<String> names = <String>['Men', 'Women', 'Devices', 's', 's'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: SingleChildScrollView( // Wrap the body in a SingleChildScrollView
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            children: [
              _searchTextFormField(),
              SizedBox(height: 25),
              Text(
                'Categories',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              _listViewCategory(),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Selling',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 40),
              _listViewProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search product',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }

  Widget _listViewCategory() {
    return Container(
      height: 100,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade200,
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/Icon_Mens Shoe.png'),
                ),
              ),
              SizedBox(height: 20),
              Text(names[index], style: TextStyle(color: Colors.grey)),
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Widget _listViewProduct() {
    return Container(
      height: 350,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.transparent,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    height: 220,
                    child: Image.asset(
                      'images/Image.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  'SmartWatch',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  'Apple',
                  style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Text(
                  '\$700',
                  style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }
  bottomNavigationBar(){
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller)=> BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          activeIcon: Text('Home'),
          label: '',
          icon: Icon(Icons.home,color: Colors.green)),
        BottomNavigationBarItem(
          activeIcon:Text('Cart') ,
          label: '',
          icon: Icon(Icons.shopping_cart,color: Colors.green)),
        BottomNavigationBarItem(
          activeIcon: Text('Account'),
          label: '',
          icon: Icon(Icons.person,color: Colors.green,))
      ],
      currentIndex: controller.navigatorValue,
      onTap: (index)=> controller.changeSelectedValue(index),
      elevation: 0,
      selectedItemColor: Colors.black,
      backgroundColor: Colors.grey.shade100,
      ),
    );
  }
}