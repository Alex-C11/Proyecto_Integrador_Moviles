import 'package:asistencia_app/apis/actividad_api.dart';
import 'package:asistencia_app/apis/escuela_api.dart';
import 'package:asistencia_app/comp/DropDownFormField.dart';
import 'package:asistencia_app/modelo/EscuelaModelo.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EscuelaFormEdit extends StatefulWidget {
  EscuelaModelo modelA;
  EscuelaFormEdit({required this.modelA}):super();
  @override
  _EscuelaFormEditState createState() =>_EscuelaFormEditState(modelA: modelA);
}
class _EscuelaFormEditState extends State<EscuelaFormEdit> {
  EscuelaModelo modelA;

  _EscuelaFormEditState({required this.modelA}) :super();
  late String _nombreeap = "";
  late String _estado = "D";
  late String _inicialeseap = "NO";
  late String _facultad_nom = "";
  var _data = [];
  List<Map<String, String>> lista = [
    {'value': 'A', 'display': 'Activo'},
    {'value': 'D', 'display': 'Desactivo'}
  ];
  List<Map<String, String>> listaEva = [
    {'value': 'SI', 'display': 'SI'},
    {'value': 'NO', 'display': 'NO'}
  ];

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );void capturaNombreeap(valor) {this._nombreeap = valor;}
  void capturaEstado(valor) {this._estado = valor;}
  void capturaInicialeseap(valor) {this._inicialeseap = valor;}
  void capturaFacultad_nom(valor) {this._facultad_nom = valor;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Escuela"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDatoCadena(capturaNombreeap,modelA.nombreeap.toString(), "Nombre de la escuela:"),
                    _buildDatoLista(capturaEstado, _estado = modelA.estado,
                        "Estado:", lista),
                    _buildDatoLista(
                        capturaInicialeseap, _inicialeseap = modelA.inicialeseap, "Evaluar:",
                        listaEva),
                    _buildDatoCadena(capturaFacultad_nom,modelA.facultad_nom, "Nombre de Facultad:"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:
                      16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );
                              _formKey.currentState!.save();
                              EscuelaModelo mp = new
                              EscuelaModelo.unlaunched();
                              mp.nombreeap = _nombreeap;
                              mp.estado = _estado;
                              mp.inicialeseap = _inicialeseap;
                              mp.facultad_nom = _facultad_nom;

                              var api = await
                              Provider.of<EscuelaApi>(
                                  context,
                                  listen: false)
                                  .updateEscuela(
                                  TokenUtil.TOKEN, modelA.id.toInt(), mp);
                              print("ver: ${api.toJson()['success']}");
                              if (api.toJson()['success'] ==
                                  true) {
                                Navigator.pop(context, () {
                                  setState(() {});
                                });
// Navigator.push(context,MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'No estan bien los datos de los campos!'),
                                ),
                              );
                            }
                          },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String _dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String _dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _dato,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget _buildDatoLista(Function obtValor, _dato, String label,
      List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }
}