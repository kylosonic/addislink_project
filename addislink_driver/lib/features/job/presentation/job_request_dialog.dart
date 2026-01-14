import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:addislink_shared/addislink_shared.dart';

class JobRequestDialog extends StatelessWidget {
  const JobRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Job Request!', style: TextStyle(color: AppTheme.primary)),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Merkato -> Bole'),
            subtitle: Text('5 km • Isuzu NPR'),
          ),
          Divider(),
          Text('Estimated Fare', style: TextStyle(color: Colors.grey)),
          Text('850 ETB', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.success)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Decline', style: TextStyle(color: AppTheme.error)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.success),
          onPressed: () {
             Navigator.pop(context);
             context.push('/trip');
          },
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }
}
