import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_hooks/domain/person.dart';
import 'package:isar_hooks/screen/read_page.dart';
import 'package:isar_hooks/utils/db_service.dart';

class AddPage extends HookConsumerWidget {
  const AddPage({Key? key, required this.isar}) : super(key: key);

  final Isar isar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('メモ追加'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.amber,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.amber,
                      )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  // Personクラスのインスタンスを作成
                  final person = Person()..name = nameController.text;
                  // 入力後にテキストフィールドを空にする
                  ref.read(dbServiceProvider).addData(person);
                  nameController.clear();
                },
                child: const Text('追加')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReadPage(isar: isar),
                    ),
                  );
                },
                child: const Text('一覧へ'))
          ],
        ),
      ),
    );
  }
}
