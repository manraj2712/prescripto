class SignupDetails {
  final String email;
  final String designation;
  final String name;
  final String phoneNumber;

  SignupDetails({
    required this.email,
    required this.designation,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'profession': designation,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
