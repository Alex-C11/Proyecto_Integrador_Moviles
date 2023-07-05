import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:asistencia_app/apis/actividad_api.dart';
import 'package:asistencia_app/apis/escuela_api.dart';
import 'package:asistencia_app/comp/TabItem.dart';
import 'package:asistencia_app/modelo/EscuelaModelo.dart';
import 'package:asistencia_app/ui/actividad/actividad_edit.dart';
import 'package:asistencia_app/ui/actividad/actividad_form.dart';
import 'package:asistencia_app/ui/escuela/escuela_edit.dart';
import 'package:asistencia_app/ui/escuela/escuela_form.dart';
import 'package:flutter/material.dart';
import 'package:asistencia_app/modelo/ActividadModelo.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:asistencia_app/theme/AppTheme.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import '../help_screen.dart';

class MainEscuela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<EscuelaApi>(
      create: (_) => EscuelaApi.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeData,
        //theme: ThemeData(primaryColor: Colors.lightBlue),
        home: EscuelaUI(),
      ),
    );
  }
}

class EscuelaUI extends StatefulWidget {
  @override
  _EscuelaUIState createState() => _EscuelaUIState();
}

class _EscuelaUIState extends State<EscuelaUI> {
  //ApiCovid apiService;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var api;
  @override
  void initState() {
    super.initState();
  //apiService = ApiCovid();
  //api=Provider.of<PredictionApi>(context, listen: false).getPrediction();
    print("entro aqui");
  }
  final GlobalKey<AnimatedFloatingActionButtonState> key =
  GlobalKey<AnimatedFloatingActionButtonState>();

  Future onGoBack(dynamic value) async {
    setState(() {
      print(value);
    });
  }
  void accion(){
    setState(() {
    });
  }

  void accion2(){
    setState(() {
      print("Holaas");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,
      home: Scaffold(

        appBar: new AppBar(
          title: Text(
            'Lista de Escuelas',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  print("Si funciona");
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  //final producto=new ModeloProductos();
                  //formDialog(context, producto);
                  print("Si funciona 2");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EscuelaForm()),
                  ).then(onGoBack);
                },
                child: Icon(Icons.add_box_sharp),
              ),
            )
          ],
        ),


        backgroundColor: AppTheme.nearlyWhite,
        body: FutureBuilder<List<EscuelaModelo>>(
          future: Provider.of<EscuelaApi>(context, listen: true)
              .getEscuela(TokenUtil.TOKEN).then((value) => value.data),
          builder: (BuildContext context,
              AsyncSnapshot<List<EscuelaModelo>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<EscuelaModelo> persona = snapshot.data!!;
              print(persona.length);
              return _buildListView(persona);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBottomTab(),
        floatingActionButton: AnimatedFloatingActionButton(
          key: key,
          fabButtons: <Widget>[
            add(),
            image(),
            inbox(),
          ],
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
        ),

      ),
    );

  }

  Widget _buildListView(List<EscuelaModelo> persona) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          EscuelaModelo personax = persona[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        title: Text(personax.nombreeap,
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.themeData.colorScheme.primaryContainer),
                                child: Text(
                                  personax.estado,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppTheme.themeData.colorScheme.primaryContainer),
                                child: Text(
                                  personax.inicialeseap,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ]),
                        leading: CircleAvatar(
                          backgroundImage:
                          AssetImage("assets/imagen/man-icon.png"),
                        ),
                        trailing: Row(mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  color: AppTheme.themeData.colorScheme.primary,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EscuelaFormEdit(modelA: personax)),
                                    ).then(onGoBack);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: AppTheme.themeData.colorScheme.primary,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                            Text("Mensaje de confirmacion"),
                                            content: Text("Desea Eliminar?"),
                                            actions: [
                                              FloatingActionButton(
                                                child: const Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop('Failure');
                                                },
                                              ),
                                              FloatingActionButton(
                                                  child: const Text('ACCEPT'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Success');
                                                  })
                                            ],
                                          );
                                        }).then((value) {
                                      if (value.toString() == "Success") {
                                        print(personax.id);

                                        Provider.of<EscuelaApi>(context,
                                            listen: false)
                                            .deleteEscuela(TokenUtil.TOKEN,personax.id)
                                            .then((value) => onGoBack(value));
                                        //var onGoBack = onGoBack;
                                        //BlocProvider.of<ProductosBloc>(context).add(DeleteProductoEvent(producto: state.productosList[index]));
                                      }
                                    });
                                  })
                            ])),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: persona.length,
      ),
    );
  }

  int selectedPosition = 0;
  final tabs = ['Home', 'Profile', 'Help', 'Settings'];
  _buildBottomTab() {
    return BottomAppBar(
      color: AppTheme.themeData.colorScheme.primaryContainer,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            icon: Icons.menu,
            text: tabs[0],
            isSelected: selectedPosition == 0,
            onTap: (){
              setState(() {
                selectedPosition = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return  HelpScreen();
              }));
            },
          ),
          TabItem(
            icon: Icons.person,
            text: tabs[1],
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),

          TabItem(text: tabs[2], icon: Icons.help, isSelected: selectedPosition == 2, onTap: () {
            setState(() {
              selectedPosition = 2;
            });
          },),
          TabItem(text: tabs[3], icon: Icons.settings, isSelected: selectedPosition == 3, onTap: () {
            setState(() {
              selectedPosition = 3;
            });
          },),
        ],
      ),
    );
  }


  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          key.currentState?.closeFABs();
        },
        heroTag: Text("Image"),
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Image"),
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: Text("Inbox"),
        tooltip: 'Inbox',
        child: Icon(Icons.inbox),
      ),
    );
  }
}