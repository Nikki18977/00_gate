# Gate Task (Slurm Навыкум "Build Containers!")

## Описание

Это Gate Task, который позволит вам понять:
1. Хватает ли вашего уровня для прохождения [Slurm Навыкум "Build Containers!"](https://slurm.io)
2. Устраивает ли вас используемый [подход](#Подход)

**Важно**: ничего никуда присылать не надо &ndash; это задача для самопроверки. Если:
1. Вам всё нравится и по силам &ndash; записывайтесь на Навыкум
2. Вам всё нравится, но не по силам &ndash; прокачивайте свои скиллы* и приходите
3. Вам не нравится &ndash; пишите нам в [Телеграм Бот](https://t.me/SlurmCustomerBot) о том, что можно изменить, и как сделать лучше

Примечание*: у нас есть [курс по Docker](https://slurm.io/docker-intensive), можете пройти его, чтобы "подтянуться". На самом Навыкуме будет не только Docker.

## Подход

Всё как в реальной жизни &ndash; куча технологий, разные команды, половина не знает Docker, другая половина пишет `Dockerfile` как попало.

Документации, как обычно, нет, есть только короткие инструкции (если повезёт), как и что запускается и что нужно сделать ("требования" 😈).

И всем нужно помочь, упаковать "их чудо" в образ и ещё предоставить им возможность "потестировать".

Поэтому:
1. Будьте готовы, что придётся разбираться в коде, в системах управления зависимостями, сборщиках и целевой экосистеме (пусть даже это не "ваш стек", будут задачи для JS, Java, Go и "*пока не скажем чему*")
2. Будьте готовы, что те же разработчики иногда сами не знают, как оно должно запускаться в Production (их не всегда* этому учат)
3. Будьте готовы, что задачи будут ставиться так, как они ставятся (парой сообщений в мессенджере или таск-трекере со ссылкой на код без доков)

Примечание*: правильнее было бы сказать, что совсем не учат.

## Задача

Для решения Gate Task необходимо использовать Docker для сборки образа контейнера.

В качестве Gate Task &ndash; сервис на Node.js, который умеет считать `HMAC с заданным секретом по алгоритму SHA256`*.

Примечание*: из всего написанного нужно знать, что есть секрет и алгоритм, по которому рассчитывается что-то, связанное с криптографией 😊. Точки, в которых задаются указанные значения в коде будут помечены через комментарий `FIXME:`.

### Формулировка разработчика

Разработчик сказал следующее (дословно):
> Стандартный проект на ноде, используем последнюю LTS-версию
> 
> Запускаем в режиме разработки через `yarn start`
> 
> Секрет и алгоритм захардкожены в `index.js`
> 
> Для проверки нужно отправить через `POST` JSON на `http://localhost:9000` следующего вида:
> ```json
> {"data": "data-for-hmac"}
> ```

Что нужно сделать (дословно):
> Упаковать всё в Docker так, чтобы можно было алгоритм и секрет задавать через переменные окружения `HMAC_ALGO` и `HMAC_SECRET` соответственно*
> 
> В качестве базового образа хотим использовать официальный образ ноды на базе alpine 3.17
> 
> Никаких entrypoint.sh и других sh-скриптов писать не нужно
> 
> Никаких тестов, проверок стиля кода, проверок безопасности (в том числе сканирования зависимостей и образов на уязвимости) делать не нужно
> 
> Выложить всё в виде публичного образа на GHCR (GitHub Container Registry), чтобы мы могли сами затестить и переиспользовать

Примечание*: да, мы знаем, что для секретов переменные окружения &ndash; не лучшая идея, но пока так.

### Требования

Ко всем заданиям в Навыкуме будут применяться следующие требования:
1. Всё должно быть оформлено в виде публичного репозитория на GitHub
2. Вся сборка образов должна проходить через GitHub Actions
3. Образ должен выкладываться в GitHub Container Registry (GHCR)

К текущему заданию дополнительно предъявляются требования:
1. Docker Legacy Build ([`DOCKER_BUILDKIT=0 docker build .`](https://github.com/docker/cli/pull/3314))
2. No Multi-Stage (должно быть достаточно одного образа для всего)

В других заданиях Навыкуме, конечно же, будут и другие требования, например, наоборот, использовать BuildKit и Multi-Stage и т.д.

<details>
<summary>Спойлеры</summary>

Спойлеры смотреть не хорошо 😈!

Основные моменты:
1. Не запускайте приложение от root'а (прописывайте это явно в `Dockerfile`)
2. Точно указывайте базовый образ (как минимум, с точностью до minor-версии)
3. Выполняйте установку только `production`-зависимостей и только с теми версиями, которые указаны в `*.lock`-файлах 

</details>