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
  
  // Addis Ababa Coordinates
  final LatLng addisAbaba = const LatLng(9.005401, 38.763611);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddisLink Driver'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () => context.push('/wallet'),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Background (Only visible when Online)
          if (isOnline)
            FlutterMap(
              options: MapOptions(
                initialCenter: addisAbaba,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.addislink.driver',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: addisAbaba,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.local_shipping, // Driver Icon
                        color: AppTheme.primary, 
                        size: 40
                      ),
                    ),
                  ],
                ),
              ],
            ),

          // Foreground Content
          Column(
            children: [
              // Online/Offline Toggle
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  boxShadow: isOnline ? [] : [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isOnline ? 'ONLINE' : 'OFFLINE',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: isOnline ? AppTheme.success : Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                    Switch(
                      value: isOnline,
                      onChanged: (val) {
                        setState(() {
                          isOnline = val;
                          if(isOnline) {
                             // Simulator job request coming in after 2 seconds
                             Future.delayed(const Duration(seconds: 2), () {
                               if(mounted) showDialog(context: context, builder: (_) => const JobRequestDialog());
                             });
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              if (isOnline) ...[
                 const SizedBox(height: 20),
                 Card(
                   margin: const EdgeInsets.symmetric(horizontal: 16),
                   color: AppTheme.surface.withOpacity(0.9),
                   child: const Padding(
                     padding: EdgeInsets.all(16),
                     child: Column(
                       children: [
                         Text('Queue Status'),
                         Text('You are in the Merkato Geofence Queue: #4', style: TextStyle(fontWeight: FontWeight.bold)),
                       ],
                     ),
                   ),
                 ),
                 
                 const Spacer(),
                 Container(
                   width: double.infinity,
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     color: AppTheme.surface,
                     boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
                   ),
                   child: const Text(
                     "Today's Earnings: 850 ETB", 
                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                     textAlign: TextAlign.center,
                   ),
                 ),
              ] else ...[
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text("You are offline"),
                      ],
                    ),
                  ),
                )
              ]
            ],
          ),
        ],
      ),
    );
  }
}
