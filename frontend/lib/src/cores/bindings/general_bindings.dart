import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GeneralBindings extends Bindings {

  Logger? get logger => Logger();

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(logger);
  }
}
