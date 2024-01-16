
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_flutter/db/database_sqlite.dart';

final databaseProvider = StateProvider((ref) => SQLHelper());