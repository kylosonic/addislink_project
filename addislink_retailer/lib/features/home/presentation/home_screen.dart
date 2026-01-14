import 'package:flutter/material.dart';
import 'package:addislink_shared/addislink_shared.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedVehicleIndex = 0; // Default selected

  @override
  Widget build(BuildContext context) {
    final LatLng addisAbaba = const LatLng(9.005401, 38.763611);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppTheme.softShadow,
          ),
          child: const Text('AddisLink', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // Map View
          FlutterMap(
            options: MapOptions(
              initialCenter: addisAbaba,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.addislink.retailer',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: addisAbaba,
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.location_on, color: AppTheme.primary, size: 40),
                  ),
                ],
              ),
            ],
          ),
          
          // Vehicle Selector Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  children: [
                    // Grab Handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        width: 40, height: 4,
                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                      ),
                    ),

                    Text('Select Vehicle', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),

                    _buildVehicleCard(0, 'Moto', 'Docs/Spare parts', '400-600', AppIcons.moto),
                    const SizedBox(height: 12),
                    _buildVehicleCard(1, 'Bajaj', 'Small restocking', '600-900', AppIcons.bajaj),
                    const SizedBox(height: 12),
                    _buildVehicleCard(2, 'Damas', 'Standard Souq', '1k-1.5k', AppIcons.damas),
                    const SizedBox(height: 12),
                    _buildVehicleCard(3, 'Pickup', 'Construction', '2k-3k', AppIcons.pickup),
                    
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => context.push('/booking'),
                      child: const Text('CONTINUE'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(int index, String title, String subtitle, String price, String iconPath) {
    final isSelected = selectedVehicleIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedVehicleIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accent.withOpacity(0.05) : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.accent : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppTheme.softShadow : [],
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, width: 48),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('ETB', style: TextStyle(color: Colors.grey[500], fontSize: 10, fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
