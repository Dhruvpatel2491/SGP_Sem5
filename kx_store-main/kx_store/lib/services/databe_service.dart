
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kx_store/models/person.dart';
import 'package:kx_store/models/product.dart';

class DatabaseService {
  final fb = FirebaseDatabase.instance;
  final usersRef = FirebaseDatabase.instance.reference().child('users');

  uploadData(Person person) {
    final ref = fb.reference();
    String phoneNumber =
        FirebaseAuth.instance.currentUser!.phoneNumber.toString();

    ref.child('users').child(phoneNumber).push().set({
      'name': person.name,
      'email': person.email,
      'address': person.address,
      'district': person.district,
      'state': person.state,
      'dob' : person.dateOfBirth
    }).asStream();
  }

  uploadProductData(Product product) {
    final ref = fb.reference();
    // String phoneNumber =
    //     FirebaseAuth.instance.currentUser!.phoneNumber.toString();

    ref.child('inventory').push().set({
      'phone_number': product.phoneNumber,
      'image_url': product.productURL,
      'product_name': product.productName,
      'product_category': product.productCategory,
      'product_description': product.productDescription,
      'company_name' : product.companyName,
      'product_price' : product.productPrice,
      'units' : product.units,
    }).asStream();
  }
}