import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_hooks/domain/person.dart';
import 'package:isar_hooks/utils/db_service.dart';

class ReadPage extends HookConsumerWidget {
  const ReadPage({super.key, required this.isar});

  final Isar isar; // Isarのインスタンスを受け取るための変数

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Person> persons = [];をuseStateで書き換えます
    final persons = useState<List<Person>>([]);

    // データベースの中身を取得する関数
    Future<void> loadData() async {
      final data = await isar.persons.where().findAll();
      persons.value = data;
    }

    useEffect(() {
      loadData();
      return null;
    }, []); // ここで空の配列を渡すことで、画面が表示される前に一度だけ実行されるようになります

    return Scaffold(
      appBar: AppBar(title: const Text('データを表示')),
      body: ListView.builder(
        itemCount: persons.value.length,
        itemBuilder: (context, index) {
          final person = persons.value[index];
          return ListTile(
              title: Text(person.name ?? "値が入ってません"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  // ここでデータベースから削除しています
                  ref.read(dbServiceProvider).deleteData(person);
                  loadData();
                },
              ));
        },
      ),
    );
  }
}
