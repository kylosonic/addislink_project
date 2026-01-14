import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:addislink_shared/addislink_shared.dart';
import 'package:addislink_driver/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: AddisLinkDriverApp()));
}

class AddisLinkDriverApp extends StatelessWidget {
  const AddisLinkDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AddisLink Driver',
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
