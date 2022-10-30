import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

buildBottomSheet(context) => showModalBottomSheet(
      backgroundColor: HexColor('#BAD1C2').withOpacity(0.8),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Todo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
