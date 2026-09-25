# Poko & Friends

Tiny Think – Poko & Friends by Klay Kandy. A sibling of [bao_and_friends](https://github.com/TheSinghPranjal/bao_and_friends) with the same screens, stores, and activity video state machines.

Poko (Bao’s little sister, ages 0–2) is the unlocked playable lead. Bao, Po, Koko, Momo, and Dodo stay on the family carousel as coming soon. Poko's screens play her own clips where a matching slot exists (`lib/models/character_media.dart`). Bao's files stay registered and still play for Bao, and they remain the fallback on any Poko slot that does not have a clip yet.

## Run locally

```bash
cd ~/StudioProjects/poko_and_friends
flutter pub get
flutter run
```

Pull this repo into an existing checkout with:

```bash
cd ~/StudioProjects/poko_and_friends
git fetch origin
git checkout main
git pull origin main
flutter pub get
```

## Identity

| | Value |
| --- | --- |
| Package | `poko_and_friends` |
| Android applicationId | `com.lazy_bear_club.poko_and_friends` |
| iOS / macOS bundle id | `com.lazybearclub.pokoAndFriends` |
| Display name | Poko & Friends |

## Firebase

`lib/firebase_options.dart`, `android/app/google-services.json`, and `ios/Runner/GoogleService-Info.plist` are placeholders. The app boots without a live Firebase project because force-update init is wrapped in try/catch. Replace them with a real Poko Firebase app before store release. Steps are in the comment at the top of `lib/firebase_options.dart`.

Release signing still expects `android/key.properties` (gitignored), same as Bao.
