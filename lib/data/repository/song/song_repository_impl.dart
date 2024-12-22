import 'package:dartz/dartz.dart';
import 'package:spotify_flutter/domain/repository/song/song.dart';

import '../../../service_locator.dart';
import '../../sources/song/song_firebase_service.dart';

class SongsRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getPlayList() async{
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async{
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async{
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }

}