# 🚀 Advanced Git Guide

<div align="center">
  <img src="https://git-scm.com/images/logos/downloads/Git-Logo-2Color.png" alt="Git Logo" width="200"/>
</div>

## 📋 Содержание

- [Git Stash](#git-stash)
- [Cherry Pick](#cherry-pick)
- [Решение конфликтов](#решение-сложных-конфликтов-вручную-с-сохранением-истории)
- [Модели ветвления](#-модели-ветвления-в-git)
  - [GitHub Flow](#-github-flow)
  - [Git Flow](#-git-flow)
  - [Release Flow](#-release-flow-от-microsoft)
  - [Trunk-Based Development](#-trunk-based-development)

---

## 📦 Git Stash

> `git stash` — это временное **локальное** хранилище изменений.

Если у нас есть несохранённые изменения в файлах, но мы не хотим их коммитить прямо сейчас, можно использовать `git stash`. Это позволяет переключиться на другую ветку или выполнить другие задачи, а затем вернуться к изменениям, когда это потребуется.

### Основные команды:

| Команда | Описание |
|---------|----------|
| `git stash` | Сохранить изменения в stash |
| `git stash list` | Посмотреть список stash'ей |
| `git stash apply` | Применить stash без удаления |
| `git stash pop` | Применить stash и удалить его |

<details>
<summary><b>Подробнее о командах</b></summary>

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

#### 1️⃣ `git stash apply`
Применяет stash, но **не удаляет** его из списка stash'ей. Это удобно, если мы хотим использовать этот stash несколько раз или на разных ветках.
  
```bash
git stash apply
```

#### 2️⃣ `git stash pop`
Применяет stash и **удаляет** его из списка stash'ей. Это полезно, если stash нужен только один раз.
  
```bash
git stash pop
```
</details>

---

## 🍒 Cherry Pick

> `git cherry-pick` позволяет **применить один или несколько конкретных коммитов** из другой ветки в текущую.

Это удобно, когда нужно "перенести" нужный коммит вручную, без слияния всей ветки.

### Основные команды:

| Команда | Описание |
|---------|----------|
| `git cherry-pick <commit-hash>` | Применить один коммит |
| `git cherry-pick <hash1>^..<hash2>` | Применить диапазон коммитов |

<details>
<summary><b>Примеры использования</b></summary>

#### 🔹 **Применить один коммит по его hash:**
```bash
git cherry-pick a1b2c3d
```

#### 🔹 **Применить несколько коммитов (диапазон):**
```bash
git cherry-pick a1b2c3d^..d4e5f6g
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
  <img src="https://github.com/zontz/advanced-git/blob/ba8388f1fea6bc0bf59bfaa8ec34aa5e6a1f9105/screenshots/tbd_workflow.drawio-1-1.png" alt="Trunk-Based" width="600"/>
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




