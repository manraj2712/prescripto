class UserModel {
  final String name;
  final String gender;
  final String mobileNo;
  bool joined;

  UserModel(
      {required this.name,
      required this.gender,
      required this.mobileNo,
      this.joined = false});
}
