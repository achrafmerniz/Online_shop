import 'dart:convert';
import 'dart:io';

import 'package:clothes_app/admin/admin_get_all_orders.dart';
import 'package:clothes_app/admin/admin_login.dart';
import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/authentification/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AdminUploadItemsScreen extends StatefulWidget {
  @override
  State<AdminUploadItemsScreen> createState() => _AdminUploadItemsScreenState();
}

class _AdminUploadItemsScreenState extends State<AdminUploadItemsScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ratingController = TextEditingController();
  final tagsController = TextEditingController();
  final priceController = TextEditingController();
  final sizesController = TextEditingController();
  final colorsController = TextEditingController();
  final descriptionController = TextEditingController();
  String imageLink = "";

  // Image picking methods
  Future<void> captureImageWithPhoneCamera() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
    Get.back();
    setState(() {});
  }

  Future<void> pickImageFromPhoneGallery() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    setState(() {});
  }

  void showDialogBoxForImagePickingAndCapturing() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Item Image",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: captureImageWithPhoneCamera,
              child: const Text(
                "Capture with Phone Camera",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromPhoneGallery,
              child: const Text(
                "Pick Image From Phone Gallery",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // UI for the default screen
  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: ()
          {
            Get.to(AdminGetAllOrdersScreen());

          }
          ,

          child: const Text(
            "New Orders",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: ()
            {

              Get.to(LoginScreen());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
          ),

        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate,
                color: Colors.white54,
                size: 200,
              ),
              Material(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: showDialogBoxForImagePickingAndCapturing,
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 28,
                    ),
                    child: Text(
                      "Add New Item",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Methods to handle image upload and item information save
  Future<void> uploadItemImage() async {
    var requestImgurApi = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.imgur.com/3/image"),
    );

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    requestImgurApi.fields['title'] = imageName;
    requestImgurApi.headers['Authorization'] = "Client-ID YOUR_CLIENT_ID";

    var imageFile = await http.MultipartFile.fromPath(
      'image',
      pickedImageXFile!.path,
      filename: imageName,
    );

    requestImgurApi.files.add(imageFile);
    var responseFromImgurApi = await requestImgurApi.send();

    var responseDataFromImgurApi = await responseFromImgurApi.stream.toBytes();
    var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

    Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);

    imageLink = jsonRes["data"]["link"].toString();

    saveItemInfoToDatabase();
  }

  Future<void> saveItemInfoToDatabase() async {
    List<String> tagsList = tagsController.text.split(',');
    List<String> sizesList = sizesController.text.split(',');
    List<String> colorsList = colorsController.text.split(',');

    try {
      var response = await http.post(
        Uri.parse(API.uploadNewItem),
        body: {
          'id_product': '1',
          'product_name': nameController.text.trim(),
          'rating': ratingController.text.trim(),
          'tags': tagsList.toString(),
          'price': priceController.text.trim(),
          'sizes': sizesList.toString(),
          'colors': colorsList.toString(),
          'description': descriptionController.text.trim(),
          'image': imageLink,
        },
      );

      if (response.statusCode == 200) {
        var resBodyOfUploadItem = jsonDecode(response.body);

        if (resBodyOfUploadItem['success'] == true) {
          Fluttertoast.showToast(msg: "New item uploaded successfully");
          setState(() {
            pickedImageXFile = null;
            nameController.clear();
            ratingController.clear();
            tagsController.clear();
            priceController.clear();
            sizesController.clear();
            colorsController.clear();
            descriptionController.clear();
          });

          Get.to(AdminUploadItemsScreen());
        } else {
          Fluttertoast.showToast(msg: "Item not uploaded. Try again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error: Item not uploaded.");
      print("Error: $errorMsg");
    }
  }

  // UI for the upload item form
  Widget uploadItemFormScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.orange,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text("Upload Form"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              pickedImageXFile = null;
              nameController.clear();
              ratingController.clear();
              tagsController.clear();
              priceController.clear();
              sizesController.clear();
              colorsController.clear();
              descriptionController.clear();
            });
          },
          icon: const Icon(Icons.clear),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(AdminLoginScreen());
            },
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Display the picked image
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(pickedImageXFile!.path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Upload item form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildTextFormField(nameController, "Item Name", Icons.title),
                      const SizedBox(height: 18),
                      buildTextFormField(ratingController, "Item Rating", Icons.rate_review),
                      const SizedBox(height: 18),
                      buildTextFormField(tagsController, "Item Tags", Icons.tag),
                      const SizedBox(height: 18),
                      buildTextFormField(priceController, "Item Price", Icons.price_change_outlined),
                      const SizedBox(height: 18),
                      buildTextFormField(sizesController, "Item Sizes", Icons.shop_two_outlined),
                      const SizedBox(height: 18),
                      buildTextFormField(colorsController, "Item Colors", Icons.color_lens_outlined),
                      const SizedBox(height: 18),
                      buildTextFormField(descriptionController, "Item Description", Icons.description, maxLines: 3),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Fluttertoast.showToast(msg: "Uploading Now...");

            uploadItemImage();
          }
        },
        label: const Text("Upload Now"),
        icon: const Icon(Icons.cloud_upload),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Method to build text form fields
  TextFormField buildTextFormField(
      TextEditingController controller, String hint, IconData icon, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white54),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white54),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        filled: true,
        fillColor: Colors.white54,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter $hint.";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }

  @override
  Widget build(BuildContext context) {
    return pickedImageXFile == null ? defaultScreen() : uploadItemFormScreen();
  }
}
