import 'package:go_router/go_router.dart';
import 'package:addislink_driver/features/dashboard/presentation/dashboard_screen.dart';
import 'package:addislink_driver/features/trip/presentation/active_trip_screen.dart';
import 'package:addislink_driver/features/wallet/presentation/wallet_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/trip',
      builder: (context, state) => const ActiveTripScreen(),
    ),
    GoRoute(
      path: '/wallet',
      builder: (context, state) => const WalletScreen(),
    ),
  ],
);
