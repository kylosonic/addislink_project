import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Details')),
      body: Center(
        child: Column(
          children: [
             const Text('Booking Form Placeholder'),
             ElevatedButton(
               onPressed: () => context.push('/tracking'), 
               child: const Text('Confirm Booking'),
             ),
          ],
        ),
      ),
    );
  }
}
