import 'package:flutter/cupertino.dart';

import '../widgets/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Today\'s Todo'),
      ),
      child: HomePageBody(),
    );
  }
}
