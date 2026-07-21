#!/usr/bin/env bash

set -euo pipefail

# Força a conversão em UTC para ignorar o fuso horário local (UTC-3, etc)
to_seconds() {
    date -u -d "1970-01-01 $1:00" +%s
}

to_time() {
    date -u -d "@$1" +%H:%M
}

if [ "$#" -lt 2 ]; then
    echo "Uso: $0 <HH:MM entrada> <HH:MM ida_almoco> [HH:MM retorno_almoco] [HH:MM expediente]"
    echo "Exemplo: $0 08:07 12:12"
    exit 1
fi

HORA_ENTRADA="$1"
HORA_ALMOCO="$2"
RETORNO_ALMOCO="${3:-}"
EXPEDIENTE="${4:-08:00}"

# Converter expediente para segundos
EXP_H=$(echo "$EXPEDIENTE" | cut -d: -f1)
EXP_M=$(echo "$EXPEDIENTE" | cut -d: -f2)
EXP_SECS=$(( (10#$EXP_H * 3600) + (10#$EXP_M * 60) ))

ENTRADA_SECS=$(to_seconds "$HORA_ENTRADA")
ALMOCO_SECS=$(to_seconds "$HORA_ALMOCO")

if [ -z "$RETORNO_ALMOCO" ]; then
    RETORNO_SECS=$(( ALMOCO_SECS + 3600 ))
    SUGESTAO_RETORNO=$(to_time "$RETORNO_SECS")
    echo -e "\n[Info] Retorno do almoço sugerido (1h): $SUGESTAO_RETORNO"
else
    RETORNO_SECS=$(to_seconds "$RETORNO_ALMOCO")
fi

# Cálculo da saída
TRABALHADO_MANHA=$(( ALMOCO_SECS - ENTRADA_SECS ))
RESTANTE_EXPEDIENTE=$(( EXP_SECS - TRABALHADO_MANHA ))
SAIDA_SECS=$(( RETORNO_SECS + RESTANTE_EXPEDIENTE ))

HORA_SAIDA=$(to_time "$SAIDA_SECS")

echo -e "Saia às: $HORA_SAIDA\n"