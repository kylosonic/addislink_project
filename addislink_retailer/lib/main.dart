import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:addislink_shared/addislink_shared.dart';
import 'package:addislink_retailer/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: AddisLinkRetailerApp()));
}

class AddisLinkRetailerApp extends StatelessWidget {
  const AddisLinkRetailerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AddisLink Retailer',
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
