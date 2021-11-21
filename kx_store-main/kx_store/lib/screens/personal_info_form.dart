import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kx_store/models/person.dart';
import 'package:kx_store/screens/decide_role_screen.dart';
import 'package:kx_store/services/databe_service.dart';
import 'package:kx_store/widgets/background_widget.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  String name = "",
      dateOfBirth = "",
      email = "",
      address = "",
      district = "",
      state = "";

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _selectDate(BuildContext context) async {
    DateTime now = new DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              BackgroundWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/logo.png',
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'User Details',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.grey[400]!,
                          offset: Offset(0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 10.0,
                              color: Colors.grey)
                        ],
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: 'Name',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (!EmailValidator.validate(value!) ||
                                  value.isEmpty) {
                                return 'Please enter the valid email';
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: 'Email Address',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          TextFormField(
                            controller: dateController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a valid date';
                              }
                              return null;
                            },
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _selectDate(context);
                            },
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: 'Date Of Birth',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid address';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                            maxLines: 3,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: 'Address',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a valid district';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                district = value;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.location_city,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: 'District/City',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid state';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                state = value;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.public,
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: 'State',
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: RawMaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Person person = new Person(
                                name: name,
                                email: email,
                                address: address,
                                district: district,
                                state: state,
                                dateOfBirth: dateController.text,
                              );

                              DatabaseService().uploadData(person);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => DecideRoleScreen()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                          fillColor: Colors.blue[400],
                          hoverColor: Colors.blue,
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 55.0,
                            color: Colors.white,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
