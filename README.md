# StocksViewer – трекер акций

### Проектная работа в рамках отоброчного этапа в Школу Мобильной Разработки Яндекса 2021.
#### Проект выполнил Бен Мустафа Анас

## Краткий обзор функционала

Приложение включает в себя несколько экранов
<!--ts-->
  * Основной экран с избранными акциями <br />
  * Внутренний экран акции с графиком и информацией о компании <br />
  * Экран последних новостей <br />
<!--te-->

#### Главный экран
На главном экране отображаются избранные акции пользователя. При первом запуске, список акций наполняется несколькими популярыми акциями технологического сектора.

Поиск акций по тикеру или названию компании располагается здесь же. При поиске, акции можно добавлять в избранное.
<img src="https://user-images.githubusercontent.com/57250290/112748049-f366e900-8fc1-11eb-8de0-5d34a6f6caf6.mov" alt="alt text" width="300" height="600">

Также, акции можно удалять из списка.
<img src="https://user-images.githubusercontent.com/57250290/112748212-ff9f7600-8fc2-11eb-8bd2-fb0eaad7f6fd.mov" alt="alt text" width="300" height="600">

Все изменения, разумеется, сохраняются на устройстве. Для этого используется CoreData.
