import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter_dingdian/moudules/detail/model/directory_model.dart';
import 'package:flutter_dingdian/moudules/detail/model/info_model.dart';
import 'package:flutter_dingdian/moudules/read/model/content_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper = new DbHelper();
  static DbHelper instance = _dbHelper;

  final String _tableName = "books";
  final String _tableName1 = "chapters";

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
    String path = documentsDirectory.path + "/chapters.db";
    print("chapter $path");
    var db = await openDatabase(path, version: version, onCreate: _onCreate1);
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
        "sortTime INTEGER,"
        "bookStatus TEXT)");
    await db.execute("CREATE INDEX book_id_idx ON $_tableName (bookId);");
  }

  // When creating the db, create the table
  void _onCreate1(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $_tableName1("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "chapterId INTEGER,"
        "pId INTEGER,"
        "nId INTEGER,"
        "name TEXT,"
        "content TEXT,"
        "bookId INTEGER,"
        "hasContent INTEGER)");
    await db.execute("CREATE INDEX book_id_idx ON $_tableName1 (bookId);");
    await db
        .execute("CREATE INDEX chapter_id_idx ON $_tableName1 (chapterId);");
  }

  Future<Null> addBooks(List<BookDetailInfoModel> bks) async {
    var dbClient = await db;

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
        "sortTime": DateUtil.getNowDateMs(),
        "bookStatus": book.bookStatus,
      });
    }
    await batch.commit(noResult: true);
  }

  //获取所有图书
  //获取单本图书
  Future<List<BookDetailInfoModel>> getBooks() async {
    var dbClient = await db;
    List<BookDetailInfoModel> bks = [];
    var list = await dbClient
        .rawQuery("select * from $_tableName order by sortTime desc", []);
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
      bk.sortTime = item["sortTime"];
      bks.add(bk);
    }
    return bks;
  }

  //获取单本图书
  Future getBook(int bookId) async {
    var dbClient = await db;
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
      bk.sortTime = item["sortTime"];
    }
    return list.length > 0 ? bk : null;
  }

  //删除图书
  Future<Null> delBook(int bookId) async {
    var dbClient = await db;

    await dbClient
        .rawDelete('delete from $_tableName where bookId=?', [bookId]);
  }

  //更新图书信息
  Future<Null> updBook(String lastChapter, String lastTime, int lastChapterId,
      String bookStatus, int bookId) async {
    var dbClient = await db;
    dbClient.rawUpdate(
        "update $_tableName set lastChapter=?,lastTime=?,lastChapterId=?,bookStatus=? where bookId=?",
        [lastChapter, lastTime, lastChapterId, bookStatus, bookId]);
    print("更新数据成功");
  }

  //更新图书阅读信息
  Future<Null> updBookProcess(
      int cChapter, int cChapterPage, int bookId) async {
    var dbClient = await db;
    await dbClient.rawUpdate(
        "update $_tableName set cChapter=?,cChapterPage=? where bookId=?", [
      cChapter,
      cChapterPage,
      bookId,
    ]);
    print("更新图书进度成功");
  }

  Future<Null> sortBook(int bookId) async {
    var dbClient = await db;

    await dbClient.rawUpdate(
        'update  $_tableName set sortTime=${DateUtil.getNowDateMs()} where bookId=?',
        [bookId]);
  }

  /// 添加章节
  Future<Null> addChapters(List<TwoList> cps, String bookId) async {
    var dbClient = await db1;
    var batch = dbClient.batch();
    for (var i = 0; i < cps.length; i++) {
      TwoList chapter = cps[i];
      batch.rawInsert(
          'insert into $_tableName1 (chapterId,name,content,bookId,hasContent) values(?,?,?,?,?)',
          [chapter.id, chapter.name, "", bookId, chapter.hasContent]);
    }

    await batch.commit(noResult: true);
  }

  Future<List<TwoList>> getChapters(int bookId) async {
    var dbClient = await db1;
    var list = await dbClient.rawQuery(
        "select hasContent,chapterId,name from $_tableName1 where bookId=?",
        [bookId]);
    print(list);
    List<TwoList> cps = [];
    for (Map i in list) {
      TwoList cp = TwoList();
      cp.hasContent = i['hasContent'];
      cp.id = i['chapterId'];
      cp.name = i['name'];
      cps.add(cp);
    }
    return cps;
  }

  Future<BookChapterContentModel> getChapter(int chapterId) async {
    var dbClient = await db1;
    var list = await dbClient.rawQuery(
        "select pId,nId,name,content from $_tableName1 where chapterId=?",
        [chapterId]);
    print(list);
    BookChapterContentModel model = BookChapterContentModel();
    for (Map i in list) {
      print(i);
      model.cname = i["name"];
      model.content = i["content"];
      model.cid = chapterId;
      model.nid = i['nId'];
      model.pid = i['pId'];
      model.hasContent = 2;
    }
    return model;
  }

  // 清除章节
  Future<Null> clearChapters(int bookId) async {
    var dbClient = await db1;
    await dbClient
        .rawDelete("delete from $_tableName1 where bookId=?", [bookId]);
  }

  //更新章节
  Future<Null> udpChapter(
      String content, int pid, int nid, int chapterId) async {
    var dbClient = await db1;
    var batch = dbClient.batch();
    batch.rawUpdate(
        "update $_tableName1 set content=?,pId=?,nId=?,hasContent=2 where chapterId=?",
        [content, pid, nid, chapterId]);
    await batch.commit(noResult: true);
  }
}
