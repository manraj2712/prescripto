import 'package:flutter/material.dart';


class CircleAvatarWidget extends StatelessWidget {
  final String firstName;
  final String lastName;

  const CircleAvatarWidget({Key? key, required this.firstName, required this.lastName}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    String firstNameInitial =
        firstName[0];
    String lastNameInitial = lastName.isNotEmpty
        ? lastName.substring(0, 1)
        : '';
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.blue,
      child: Text('$firstNameInitial$lastNameInitial'),
    );
  }
}
