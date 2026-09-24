# poko_and_friends

**Tiny Think – Poko & Friends** by Klay Kandy.

Structural and behavioral sibling of
[`bao_and_friends`](https://github.com/TheSinghPranjal/bao_and_friends).
Same screens, stores, and activity video state machines (idle → bubble →
one-shot → completed idle → rewards). **Poko** is the unlocked lead playable
character; family roster still includes Bao, Po, Koko, Momo, and Dodo.

## Media note

Video/image filenames still use the `bao_*` / `Bao_*` prefixes on purpose.
Poko currently reuses Bao media — do not rename those asset paths until
dedicated Poko media is ready.

## Open in Android Studio

```bash
git clone https://github.com/TheSinghPranjal/poko_and_friends.git ~/StudioProjects/poko_and_friends
cd ~/StudioProjects/poko_and_friends
flutter pub get
flutter run
```

## Identity

| | |
|---|---|
| Dart package | `poko_and_friends` |
| Android applicationId | `com.lazy_bear_club.poko_and_friends` |
| iOS bundle id | `com.lazybearclub.pokoAndFriends` |
| Display name | Poko & Friends |

## Firebase (human setup)

`lib/firebase_options.dart`, `android/app/google-services.json`, and
`ios/Runner/GoogleService-Info.plist` contain **placeholders**. Create a
Firebase project (e.g. `poko-and-friends`), register the Android/iOS apps with
the ids above, then run:

```bash
flutterfire configure
```

Do not reuse the Bao Firebase app ids in production.

## Getting Started

This project is a Flutter application. See the
[Flutter docs](https://docs.flutter.dev/) for tooling help.
