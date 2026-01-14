import 'package:flutter/material.dart';
import 'package:addislink_shared/addislink_shared.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Addis Ababa Coordinates
    final LatLng addisAbaba = const LatLng(9.005401, 38.763611);

    return Scaffold(
      appBar: AppBar(title: const Text('AddisLink Retailer')),
      body: Stack(
        children: [
          // OpenStreetMap View
          FlutterMap(
            options: MapOptions(
              initialCenter: addisAbaba, // Center on Addis Ababa
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.addislink.retailer',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: addisAbaba,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on, 
                      color: AppTheme.accent, 
                      size: 40
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Vehicle Selector Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      'Select Vehicle', 
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    ListTile(
                      leading: SvgPicture.asset(AppIcons.moto, width: 40),
                      title: const Text('Moto'),
                      subtitle: const Text('Docs/Spare parts'),
                      trailing: const Text('400-600 ETB'),
                      onTap: () => context.push('/booking'),
                    ),
                     ListTile(
                      leading: SvgPicture.asset(AppIcons.bajaj, width: 40),
                      title: const Text('Bajaj'),
                      subtitle: const Text('Small restocking'),
                      trailing: const Text('600-900 ETB'),
                      onTap: () => context.push('/booking'),
                    ),
                     ListTile(
                      leading: SvgPicture.asset(AppIcons.damas, width: 40),
                      title: const Text('Damas'),
                      subtitle: const Text('Standard Souq'),
                      trailing: const Text('1k-1.5k ETB'),
                      onTap: () => context.push('/booking'),
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
}
