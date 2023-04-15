import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../model/patients.dart';
// import '../provider/prescription_preview_provider.dart';
// import '../widgets/preview_widgets/complaints.dart';
// import '../widgets/preview_widgets/medicines.dart';
// import '../widgets/preview_widgets/patient_details.dart';
// import '../widgets/preview_widgets/preview_header.dart';

// class PreviewScreen extends StatefulWidget {
//   @override
//   State<PreviewScreen> createState() => _PreviewScreenState();
// }

// class _PreviewScreenState extends State<PreviewScreen> {
//   List<Medicine> medicineList = [];

//   @override
//   Widget build(BuildContext context) {
//     PrescriptionPreviewProvider prescriptionProvider =
//         Provider.of<PrescriptionPreviewProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medicine List'),
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: medicineNameController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: ' Name',
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: medicineQuantityController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: ' Quantity',
//                     ),
//                   ),

//                   // quantity unit dropdown button

//                   DropdownButton<QuantityUnit>(
//                     value: quantityUnit,
//                     icon: const Icon(Icons.arrow_downward),
//                     iconSize: 24,
//                     elevation: 16,
//                     style: const TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.deepPurpleAccent,
//                     ),
//                     onChanged: (QuantityUnit? newValue) {
//                       setState(() {
//                         quantityUnit = newValue!;
//                       });
//                     },
//                     items: QuantityUnit.values
//                         .map<DropdownMenuItem<QuantityUnit>>(
//                             (QuantityUnit value) {
//                       return DropdownMenuItem<QuantityUnit>(
//                         value: value,
//                         child: Text(Medicine.getQuantityUnitString(value)),
//                       );
//                     }).toList(),
//                   ),

//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: medicineWhenController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: ' When',
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   DropdownButton<String>(
//                     value: frequency,
//                     icon: const Icon(Icons.arrow_downward),
//                     iconSize: 24,
//                     elevation: 16,
//                     style: const TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.deepPurpleAccent,
//                     ),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         frequency = newValue!;
//                       });
//                     },
//                     items: <String>['Daily', 'Weekly', 'Monthly']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),

//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: medicineDurationController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: ' Duration',
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         medicineList.add(Medicine(
//                           name: medicineNameController.text,
//                           quantity: int.parse(medicineQuantityController.text),
//                           when: medicineWhenController.text,
//                           frequency: frequency,
//                           duration: int.parse(medicineDurationController.text),
//                           quantityUnit: quantityUnit,
//                           durationUnit: frequency == 'Daily'
//                               ? DurationUnit.days
//                               : frequency == 'Weekly'
//                                   ? DurationUnit.weeks
//                                   : DurationUnit.months,
//                         ));
//                         medicineNameController.clear();
//                         medicineQuantityController.clear();
//                         medicineWhenController.clear();
//                         medicineDurationController.clear();
//                       });
//                     },
//                     child: const Text('Add'),
//                   ),
//                   Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: medicineList.map((medicine) {
//                       return Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 0.5,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   medicine.name,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(width: 15),
//                                 Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           medicineNameController.text =
//                                               medicine.name;
//                                           medicineQuantityController.text =
//                                               medicine.quantity.toString();
//                                           medicineWhenController.text =
//                                               medicine.when;
//                                           medicineDurationController.text =
//                                               medicine.duration.toString();
//                                           frequency = medicine.frequency;
//                                           quantityUnit = medicine.quantityUnit;

//                                           medicineList.remove(medicine);
//                                         });
//                                       },
//                                       child: Icon(Icons.edit,
//                                           color: Colors.grey.shade400,
//                                           size: 20),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           medicineList.remove(medicine);
//                                         });
//                                       },
//                                       child: Icon(Icons.delete,
//                                           color: Colors.grey.shade400,
//                                           size: 20),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 5),
//                             Text(medicine.getQuantityString()),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             flex: 2,
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               // contains data about the doctor and hospital to be displayed on the preview
//               previewHeader(
//                   doctor: prescriptionProvider.doctor,
//                   hospital: prescriptionProvider.hospital),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     patientDetails(prescriptionProvider.patient),
//                     const SizedBox(height: 10),
//                     Divider(height: 0.5, color: Colors.grey.shade400),
//                     const SizedBox(height: 20),

//                     // complaints
//                     if (prescriptionProvider.complaints.isNotEmpty)
//                       complaintsColumn(prescriptionProvider.complaints),
//                     if (medicineList.isNotEmpty) medicinesColumn(medicineList),
//                     const SizedBox(height: 20),

//                     // advice
//                     const Text('Advice', style: PreviewFontStyles.heading2),
//                     const SizedBox(height: 10),
//                     Text(prescriptionProvider.getAdvice(),
//                         style: PreviewFontStyles.body),
//                     Divider(height: 0.5, color: Colors.grey.shade400),
//                   ],
//                 ),
//               )
//               // patient details and visit date
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }

class PreviewFontStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle heading2 =
      TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold);
  static const TextStyle body = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(117, 117, 117, 1));
  // body text bold
  static const TextStyle bodyBold = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(117, 117, 117, 1));
}
