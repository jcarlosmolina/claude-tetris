#!/usr/bin/env bash
# Fetches current weather for a city from wttr.in (no API key required).
set -euo pipefail

CITY="${1:-Denia,Spain}"
CITY="$(echo "$CITY" | iconv -f utf-8 -t ascii//translit)"

curl -fsS "https://wttr.in/${CITY// /+}?format=%l:+%c+%t+(feels+%f)+humedad+%h+viento+%w&lang=es"
echo
