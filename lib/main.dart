import 'package:flutter/material.dart';
import "package:dotted_border/dotted_border.dart";
import 'package:flutter/services.dart';
import 'package:lang/providers/verbprovider.dart';
import 'package:lang/ui/home.dart';
import 'package:lang/ui/widgets/answer.dart';
import 'package:lang/utils/setup.dart';
import "package:provider/provider.dart";

void main() {
  setup();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerbProvider>(
        create: (_) => backend<VerbProvider>(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        ));
  }
}
