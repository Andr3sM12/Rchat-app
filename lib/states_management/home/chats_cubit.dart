import 'package:bloc/bloc.dart';
import 'package:cham_app/models/chat.dart';
import 'package:cham_app/viewmodels/chats_view_model.dart';

class ChatsCubit extends Cubit<List<Chat>> {
  final ChatsViewModel viewModel;
  ChatsCubit(this.viewModel) : super([]);

  Future<void> chats() async {
    final chats = await viewModel.getChats();
    emit(chats);
  }
}
