import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:poko_and_friends/models/character.dart';
import 'package:poko_and_friends/models/character_media.dart';
import 'package:poko_and_friends/models/feed_foods.dart';
import 'package:poko_and_friends/models/play_games.dart';

void main() {
  test('every Poko clip is a registered file', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(
      CharacterMedia.allPokoAssets.toSet().length,
      CharacterMedia.allPokoAssets.length,
    );
    for (final path in CharacterMedia.allPokoAssets) {
      expect(File(path).existsSync(), isTrue, reason: path);
      expect(pubspec.contains('    - $path'), isTrue, reason: path);
    }
  });

  test('Poko swaps matching slots and Bao keeps his own files', () {
    const apple = 'assets/videos/feed/apple/bao_eating_apple.mp4';
    expect(CharacterMedia.clip(CharacterId.bao, apple), apple);
    expect(CharacterMedia.clip(CharacterId.po, apple), apple);
    expect(
      CharacterMedia.clip(CharacterId.poko, apple),
      CharacterMedia.appleAction,
    );

    for (final fallback in CharacterMedia.pokoBaoFallbacks) {
      expect(
        CharacterMedia.pokoOverrides.containsKey(fallback),
        isFalse,
        reason: fallback,
      );
      expect(CharacterMedia.clip(CharacterId.poko, fallback), fallback);
      expect(File(fallback).existsSync(), isTrue, reason: fallback);
    }

    final baoFootball = File(
      'assets/videos/play/football/bao_playing_football_video.mp4',
    ).readAsBytesSync();
    final pokoFootball = File(CharacterMedia.footballAction).readAsBytesSync();
    expect(baoFootball, isNot(equals(pokoFootball)));
  });

  test('feed and play resolve per character', () {
    final pokoApple = FeedFoods.resolve('apple', CharacterId.poko);
    expect(pokoApple.idleVideoAsset, CharacterMedia.appleIdle);
    expect(pokoApple.actionVideoAsset, CharacterMedia.appleAction);

    final baoApple = FeedFoods.resolve('apple', CharacterId.bao);
    expect(baoApple.actionVideoAsset, contains('bao_eating_apple'));

    final milk = FeedFoods.resolve('milk', CharacterId.poko);
    expect(milk.idleVideoAsset, contains('bao_not_drinking_milk'));
    expect(milk.actionVideoAsset, contains('bao_drinking_milk'));

    final rice = FeedFoods.resolve('rice', CharacterId.poko);
    expect(rice.actionVideoAsset, CharacterMedia.riceAction);

    final football = PlayGames.byId('football')!;
    expect(
      PlayGames.resolve(football, CharacterId.poko).actionVideoAsset,
      CharacterMedia.footballAction,
    );
    expect(
      PlayGames.resolve(football, CharacterId.bao).actionVideoAsset,
      football.actionVideoAsset,
    );

    final badminton = PlayGames.byId('badminton')!;
    expect(badminton.hasVideos, isFalse);
    expect(PlayGames.resolve(badminton, CharacterId.poko).hasVideos, isTrue);
    expect(PlayGames.resolve(badminton, CharacterId.bao).hasVideos, isFalse);

    final cricket = PlayGames.byId('cricket')!;
    expect(
      PlayGames.resolve(cricket, CharacterId.poko).actionVideoAsset,
      CharacterMedia.cricketAction,
    );
    expect(
      PlayGames.resolve(cricket, CharacterId.bao).idleVideoAsset,
      cricket.idleVideoAsset,
    );

    expect(
      CharacterMedia.celebrationVideo(CharacterId.poko),
      CharacterMedia.celebration,
    );
    expect(CharacterMedia.celebrationVideo(CharacterId.bao), isNull);
  });
}
