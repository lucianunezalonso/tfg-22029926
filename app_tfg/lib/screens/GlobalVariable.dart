class GlobalVariable {
  static final GlobalVariable _instance = GlobalVariable._internal();

  factory GlobalVariable() {
    return _instance;
  }

  GlobalVariable._internal();

  String ip = '';
}
