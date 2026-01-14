import 'package:go_router/go_router.dart';
import 'package:addislink_retailer/features/home/presentation/home_screen.dart';
import 'package:addislink_retailer/features/booking/presentation/booking_screen.dart';
import 'package:addislink_retailer/features/tracking/presentation/tracking_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/booking',
      builder: (context, state) => const BookingScreen(),
    ),
    GoRoute(
      path: '/tracking',
      builder: (context, state) => const TrackingScreen(),
    ),
  ],
);
