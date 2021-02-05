import 'package:sqflite/sqflite.dart';

import '../providers/context.dart';
import '../../models/income_category.dart';

class IncomeCategoryRepository {
  IncomeCategoryRepository._();

  final dbContext = Context.instance;
  static final IncomeCategoryRepository instance = IncomeCategoryRepository._();

  Future<IncomeCategory> upsert(IncomeCategory entity) async {
    Database db = await dbContext.db;
    var count = 0;
    if (entity.id != null) {
      count = Sqflite.firstIntValue(await db.rawQuery(
          "SELECT COUNT(*) FROM IncomeCategory WHERE Id = ?", [entity.id]));
    }

    if (count == 0) {
      entity.id = await db.insert("IncomeCategory", entity.toMap());
    } else {
      await db.update("IncomeCategory", entity.toMap(),
          where: "Id = ?", whereArgs: [entity.id]);
    }

    return entity;
  }

  Future<IncomeCategory> fetch(int id) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("IncomeCategory",
        columns: IncomeCategory.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = IncomeCategory.fromMap(results[0]);

    return entity;
  }

  Future<List<IncomeCategory>> fetchAll(int limit) async {
    Database db = await dbContext.db;
    List<Map> results = await db.query("IncomeCategory",
        columns: IncomeCategory.columns, limit: limit, orderBy: "Id DESC");

    List<IncomeCategory> entities = [];
    results.forEach((result) {
      IncomeCategory story = IncomeCategory.fromMap(result);
      entities.add(story);
    });

    return entities;
  }
}
