import 'dart:io';

import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper = new DbHelper();
  static DbHelper instance = _dbHelper;

  final String _chapterName = "chapters";
  final String _tableName = "books";

  static Database? _db;
  static Database? _db1;
  int version = 3;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();

    return _db!;
  }

  Future<Database> get db1 async {
    if (_db1 != null) {
      return _db1!;
    }
    _db1 = await _initDb1();
    return _db1!;
  }

  //初始化数据库
  _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/books.db";
    print("chapter $path");
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  //初始化数据库
  _initDb1() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/books.db";
    print("chapter $path");
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $_tableName("
        "id INTEGER   PRIMARY KEY AUTOINCREMENT,"
        "bookId INTEGER,"
        "name TEXT,"
        "author TEXT,"
        "img TEXT,"
        "desc TEXT,"
        "cId INTEGER,"
        "cName TEXT,"
        "lastTime TEXT,"
        "firstChapterId INTEGER,"
        "lastChapter TEXT,"
        "lastChapterId INTEGER,"
        "cChapter INTEGER,"
        "cChapterPage INTEGER,"
        "bookStatus TEXT)");
    await db.execute("CREATE INDEX book_id_idx ON $_tableName (bookId);");
  }

  Future<Null> addBooks(List<BookDetailInfoModel> bks) async {
    var dbClient = await db1;

    var batch = dbClient.batch();

    for (BookDetailInfoModel book in bks) {
      batch.insert("$_tableName", {
        "bookId": book.id,
        "name": book.name,
        "author": book.author,
        "img": book.img,
        "desc": book.desc,
        "cId": book.cId,
        "cName": book.cName,
        "lastTime": book.lastTime,
        "firstChapterId": book.firstChapterId,
        "lastChapter": book.lastChapter,
        "lastChapterId": book.lastChapterId,
        "cChapter": book.cChapter ?? 0,
        "cChapterPage": book.cChapterPage ?? 0,
        "bookStatus": book.bookStatus,
      });
    }
    await batch.commit(noResult: true);
  }

  //获取所有图书
  //获取单本图书
  Future<List<BookDetailInfoModel>> getBooks(int bookId) async {
    var dbClient = await db1;
    List<BookDetailInfoModel> bks = [];
    var list = await dbClient
        .rawQuery("select * from $_tableName where bookId=?", [bookId]);
    for (Map item in list) {
      BookDetailInfoModel bk = BookDetailInfoModel();
      bk.id = item["bookId"];
      bk.name = item["name"];
      bk.author = item["author"];
      bk.desc = item["desc"];
      bk.img = item["img"];
      bk.cId = item["cId"];
      bk.cName = item["cName"];
      bk.lastTime = item["lastTime"];
      bk.firstChapterId = item["firstChapterId"];
      bk.lastChapter = item["lastChapter"];
      bk.lastChapterId = item["lastChapterId"];
      bk.bookStatus = item["bookStatus"];
      bk.cChapter = item["cChapter"];
      bk.cChapterPage = item["cChapterPage"];
      bks.add(bk);
    }
    return bks;
  }

  //获取单本图书
  Future getBook(int bookId) async {
    var dbClient = await db1;
    BookDetailInfoModel? bk = BookDetailInfoModel();
    var list = await dbClient
        .rawQuery("select * from $_tableName where bookId=?", [bookId]);
    for (Map item in list) {
      bk.id = item["bookId"];
      bk.name = item["name"];
      bk.author = item["author"];
      bk.desc = item["desc"];
      bk.img = item["img"];
      bk.cId = item["cId"];
      bk.cName = item["cName"];
      bk.lastTime = item["lastTime"];
      bk.firstChapterId = item["firstChapterId"];
      bk.lastChapter = item["lastChapter"];
      bk.lastChapterId = item["lastChapterId"];
      bk.bookStatus = item["bookStatus"];
      bk.cChapter = item["cChapter"];
      bk.cChapterPage = item["cChapterPage"];
    }
    return list.length > 0 ? bk : null;
  }

  //删除图书
  Future<Null> delBook(int bookId) async {
    var dbClient = await db1;

    await dbClient
        .rawDelete('delete from $_tableName where bookId=?', [bookId]);
  }

  //更新图书信息
  Future<Null> updBook(String lastChapter, String lastTime, int lastChapterId,
      String bookStatus, int bookId) async {
    var dbClient = await db1;
    dbClient.rawUpdate(
        "update $_tableName set lastChapter=?,lastTime=?,lastChapterId=?,bookStatus=? where bookId=?",
        [lastChapter, lastTime, lastChapterId, bookStatus, bookId]);
    print("更新数据成功");
  }

  //更新图书阅读信息
  Future<Null> updBookProcess(
      int cChapter, int cChapterPage, int bookId) async {
    var dbClient = await db1;
    await dbClient.rawUpdate(
        "update $_tableName set cChapter=?,cChapterPage=? where bookId=?", [
      cChapter,
      cChapterPage,
      bookId,
    ]);
    print("更新图书进度成功");
  }
}
