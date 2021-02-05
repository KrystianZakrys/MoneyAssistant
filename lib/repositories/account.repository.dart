import 'package:sqflite/sqflite.dart';

import '../context.dart';
import '../models/account.dart';

class AccountRepository {
  AccountRepository._();

  final dbContext = Context.instance;
  static final AccountRepository instance = AccountRepository._();

  Future<Account> upsert(Account entity) async {
    Database db = await dbContext.db;
    var count = 0;
    if (entity.id != null) {
      count = Sqflite.firstIntValue(await db
          .rawQuery("SELECT COUNT(*) FROM Account WHERE Id = ?", [entity.id]));
    }

    if (count == 0) {
      entity.id = await db.insert("Account", entity.toMap());
    } else {
      await db.update("Account", entity.toMap(),
          where: "Id = ?", whereArgs: [entity.id]);
    }

    return entity;
  }

  Future<Account> fetch(int id) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("Account",
        columns: Account.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = Account.fromMap(results[0]);

    return entity;
  }

  Future<List<Account>> fetchAll(int limit) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("Account",
        columns: Account.columns, limit: limit, orderBy: "Id DESC");

    List<Account> entities = [];
    results.forEach((result) {
      Account story = Account.fromMap(result);
      entities.add(story);
    });

    return entities;
  }
}
