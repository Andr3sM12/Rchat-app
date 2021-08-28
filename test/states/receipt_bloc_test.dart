import 'package:cham_app/states_management/receipt/receipt_bloc.dart';
import 'package:chat/chat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FakeReceiptService extends Mock implements IReceiptService {}

void main() {
  ReceiptBloc sut;
  IReceiptService receiptService;
  User user;

  setUp(() {
    receiptService = FakeReceiptService();
    user = User(
      username: 'test',
      photoUrl: '',
      active: true,
      lastseen: DateTime.now(),
    );
    sut = ReceiptBloc(receiptService);
  });

  tearDown(() => sut.close());

  test('should emit initial only without subscriptions', () {
    expect(sut.state, ReceiptInitial());
  });

  test('should emit message sent state when message is sent', () {
    final receipt = Receipt(
        recipient: '444',
        messageId: '1234',
        status: ReceiptStatus.deliverred,
        timestamp: DateTime.now());

    when(receiptService.send(receipt)).thenAnswer((_) async => null);
    sut.add(ReceiptEvent.onMessageSent(receipt));
    expectLater(sut.stream, emits(ReceiptState.sent(receipt)));
  });

  test('should emit messages received from service', () {
    final receipt = Receipt(
        recipient: '444',
        messageId: '1234',
        status: ReceiptStatus.deliverred,
        timestamp: DateTime.now());

    when(receiptService.receipts(user))
        .thenAnswer((_) => Stream.fromIterable([receipt]));

    sut.add(ReceiptEvent.onSubscribed(user));
    expectLater(sut.stream, emitsInOrder([ReceiptReceivedSuccess(receipt)]));
  });
}
