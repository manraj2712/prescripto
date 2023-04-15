import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginText extends StatelessWidget {
  const LoginText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        headingText("Get Started Quickly",
            "Start scheduling and collecting payments in minutes"),
        const SizedBox(height: 20),
        headingText("Delight patients and grow your business",
            "Keep patients coming back with easy booking, payments, and telemedicine"),
        const SizedBox(height: 20),
        headingText("Stay up-to-date on medical news",
            "Join 4000+ doctors who trust Kulcare for timely, specialized medical news"),
      ],
    );
  }

  ListTile headingText(String heading, String subHeading) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Icon(Icons.check_circle_sharp, color: Colors.blue),
      title: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            text: heading,
            style: GoogleFonts.openSans(
                color: Color(0xFF078BFF),
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: RichText(
          text: TextSpan(
            text: subHeading,
            style: GoogleFonts.openSans(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
