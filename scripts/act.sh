#!/bin/bash
set -eo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

print_error() {
    echo -e "${RED}Erro: $1${NC}"
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

check_command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_docker() {
    if ! check_command_exists docker; then
        case "$OSTYPE" in
            "linux-gnu"*)
                echo "Instalando Docker para Linux..."
                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh get-docker.sh
                ;;
            "darwin"*)
                echo "Instalando Docker para macOS..."
                brew install --cask docker
                ;;
            "msys"*)
                echo "Instalando Docker para Windows..."
                choco install docker-desktop
                ;;
            *)
                print_error "Sistema operacional não suportado para instalação automática do Docker."
                exit 1
                ;;
        esac


        if ! check_command_exists docker; then
            print_error "Falha na instalação do Docker."
            exit 1
        else
            print_success "Docker instalado com sucesso."
        fi
    else
        print_success "Docker já está instalado."
    fi
}

install_act() {
    curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

    if ! check_command_exists act; then
        print_error "Falha na instalação do Act."
        exit 1
    fi
}

ensure_act_installed() {
    if ! check_command_exists act; then
        print_error "Act não está instalado. Instalando agora..."
        install_act
        print_success "Act instalado com sucesso."
    else
        print_success "Act já está instalado."
    fi
}


run_act_with_arguments() {
    [ "$#" -eq 0 ] && { act; } || { act "$@"; }
}

install_docker
ensure_act_installed
run_act_with_arguments "$@"
