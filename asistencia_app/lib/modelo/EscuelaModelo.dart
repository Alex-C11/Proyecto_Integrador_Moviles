import 'package:floor/floor.dart';

@Entity(tableName: "escuela")
class EscuelaModelo {
  @primaryKey
  late int id=0;
  late String nombreeap;
  late String estado;
  late String inicialeseap;
  late String facultad_nom;
  @ignore

  EscuelaModelo(
      { required this.id,
        required this.nombreeap,
        required this.estado,
        required this.inicialeseap,
        required this.facultad_nom,
      });
  EscuelaModelo.unlaunched();

  EscuelaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreeap = json['nombreeap'];
    estado = json['estado'];
    inicialeseap = json['inicialeseap'];
    facultad_nom = json['facultad_nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombreeap'] = this.nombreeap;
    data['estado'] = this.estado;
    data['inicialeseap'] = this.inicialeseap;
    data['facultad_nom'] = this.facultad_nom;
    return data;
  }
}

class RespEscuelaModelo {
  late bool success;
  late List<EscuelaModelo> data;
  late String message;

  RespEscuelaModelo({ required this.success, required this.data ,required this.message});
  RespEscuelaModelo.unlaunched();

  RespEscuelaModelo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List).map((e) =>
        EscuelaModelo.fromJson(e as Map<String, dynamic>)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data']=this.data.map((e) => e.toJson()).toList();
    data['message'] = this.message;
    return data;
  }
}
