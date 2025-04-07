# advanced-git

## Git Stash

`git stash` — это временное **локальное** хранилище изменений. Если у нас есть несохранённые изменения в файлах, но мы не хотим их коммитить прямо сейчас, можно использовать `git stash`. Это позволяет переключиться на другую ветку или выполнить другие задачи, а затем вернуться к изменениям, когда это потребуется.

### Основные команды:

- 🔹 **Сохранить изменения в stash:**  
  ```bash
  git stash
  ```
  Это очистит рабочую директорию, сохранив изменения в скрытом списке stash'ей.

- 🔹 **Посмотреть список stash'ей:**  
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

## Cherry Pick

`git cherry-pick` позволяет **применить один или несколько конкретных коммитов** из другой ветки в текущую, без слияния всей ветки. Это удобно, когда нужно "перенести" нужный коммит вручную.

### Основные команды:

- 🔹 **Применить один коммит по его hash:**
  ```bash
  git cherry-pick a1b2c3d

- 🔹 **Применить несколько коммитов (диапазон):**
  ```bash
  git cherry-pick a1b2c3d^..d4e5f6g

## Решение сложных конфликтов вручную с сохранением истории
  #### 1️⃣ создал и перешел в ветку feature/conflict-training

  #### 2️⃣ вернулся в ветку main

  #### 3️⃣ сделал коммит в main с изменением:
    Text("Hello, world! v1")

  #### 4️⃣ вернулся в ветку feature/conflict-training и сделал коммит с изменением:
    Text("Hello, world! v2")

  #### 5️⃣ вернулся в ветку main и сделал merge:
    git merge feature/conflict-training
  
  #### 6️⃣ решил конфликт вручную и сделал коммит:
    git commit



![GitFlow](https://github.com/zontz/advanced-git/blob/85f71a52e913fed3612dba02039f82257d22c2a5/screenshots/1_PtbECo8DeSwfFcWTCmxkqg.jpg?raw=true)
![GithubFlow](https://github.com/zontz/advanced-git/blob/45308b880b4c1a68459e64c20ff31b3d95d8dc35/screenshots/g.png)
![ReleaseFlow](https://github.com/zontz/advanced-git/blob/774518c195526564df1b06163a4923598501ce84/screenshots/branchstrategy-releaseflow.png)



