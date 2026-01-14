import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:addislink_shared/addislink_shared.dart';
import 'package:go_router/go_router.dart';
import 'package:addislink_driver/features/job/presentation/job_request_dialog.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool isOnline = false;
  final LatLng addisAbaba = const LatLng(9.005401, 38.763611);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      body: Stack(
        children: [
          // 1. Full Screen Map
          FlutterMap(
            options: MapOptions(
              initialCenter: addisAbaba,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                // Using CartoDB Positron for a cleaner, modern look
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.addislink.driver',
              ),
              if (isOnline)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: addisAbaba,
                      width: 50,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: AppTheme.softShadow,
                        ),
                        child: const Icon(Icons.local_shipping, color: AppTheme.accent, size: 28),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // 2. Floating Top Bar (SafeArea)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Profile
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: AppTheme.softShadow,
                      ),
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'), // Placeholder
                        backgroundColor: AppTheme.surface,
                      ),
                    ),
                    
                    // Online/Offline Pill
                    GestureDetector(
                      onTap: () {
                         setState(() {
                            isOnline = !isOnline;
                            if(isOnline) {
                               Future.delayed(const Duration(seconds: 2), () {
                                 if(mounted) showModalBottomSheet(
                                   context: context, 
                                   isScrollControlled: true,
                                   backgroundColor: Colors.transparent,
                                   builder: (_) => const JobRequestSheet()
                                 );
                               });
                            }
                         });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: isOnline ? AppTheme.primary : Colors.grey[300],
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: AppTheme.softShadow,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isOnline ? 'ONLINE' : 'OFFLINE',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: isOnline ? AppTheme.accent : Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isOnline) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 8, height: 8,
                                decoration: const BoxDecoration(color: AppTheme.success, shape: BoxShape.circle),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),

                    // Wallet Balance
                    GestureDetector(
                      onTap: () => context.push('/wallet'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: AppTheme.softShadow,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.account_balance_wallet, size: 20, color: AppTheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              '850 Br',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Glassmorphic Queue Status
          if (isOnline)
            Positioned(
              top: 120, // Below top bar
              left: 20,
              right: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.accent.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.queue, color: Colors.black87),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Merkato Queue', style: Theme.of(context).textTheme.bodySmall),
                            Text('Position #4', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // 4. Sliding Earnings Panel (Bottom Sheet Simulation)
          if(isOnline)
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    Center(
                      child: Container(
                        width: 40, height: 4,
                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Today's Earnings", style: Theme.of(context).textTheme.bodyMedium),
                            Text("850.00 ETB", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {}, // Go to full breakdown
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.inputFill,
                            foregroundColor: AppTheme.textPrimary,
                          ),
                          child: const Text("Details"),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
