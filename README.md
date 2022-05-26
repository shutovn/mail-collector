# Автоматизация сохранения вложений из входящей почты.
Связка инструментов fetchmail + procmail + uudeview позволяет в автоматическом режиме сохранять вложения из входящих писем. А так же позволяет достаточно гибко управлять процессом сохранения вложений используя правила фильтрации.
+ fetchmail — почтовый клиент.
+ procmail — обработчик правил фильтрации сообщений.
+ uudeview — сохраняет вложения.

## Подготовка к работе
Проект адаптирован под работу с почтовым сервером imap.yandex.com
1. Необходимо завести учетную запись (УЗ) на почтовом сервере yandex.com.
2. Клонируем проект:

    `git clone git@github.com:shutovn/mail-collector.git`
3. Переходим в директорию проекта:

    `cd mail-collector`
4. Переименовываем файл conf/.fetchmailrc_example

    `cp conf/.fetchmailrc_example conf/.fetchmailrc`
5. Редактируем файл conf/.fetchmailrc, необходимо заменить XXXXXXXXXXX на корректные login password:
```
poll imap.yandex.com
  port 993
  proto IMAP
  user "XXXXXXXXXXX"
  password "XXXXXXXXXXX"
  ssl
  mda "/usr/bin/procmail -d %T"
  set syslog set logfile "fetchmail/logs/fetchmail.log"
```
6. Собираем контейнер

    `sudo docker build -t="mail-collector" .`

## Запускаем проект
