import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Temp Screen'),
            TextButton(
                onPressed: () {
                  printNavigationStack(context);
                },
                child: const Text('Push')),
            TextButton(onPressed: () {}, child: const Text('Pop')),
            TextButton(onPressed: () {}, child: const Text('Empty')),
          ],
        ),
      ),
    );
  }
}
