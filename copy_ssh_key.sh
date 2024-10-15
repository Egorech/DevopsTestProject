#!/bin/bash

if [[ ! -f server.list ]]; then
  echo "Файл server.list не найден!"
  exit 1
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  # Пропускаем пустые строки
  if [[ -z "$line" ]]; then
    continue
  fi

  echo "Проверка: ping $line"
  if ping -c 1 "$line" &> /dev/null; then
    echo "Узел доступен: $line"
    echo "Выполняется ssh-copy-id..."
    ssh-copy-id "egor@$line"
    echo "ssh-copy-id завершен."
  else
    echo "Узел недоступен: $line"
  fi
done < server.list
