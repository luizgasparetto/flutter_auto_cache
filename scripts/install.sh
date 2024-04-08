#!/bin/bash

set -eo pipefail

check_command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_melos() {
  echo "Instalando Melos..."
  dart pub global activate melos || {
    echo "Falha ao instalar o Melos. Certifique-se de que o Dart está instalado e no PATH."
    exit 1
  }
}

ensure_melos_installed() {
  if ! check_command_exists melos; then
    echo "Melos não está instalado."
    install_melos
  else
    echo "Melos já está instalado."
  fi
}

run_pub_get() {
  echo "Executando flutter pub get..."
  flutter pub get || {
    echo "Falha ao executar flutter pub get. Verifique se o Flutter está corretamente instalado e no PATH."
    exit 1
  }
}

ensure_melos_installed
run_pub_get
