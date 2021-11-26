class Utils {
  static String format(String _city, {required Function onError}) {
    if (_city.isEmpty && _city.length > 1) {
      onError();
    } else {
      _city = '${_city[0].toUpperCase()}${_city.substring(1)}';
    }
    return _city;
  }
}
