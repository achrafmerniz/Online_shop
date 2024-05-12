

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/model/clothes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class HomeFragmentScreen extends StatelessWidget {
   HomeFragmentScreen({super.key});

  TextEditingController searchController = TextEditingController();
   Future<List<Clothes>> getTrendingClothItems() async
   {
     List<Clothes> trendingClothItemsList = [];

     try
     {
       var res = await http.post(
           Uri.parse(API.getTrendingMostPopularClothes)
       );

       if(res.statusCode == 200)
       {
         var responseBodyOfTrending = jsonDecode(res.body);
         if(responseBodyOfTrending["success"] == true)
         {
           (responseBodyOfTrending["clothItemsData"] as List).forEach((eachRecord)
           {
             trendingClothItemsList.add(Clothes.fromJson(eachRecord));
           });
         }
       }
       else
       {
         Fluttertoast.showToast(msg: "Error, status code is not 200");
       }
     }
     catch(errorMsg)
     {
       print("Error:: " + errorMsg.toString());
     }

     return trendingClothItemsList;
   }

   Future<List<Clothes>> getAllClothItems() async
   {
     List<Clothes> allClothItemsList = [];

     try
     {
       var res = await http.post(
           Uri.parse(API.getAllClothes)
       );

       if(res.statusCode == 200)
       {
         var responseBodyOfAllClothes = jsonDecode(res.body);
         if(responseBodyOfAllClothes["success"] == true)
         {
           (responseBodyOfAllClothes["clothItemsData"] as List).forEach((eachRecord)
           {
             allClothItemsList.add(Clothes.fromJson(eachRecord));
           });
         }
       }
       else
       {
         Fluttertoast.showToast(msg: "Error, status code is not 200");
       }
     }
     catch(errorMsg)
     {
       print("Error:: " + errorMsg.toString());
     }

     return allClothItemsList;
   }

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

            trendingMostPopularClothItemWidget(context),
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

   Widget trendingMostPopularClothItemWidget(context)
   {
     return FutureBuilder(
       future: getTrendingClothItems(),
       builder: (context, AsyncSnapshot<List<Clothes>> dataSnapShot)
       {
         if(dataSnapShot.connectionState == ConnectionState.waiting)
         {
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
         if(dataSnapShot.data == null)
         {
           return const Center(
             child: Text(
               "No Trending item found",
             ),
           );
         }
         if(dataSnapShot.data!.length > 0)
         {
           return SizedBox(
             height: 260,
             child: ListView.builder(
               itemCount: dataSnapShot.data!.length,
               scrollDirection: Axis.horizontal,
               itemBuilder: (context, index)
               {
                 Clothes eachClothItemData = dataSnapShot.data![index];
                 return GestureDetector(
                   onTap: ()
                   {

                   },
                   child: Container(
                     width: 200,
                     margin: EdgeInsets.fromLTRB(
                       index == 0 ? 16 : 8,
                       10,
                       index == dataSnapShot.data!.length - 1 ? 16 : 8,
                       10,
                     ),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.black,
                       boxShadow:
                       const [
                         BoxShadow(
                           offset: Offset(0,3),
                           blurRadius: 6,
                           color: Colors.orange,
                         ),
                       ],
                     ),
                     child: Column(
                       children: [

                         //item image
                         ClipRRect(
                           borderRadius: const BorderRadius.only(
                             topLeft: Radius.circular(22),
                             topRight: Radius.circular(22),
                           ),
                           child: FadeInImage(
                             height: 150,
                             width: 200,
                             fit: BoxFit.cover,
                             placeholder: const AssetImage("images/place_holder.png"),
                             image: NetworkImage(
                               eachClothItemData.image!,
                             ),
                             imageErrorBuilder: (context, error, stackTraceError)
                             {
                               return const Center(
                                 child: Icon(
                                   Icons.broken_image_outlined,
                                 ),
                               );
                             },
                           ),
                         ),

                         //item name & price
                         //rating stars & rating numbers
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               //item name & price
                               Row(
                                 children: [
                                   Expanded(
                                     child: Text(
                                       eachClothItemData.name!,
                                       maxLines: 2,
                                       overflow: TextOverflow.ellipsis,
                                       style: const TextStyle(
                                         color: Colors.grey,
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                   const SizedBox(
                                     width: 10,
                                   ),
                                   Text(
                                     eachClothItemData.price.toString(),
                                     style: const TextStyle(
                                       color: Colors.purpleAccent,
                                       fontSize: 18,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 ],
                               ),

                               const SizedBox(height: 8,),

                               //rating stars & rating numbers
                               Row(
                                 children: [

                                   RatingBar.builder(
                                     initialRating: eachClothItemData.rating!,
                                     minRating: 1,
                                     direction: Axis.horizontal,
                                     allowHalfRating: true,
                                     itemCount: 5,
                                     itemBuilder: (context, c)=> const Icon(
                                       Icons.star,
                                       color: Colors.amber,
                                     ),
                                     onRatingUpdate: (updateRating){},
                                     ignoreGestures: true,
                                     unratedColor: Colors.grey,
                                     itemSize: 20,
                                   ),

                                   const SizedBox(width: 8,),

                                   Text(
                                     "(" + eachClothItemData.rating.toString() + ")",
                                     style: const TextStyle(
                                       color: Colors.grey,
                                     ),
                                   ),

                                 ],
                               ),

                             ],
                           ),
                         ),

                       ],
                     ),
                   ),
                 );
               },
             ),
           );
         }
         else
         {
           return const Center(
             child: Text("Empty, No Data."),
           );
         }
       },
     );
   }
}