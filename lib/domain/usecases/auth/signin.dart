import 'package:dartz/dartz.dart';
import 'package:spotify_flutter/data/models/auth/signin_user_req.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SigninUseCase implements UseCase<Either,SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRepository>().signin(params!);
  }
}