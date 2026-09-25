# Poko & Friends

**Tiny Think – Poko & Friends** by Klay Kandy. A sibling of [bao_and_friends](https://github.com/TheSinghPranjal/bao_and_friends).

The Flutter tree matches Bao: models, go_router, screens, stores, theme, and the activity video state machines (idle loop, floating bubble tap, one-shot action, next idle, reward). Poko is the unlocked lead (little sister, ages 0–2). The family order is still Bao, Poko, Po, Koko, Momo, Dodo. Bao and the rest are coming soon. The carousel opens on Poko.

Where a Poko clip exists, her screens play it (`lib/models/character_media.dart`). Bao's files stay registered and still play for Bao. Slots with no Poko clip keep Bao's media.

## Run locally

```bash
cd ~/StudioProjects/poko_and_friends
git checkout main && git pull origin main && flutter pub get && flutter run
```

## Identity

| | Value |
| --- | --- |
| Package | `poko_and_friends` |
| Display name | Poko & Friends |
| Android applicationId | `com.lazy_bear_club.poko_and_friends` |
| iOS / macOS bundle id | `com.lazybearclub.pokoAndFriends` |
| Play listing URL in force-update | `https://play.google.com/store/apps/details?id=com.lazy_bear_club.poko_and_friends` |

## Firebase (left for a human)

`lib/firebase_options.dart`, `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`, and `firebase.json` are placeholders. They are not Bao's project and they are not real secrets. The app still boots: Android `Firebase.initializeApp` is inside try/catch, and force-update is skipped when init fails.

1. Create a Firebase project (suggested id `poko-and-friends`).
2. Register Android `com.lazy_bear_club.poko_and_friends` and iOS `com.lazybearclub.pokoAndFriends`.
3. Run FlutterFire (`flutterfire configure` with those ids) or drop in the downloaded plist/json and replace `lib/firebase_options.dart`.
4. Add Remote Config keys used by Bao: `force_update` (bool), `minimum_android_version` (string), `latest_android_version` (string).
5. Add `android/key.properties` (gitignored) before a Play release build. The Gradle release signing block matches Bao and no-ops until that file exists.
