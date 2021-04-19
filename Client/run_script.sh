#!/bin/bash

echo "==============================="
echo "============Running============"
echo "==============================="
echo ""

cd api
echo "====== api_sdk: cleaning ======"
flutter clean
echo "====== api_sdk: pub get ======="
flutter pub get
echo "====== api_sdk: done =========="

cd ../app
echo "======== app: cleaning ========"
flutter clean
echo "======== app: pub get ========="
flutter pub get
echo "======== app: done ============"
flutter run  --dart-define=ENV=test