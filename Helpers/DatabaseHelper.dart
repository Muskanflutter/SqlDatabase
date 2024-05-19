import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{
  Database? db;

 Future<Database> create_db() async {
    if(db!=null)
      {
        return db!;
      }
    else
      {
        Directory dir = await getApplicationDocumentsDirectory();
        String path = join(dir.path,"first_db");
         db = await openDatabase(path,version: 1,onCreate: create_table);

        return db!;
      }


  }
  create_table(Database db , int version)
  {
    db!.execute("create table products(pid integer primary key autoincrement,pname text,pprice text,pqty text)");
    db!.execute("create table stu(pid integer primary key autoincrement,pname text,pprice text,pqty text)");

    print("table created");

  }
  // crud create read update delete
  Future<List> getData() async
  {
    var db = await create_db();
    var data = await db!.rawQuery("SELECT * FROM products");
    return data.toList();

  }
  Future<int> insertData(prnm,prpc,prqu) async
  {
   var db =  await create_db();
    var id = db!.rawInsert("insert into products(pname,pprice,pqty) values (?,?,?)",[prnm,prpc,prqu]);
    return id;
  }
  Future<int> deleteData(proid)async
  {
    var db =  await create_db();
    var status = await db!.rawDelete("delete from products where pid=?",[proid]);
    return status;

  }
   Future<int> updateData(proid,nm,pr,qty) async
  {
    var db = await create_db();
    var status = db!.rawUpdate("Update products set pname=?,pprice=? , pqty=? where pid=?",[nm,pr,qty,proid]);
    return status;

  }
  Future<List> getSigleData(proid) async
  {
    var db =  await create_db();
   var list = await db.rawQuery("Select * from products where pid=?",[proid]);
   return list.toList();

  }
}