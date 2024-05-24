import 'package:gym_dot/shares/models/abstract_user.dart';

class Administradores extends AbstractUser {
  late String gymName;
  late String gymLogoImg;
  late List<int> listaDeTreinadoresIDs;
  late List<int> listaDeUsuariosTreinadores;
}
