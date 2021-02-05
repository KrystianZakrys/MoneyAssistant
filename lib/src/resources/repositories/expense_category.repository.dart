import 'package:sqflite/sqflite.dart';

import '../providers/context.dart';
import '../../models/expense_category.dart';

class ExpenseCategoryRepository {
  ExpenseCategoryRepository._();

  final dbContext = Context.instance;
  static final ExpenseCategoryRepository instance =
      ExpenseCategoryRepository._();

  Future<ExpenseCategory> upsert(ExpenseCategory entity) async {
    Database db = await dbContext.db;
    var count = 0;
    if (entity.id != null) {
      count = Sqflite.firstIntValue(await db.rawQuery(
          "SELECT COUNT(*) FROM ExpenseCategory WHERE Id = ?", [entity.id]));
    }

    if (count == 0) {
      entity.id = await db.insert("ExpenseCategory", entity.toMap());
    } else {
      await db.update("ExpenseCategory", entity.toMap(),
          where: "Id = ?", whereArgs: [entity.id]);
    }

    return entity;
  }

  Future<ExpenseCategory> fetch(int id) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("ExpenseCategory",
        columns: ExpenseCategory.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = ExpenseCategory.fromMap(results[0]);

    return entity;
  }

  Future<List<ExpenseCategory>> fetchAll(int limit) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("ExpenseCategory",
        columns: ExpenseCategory.columns, limit: limit, orderBy: "Id DESC");

    List<ExpenseCategory> entities = [];
    results.forEach((result) {
      ExpenseCategory story = ExpenseCategory.fromMap(result);
      entities.add(story);
    });

    return entities;
  }
}
