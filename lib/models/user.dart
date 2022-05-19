class User {
  static String? _name;

  static set name(String? name) {
    _name = name;
  }

  static String? get name => _name;
}
