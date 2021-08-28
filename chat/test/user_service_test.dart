import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/user/user_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

import 'helpers.dart';

void main() {
  Rethinkdb r = Rethinkdb();
  Connection connection;
  UserService sut;

  setUp(() async {
    connection = await r.connect(host: "192.168.0.5", port: 28015);
    await createDb(r, connection);
    sut = UserService(r, connection);
  });

  tearDown(() async {
    await cleanDb(r, connection);
  });

  test('Crea un nuevo usuario en DB', () async {
    final user = User(
      username: 'User_prueba',
      photoUrl: 'foto_perfil',
      active: true,
      lastseen: DateTime.now(),
    );
    final userWithId = await sut.connect(user);
    expect(userWithId.id, isNotEmpty);
  });

  test('Obtiene usuarios online', () async {
    final user = User(
      username: 'User_prueba',
      photoUrl: 'foto_perfil',
      active: true,
      lastseen: DateTime.now(),
    );
    //arrange
    await sut.connect(user);
    //act
    final users = await sut.online();
    //assert
    expect(users.length, 1);
  });
}
