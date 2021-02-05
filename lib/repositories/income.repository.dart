import 'package:sqflite/sqflite.dart';

import '../context.dart';
import '../models/income.dart';

class IncomeRepository {
  IncomeRepository._();

  final dbContext = Context.instance;
  static final IncomeRepository instance = IncomeRepository._();

  Future<Income> upsert(Income entity) async {
    Database db = await dbContext.db;
    var count = 0;
    if (entity.id != null) {
      count = Sqflite.firstIntValue(await db
          .rawQuery("SELECT COUNT(*) FROM Income WHERE Id = ?", [entity.id]));
    }

    if (count == 0) {
      entity.id = await db.insert("Income", entity.toMap());
    } else {
      await db.update("Income", entity.toMap(),
          where: "Id = ?", whereArgs: [entity.id]);
    }

    return entity;
  }

  Future<Income> fetch(int id) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("Income",
        columns: Income.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = Income.fromMap(results[0]);

    return entity;
  }

  Future<List<Income>> fetchAll(int limit) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("Income",
        columns: Income.columns, limit: limit, orderBy: "Id DESC");

    List<Income> entities = [];
    results.forEach((result) {
      Income story = Income.fromMap(result);
      entities.add(story);
    });

    return entities;
  }
}
