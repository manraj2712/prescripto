import 'package:flutter/material.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/constants/widgets.dart';

class SpecialityScreen extends StatelessWidget {
  const SpecialityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final specialityController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Kulcare',
          style: MyFontStyles.heading1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[500]!),
                shape: BoxShape.circle,
                // color: Colors.grey[200],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/assets/images/background1.png',
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.center,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 5),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyWidgets.verticalSeparator,
                      Text(
                        'What is your speciality?',
                        style: MyFontStyles.heading1,
                      ),
                      MyWidgets.verticalSeparator,
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Type or select'),
                        controller: specialityController,
                      ),
                      MyWidgets.verticalSeparator,
                      MyWidgets.verticalSeparator,
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Next'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   // extendBodyBehindAppBar: true,
    //   extendBody: true,
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     elevation: 0,
    //     title: Text(
    //       'Kulcare',
    //       style: MyFontStyles.heading1,
    //     ),
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: CircleAvatar(
    //           child: Icon(Icons.person),
    //         ),
    //       )
    //     ],
    //   ),
    //   body: Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       Image.asset(
    //         'lib/assets/images/background.png',
    //         fit: BoxFit.cover,
    //       ),
    //       Container(
    //         alignment: Alignment.center,
    //         child: Card(
    //           elevation: 5,
    //           margin: EdgeInsets.all(16),
    //           child: Padding(
    //             padding: EdgeInsets.all(16),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 MyWidgets.verticalSeparator,
    //                 Text(
    //                   'What is your speciality?',
    //                   style: MyFontStyles.heading1,
    //                 ),
    //                 MyWidgets.verticalSeparator,
    //                 TextFormField(
    //                   decoration: InputDecoration(hintText: 'Type or select'),
    //                   controller: specialityController,
    //                 ),
    //                 MyWidgets.verticalSeparator,
    //                 Align(
    //                   alignment: Alignment.bottomRight,
    //                   child: ElevatedButton(
    //                     onPressed: () {},
    //                     child: Text('Next'),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
