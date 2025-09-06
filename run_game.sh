#!/bin/bash

# Matar simulador
echo "Matar simulador..."
killall "Simulator"

# Limpiar build
echo "Limpiar proyecto Flutter..."
flutter clean

# Actualizar dependencias
echo "Actualizar paquetes..."
flutter pub get

# Abrir simulador
echo "Abrir simulador..."
open -a Simulator

# Esperar unos segundos a que abra
sleep 5

# Correr la app
echo "Ejecutando la app..."
flutter run
