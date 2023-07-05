import 'dart:convert';


import 'package:asistencia_app/modelo/EscuelaModeloFire.dart';
import 'package:asistencia_app/util/NetworConnection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EscuelaFireRepository{
  CollectionReference db=FirebaseFirestore.instance.collection("escuela");

  Future<List<EscuelaModeloFire>> getEscuela() async{
    print("Holas: Fire");
    if(await isConected()){
      print("Holas: Fire2");
      var data=await db.get();
      var escuela=data.docs.map((e){
        //var datax=e.data() as ActividadModeloFire;
        print("Holas: Fire2 ${json.encode(e.data())}");
        Map<String, dynamic> jsonMap = jsonDecode(json.encode(e.data()));
        EscuelaModeloFire eventData = EscuelaModeloFire.fromJson(jsonMap);
        eventData.id=e.id;
        return eventData;
      }).toList();
      return escuela;
    }else{
      return null!;
    }
  }

  Future<void> crearEscuela(EscuelaModeloFire act) async{
    if(await isConected()){
      return await db.add(act.toMap())
          .then((value) => print("Holas: ${value.id}"))
          .catchError((onError)=>print("Error: $onError"));
    }else{
      print("No hay Internet...");
    }
  }

  Future<void> eliminarEscuela(String id) async{
    if(await isConected()){
      return await db.doc(id).delete()
          .then((value) => print("Escuela eliminada"))
          .catchError((onError)=>print("Error: $onError"));
    }else{
      print("No hay Internet...");
    }
  }

  Future<void> actualizarEscuela(String id, EscuelaModeloFire act) async{
    if(await isConected()){
      return await db.doc(id).update(act.toMap())
          .then((value) => print("Actualizo correctamente"))
          .catchError((onError)=>print("Error: $onError"));
    }else{
      print("No hay Internet...");
    }
  }




}