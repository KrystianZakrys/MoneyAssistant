import 'dart:io';
import 'package:money_assistant/src/models/income.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/account.dart';
import '../../models/expense.dart';
import '../../models/expense_category.dart';
import '../../models/income_category.dart';

class Context {
  static final _databaseName = "MoneyAssistant";
  static final _databaseVersion = 1;

  static final _accountTable = '''
        CREATE TABLE Account (
          Name string,
          Id integer PRIMARY KEY AUTOINCREMENT,
          Balance double,
          Type string,
          Icon text,
          CardLimit double,
          IsCountedInTotal boolean
        );
    ''';

  static final _expenseCategoryTable = '''
      CREATE TABLE ExpenseCategory (
        Id integer PRIMARY KEY AUTOINCREMENT,
        Name string,
        Description text,
        SubCategoryId integer
    );
    ''';

  static final _incomeCategoryTable = '''CREATE TABLE IncomeCategory (
	Id integer PRIMARY KEY AUTOINCREMENT,
	Name string,
	Description text,
	SubCategoryId integer
);''';

  static final _incomeTable = '''CREATE TABLE Income (
	Id integer PRIMARY KEY AUTOINCREMENT,
	Name string,
	Description text,
	CategoryId integer,
	Amount double,
	Date datetime,
	AccountId integer
);''';

  static final _expenseTable = '''CREATE TABLE Expense (
	Id integer PRIMARY KEY AUTOINCREMENT,
	Name string,
	Description string,
	CategoryId integer,
	Amount double,
	Date datetime,
	AccountId integer
);''';

  Context._();

  static final Context instance = Context._();

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //Create tables
    await db.execute(_accountTable);
    await db.execute(_expenseCategoryTable);
    await db.execute(_incomeCategoryTable);
    await db.execute(_incomeTable);
    await db.execute(_expenseTable);
  }

  //Input or update account
  Future<Account> upsertAccount(Account entity) async {
    Database db = await instance.db;
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

//Input or update Income
  Future<Income> upsertIncome(Income entity) async {
    Database db = await instance.db;
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

//Input or update Expense
  Future<Expense> upsertExpense(Expense entity, String tableName) async {
    Database db = await instance.db;
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

//Input or update IncomeCategory
  Future<IncomeCategory> upsertIncomeCategory(
      IncomeCategory entity, String tableName) async {
    Database db = await instance.db;
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

//Input or update ExpenseCategory
  Future<ExpenseCategory> upsertExpenseCategory(
      ExpenseCategory entity, String tableName) async {
    Database db = await instance.db;
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

  //Get single by id
  //Account
  Future<Account> fetchAccount(int id) async {
    Database db = await instance.db;
    List<Map> results = await db.query("Account",
        columns: Account.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = Account.fromMap(results[0]);

    return entity;
  }

  //Income
  Future<Income> fetchIncome(int id) async {
    Database db = await instance.db;
    List<Map> results = await db.query("Income",
        columns: Income.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = Income.fromMap(results[0]);

    return entity;
  }

  //Expense
  Future<Expense> fetchExpense(int id) async {
    Database db = await instance.db;
    List<Map> results = await db.query("Expense",
        columns: Expense.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = Expense.fromMap(results[0]);

    return entity;
  }

  //IncomeCategory
  Future<IncomeCategory> fetchIncomeCategory(int id) async {
    Database db = await instance.db;
    List<Map> results = await db.query("IncomeCategory",
        columns: IncomeCategory.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = IncomeCategory.fromMap(results[0]);

    return entity;
  }

  //ExpenseCategory
  Future<ExpenseCategory> fetchExpenseCategory(int id) async {
    Database db = await instance.db;
    List<Map> results = await db.query("ExpenseCategory",
        columns: ExpenseCategory.columns, where: "Id = ?", whereArgs: [id]);

    dynamic entity = ExpenseCategory.fromMap(results[0]);

    return entity;
  }

  //Get all
  //Accounts
  Future<List<Account>> fetchAccounts(int limit) async {
    Database db = await instance.db;
    List<Map> results = await db.query("Account",
        columns: Account.columns, limit: limit, orderBy: "Id DESC");

    List<Account> entities = [];
    results.forEach((result) {
      Account story = Account.fromMap(result);
      entities.add(story);
    });

    return entities;
  }

  //Incomes
  Future<List<Income>> fetchIncomes(int limit) async {
    Database db = await instance.db;
    List<Map> results = await db.query("Income",
        columns: Income.columns, limit: limit, orderBy: "Id DESC");

    List<Income> entities = [];
    results.forEach((result) {
      Income story = Income.fromMap(result);
      entities.add(story);
    });

    return entities;
  }

  //Expenses
  Future<List<Expense>> fetchExpenses(int limit) async {
    Database db = await instance.db;
    List<Map> results = await db.query("Expense",
        columns: Expense.columns, limit: limit, orderBy: "Id DESC");

    List<Expense> entities = [];
    results.forEach((result) {
      Expense story = Expense.fromMap(result);
      entities.add(story);
    });

    return entities;
  }

  //IncomeCategories
  Future<List<IncomeCategory>> fetchIncomeCategories(int limit) async {
    Database db = await instance.db;
    List<Map> results = await db.query("IncomeCategory",
        columns: IncomeCategory.columns, limit: limit, orderBy: "Id DESC");

    List<IncomeCategory> entities = [];
    results.forEach((result) {
      IncomeCategory story = IncomeCategory.fromMap(result);
      entities.add(story);
    });

    return entities;
  }

  //ExpenseCategories
  Future<List<ExpenseCategory>> fetchExpenseCategories(int limit) async {
    Database db = await instance.db;
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
