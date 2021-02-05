import 'package:sqflite/sqflite.dart';

import '../providers/context.dart';
import '../../models/expense.dart';

class ExpenseRepository {
  ExpenseRepository._();

  final dbContext = Context.instance;
  static final ExpenseRepository instance = ExpenseRepository._();

  Future<Expense> upsert(Expense entity) async {
    Database db = await dbContext.db;
    var count = 0;
    if (entity.id != null) {
      count = Sqflite.firstIntValue(await db
          .rawQuery("SELECT COUNT(*) FROM Expense WHERE Id = ?", [entity.id]));
    }

    if (count == 0) {
      entity.id = await db.insert("Expense", entity.toMap());
    } else {
      await db.update("Expense", entity.toMap(),
          where: "Id = ?", whereArgs: [entity.id]);
    }

    return entity;
  }

  Future<Expense> fetch(int id) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("Expense",
        columns: Expense.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = Expense.fromMap(results[0]);

    return entity;
  }

  Future<List<Expense>> fetchAll(int limit) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("Expense",
        columns: Expense.columns, limit: limit, orderBy: "Id DESC");

    List<Expense> entities = [];
    results.forEach((result) {
      Expense story = Expense.fromMap(result);
      entities.add(story);
    });

    return entities;
  }
}
