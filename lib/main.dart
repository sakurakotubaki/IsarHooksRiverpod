import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_hooks/domain/person.dart';
import 'package:isar_hooks/screen/add_page.dart';
import 'package:isar_hooks/utils/db_service.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Isarの初期化
  WidgetsFlutterBinding.ensureInitialized();
  // アプリのドキュメントディレクトリを取得
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [PersonSchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      // overrides:は、Providerの値を上書きするためのものです。
      // overrideWithValueは、上書きする値を指定するためのものです。
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: MyApp(isar: isar),
    ),
  );
}


class MyApp extends StatelessWidget {
  final Isar isar;

  MyApp({required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddPage(isar: isar),
    );
  }
}
