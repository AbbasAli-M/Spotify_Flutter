import 'package:get_it/get_it.dart';
import 'package:spotify_flutter/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_flutter/data/repository/song/song_repository_impl.dart';
import 'package:spotify_flutter/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_flutter/data/sources/song/song_firebase_service.dart';
import 'package:spotify_flutter/domain/repository/auth/auth.dart';
import 'package:spotify_flutter/domain/repository/song/song.dart';
import 'package:spotify_flutter/domain/usecases/auth/signin.dart';
import 'package:spotify_flutter/domain/usecases/auth/signup.dart';
import 'package:spotify_flutter/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify_flutter/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_flutter/domain/usecases/song/get_play_list.dart';

import 'domain/usecases/auth/get_user.dart';
import 'domain/usecases/song/add_or_remove_favorite_song.dart';
import 'domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );


  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SongsRepository>(
      SongsRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<SigninUseCase>(
      SigninUseCase()
  );

  sl.registerSingleton<GetNewSongsUseCase>(
      GetNewSongsUseCase()
  );

  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase()
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
      IsFavoriteSongUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetFavoriteSongsUseCase>(
      GetFavoriteSongsUseCase()
  );


}