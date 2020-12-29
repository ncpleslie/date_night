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

cd ../model
echo "======= model: cleaning ======="
flutter clean
echo "======= model: pub get ========"
flutter pub get
echo "======= model: done ==========="

cd ../app
echo "======== app: cleaning ========"
flutter clean
echo "======== app: pub get ========="
flutter pub get
echo "======== app: done ============"
flutter run