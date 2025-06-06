# 🚀 Advanced Git Guide

<div align="center">
  <img src="https://git-scm.com/images/logos/downloads/Git-Logo-2Color.png" alt="Git Logo" width="200"/>
</div>

## 📋 Содержание

- [Продвинутые команды и техники](#-продвинутые-команды-и-техники)
  - [Git Stash](#-git-stash)
  - [Cherry Pick](#-cherry-pick)
  - [Rebase](#-rebase)
  - [Interactive Rebase](#-interactive-rebase)
  - [Bisect](#-bisect)
  - [Reflog](#-reflog)
  - [Reset Hard](#-reset-hard)
  - [Merge Strategies](#-merge-strategies)
  - [Submodules](#-submodules)
- [Решение конфликтов](#-решение-сложных-конфликтов-вручную-с-сохранением-истории)
- [Восстановление удалённых коммитов](#-восстановление-удалённыхперезаписанных-коммитов)
- [Модели ветвления](#-модели-ветвления-в-git)
  - [GitHub Flow](#-github-flow)
  - [Git Flow](#-git-flow)
  - [Release Flow](#-release-flow-от-microsoft)
  - [Trunk-Based Development](#-trunk-based-development)

---

## 🛠 Продвинутые команды и техники

Здесь представлены продвинутые команды и техники в Git, которые помогут вам эффективнее управлять вашим рабочим процессом и кодом.

### 📦 Git Stash

Временное **локальное** хранилище изменений для случаев, когда нужно быстро переключиться на другую задачу.

- 💼 Позволяет сохранить несохраненные изменения без коммита.
- 🔄 Отлично работает для переключения между задачами.
- 📋 Можно создавать множество стэшей и применять их по мере необходимости.
- 🔍 Стэши доступны только локально и не отправляются на удаленный репозиторий.

> **Лучше всего для:** временного сохранения работы, быстрого переключения контекста.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git stash` | Сохранить изменения в stash |
| `git stash list` | Посмотреть список stash'ей |
| `git stash apply` | Применить stash без удаления |
| `git stash pop` | Применить stash и удалить его |
| `git stash drop` | Удалить stash без применения |
| `git stash save "сообщение"` | Сохранить stash с комментарием |

#### 🔹 **Сохранить изменения в stash:**  
```bash
git stash
```
Это очистит рабочую директорию, сохранив изменения в скрытом списке stash'ей.

#### 🔹 **Посмотреть список stash'ей:**  
```bash
git stash list
```
Покажет все сохранённые stash'и с их идентификаторами (`stash@{0}`, `stash@{1}`, ...).

#### 🔹 **Применить stash без удаления:**
```bash
git stash apply
```
Применяет stash, но **не удаляет** его из списка stash'ей. Полезно, когда нужно использовать один стэш в нескольких местах.
  
#### 🔹 **Применить stash и удалить его:**
```bash
git stash pop
```
Применяет stash и **удаляет** его из списка stash'ей. Удобно для одноразового использования.
</details>

### 🍒 Cherry Pick

Точное извлечение отдельных коммитов из любой ветки и применение их к текущей ветке.

- 🎯 Позволяет выбирать только нужные коммиты вместо всей ветки.
- 🧩 Идеально подходит для выборочного переноса исправлений.
- ⚠️ Создает новые коммиты с другими хэшами, но сохраняет изменения.
- 🔁 Можно применять как одиночные коммиты, так и диапазоны.

> **Лучше всего для:** применения конкретных фиксов, работы с хотфиксами между ветками.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git cherry-pick <commit-hash>` | Применить один коммит |
| `git cherry-pick <hash1>^..<hash2>` | Применить диапазон коммитов |
| `git cherry-pick --no-commit <hash>` | Применить изменения без создания коммита |
| `git cherry-pick -x <hash>` | Применить с указанием исходного коммита |

#### 🔹 **Применить один коммит по его hash:**
```bash
git cherry-pick a1b2c3d
```
Берет изменения из указанного коммита и применяет их в текущей ветке с созданием нового коммита.

#### 🔹 **Применить несколько коммитов (диапазон):**
```bash
git cherry-pick a1b2c3d^..d4e5f6g
```
Применяет все коммиты из указанного диапазона включительно, создавая для каждого новый коммит.

#### 🔹 **Перенести изменения без создания коммита:**
```bash
git cherry-pick --no-commit a1b2c3d
```
Применяет изменения в рабочую директорию и индекс, но не создает коммит автоматически.
</details>

### 🔄 Rebase

Перебазирование коммитов одной ветки на основание другой ветки, создавая линейную историю.

- 📈 Создает более чистую, линейную историю коммитов.
- 🧹 Помогает избежать ненужных merge-коммитов.
- 🔄 Позволяет переписать и реорганизовать локальную историю коммитов.
- ⚠️ Не рекомендуется для веток, которые уже опубликованы в удаленном репозитории.

> **Лучше всего для:** поддержания чистой истории перед слиянием фич, обновления локальных веток.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git rebase main` | Перебазировать текущую ветку на ветку main |
| `git rebase --onto <newbase> <oldbase>` | Перебазировать на новую базу от указанной старой |
| `git pull --rebase` | Получить изменения с удаленного репозитория и перебазировать |
| `git rebase --continue` | Продолжить процесс rebase после разрешения конфликтов |
| `git rebase --abort` | Отменить процесс rebase и вернуться к исходному состоянию |

#### 🔹 **Перебазировать текущую ветку на main:**
```bash
git checkout feature-branch
git rebase main
```
Переносит коммиты из текущей ветки поверх последнего коммита ветки main.

#### 🔹 **Обновить ветку с перебазированием вместо слияния:**
```bash
git pull --rebase origin main
```
Получает изменения из удаленного репозитория и применяет локальные коммиты поверх них.
</details>

### 🧩 Interactive Rebase

Мощный инструмент для редактирования истории коммитов с возможностью изменять порядок, объединять, разделять и редактировать коммиты.

- 🔧 Позволяет изменять, переименовывать, объединять, удалять коммиты.
- 🧠 Даёт полный контроль над историей локальной ветки.
- 📝 Помогает создать логически организованную и чистую историю перед публикацией.
- 🎯 Идеально для очистки WIP-коммитов перед созданием pull request.

> **Лучше всего для:** очистки истории перед публикацией, объединения множества маленьких коммитов.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git rebase -i HEAD~3` | Интерактивный rebase для 3 последних коммитов |
| `git rebase -i <commit-hash>` | Интерактивный rebase начиная с указанного коммита |
| `git commit --amend` | Изменить последний коммит (часто используется с rebase) |

#### 🔹 **Доступные операции в интерактивном режиме:**
- `pick` – использовать коммит без изменений
- `reword` – изменить сообщение коммита
- `edit` – остановиться для внесения изменений в коммит
- `squash` – объединить с предыдущим коммитом
- `fixup` – объединить с предыдущим без сохранения сообщения
- `drop` – удалить коммит

#### 🔹 **Объединить последние три коммита:**
```bash
git rebase -i HEAD~3
```
Заменить `pick` на `squash` или `fixup` для коммитов, которые нужно объединить.
</details>

### 🔍 Bisect

Бинарный поиск для нахождения коммита, в котором был внесен баг или нежелательное изменение.

- 🔎 Позволяет быстро найти проблемный коммит среди множества изменений.
- 🤖 Автоматизирует процесс поиска через бинарное разделение истории.
- ✅ Можно использовать с автоматизированными тестами.
- 🕒 Экономит огромное количество времени при отладке.

> **Лучше всего для:** поиска источника бага в большом количестве коммитов.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git bisect start` | Начать сессию бинарного поиска |
| `git bisect bad` | Пометить текущий коммит как содержащий проблему |
| `git bisect good <commit>` | Пометить указанный коммит как "хороший" |
| `git bisect reset` | Завершить сессию и вернуться к исходному состоянию |
| `git bisect run <script>` | Автоматизировать процесс с помощью скрипта |

#### 🔹 **Пример использования bisect:**
```bash
git bisect start
git bisect bad  # текущая версия содержит баг
git bisect good v1.0.0  # известная версия без бага

# Git чекаутит коммит посередине между "хорошим" и "плохим"
# Проверяем наличие бага, затем:
git bisect good  # если в этой версии бага нет
# или
git bisect bad   # если баг присутствует

# Повторяем, пока Git не определит проблемный коммит
git bisect reset  # Завершаем сессию bisect
```
</details>

### 📜 Reflog

Журнал ссылок на коммиты, который сохраняет историю всех изменений HEAD и других ссылок в локальном репозитории.

- 🔄 Хранит историю всех перемещений указателя HEAD.
- 💾 Помогает восстановить "потерянные" коммиты после reset, rebase, checkout.
- 🛟 Спасательный круг для восстановления данных при непреднамеренном изменении истории.
- ⏱️ Позволяет вернуться к любому состоянию репозитория за последние ~30 дней.

> **Лучше всего для:** восстановления после ошибок, возврата к предыдущим состояниям.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git reflog` | Показать журнал ссылок |
| `git reflog show <ref>` | Показать reflog для конкретной ссылки |
| `git checkout HEAD@{2}` | Перейти к состоянию, которое было 2 операции назад |
| `git reset --hard HEAD@{2}` | Сбросить текущую ветку к состоянию 2 операции назад |

#### 🔹 **Восстановление после неудачного rebase:**
```bash
git reflog  # Найти запись перед началом rebase
git reset --hard HEAD@{5}  # Восстановиться к состоянию перед rebase
```

#### 🔹 **Восстановление удаленной ветки:**
```bash
git reflog  # Найти последний коммит удаленной ветки
git checkout -b восстановленная-ветка HEAD@{4}  # Создать новую ветку из этого состояния
```
</details>

### 💥 Reset Hard

Команда для жесткого сброса текущей ветки к указанному состоянию, удаляя все изменения.

- 🔙 Позволяет полностью откатить ветку к предыдущему состоянию.
- 🧹 Удаляет все коммиты и изменения, сделанные после указанного коммита.
- ⚠️ Необратимая операция, если не использовать reflog для восстановления.
- 🚫 Следует использовать с осторожностью для локальных веток.

> **Лучше всего для:** отмены ошибочных коммитов, начала с чистого состояния.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git reset --hard HEAD~3` | Сбросить к состоянию 3 коммита назад, удалив все изменения |
| `git reset --hard <commit-hash>` | Сбросить к указанному коммиту |
| `git reset --hard origin/main` | Сбросить к состоянию удаленной ветки |

#### 🔹 **Режимы reset:**
- `--soft` – сохраняет изменения в индексе (staged)
- `--mixed` – сохраняет изменения в рабочей директории (default)
- `--hard` – удаляет все изменения

#### 🔹 **Полный сброс к состоянию удаленной ветки:**
```bash
git fetch origin
git reset --hard origin/main
```
Отбрасывает все локальные изменения и синхронизирует с удаленной веткой.
</details>

### 🔀 Merge Strategies

Продвинутые стратегии слияния, позволяющие контролировать процесс разрешения конфликтов.

- 🎯 Позволяют автоматизировать разрешение конфликтов по заданным правилам.
- 🔄 Стратегия `ours` сохраняет файлы текущей ветки при конфликтах.
- 🔄 Стратегия `theirs` предпочитает файлы из сливаемой ветки.
- 🧩 Полезно для автоматизации слияний в определенных ситуациях.

> **Лучше всего для:** управления конфликтами при слиянии веток с предсказуемыми изменениями.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git merge -s recursive -X ours feature` | Слияние с предпочтением текущих изменений |
| `git merge -s recursive -X theirs feature` | Слияние с предпочтением изменений из feature |
| `git merge -s ours feature` | Игнорирование всех изменений из сливаемой ветки |
| `git checkout --ours file.txt` | Выбрать нашу версию файла при конфликте |
| `git checkout --theirs file.txt` | Выбрать их версию файла при конфликте |

#### 🔹 **Слияние с автоматическим разрешением в пользу наших изменений:**
```bash
git merge -s recursive -X ours feature-branch
```
При конфликтах предпочитает изменения в текущей ветке.

#### 🔹 **Слияние с автоматическим разрешением в пользу их изменений:**
```bash
git merge -s recursive -X theirs feature-branch
```
При конфликтах предпочитает изменения в сливаемой ветке.
</details>

### 📦 Submodules

Механизм для включения одного Git-репозитория в другой как подмодуль, позволяя работать с зависимостями.

- 🔗 Позволяет включать внешние репозитории как поддиректории в основной проект.
- 📌 Фиксирует конкретную версию зависимости, гарантируя воспроизводимость.
- 🚀 Удобно для управления библиотеками, фреймворками и общими компонентами.
- 🔄 Можно обновлять зависимости централизованно.

> **Лучше всего для:** работы с внешними зависимостями, многокомпонентных систем.

<details>
<summary><b>Основные команды</b></summary>

| Команда | Описание |
|---------|----------|
| `git submodule add <repo_url> <path>` | Добавить подмодуль в проект |
| `git submodule init` | Инициализировать подмодули после клонирования |
| `git submodule update` | Обновить подмодули до зафиксированных коммитов |
| `git submodule update --remote` | Обновить подмодули до последней версии |
| `git clone --recursive <repo>` | Клонировать репозиторий со всеми подмодулями |

#### 🔹 **Добавление подмодуля:**
```bash
git submodule add https://github.com/username/library.git lib/library
```
Добавляет внешний репозиторий как подмодуль в указанный путь.

#### 🔹 **Клонирование проекта с подмодулями:**
```bash
git clone --recursive https://github.com/username/project.git
```
Или для уже клонированного репозитория:
```bash
git submodule init
git submodule update
```
</details>

---

## 🔄 Решение сложных конфликтов вручную с сохранением истории

<details>
<summary><b>Пошаговый пример разрешения конфликта</b></summary>

#### 1️⃣ Создаем и переходим в ветку разработки
```bash
git checkout -b feature/conflict-training
```

#### 2️⃣ Возвращаемся в ветку main
```bash
git checkout main
```

#### 3️⃣ Делаем коммит в main с изменением:
```
Text("Hello, world! v1")
```

#### 4️⃣ Возвращаемся в ветку feature/conflict-training и делаем коммит с изменением:
```
Text("Hello, world! v2")
```

#### 5️⃣ Возвращаемся в ветку main и делаем merge:
```bash
git merge feature/conflict-training
```
  
#### 6️⃣ Решаем конфликт вручную и делаем коммит:
```bash
git commit
```
</details>

---

## 🧠 Восстановление удалённых/перезаписанных коммитов

<div align="center">
  <img src="https://www.edureka.co/blog/wp-content/uploads/2016/11/Git-Architechture-Git-Tutorial-Edureka-2.png" alt="Git Recovery" width="500"/>
</div>

Даже если коммиты были удалены, перезаписаны или потеряны, Git часто сохраняет возможность восстановить их благодаря своей архитектуре.

- 💾 Git почти никогда не удаляет данные полностью до garbage collection.
- 🕒 Временное окно для восстановления обычно составляет ~30 дней.
- 🔮 Можно восстановить коммиты после неправильного rebase, reset, амендов или удаления веток.
- 🛡️ Знание этих техник — ключ к спокойствию при работе с Git.

> **Лучше всего для:** исправления критических ошибок в истории, восстановления потерянных данных.

<details>
<summary><b>Восстановление после различных ситуаций</b></summary>

### 🔹 **Восстановление после неудачного reset --hard**

```bash
# Шаг 1: Посмотреть reflog, чтобы найти последнее состояние до reset
git reflog

# Шаг 2: Найти запись типа "HEAD@{N}: commit: Ваше сообщение коммита"
# Шаг 3: Восстановить состояние
git reset --hard HEAD@{N}
```

### 🔹 **Восстановление после неудачного rebase или амендов**

```bash
# Шаг 1: Найти состояние до начала rebase
git reflog

# Шаг 2: Создать новую ветку из этого состояния
git branch восстановленная-ветка HEAD@{N}

# Шаг 3: Проверить, что все восстановлено
git checkout восстановленная-ветка
git log
```

### 🔹 **Восстановление удалённой ветки**

```bash
# Шаг 1: Найти последний коммит удалённой ветки
git reflog

# Шаг 2: Создать новую ветку с тем же именем из найденного коммита
git checkout -b deleted-branch HEAD@{N}
```

### 🔹 **Восстановление потерянных коммитов, не видимых в reflog**

```bash
# Шаг 1: Найти "плавающие" коммиты (обычно результат сборки мусора)
git fsck --lost-found

# Шаг 2: Просмотреть содержимое найденного коммита
git show <commit-hash>

# Шаг 3: Создать ветку из этого коммита
git branch recovered-branch <commit-hash>
```

### 🔹 **Восстановление после conflict-разрешения, которое пошло не так**

```bash
# Если вы еще в процессе слияния
git merge --abort

# Если вы уже закоммитили неправильное разрешение
git reflog
git reset --hard HEAD@{N}  # Где N - состояние до слияния
```

### 🔹 **Спасение от случайного force-push**

```bash
# Если ваша локальная ветка была перезаписана удаленной
git reflog
git reset --hard HEAD@{N}  # Где N - состояние до pull/fetch

# После восстановления будьте осторожны с push
git push --force-with-lease origin ветка
```
</details>

<details>
<summary><b>Профилактика потери данных</b></summary>

### 🔹 **Создание временной ветки перед сложными операциями**

```bash
# Перед началом сложного rebase или reset
git branch backup-branch

# После успешного завершения операции
git branch -D backup-branch
```

### 🔹 **Настройка более длительного хранения reflog**

```bash
# Увеличить время хранения reflog до 90 дней (по умолчанию 30)
git config --global gc.reflogExpire 90.days

# Увеличить время хранения недостижимых записей reflog
git config --global gc.reflogExpireUnreachable 30.days
```

### 🔹 **Создание реальных бэкапов для критически важных проектов**

```bash
# Создать пакет со всеми объектами и ссылками
git bundle create repo-backup.bundle --all

# Для восстановления
git clone repo-backup.bundle restored-repo
```
</details>

---

## 🌿 Модели ветвления в Git

Здесь представлены 4 популярные модели ветвления, которые применяются в разных типах проектов: от стартапов до крупных корпоративных систем. Каждая имеет свои сильные и слабые стороны.

### 🔵 GitHub Flow

<div align="center">
  <img src="https://github.com/zontz/advanced-git/blob/45308b880b4c1a68459e64c20ff31b3d95d8dc35/screenshots/g.png" alt="GitHub Flow" width="600"/>
</div>

Идеален для проектов с частыми деплоями и простым процессом разработки.

- ✅ Простая структура: только `main` и фичевые ветки.
- 🔀 Вся работа ведётся в ветках `feature/*`, сливающихся в `main` через Pull Request.
- 🚀 Слияние в `main` означает готовность к релизу.
- 📦 Отлично работает для CI/CD и web-проектов.

> **Подходит для:** небольших команд, open-source, веб-приложений.

### 🌳 Git Flow

<div align="center">
  <img src="https://github.com/zontz/advanced-git/blob/85f71a52e913fed3612dba02039f82257d22c2a5/screenshots/1_PtbECo8DeSwfFcWTCmxkqg.jpg?raw=true" alt="Git Flow" width="600"/>
</div>

Классическая модель с множеством веток — подходит для проектов с длительными релизными циклами.

| Ветка | Назначение |
|-------|------------|
| `main` | Только стабильные релизы |
| `develop` | Основная ветка для интеграции фич |
| `feature/*` | Разработка новых фич |
| `release/*` | Подготовка к релизу |
| `hotfix/*` | Экстренные исправления |

> **Подходит для:** крупных команд, долгих релизов, корпоративной разработки.

### 🚀 Release Flow (от Microsoft)

<div align="center">
  <img src="https://github.com/zontz/advanced-git/blob/774518c195526564df1b06163a4923598501ce84/screenshots/branchstrategy-releaseflow.png" alt="Release Flow" width="600"/>
</div>

Гибридная модель, предназначенная для управления стабильными версиями с возможностью патчей.

- `main` — стабильный релиз.
- `feature/*` — работа над новыми фичами.
- `release/*` — ветки конкретных версий (например, `release/1.2`).
- 🛠 Хотфиксы можно вносить в релизные ветки даже после релиза.

> **Подходит для:** мобильной разработки (iOS/Android), App Store релизов, долгосрочной поддержки версий.

### 🌱 Trunk-Based Development

<div align="center">
  <img src="https://github.com/zontz/advanced-git/blob/16ff89836dc4acdc3427c7eccac4dc97673235c9/screenshots/images.png" alt="Trunk-Based" width="600"/>
</div>

Минималистичная и гибкая модель, в которой вся разработка вращается вокруг одной ветки (`main` или `trunk`).

- 🔁 Все фичи разрабатываются в короткоживущих ветках.
- 🎯 Частые коммиты и интеграция в `main` — каждый день.
- 🔒 Часто используется совместно с feature toggles.
- 🚧 Требует хорошей автоматизации (CI, тесты).

> **Подходит для:** high-speed разработки, DevOps, небольших команд.

---

<div align="center">
  <p>
    <a href="https://git-scm.com/doc">📚 Официальная документация Git</a> •
    <a href="https://github.com/zontz/advanced-git">🌟 Репозиторий проекта</a>
  </p>
</div>



