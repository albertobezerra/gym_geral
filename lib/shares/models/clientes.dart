import 'package:gym_dot/shares/models/abstract_user.dart';

import 'bloco_de_treino.dart';

class Clientes extends AbstractUser {
  late String uniqueCodeClient;
  late List<BlocoDeTreino> listaDeBlocoDeTreinos;
}
