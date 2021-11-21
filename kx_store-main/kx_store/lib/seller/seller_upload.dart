import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kx_store/models/product.dart';
import 'package:kx_store/services/databe_service.dart';
import 'package:kx_store/shared/kx_brand.dart';
import 'package:path/path.dart' as path;

import 'package:firebase_storage/firebase_storage.dart';

class SellerUpload extends StatefulWidget {
  const SellerUpload({Key? key}) : super(key: key);

  @override
  _SellerUploadState createState() => _SellerUploadState();
}

class _SellerUploadState extends State<SellerUpload> {
  String page = 'Grey';
  Color navbar_green = new Color(0xffCAEACD);
  Color navbar_grey = new Color(0xff5B5A5A);
  Color floatAction_blue = new Color(0xff3287EB);
  int index = 0;

  final _formKey = GlobalKey<FormState>();

  String productName = '';
  String productDescription = '';
  String companyName = '';
  String units = '';
  String productPrice = '';

  File? _imageFile;
  final picker = ImagePicker();
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<String> uploadImageToFirebase(BuildContext context) async {
    String filePath = _imageFile!.path;
    // StorageReference firebaseStorageRef =
    String fileName = path.basename(filePath);
    final ref = FirebaseStorage.instance.ref('images/').child(fileName);
    await ref.putFile(_imageFile!);
    final fileUrl = await ref.getDownloadURL();
    return fileUrl;
  }

  @override
  Widget build(BuildContext context) {
    double Scrheight = MediaQuery.of(context).size.height;
    double Scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: Scrheight * 0.2,
                width: Scrwidth,
                color: Colors.amberAccent,
                child: _imageFile != null ? Image.file(_imageFile!) : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          pickImage();
                        },
                        focusColor: Colors.grey,
                        // padding: EdgeInsets.all(0),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, Scrheight * 0.13, 30, 0),
                // height: Scrheight * 0.6,
                // width: Scrwidth * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(-10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'PRODUCT NAME',
                        style: TextStyle(color: kxBrand().kxblue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the product name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            productName = value;
                          });
                        },
                        decoration: InputDecoration(
                            focusColor: Colors.amberAccent,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: -5, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kxBrand().kxblue),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kxBrand().kxblue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'PRODUCT DESCRIPTION',
                        style: TextStyle(color: kxBrand().kxblue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the product description';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            productDescription = value;
                          });
                        },
                        decoration: InputDecoration(
                            focusColor: Colors.amberAccent,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: -5, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kxBrand().kxblue),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kxBrand().kxblue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'CATEGORY',
                        style: TextStyle(color: kxBrand().kxblue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'COMPANY NAME',
                        style: TextStyle(color: kxBrand().kxblue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the company name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            companyName = value;
                          });
                        },
                        decoration: InputDecoration(
                            focusColor: Colors.amberAccent,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: -5, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kxBrand().kxblue),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kxBrand().kxblue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Units',
                        style: TextStyle(color: kxBrand().kxblue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the units';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            units = value;
                          });
                        },
                        decoration: InputDecoration(
                            focusColor: Colors.amberAccent,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: -5, horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kxBrand().kxblue),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kxBrand().kxblue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Price',
                        style: TextStyle(color: kxBrand().kxblue),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the price';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            productPrice = value;
                          });
                        },
                        decoration: InputDecoration(
                            prefix: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('₹'),
                            ),
                            focusColor: Colors.amberAccent,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kxBrand().kxblue),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: kxBrand().kxblue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: false,
        backgroundColor: floatAction_blue,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String url = await uploadImageToFirebase(context) ;

            Product product = new Product(
              phoneNumber:
                  FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
              productURL: url,
              productName: productName,
              productDescription: productDescription,
              productCategory: 'default category',
              companyName: companyName,
              units: units,
              productPrice: productPrice,
            );

            await DatabaseService().uploadProductData(product);
            Navigator.pop(context);
          }
        },
        hoverElevation: 0,
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        elevation: 0,
        child: Icon(
          Icons.done,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Container BottomNavBar() {
    double topCornerRadius = 20.0;
    return Container(
        decoration: BoxDecoration(
          color: kxBrand().kxgreen,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(topCornerRadius),
              topLeft: Radius.circular(topCornerRadius)),
          // boxShadow: [
          //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          // ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topCornerRadius),
            topRight: Radius.circular(topCornerRadius),
          ),
          child: BottomNavigationBar(
            backgroundColor: navbar_green,
            // selectedItemColor: ,
            // unselectedItemColor: navbar_grey,
            currentIndex: index,
            onTap: (int i) {
              setState(() {
                index = i;
              });
            },
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: 'Inventory',
              )
            ],
          ),
        ));
  }
}
