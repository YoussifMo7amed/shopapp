// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/network/local/cache.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(Appinitialstates());
  static Appcubit get(context) => BlocProvider.of(context);
    var titlecontroller = TextEditingController();
  var timingcontroller = TextEditingController();
  var datecontroller = TextEditingController();
List<Map> Newtasks=[];
List<Map> Donetasks=[];
List<Map> Archivedtasks=[];
Database? database;
  int currentIndex = 0;
  List<Widget> Screens = [

  ];
  List<String> tittle = [
    'New Tasks',
   'Done Tasks',
   'Archived Tasks'
   ];
  void changeIndex(int index)
  {
    currentIndex=index;
    emit(AppchangeButtomNavBarState());
  }
  void createdatabase()  {
   openDatabase(
    'Todo.db',
    version: 1,
    onCreate: (database, version) {
      //id integer
      //tittle string
      //date string
      //time string
      //status string
      database
          .execute(
              'CREATE TABLE Tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT )')
          .then((value) {
      }).catchError((error) {
      });
    },
    onOpen: (database) {
      getfromdatabase(database);
    },
  ).then((value) {
    database=value;
    emit(AppCreateDatabasestate());
  });
}

  void  insertTodatabase({
  required String title,
  required String date,
  required String time,
}) async {
 await database!.transaction((txn)async {
    txn
        .rawInsert(
            'INSERT INTO Tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
        .then((value) {
      // ignore: avoid_print
      print('$value inserted successfully');
      emit(AppInsertDatabasestate());
      getfromdatabase(database);
    }).catchError((error) {
    });
return null;
  });
}

void getfromdatabase(database)  {
  Newtasks=[];
  Donetasks=[];
  Archivedtasks=[];
  emit(AppGetDatabaseLoadingstate());
  database!.rawQuery('SELECT * FROM Tasks').then((value) {
         value.forEach((element) {
        if(element['status']=='new')
        {
Newtasks.add(element);
        }
        else if(element['status']=='done')
        {
Donetasks.add(element);
        }
        else
        {
          Archivedtasks.add(element);
        }
      });
        emit(AppGetDatabasestate());
        clearBottomsheetstates();
      });
}
void updateData({
  required String status,
  required int id,
})
{
   database!.rawUpdate(
    'UPDATE Tasks SET status = ? WHERE id = ?',
    [status, id]).then((value) {
      getfromdatabase(database);
      emit(AppUpdateDatabasestate());
    
    });
}
void deleteData({
  required int id,
})
{
   database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getfromdatabase(database);
      emit(AppDeleteDatabasestate());
    
    });
}

bool isbottomsheetshown = false;
IconData fabIcon = Icons.edit;


void changeBottomsheetstates({
  required bool isshow,
  required IconData icon
})
{
isbottomsheetshown=isshow;
fabIcon=icon;
emit(AppchangeButtomSheetState());
}
void clearBottomsheetstates()
{

timingcontroller.clear();
titlecontroller.clear();
datecontroller.clear();
emit(AppclearBottomsheetstate());
}
bool isdark=false;
void changetheme({bool ?fromshare})
{
  if(fromshare !=null)
  {
    isdark=fromshare;
    emit(AppchangeThemeState());
  }
  else{
 isdark=!isdark;
  casheHealper.putboolean(key: 'isdark',value:isdark).then((value) {
emit(AppchangeThemeState());
  });
  
  }
 
}
}
