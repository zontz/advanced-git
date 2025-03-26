# advanced-git

Stash:
git stash - временное локальное хранилище изменений. Если у нас есть изменение в файлах, которые мы сделали, но не хотим пока комитить, то мы можем сделать git stash и вернутся к этим изменениям, когда нам будет это необходимо.
Есть 2 вида применения stash:
git stash apply - применяет stash, но не удаляет его из списка stash'ей. Это удобно, если мы хотим использовать этот стеш на нескольких ветках или несколько раз, не потеряв его
git stash pop - применяет stash и удаляет его из списка stash'ей. Это удобно, если stash нужен только один раз, и ты не хочешь его оставлять в истории.
