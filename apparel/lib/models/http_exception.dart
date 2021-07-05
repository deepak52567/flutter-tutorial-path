class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
   return message;
   // returns super.toString(); //Instance of HttpException
  }
}
