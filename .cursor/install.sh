#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap for the poko_and_friends Flutter app.
# Safe to run repeatedly: it only installs the Flutter SDK when missing and
# then refreshes the project's Dart/Flutter dependencies.
set -euo pipefail

FLUTTER_VERSION="3.47.5"
FLUTTER_HOME="${HOME}/flutter"
FLUTTER_BIN="${FLUTTER_HOME}/bin"
ARCHIVE_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

export PATH="${FLUTTER_BIN}:${PATH}"

# Install the Flutter SDK if it is not already present (e.g. first boot without
# a prebuilt snapshot). When booting from a snapshot the SDK is already here and
# this block is skipped.
if [ ! -x "${FLUTTER_BIN}/flutter" ]; then
  echo "Flutter SDK not found; downloading ${FLUTTER_VERSION}..."
  tmp_archive="$(mktemp --suffix=.tar.xz)"
  curl -fSL --retry 4 --retry-delay 4 -o "${tmp_archive}" "${ARCHIVE_URL}"
  rm -rf "${FLUTTER_HOME}"
  tar xf "${tmp_archive}" -C "${HOME}"
  rm -f "${tmp_archive}"
fi

# Flutter refuses to run against a git checkout it does not trust.
git config --global --add safe.directory "${FLUTTER_HOME}" || true

# Make the SDK available in future interactive agent shells (idempotent).
BASHRC="${HOME}/.bashrc"
PATH_LINE='export PATH="$HOME/flutter/bin:$PATH"'
if [ -f "${BASHRC}" ] && ! grep -qxF "${PATH_LINE}" "${BASHRC}"; then
  printf '\n# Flutter SDK (added by Cloud Agent environment setup)\n%s\n' "${PATH_LINE}" >> "${BASHRC}"
fi

# Quiet, non-interactive tooling and enable the web target used for demos/tests.
flutter --disable-analytics >/dev/null 2>&1 || true
dart --disable-analytics >/dev/null 2>&1 || true
flutter config --enable-web --no-analytics >/dev/null 2>&1 || true

# Refresh project dependencies against the checked-out source.
flutter pub get

flutter --version
