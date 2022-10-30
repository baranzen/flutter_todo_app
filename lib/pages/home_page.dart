import 'package:flutter/material.dart';
import 'package:flutter_todo_app/widgets/bottom_sheet.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#BAD1C2'),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Today Todos'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //show bottom sheet
                buildBottomSheet(context);
              },
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: HomePageBody(),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          Text(
            'hello',
          ),
        ],
      ),
    );
  }
}
