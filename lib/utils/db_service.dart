import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_hooks/domain/person.dart';
// isarパッケージをインポートする
final dbServiceProvider = Provider<DbService>((ref) => DbService(ref.read(isarProvider)));

final isarProvider = Provider<Isar>((ref) {
  // UnimplementedErrorは、この関数が呼ばれたらエラーを投げるという意味です。
  throw UnimplementedError();
});

class DbService {
  DbService(this.isar);

  final Isar isar;
  // isarにデータを追加する関数
  Future<void> addData(Person person) async {
    await isar.writeTxn(() async {
      await isar.persons.put(person);
    });
  }
  // isarからデータを削除する関数
  Future<void> deleteData(Person person) async {
    await isar.writeTxn(() async {
      await isar.persons.delete(person.id);
    });
  }
}
