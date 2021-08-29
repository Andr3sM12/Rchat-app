import 'package:flutter/material.dart';
import 'package:cham_app/composition_root.dart';
import 'package:cham_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  // final firstPage = CompositionRoot.start();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Widget firstPage;

  // MyApp(this.firstPage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cham Chat',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: CompositionRoot.composeOnboardingUi(),
    );
  }
}
