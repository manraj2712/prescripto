import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MyWidgets.verticalSeparator,
          Row(
            children: [
              MyWidgets.horizontalSeparator,
              Expanded(
                child: Text(
                    "Search a doctor using their mobile number to add them as a consultant to your clinic. A\n consultant account can only view the data related to their patients in the clinic."),
              ),
              SizedBox(
                  width: 200,
                  child: MyWidgets.ctaButton(
                      text: "Add Doctor",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            //TODO: Alert dialog of user screen
                            return AlertDialog(
                              title: Text('Verification'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Medical Registration Number'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'Medical Registration Certificate'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: Text('Verify'),
                                  onPressed: () {
                                    //TODO: Add logic for verification
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      })),
              SizedBox(
                width: 50,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: UserTable(),
          ),
        ]),
      ),
    );
  }
}

class UserTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          child: DataTable(
            border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey, width: 0.5)),
            showCheckboxColumn: false,
            columns: [
              DataColumn(label: Text('')),
              DataColumn(
                  label: Text(
                'Name',
                style: MyFontStyles.heading2,
              )),
              DataColumn(
                  label: Text(
                'Gender',
                style: MyFontStyles.heading2,
              )),
              DataColumn(
                  label: Text(
                'Mobile No.',
                style: MyFontStyles.heading2,
              )),
              DataColumn(
                  label: Text(
                'Status',
                style: MyFontStyles.heading2,
              )),
            ],
            rows: userProvider.users
                .map((user) => DataRow(cells: [
                      DataCell(CircleAvatar(
                          backgroundColor: Colors.blue[50],
                          child: Icon(Icons.person))),
                      DataCell(Text(
                        user.name,
                        style: MyFontStyles.heading3,
                      )),
                      DataCell(Text(
                        user.gender,
                        style: MyFontStyles.heading3,
                      )),
                      DataCell(Text(
                        user.mobileNo,
                        style: MyFontStyles.heading3,
                      )),
                      DataCell(Text(
                        user.joined ? 'Joined' : 'Pending',
                        style: MyFontStyles.heading3,
                      )),
                    ]))
                .toList(),
          ),
        );
      },
    );
  }
}

// class AddDoctorButton extends StatefulWidget {
//   @override
//   State<AddDoctorButton> createState() => _AddDoctorButtonState();
// }

// class _AddDoctorButtonState extends State<AddDoctorButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             //TODO: Alert dialog of user screen
//             return AlertDialog(
//               title: Text('Verification'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Medical Registration Number'),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Medical Registration Certificate'),
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   child: Text('Cancel'),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 TextButton(
//                   child: Text('Verify'),
//                   onPressed: () {
//                     //TODO: Add logic for verification
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Text('Add Doctor'),
//     );
//   }
// }
