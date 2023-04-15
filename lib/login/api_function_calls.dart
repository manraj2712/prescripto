import 'package:online_prescription_frontend/API%20MANAGER/api_manager.dart';
import 'package:online_prescription_frontend/login/models/signup.dart';

class ApiFunctionCalls {
  final _apiManager = APIManager();
  final _url = APIManager.url;
  signup(SignupDetails signupDetails) async {
    String path = "$_url/user/signup";
    var body = signupDetails.toJson();
    var res = await _apiManager.postAPICall(path, body);
    return res;
  }

  login(String phoneNumber) async {
    String path = "$_url/user/login";
    var body = {"phoneNumber": phoneNumber};
    var res = await _apiManager.postAPICall(path, body);
    return res;
  }
}
