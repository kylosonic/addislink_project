import 'package:flutter/material.dart';
import 'package:addislink_shared/addislink_shared.dart';

class ActiveTripScreen extends StatefulWidget {
  const ActiveTripScreen({super.key});

  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  // Mock timer logic would go here
  int minutes = 12;

  @override
  Widget build(BuildContext context) {
    bool isOvertime = minutes > 30;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Active Trip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Card(
               color: isOvertime ? AppTheme.error.withOpacity(0.1) : AppTheme.success.withOpacity(0.1),
               child: Padding(
                 padding: const EdgeInsets.all(32.0),
                 child: Column(
                   children: [
                     const Text('Loading Time'),
                     Text(
                       '$minutes:00', 
                       style: TextStyle(
                         fontSize: 48, 
                         fontWeight: FontWeight.bold,
                         color: isOvertime ? AppTheme.error : AppTheme.success
                       )
                     ),
                     if(isOvertime)
                       const Text('BILLABLE TIME', style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.bold)),
                   ],
                 ),
               ),
             ),
             const Spacer(),
             Row(
               children: [
                 Expanded(
                   child: ElevatedButton(
                     onPressed: () {},
                     child: const Text('Start Trip'),
                   ),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
                     onPressed: () => Navigator.pop(context),
                     child: const Text('End Trip'),
                   ),
                 ),
               ],
             )
          ],
        ),
      ),
    );
  }
}
