class GlobalVariable {
  static final GlobalVariable _instance = GlobalVariable._internal();

  factory GlobalVariable() {
    return _instance;
  }

  GlobalVariable._internal();

  // 192.168.8.121 (CASA)
  // 172.20.10.13 (MÓVIL)

  String ip = '172.20.10.13';
}
