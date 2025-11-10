import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import 'settings_view_cupertino.dart';
import 'settings_view_material.dart';
import 'settings_view_web.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const SettingsViewWeb();
    if (Platform.isIOS) return const SettingsViewCupertino();
    return const SettingsViewMaterial();
  }
}
