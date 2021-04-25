#!/bin/bash

echo "==============================="
echo "============Running============"
echo "==============================="
echo ""

cd app
echo "======== app: cleaning ========"
flutter clean
echo "======== app: pub get ========="
flutter pub get
echo "======== app: done ============"
flutter run  --dart-define=ENV=test