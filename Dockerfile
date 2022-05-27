FROM ubuntu:20.04
MAINTAINER Shutov Nikolay

# Устанавливаем необходимый софт
RUN apt-get update
RUN apt-get install -y \
    fetchmail \
    procmail \
    uudeview \
    locales

# Настройка локали и часового пояса
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN echo "Europe/Moscow" | tee /etc/timezone

# Указываем домашнюю директорию пользователя fetchmail как рабочую директорию
WORKDIR /var/lib/fetchmail

# Копируем структуру файлов и конфиги из директории conf в рабочую директорию
COPY ./conf/ .

# Устанавливаем необходимые права
RUN chown fetchmail -R . && chmod 0700 ./.fetchmailrc

# Запускаемся от пользователя fetchmail
USER fetchmail

ENTRYPOINT ["bash", "entrypoint.sh"]
