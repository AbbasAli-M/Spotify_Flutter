import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_flutter/domain/usecases/auth/get_user.dart';
import 'package:spotify_flutter/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_flutter/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {

  ProfileInfoCubit() : super (ProfileInfoLoading());

  Future<void> getUser() async {

    var user = await sl<GetUserUseCase>().call();

    user.fold(
            (l){
          emit(
              ProfileInfoFailure()
          );
        },
            (userEntity) {
          emit(
              ProfileInfoLoaded(userEntity: userEntity)
          );
        }
    );
  }
}