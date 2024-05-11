

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeFragmentScreen extends StatelessWidget {
   HomeFragmentScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const  SizedBox(height: 16,),
            //search bar
            showSearchBarWidget(),

            const  SizedBox(height: 24,),

            const  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("Trending",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              ),
            ),

             const  SizedBox(height: 24,),

            const  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("New collections",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              ),
            )

            //trending items
          ],
        ),
      ),
    );
  }
  showSearchBarWidget(){
    return Padding(padding:const EdgeInsets.symmetric(horizontal: 18),
    child: TextField(
     style:const TextStyle(color: Colors.white),
     controller: searchController,
     decoration: InputDecoration(
      prefixIcon: IconButton(onPressed: (){

      },
      icon:const Icon(Icons.search,
      color: Colors.orange,
      ),
      ),
      hintText: "Search product here",
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      suffixIcon: IconButton(onPressed: (){

      },
      icon: Icon(Icons.shopping_cart,
      ),
      
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.orange,
        ),
        
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.orange.shade100,
        ),
        
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.grey,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10
      ),
      fillColor: Colors.white,
      filled: true,
     ),
    ),
    );
    
  }
}