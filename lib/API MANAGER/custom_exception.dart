class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);
  @override
  String toString() {
    return _message.toString();
  }
}

class UnexceptedInputException extends CustomException {
  UnexceptedInputException([message]) : super(message, "Invalid Input");
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
