#!/bin/bash

echo "==============================="
echo "===========Cleaning============"
echo "==============================="
echo ""

cd api
echo "====== api_sdk: cleaning ======"
flutter clean
echo "====== api_sdk: done =========="

cd ../model
echo "======= model: cleaning ======="
flutter clean
echo "======= model: done ==========="

cd ../app
echo "======== app: cleaning ========"
flutter clean
echo "======== app: done ============"