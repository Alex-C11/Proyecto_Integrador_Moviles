// required package imports
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:asistencia_app/local/dao/ActividadDao.dart';
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:asistencia_app/local/dao/EscuelaDao.dart';
import 'package:asistencia_app/modelo/EscuelaModelo.dart';
import 'package:floor/floor.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ActividadModelo,EscuelaModelo])
abstract class AppDatabase extends FloorDatabase{
  ActividadDao get actividadDao;
  EscuelaDao get escuelaDao;
}