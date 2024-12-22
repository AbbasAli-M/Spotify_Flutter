import 'package:dartz/dartz.dart';
import 'package:spotify_flutter/core/usecase/usecase.dart';

import 'package:spotify_flutter/service_locator.dart';
import 'package:spotify_flutter/domain/repository/song/song.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String ? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }

}