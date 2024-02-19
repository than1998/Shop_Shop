import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/bottomNavigationBar/bottom_navigation_bar_view.dart';
import 'database/objectbox.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(GetMaterialApp(home: BottomNavigationBarView()));
}
