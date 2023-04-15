import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_prescription_frontend/constants/fonts_styles.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/screens/availability_widget.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/screens/services_table.dart';
import 'package:online_prescription_frontend/settings/ClinicSettings/screens/sms_whatsapp.dart';
import 'prescription.dart';
import 'vitals_table.dart';

class ArrowTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ArrowPainter();
  }
}

class _ArrowPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Offset(offset.dx, configuration.size!.height - 12) &
        Size(configuration.size!.width, 12);
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(rect.left + rect.width / 2 - 8, rect.top)
      ..lineTo(rect.left + rect.width / 2, rect.top - 8)
      ..lineTo(rect.left + rect.width / 2 + 8, rect.top)
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top);
    canvas.drawPath(path, paint);
  }
}

class ClinicSettingScreen extends StatefulWidget {
  static const routeName = '/clinic-setting-screen';
  const ClinicSettingScreen({Key? key}) : super(key: key);

  @override
  State<ClinicSettingScreen> createState() => _ClinicSettingScreenState();
}

class _ClinicSettingScreenState extends State<ClinicSettingScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Text("Vitals", style: MyFontStyles.heading3),
              Text("Services", style: MyFontStyles.heading3),
              Text("Prescription", style: MyFontStyles.heading3),
              Text("SMS/Whatsapp", style: MyFontStyles.heading3),
              Text("Availability", style: MyFontStyles.heading3),
            ],
          ),
        ),
        body: TabBarView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            VitalsTable(),
            ServicesTable(),
            PrescriptionRow(),
            SmsWidget(),
            AvailabilityWidget()
          ],
        ),
      ),
    );
  }
}