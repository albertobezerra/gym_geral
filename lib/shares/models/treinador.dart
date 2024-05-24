import 'package:gym_dot/shares/models/abstract_user.dart';

import 'clientes.dart';

class Treinador extends AbstractUser {
  // Lista de ids dos clientes (API)
  late List<int> clientesIds;

  // Lista dos clientes
  late List<Clientes> listaDeClientes;
}
