// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../features/global_settings/view_model/global_settings_view_model.dart';
// import '../../features/home/view_model/meal_tab_view_model.dart';
//
// class MealBannerController extends GetxController {
//   Rx<Duration?> lunchCountdown = Rx<Duration?>(null);
//   Rx<Duration?> dinnerCountdown = Rx<Duration?>(null);
//   RxString lunchCutoffTime = "".obs;
//   RxString dinnerCutoffTime = "".obs;
//   final globalSettings = Get.find()<GlobalSettingsViewModel>();
//
//   RxString lunchMessage = "".obs;
//   RxString dinnerMessage = "".obs;
//
//   bool lunchClosed = false;
//   bool dinnerClosed = false;
//
//   Timer? _timer;
//
//   void startCountdown(MealType tab) {
//     final now = DateTime.now();
//
//
//
//     DateTime? cutoff;
//     DateTime? windowStart;
//     DateTime? windowEnd;
//     DateTime? showCountdownStart;
//
//
//
//     if (tab == MealType.lunch) {
//       print("🔁 Lunch tab selected ${globalSettings.globalData.value?.data?.lunchAllowBefore}");
//
//        lunchCutoffTime.value = globalSettings.globalData.value?.data?.lunchAllowBefore??'';
//
//       // Parse as DateTime
//       DateTime lunchParsedTime = DateFormat("HH:mm:ss").parse(lunchCutoffTime.value);
//
//       int lunchHour =  lunchParsedTime.hour;
//       int lunchMinute = lunchParsedTime.minute;
//
//       print("rose time lunch Hour: $lunchHour");   // 11
//       print("rose time lunch Minute: $lunchMinute"); // 0
//
//
//       windowStart = DateTime(now.year, now.month, now.day, 11, 0);
//       windowEnd = DateTime(now.year, now.month, now.day, 15, 0);
//       cutoff = DateTime(now.year, now.month, now.day, 11, 30);
//       showCountdownStart = cutoff.subtract(const Duration(hours: 1));
//       if (lunchClosed) return;
//     } else {//dinner banner
//       print("🔁 Dinner tab selected ${globalSettings.globalData.value?.data?.dinnerAllowBefore}");
//
//       dinnerCutoffTime.value = globalSettings.globalData.value?.data?.dinnerAllowBefore??'';
//
//       // Parse as DateTime
//       DateTime dinnerParsedTime = DateFormat("HH:mm:ss").parse(dinnerCutoffTime.value);
//
//       int dinnerHour =  dinnerParsedTime.hour;
//       int dinnerMinute = dinnerParsedTime.minute;
//
//       print("rose time Hour dinner: $dinnerHour");   // 11
//       print("rose time Minute dinner : $dinnerMinute"); // 0
//
//       windowStart = DateTime(now.year, now.month, now.day, 18, 0);
//       windowEnd = DateTime(now.year, now.month, now.day, 22, 0);
//       cutoff = DateTime(now.year, now.month, now.day, 19, 30);
//       showCountdownStart = cutoff.subtract(const Duration(hours: 1));
//       if (dinnerClosed) return;
//     }
//
//     _timer?.cancel();
//
//     // Default reset for this tab
//     if (tab == MealType.lunch) {
//       lunchCountdown.value = null;
//       lunchMessage.value = "";
//     } else {
//       dinnerCountdown.value = null;
//       dinnerMessage.value = "";
//     }
//
//     // Check if inside meal window
//     if (now.isAfter(windowStart) && now.isBefore(windowEnd)) {
//       if (now.isBefore(cutoff)) {
//         if (now.isAfter(showCountdownStart)) {
//           _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//             final diff = cutoff!.difference(DateTime.now());
//             if (diff.isNegative) {
//               _setMessage(tab,
//                   "Today's ${tab == MealType.lunch ? "Lunch" : "Dinner"} order time has passed. You can schedule for tomorrow.",
//                   null);
//               _timer?.cancel();
//             } else {
//               _setMessage(
//                 tab,
//                 "${tab == MealType.lunch ? "Lunch" : "Dinner"} order faster for today until ${tab == MealType.lunch ? "11:30 AM" : "7:30 PM"}",
//                 diff,
//               );
//             }
//           });
//         } else {
//           // Before countdown → nothing
//           _setMessage(tab, "", null);
//         }
//       } else {
//         // After cutoff → passed message
//         _setMessage(
//           tab,
//           "Today's ${tab == MealType.lunch ? "Lunch" : "Dinner"} order time has passed. You can schedule for tomorrow.",
//           null,
//         );
//       }
//     }
//   }
//
//   void _setMessage(MealType tab, String msg, Duration? diff) {
//     if (tab == MealType.lunch) {
//       lunchMessage.value = msg;
//       lunchCountdown.value = diff;
//     } else {
//       dinnerMessage.value = msg;
//       dinnerCountdown.value = diff;
//     }
//   }
//
//   void closeBanner(MealType tab) {
//     if (tab == MealType.lunch) {
//       lunchClosed = true;
//       lunchMessage.value = "";
//       lunchCountdown.value = null;
//     } else {
//       dinnerClosed = true;
//       dinnerMessage.value = "";
//       dinnerCountdown.value = null;
//     }
//     _timer?.cancel();
//   }
//
//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
// }
//
// class MealBanner extends StatelessWidget {
//   final MealTabViewModel mealTabController = Get.find();
//   final MealBannerController controller = Get.put(MealBannerController());
//
//   MealBanner({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Listen for tab change
//     mealTabController.selectedTab.listen((tab) {
//       controller.startCountdown(tab);
//     });
//
//     // Trigger once at init
//     controller.startCountdown(mealTabController.selectedTab.value);
//
//     return Obx(() {
//       final currentTab = mealTabController.selectedTab.value;
//
//       final message = currentTab == MealType.lunch
//           ? controller.lunchMessage.value
//           : controller.dinnerMessage.value;
//
//       final countdown = currentTab == MealType.lunch
//           ? controller.lunchCountdown.value
//           : controller.dinnerCountdown.value;
//
//       if (message.isEmpty) return const SizedBox.shrink();
//
//       String countdownText = "";
//       if (countdown != null) {
//         final hours = countdown.inHours;
//         final minutes = countdown.inMinutes % 60;
//         final seconds = countdown.inSeconds % 60;
//         countdownText =
//         " | Closing in ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
//       }
//
//       return Container(
//         margin: const EdgeInsets.all(8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.redAccent,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.timer, color: Colors.white),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 message + countdownText,
//                 style: const TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//             IconButton(
//               onPressed: () => controller.closeBanner(currentTab),
//               icon: const Icon(Icons.close, color: Colors.white),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
//
//
// // class MealBannerController extends GetxController {
// //   Rx<Duration?> countdown = Rx<Duration?>(null);
// //   RxString message = "".obs;
// //   RxBool isClosedManually = false.obs;
// //   Timer? _timer;
// //
// //   // Track if banner closed separately for Lunch & Dinner
// //   bool lunchClosed = false;
// //   bool dinnerClosed = false;
// //
// //   void startCountdown(MealType tab) {
// //     final now = DateTime.now();
// //     DateTime? cutoff;
// //     DateTime? windowStart;
// //     DateTime? windowEnd;
// //     DateTime? showCountdownStart;
// //
// //     if (tab == MealType.lunch) {
// //       windowStart = DateTime(now.year, now.month, now.day, 11, 0);
// //       windowEnd = DateTime(now.year, now.month, now.day, 14, 0);
// //       cutoff = DateTime(now.year, now.month, now.day, 11, 30);
// //       showCountdownStart = cutoff.subtract(const Duration(hours: 1));
// //       if (lunchClosed) return; // user closed lunch banner
// //     } else {
// //       windowStart = DateTime(now.year, now.month, now.day, 18, 0);
// //       windowEnd = DateTime(now.year, now.month, now.day, 22, 0);
// //       cutoff = DateTime(now.year, now.month, now.day, 19, 30);
// //       showCountdownStart = cutoff.subtract(const Duration(hours: 1));
// //       if (dinnerClosed) return; // user closed dinner banner
// //     }
// //
// //     // Default reset
// //     _timer?.cancel();
// //     countdown.value = null;
// //     message.value = "";
// //
// //     // Check if inside meal window
// //     if (now.isAfter(windowStart) && now.isBefore(windowEnd)) {
// //       if (now.isBefore(cutoff)) {
// //         if (now.isAfter(showCountdownStart)) {
// //           // ✅ Last 1 hour → show countdown
// //           _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// //             final diff = cutoff!.difference(DateTime.now());
// //             if (diff.isNegative) {
// //               message.value =
// //               "Today's ${tab == MealType.lunch ? "Lunch" : "Dinner"} order time has passed. You can schedule for tomorrow.";
// //               countdown.value = null;
// //               _timer?.cancel();
// //             } else {
// //               countdown.value = diff;
// //               message.value =
// //               "${tab == MealType.lunch ? "Lunch" : "Dinner"} order faster for today until ${tab == MealType.lunch ? "11:30 AM" : "7:30 PM"}";
// //             }
// //           });
// //         } else {
// //           // ⏳ Before countdown period → no banner
// //           message.value = "";
// //         }
// //       } else {
// //         // ❌ After cutoff → passed message
// //         countdown.value = null;
// //         message.value =
// //         "Today's ${tab == MealType.lunch ? "Lunch" : "Dinner"} order time has passed. You can schedule for tomorrow.";
// //       }
// //     }
// //   }
// //
// //   void closeBanner(MealType tab) {
// //     if (tab == MealType.lunch) {
// //       lunchClosed = true;
// //     } else {
// //       dinnerClosed = true;
// //     }
// //     message.value = "";
// //     countdown.value = null;
// //     _timer?.cancel();
// //   }
// //
// //   @override
// //   void onClose() {
// //     _timer?.cancel();
// //     super.onClose();
// //   }
// // }
// //
// // class MealBanner extends StatelessWidget {
// //   final MealTabViewModel mealTabController = Get.find();
// //   final MealBannerController controller = Get.put(MealBannerController());
// //
// //   MealBanner({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Listen for tab change
// //     mealTabController.selectedTab.listen((tab) {
// //       controller.startCountdown(tab);
// //     });
// //
// //     // Trigger once at init
// //     controller.startCountdown(mealTabController.selectedTab.value);
// //
// //     return Obx(() {
// //       if (controller.message.value.isEmpty) return const SizedBox.shrink();
// //
// //       final timeLeft = controller.countdown.value;
// //       String countdownText = "";
// //
// //       if (timeLeft != null) {
// //         final hours = timeLeft.inHours;
// //         final minutes = timeLeft.inMinutes % 60;
// //         final seconds = timeLeft.inSeconds % 60;
// //         countdownText =
// //         " | Closing in ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
// //       }
// //
// //       final currentTab = mealTabController.selectedTab.value;
// //
// //       return Container(
// //         margin: const EdgeInsets.all(8),
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: Colors.redAccent,
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Row(
// //           children: [
// //             const Icon(Icons.timer, color: Colors.white),
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: Text(
// //                 controller.message.value + countdownText,
// //                 style: const TextStyle(
// //                     color: Colors.white, fontWeight: FontWeight.bold),
// //                 textAlign: TextAlign.start,
// //               ),
// //             ),
// //             IconButton(
// //               onPressed: () => controller.closeBanner(currentTab),
// //               icon: const Icon(Icons.close, color: Colors.white),
// //             )
// //           ],
// //         ),
// //       );
// //     });
// //   }
// // }
