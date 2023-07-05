part of 'escuela_bloc.dart';

@immutable
abstract class EscuelaEvent {}

class ListarEscuelaEvent extends EscuelaEvent{
  ListarEscuelaEvent();
}
class DeleteEscuelaEvent extends EscuelaEvent{
  EscuelaModeloFire escuela;
  DeleteEscuelaEvent(this.escuela);
}
class UpdateEscuelaEvent extends EscuelaEvent{
  EscuelaModeloFire escuela;
  UpdateEscuelaEvent(this.escuela);
}

class CreateEscuelaEvent extends EscuelaEvent{
  EscuelaModeloFire escuela;
  CreateEscuelaEvent(this.escuela);
}