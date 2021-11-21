import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:kx_store/seller/seller_upload.dart';
import 'package:kx_store/shared/kx_brand.dart';

class InverntoryScreen extends StatefulWidget {
  const InverntoryScreen({Key? key}) : super(key: key);

  @override
  _InverntoryScreenState createState() => _InverntoryScreenState();
}

class _InverntoryScreenState extends State<InverntoryScreen> {
  int index = 0;
  Color floatAction_blue = new Color(0xff3287EB);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
              leading: IconButton(
                onPressed: () {},
                color: Colors.white70,
                iconSize: 35,
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
              // Icon(Icons.menu, color: Colors.black,iconSize: 40,),
              //title: Text("Profile"),
              elevation: 0,
              backgroundColor: Colors.green[100],
              title: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Krsik ',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'X Store',
                                style: TextStyle(
                                    color: Colors.lightGreen.shade400,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            color: Colors.white70,
                            iconSize: 35,
                            icon: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                  ),
                  Row(children: [
                    Text(
                      'Set all farming products at one place ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ]),
                ],
              ))),
      body: Container(
          color: Colors.green[100], child: Center(child: SwipeList())),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        mini: false,
        backgroundColor: floatAction_blue,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellerUpload()),
          );
        },
        hoverElevation: 0,
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        elevation: 0,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Container BottomNavBar() {
    double topCornerRadius = 20.0;
    Color navbar_green = new Color(0xffCAEACD);
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

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  
  final inventoryRef = FirebaseDatabase.instance.reference().child('inventory');
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        child: FirebaseAnimatedList(
        query: inventoryRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return Card(
              margin: EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
              elevation: 5,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20), top: Radius.circular(20))),
              child: Container(
                margin: EdgeInsets.only(left: 10),
                height: 150.0,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: <Widget>[
                              Icon(
                                Icons.agriculture,
                                color: Colors.black,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                snapshot.value['product_category'].toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.blueGrey,
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20),
                              top: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          snapshot.value['image_url'].toString()))),
                            ),
                            Container(
                              height: 100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.value['product_name'].toString(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
                                      child: Container(
                                        child: Text(
                                          snapshot.value['company_name'].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 54)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
                                      child: Container(
                                        child: Text(
                                          snapshot.value['product_price'].toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 48, 48, 54)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
        },
      ),);
  }

}
