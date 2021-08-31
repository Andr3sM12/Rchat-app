import 'package:chat/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cham_app/cache/local_cache.dart';
import 'package:cham_app/states_management/onboarding/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final IUserService _userService;
  final ILocalCache _localCache;

  OnboardingCubit(this._userService, this._localCache)
      : super(OnboardingInitial());

  Future<void> connect(String name) async {
    emit(Loading());

    final user = User(
      username: name,
      active: true,
      lastseen: DateTime.now(),
    );
    final createdUser = await _userService.connect(user);
    final userJson = {
      'username': createdUser.username,
      'active': true,
      'photo_url': createdUser.photoUrl,
      'id': createdUser.id
    };
    await _localCache.save('USER', userJson);
    emit(OnboardingSuccess(createdUser));
  }
}
