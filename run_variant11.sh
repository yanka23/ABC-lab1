#!/bin/bash

echo "=== Запуск лабораторной работы (Вариант 11) ==="

# Очистка старых следов, если они были, чтобы скрипт можно было запускать много раз
rm -rf claude_monet archive nagiev_call owner_contract shortcut_vip

# === ЧАСТЬ 1 и 2. Создание дерева каталогов и файлов ===
echo "1. Создание структуры и файлов..."
mkdir -p claude_monet/owner_office claude_monet/contracts claude_monet/advertising claude_monet/kitchen claude_monet/chef_office claude_monet/hall archive

echo "Дмитрий Нагиев требует подготовить ресторан к съёмке
Виктор Петрович должен представить новое меню
Вика отвечает за порядок в зале" > claude_monet/owner_office/owner_order

echo "Новая вывеска требует согласования
Реклама ресторана оплачивается владельцем
Расходы на банкет проверить отдельно" > claude_monet/owner_office/expense_plan

echo "Поставщик привозит продукты утром
Шеф лично проверяет качество мяса
Оплата производится после приёмки" > claude_monet/contracts/supplier_contract

echo "Музыканты выступают в пятницу вечером
Костя готовит напитки для артистов
Вика согласует время начала программы" > claude_monet/contracts/concert_contract

echo "Реклама показывает кухню и главный зал
Нагиев появляется в финале рекламного ролика
Баринов отказывается повторять текст дважды" > claude_monet/advertising/promo_plan

echo "Приготовить фирменное блюдо к восьми часам
Сеня и Федя отвечают за горячий цех
Лёва проверяет выдачу каждого блюда" > claude_monet/kitchen/chef_order

echo "Утиная ножка 850
Луковый суп 430
Мильфей 520
Стейк от шефа 1100" > claude_monet/kitchen/menu_prices

echo "Баринов согласен обновить меню
Баринов не согласен сниматься в рекламе
Все решения по кухне принимает шеф" > claude_monet/chef_office/barinov_reply

echo "За первым столом сидят актёры
Для Нагиева оставить место у сцены
Постоянным гостям подать десерт от Луи" > claude_monet/hall/vip_guests

echo "Нагиев позвонил Вике утром
Владелец приедет после открытия
Отчёт о расходах должен быть готов" > nagiev_call

# === Настройка прав доступа ===
echo "2. Настройка прав доступа..."
chmod 755 claude_monet
chmod 750 claude_monet/contracts
chmod 640 claude_monet/contracts/concert_contract
chmod 644 claude_monet/advertising/promo_plan
chmod 640 claude_monet/kitchen/chef_order
chmod 750 claude_monet/chef_office
chmod 755 claude_monet/hall
chmod 640 nagiev_call

chmod u=rwx,g=rx,o= claude_monet/owner_office
chmod u=rw,g=r,o= claude_monet/owner_office/expense_plan
chmod u=rw,g=r,o= claude_monet/contracts/supplier_contract
chmod u=rwx,g=rx,o= claude_monet/advertising
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod u=rw,g=r,o=r claude_monet/kitchen/menu_prices
chmod u=rw,g=r,o= claude_monet/chef_office/barinov_reply
chmod u=rw,g=r,o=r claude_monet/hall/vip_guests
chmod u=rwx,g=rx,o= archive

# === ЧАСТЬ 3. Копирование, перемещение и ссылки ===
echo "3. Копирование и создание ссылок..."
cp nagiev_call claude_monet/owner_office/nagiev_call_copy
cp -r claude_monet/advertising claude_monet/owner_office/advertising_backup
ln -s claude_monet/contracts/supplier_contract owner_contract
ln -s ../hall claude_monet/owner_office/hall_access
ln claude_monet/contracts/supplier_contract claude_monet/contracts/supplier_duplicate
cat claude_monet/owner_office/owner_order claude_monet/chef_office/barinov_reply > claude_monet/owner_office/meeting_notes
cat claude_monet/kitchen/chef_order >> nagiev_call

# Чтобы команда перемещения не падала из-за жестких прав папки advertising, временно даем себе полные права, переносим и возвращаем как было
chmod 777 claude_monet/advertising
mv claude_monet/advertising/promo_plan archive/promo_final
chmod 750 claude_monet/advertising
chmod 644 archive/promo_final

# === ЧАСТЬ 4. Поиск и фильтрация ===
echo "4. Выполнение поисковых запросов..."
echo "--- Подпункт 1 ---"
ls -lR | grep "^-" | grep -v "copy" | sort -k5 -n -r | head -n 5
echo "--- Подпункт 2 ---"
grep -r -i -h -E "нагиев|баринов" claude_monet/ archive/ | grep -i -v "реклам" | sort -r | head -n 5
echo "--- Подпункт 3 ---"
grep -r -l -i "поставщик" claude_monet/contracts/ claude_monet/owner_office/ | wc -l
echo "---
Подпункт 4 ---"
tail -q -n +1 claude_monet/contracts/* | head -n 1 && tail -q -n 1 claude_monet/contracts/* | grep -i -E "поставщик|музыкант|оплат" | sort
echo "--- Подпункт 5 ---"
cat claude_monet/owner_office/meeting_notes | grep -v "согласен" | grep -E "меню|кухн" | sort -r | wc -w
echo "--- Подпункт 6 ---"
ls -lR | grep "^l" | sort -k9 -r
echo "--- Подпункт 7 ---"
grep -r -h "реклам" claude_monet/owner_office/advertising_backup/ | grep -v "Нагиев" | sort | wc -w

# === ЧАСТЬ 5. Удаление ===
echo "5. Очистка и удаление файлов по варианту..."
rm claude_monet/contracts/supplier_duplicate
rm owner_contract
rm claude_monet/owner_office/meeting_notes
rm claude_monet/owner_office/nagiev_call_copy
rm -rf claude_monet/owner_office/advertising_backup

echo "=== Скрипт успешно завершил работу! ==="
