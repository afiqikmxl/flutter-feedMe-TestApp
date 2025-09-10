import 'package:feedme/modules/root/controllers/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/app_theme.dart';

void main() {
  Get.put(RootController());
  runApp(const FeedMeApp());
}

class FeedMeApp extends StatelessWidget {
  const FeedMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'McD Automated Kitchen',
      theme: buildAppTheme(),
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
    );
  }
}
