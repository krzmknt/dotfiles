#!/bin/bash
# OS Detection

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
  elif [[ -f /etc/os-release ]]; then
    . /etc/os-release
    case "$ID" in
      ubuntu|debian)
        OS="ubuntu"
        ;;
      amzn|amazonlinux)
        OS="al2023"
        ;;
      fedora|rhel|centos)
        OS="fedora"
        ;;
      *)
        OS="linux"
        ;;
    esac
  else
    OS="unknown"
  fi

  export OS
  echo "Detected OS: $OS"
}

detect_os
