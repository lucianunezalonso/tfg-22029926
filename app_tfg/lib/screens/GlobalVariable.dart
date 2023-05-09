class GlobalVariable {
  static final GlobalVariable _instance = GlobalVariable._internal();

  factory GlobalVariable() {
    return _instance;
  }

  GlobalVariable._internal();

  //  # 192.168.8.121 (CASA)

  String ip = '192.168.8.121';
}
