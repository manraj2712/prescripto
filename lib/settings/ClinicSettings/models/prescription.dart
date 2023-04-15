class Prescription {
  String title;
  bool isChecked;
  Prescription({required this.title, required this.isChecked});

  // factory Prescription.fromJson(Map<String, dynamic> json) {
  //   return Prescription(
  //     title: json['title'],
  //     isChecked: json['isChecked'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'isChecked': isChecked,
  //   };
  // }

}
