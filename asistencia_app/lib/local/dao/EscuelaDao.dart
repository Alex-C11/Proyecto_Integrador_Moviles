import 'package:asistencia_app/modelo/EscuelaModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class EscuelaDao{

  @Query('SELECT * FROM escuela')
  Future<List<EscuelaModelo>> listarEscuela();

  @Query('SELECT * FROM escuela where id=:id')
  Stream<EscuelaModelo?> buscarEscuelaId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertarEscuela(EscuelaModelo escuela);

  @update
  Future<void> updateEscuela(EscuelaModelo escuela);

  @delete
  Future<void> deleteEscuela(EscuelaModelo escuela);
}