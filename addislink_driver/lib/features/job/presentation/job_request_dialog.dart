import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:addislink_shared/addislink_shared.dart';

class JobRequestSheet extends StatelessWidget {
  const JobRequestSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 34),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          
          Text('New Job Request', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),

          // Route Visualization
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(Icons.circle, size: 12, color: AppTheme.primary),
                  Container(width: 2, height: 30, color: Colors.grey[300]),
                  const Icon(Icons.location_on, size: 16, color: AppTheme.accent),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pickup
                    Text('Merkato, Addis Ketema', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                    Text('2.5 km away', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 24),
                    // Dropoff
                    Text('Bole International Airport', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                    Text('Standard Cargo • 120 kg', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              // Fare
               Center(
                 child: Text(
                   '850\nETB', 
                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.success),
                   textAlign: TextAlign.center,
                 ),
               ),
            ],
          ),
          
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Decline', style: TextStyle(color: Colors.black54)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2, // Larger Accept button
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.push('/trip');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.success,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('ACCEPT JOB', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
