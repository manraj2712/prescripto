import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:online_prescription_frontend/settings/ClinicProfile/provider/clinic_profile_provider.dart';
import 'package:online_prescription_frontend/settings/ClinicProfile/widget/image_picker_button.dart';
import 'package:online_prescription_frontend/settings/ClinicProfile/widget/resizable_text_box.dart';
import 'package:provider/provider.dart';

class ClinicProfileScreen extends StatefulWidget {
  const ClinicProfileScreen({Key? key}) : super(key: key);

  @override
  State<ClinicProfileScreen> createState() => _ClinicProfileScreenState();
}

class _ClinicProfileScreenState extends State<ClinicProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final _clinicProfileProvider = Provider.of<ClinicProfileProvider>(context);
    final _formKey = GlobalKey<FormState>();
    TextEditingController _aboutController = TextEditingController();
    TextEditingController _clinicNameController = TextEditingController();
    TextEditingController _clinicSpecialityController = TextEditingController();
    TextEditingController _otherSpecialityController = TextEditingController();
    TextEditingController _phoneNo1Controller = TextEditingController();
    TextEditingController _phoneNo2Controller = TextEditingController();
    TextEditingController _phoneNo3Controller = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    TextEditingController _areaController = TextEditingController();
    TextEditingController _cityController = TextEditingController();
    TextEditingController _pinCodeController = TextEditingController();
    bool isChecked = false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // title: Text(
        //   "Kulcare",
        //   style: GoogleFonts.lato(
        //       color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Color.fromARGB(50, 0, 0, 0), width: 1),
          ),
          child: Card(
            elevation: 10,
            shadowColor: Colors.black,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyWidgets.verticalSeparator,
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Basic Details",
                      style: GoogleFonts.bubblegumSans(
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 25),
                    ),
                  ),
                  MyWidgets.verticalSeparator,
                  textMethod("Clinic Logo", 15),
                  MyWidgets.verticalSeparator,
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ImagePickerButton(),
                  ),
                  MyWidgets.verticalSeparator,
                  MyWidgets.verticalSeparator,
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textMethod("Clinic Name", 0),
                            MyWidgets.verticalSeparator,
                            SizedBox(
                                width: 300,
                                child: textFormFieldMethod(
                                    _clinicNameController,
                                    context,
                                    _clinicProfileProvider,
                                    (value) => _clinicProfileProvider
                                        .setClinicName(value),
                                    "Please enter a clinic name",
                                    'Clinic Name')),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textMethod("Clinic Speciality", 0),
                            MyWidgets.verticalSeparator,
                            SizedBox(
                                width: 300,
                                child: textFormFieldMethod(
                                    _clinicSpecialityController,
                                    context,
                                    _clinicProfileProvider, (value) {
                                  _clinicProfileProvider
                                      .setClinicSpeciality(value);
                                }, "Please enter clinic speciality",
                                    'Clinic Speciality')
                                // TextFormField(
                                //   controller: _clinicSpecialityController,
                                //   decoration: InputDecoration(
                                //       border: OutlineInputBorder(),
                                //       label: Text("Clinic Speciality")),
                                //   onEditingComplete: () =>
                                //       FocusScope.of(context).nextFocus(),
                                //   onFieldSubmitted: (value) {
                                //     _clinicProfileProvider
                                //         .setClinicSpeciality(value);
                                //   },
                                //   onSaved: (newValue) {
                                //     _clinicProfileProvider
                                //         .setClinicSpeciality(newValue!);
                                //   },
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "Please enter clinic speciality";
                                //     }
                                //     return null;
                                //   },
                                // ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textMethod("Other Specialities", 15),
                      MyWidgets.verticalSeparator,
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: TextFormField(
                            controller: _otherSpecialityController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: MyWidgets.borderRadius),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: MyWidgets.borderRadius),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: MyWidgets.borderRadius),
                                hintText: "Add new tag"),
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            onFieldSubmitted: (value) {
                              _clinicProfileProvider.setOtherSpeciality(value);
                            },
                            onSaved: (newValue) {
                              _clinicProfileProvider
                                  .setOtherSpeciality(newValue!);
                            },
                          ),
                        ),
                      ),
                      MyWidgets.verticalSeparator,
                      textMethod("About", 15),
                      MyWidgets.verticalSeparator,
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: ResizableTextBox(controller: _aboutController),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Contact Details",
                          style: GoogleFonts.bubblegumSans(
                              color: Colors.grey, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textMethod("Phone Number 1", 15),
                              MyWidgets.verticalSeparator,
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: SizedBox(
                                    width: 300,
                                    child: textFormFieldMethod(
                                        _phoneNo1Controller,
                                        context,
                                        _clinicProfileProvider, (value) {
                                      _clinicProfileProvider.setPhoneNo1(value);
                                    }, 'Please enter phone number',
                                        'Phone No. 1')
                                    // TextFormField(
                                    //   controller: _phoneNo1Controller,
                                    //   inputFormatters: [
                                    //     FilteringTextInputFormatter.digitsOnly
                                    //   ],
                                    //   decoration: InputDecoration(
                                    //       border: OutlineInputBorder(),
                                    //       hintText: "Phone Number 1"),
                                    //   onEditingComplete: () {
                                    //     FocusScope.of(context).nextFocus();
                                    //   },
                                    //   onSaved: (newValue) {
                                    //     _clinicProfileProvider
                                    //         .setPhoneNo1(newValue!);
                                    //   },
                                    //   validator: (value) {
                                    //     if (value!.isEmpty) {
                                    //       return "Please enter phone number 1";
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textMethod("Phone Number 2", 0),
                              MyWidgets.verticalSeparator,
                              SizedBox(
                                  width: 300,
                                  child: textFormFieldMethod(
                                      _phoneNo2Controller,
                                      context,
                                      _clinicProfileProvider, (value) {
                                    _clinicProfileProvider.setPhoneNo2(value);
                                  }, 'Please enter phone number', 'Phone no. 2')
                                  // TextFormField(
                                  //   inputFormatters: [
                                  //     FilteringTextInputFormatter.digitsOnly
                                  //   ],
                                  //   controller: _phoneNo2Controller,
                                  //   decoration: InputDecoration(
                                  //       border: OutlineInputBorder(),
                                  //       hintText: "Phone Number 2"),
                                  //   onEditingComplete: () =>
                                  //       FocusScope.of(context).nextFocus(),
                                  //   onSaved: (newValue) {
                                  //     _clinicProfileProvider
                                  //         .setPhoneNo2(newValue!);
                                  //   },
                                  //   onFieldSubmitted: (value) {
                                  //     _clinicProfileProvider.setPhoneNo2(value);
                                  //   },
                                  // ),
                                  ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textMethod("Phone Number 3", 0),
                              MyWidgets.verticalSeparator,
                              SizedBox(
                                  width: 300,
                                  child: textFormFieldMethod(
                                      _phoneNo3Controller,
                                      context,
                                      _clinicProfileProvider, (value) {
                                    _clinicProfileProvider.setPhoneNo3(value);
                                  }, 'Please enter phone number', 'Phone no. 3')
                                  // TextFormField(
                                  //   controller: _phoneNo3Controller,
                                  //   inputFormatters: [
                                  //     FilteringTextInputFormatter.digitsOnly
                                  //   ],
                                  //   decoration: InputDecoration(
                                  //       border: OutlineInputBorder(),
                                  //       hintText: "Phone Number 3"),
                                  //   onEditingComplete: () =>
                                  //       FocusScope.of(context).nextFocus(),
                                  //   onSaved: (newValue) {
                                  //     _clinicProfileProvider
                                  //         .setPhoneNo3(newValue!);
                                  //   },
                                  //   onFieldSubmitted: (value) {
                                  //     _clinicProfileProvider.setPhoneNo3(value);
                                  //   },
                                  // ),
                                  ),
                            ],
                          )
                        ],
                      ),
                      MyWidgets.verticalSeparator,
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "These numbers will be printed on the bills and description",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        color: Colors.blueGrey.shade50,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  value: isChecked,
                                  onChanged: (v) {
                                    _clinicProfileProvider.setChecked(v!);
                                  }),
                              Text(
                                "Show these phone numbers on clinic profile to patients",
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textMethod("Email", 15),
                          MyWidgets.verticalSeparator,
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: SizedBox(
                                width: 300,
                                child: textFormFieldMethod(_emailController,
                                    context, _clinicProfileProvider, (value) {
                                  _clinicProfileProvider.setEmail(value);
                                }, 'Please enter email', 'Email')
                                // TextFormField(
                                //   controller: _emailController,
                                //   decoration: InputDecoration(
                                //       border: OutlineInputBorder(),
                                //       hintText: "Email"),
                                //   onEditingComplete: () =>
                                //       FocusScope.of(context).nextFocus(),
                                //   onSaved: (newValue) {
                                //     _clinicProfileProvider.setEmail(newValue!);
                                //   },
                                //   onFieldSubmitted: (value) {
                                //     _clinicProfileProvider.setEmail(value);
                                //   },
                                //   autovalidateMode: AutovalidateMode.always,
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "Please enter email";
                                //     } else
                                //       return null;
                                //   },
                                // ),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textMethod("Address", 15),
                              MyWidgets.verticalSeparator,
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: SizedBox(
                                    width: 300,
                                    child: textFormFieldMethod(
                                        _addressController,
                                        context,
                                        _clinicProfileProvider, (value) {
                                      _clinicProfileProvider.setAddress(value);
                                    }, 'Please enter address', 'Address')
                                    // TextFormField(
                                    //   controller: _addressController,
                                    //   decoration: InputDecoration(
                                    //       border: OutlineInputBorder(),
                                    //       hintText: "Address"),
                                    //   onEditingComplete: () =>
                                    //       FocusScope.of(context).nextFocus(),
                                    //   onSaved: (newValue) {
                                    //     _clinicProfileProvider
                                    //         .setAddress(newValue!);
                                    //   },
                                    //   onFieldSubmitted: (value) {
                                    //     _clinicProfileProvider.setAddress(value);
                                    //   },
                                    //   validator: (value) {
                                    //     if (value!.isEmpty) {
                                    //       return "Please enter address";
                                    //     }
                                    //     value.isValidEmail()
                                    //         ? null
                                    //         : "Please enter valid email";
                                    //   },
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textMethod("Area(locality)", 0),
                              MyWidgets.verticalSeparator,
                              SizedBox(
                                  width: 300,
                                  child: textFormFieldMethod(_areaController,
                                      context, _clinicProfileProvider, (value) {
                                    _clinicProfileProvider.setArea(value);
                                  }, 'Please enter area', 'Area')
                                  // TextFormField(
                                  //   controller: _areaController,
                                  //   decoration: InputDecoration(
                                  //       border: OutlineInputBorder(),
                                  //       hintText: "Area(locality)"),
                                  //   onEditingComplete: () =>
                                  //       FocusScope.of(context).nextFocus(),
                                  //   onSaved: (newValue) {
                                  //     _clinicProfileProvider.setArea(newValue!);
                                  //   },
                                  //   onFieldSubmitted: (value) {
                                  //     _clinicProfileProvider.setArea(value);
                                  //   },
                                  // ),
                                  ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textMethod("City", 15),
                          MyWidgets.verticalSeparator,
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: SizedBox(
                                width: 300,
                                child: textFormFieldMethod(_cityController,
                                    context, _clinicProfileProvider, (value) {
                                  _clinicProfileProvider.setCity(value);
                                }, 'Please enter city', 'City')
                                // TextFormField(
                                //   controller: _cityController,
                                //   decoration: InputDecoration(
                                //       border: OutlineInputBorder(),
                                //       hintText: "City"),
                                //   onEditingComplete: () =>
                                //       FocusScope.of(context).nextFocus(),
                                //   onSaved: (newValue) {
                                //     _clinicProfileProvider.setCity(newValue!);
                                //   },
                                //   onFieldSubmitted: (value) {
                                //     _clinicProfileProvider.setCity(value);
                                //   },
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "Please enter city";
                                //     }
                                //     return null;
                                //   },
                                // ),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textMethod("Pincode", 0),
                          MyWidgets.verticalSeparator,
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          SizedBox(
                              width: 300,
                              child: textFormFieldMethod(_pinCodeController,
                                  context, _clinicProfileProvider, (value) {
                                _clinicProfileProvider.setPinCode(value);
                              }, 'Please enter pincode', 'Pin Code')
                              // TextFormField(
                              //   controller: _pinCodeController,
                              //   inputFormatters: [
                              //     FilteringTextInputFormatter.digitsOnly
                              //   ],
                              //   decoration: InputDecoration(
                              //       border: OutlineInputBorder(),
                              //       hintText: "Pincode"),
                              //   onSaved: (newValue) {
                              //     _clinicProfileProvider.setPinCode(newValue!);
                              //   },
                              //   onFieldSubmitted: (value) {
                              //     _clinicProfileProvider.setPinCode(value);
                              //     _formKey.currentState!.save();
                              //     if (_formKey.currentState!.validate()) {}
                              //   },
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return "Please enter pincode";
                              //     }
                              //     return null;
                              //   },
                              // ),
                              ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                            },
                            child: Text("Save"))),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFormFieldMethod(
      TextEditingController controller,
      BuildContext context,
      ClinicProfileProvider clinicProfileProvider,
      void function(String value),
      String text,
      String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
        enabledBorder: OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
        focusedBorder: OutlineInputBorder(borderRadius: MyWidgets.borderRadius),
      ),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      onFieldSubmitted: (value) {
        function(value);
        clinicProfileProvider.setClinicName(value);
      },
      onSaved: (newValue) {
        clinicProfileProvider.setClinicName(newValue!);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return text;
        }
        return null;
      },
    );
  }

  Padding textMethod(String text, double leftpad) {
    return Padding(
      padding: EdgeInsets.only(left: leftpad),
      child: Text(text, style: MyFontStyles.heading2),
      // style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
