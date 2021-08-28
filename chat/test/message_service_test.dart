import 'package:chat/src/models/message.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/encryption/encryption_service.dart';
import 'package:chat/src/services/message/message_service_impl.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

import 'helpers.dart';

void main() {
  Rethinkdb r = Rethinkdb();
  Connection connection;
  MessageService sut;

  setUp(() async {
    connection = await r.connect(host: '192.168.0.5', port: 28015);
    final encryption = EncryptionService(Encrypter(AES(Key.fromLength(32))));
    await createDb(r, connection);
    sut = MessageService(r, connection, encryption: encryption);
  });

  tearDown(() async {
    sut.dispose();
    await cleanDb(r, connection);
  });

  final user = User.fromJson({
    'id': '1234',
    'active': true,
    'lastSeen': DateTime.now(),
  });

  final user2 = User.fromJson({
    'id': '1111',
    'active': true,
    'lastSeen': DateTime.now(),
  });

  test('Mensaje enviado exitosamente', () async {
    Message message = Message(
      from: user.id,
      to: '3456',
      timestamp: DateTime.now(),
      contents: 'Mensaje prueba',
    );

    final res = await sut.send(message);
    expect(res, true);
  });

  test('Subscribe and receive mensajes exitosamente', () async {
    final contents = 'Esto es un mensaje';
    sut.messages(activeUser: user2).listen(expectAsync1((message) {
          expect(message.to, user2.id);
          expect(message.id, isNotEmpty);
          expect(message.contents, contents);
        }, count: 2));

    Message message = Message(
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: contents,
    );

    Message secondMessage = Message(
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: contents,
    );

    await sut.send(message);
    await sut.send(secondMessage);
  });

  test('Subscribe and receive nuevos mensajes exitosamente', () async {
    Message message = Message(
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: 'Esto es un mensaje',
    );

    Message secondMessage = Message(
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: 'Este es otro mensaje',
    );

    await sut.send(message);
    await sut.send(secondMessage).whenComplete(
          () => sut.messages(activeUser: user2).listen(
                expectAsync1((message) {
                  expect(message.to, user2.id);
                }, count: 2),
              ),
        );
  });
}
