class EscuelaModeloFire {
  late String id="";
  late String nombreeap;
  late String estado;
  late String inicialeseap;
  late String facultad_nom;


  EscuelaModeloFire(
      {required this.id,
        required this.nombreeap,
        required this.estado,
        required this.inicialeseap,
        required this.facultad_nom,
      });
  EscuelaModeloFire.unlaunched();

  factory EscuelaModeloFire.fromJson(Map<String, dynamic> json) {
    return EscuelaModeloFire(
        id: json['id']==null?"0":json['id'],
        nombreeap: json['nombreeap'],
        estado: json['estado'],
        inicialeseap: json['inicialeseap'],
        facultad_nom: json['facultad_nom'],
        );
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

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['id'] = this.id;
    data['nombreeap'] = this.nombreeap;
    data['estado'] = this.estado;
    data['inicialeseap'] = this.inicialeseap;
    data['facultad_nom'] = this.facultad_nom;
    return data;
  }
}