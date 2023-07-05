import 'package:asistencia_app/apis/escuela_api.dart';
import 'package:asistencia_app/local/db/database.dart';
import 'package:asistencia_app/modelo/EscuelaModelo.dart';
import 'package:asistencia_app/util/NetworConnection.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class EscuelaRepository{
  EscuelaApi? escuelaApi;

  EscuelaRepository(){
    Dio _dio=Dio();
    _dio.options.headers["Content-Type"]="application/json";
    escuelaApi=EscuelaApi(_dio);
  }

  Future<AppDatabase> conection() async{
    return await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  }

  Future<List<EscuelaModelo>> getEscuela() async {
    final database=await conection();
    final escuelaDao = database.escuelaDao;
    if(await isConected()) {
      var dato = await escuelaApi!.getEscuela(TokenUtil.TOKEN).then((
          value) => value.data);
      dato.forEach((el) async {
        await escuelaDao.insertarEscuela(new EscuelaModelo(id: el.id,
            nombreeap: el.nombreeap,
            estado: el.estado,
            inicialeseap: el.inicialeseap,
            facultad_nom: el.facultad_nom,
            ));
      });
      return dato;
    }else{
      return await escuelaDao.listarEscuela();
    }
  }

  Future<RespEscuelaModelo> deleteEscuela(int id) async{
    return await escuelaApi!.deleteEscuela(TokenUtil.TOKEN, id);
  }

  Future<RespEscuelaModelo> updateEscuela(int id, EscuelaModelo escuela) async{
    return await escuelaApi!.updateEscuela(TokenUtil.TOKEN, id, escuela);
  }

  Future<RespEscuelaModelo> createEscuela(EscuelaModelo escuela) async{
    return await escuelaApi!.createEscuela(TokenUtil.TOKEN,escuela);
  }

}