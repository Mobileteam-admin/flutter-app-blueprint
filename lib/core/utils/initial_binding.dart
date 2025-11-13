import 'package:get/get.dart';

import '../../features/home/view_model/home_view_model.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewModel(),permanent: true); // Use permanent: true to keep it alive



  }
}
