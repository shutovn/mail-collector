# Автоматизация сохранения вложений из входящей почты.
Связка инструментов *fetchmail* + *procmail* + *uudeview* позволяет в автоматическом режиме сохранять вложения из входящих писем в любой удобный для пользователя каталог в ОС Linux. А так же позволяет достаточно гибко управлять процессом сохранения вложений используя правила фильтрации.
+ fetchmail — почтовый клиент.
+ procmail — обработчик правил фильтрации сообщений.
+ uudeview — сохраняет вложения.

## Подготовка к работе
Проект адаптирован под работу с почтовым сервером imap.yandex.com
1. Необходимо завести учетную запись (УЗ) на почтовом сервере yandex.com. А так же иметь установленные инструменты docker, docker-compose.
2. Клонируем проект:

    `git clone git@github.com:shutovn/mail-collector.git`
3. Переходим в директорию проекта:

    `cd mail-collector`
4. Переименовываем файл conf/.fetchmailrc_example

    `cp conf/.fetchmailrc_example conf/.fetchmailrc`
5. Редактируем файл conf/.fetchmailrc, необходимо заменить XXXXXXXXXXX на корректные login, password:
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
Находясь в директории проекта запускаем контейнер с помощью docker-compose
```
# Запуск контейнера mail-collector
  docker-compose up -d fetchmail
# Остановка контейнера mail-collector
  docker-compose stop fetchmail
# Просмотрт логов
  docker-compose logs fetchmail
```

После того как контейнер будет запущен, fetchmail в атоматическом режиме, раз в 60 секунд будет обращаться к почтовому серверу и проверять наличие новых писем подходящих под требуемые условия. В моем случае обрабатываются все письма пришедшие от адресата с маской адреса *vnv@gmail.com. В случае если у письма есть вложение, они сохраняются в директорию проекта  conf/fetchmail/attachments/имя_вложения с правами 600 (-rw-------) от пользователя контейнера, так что на основном хосте придется самостоятельно изменить права на необходимые. 
