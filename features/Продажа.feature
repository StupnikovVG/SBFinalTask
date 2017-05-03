﻿# encoding: utf-8
# language: ru
@tree

Функционал: Продажа
	Как Продавец
	Хочу фиксировать реализацию товара документом ПРодажа
	Чтобы автоматизировать учет реализации товаров и услуг

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий:
	Допустим Я Подготавливаю вспомогательные данные для сценария продажа
	И Я удаляю документы вида "Продажа" по контрагенту "000000003"
	Когда Я создаю документ Продажа
		Когда Я нажимаю кнопку командного интерфейса "Продажа"
		Тогда открылось окно "Продажа"
		И     я нажимаю на кнопку "Создать"
		Тогда открылось окно "Продажа (создание)"
	И Я заполняю шапку
		И     я открываю выпадающий список "Контрагент"
		И     я выбираю значение реквизита "Контрагент" из формы списка
		Тогда открылось окно "Контрагенты"
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Наименование' |
		| 'Тестовые контрагенты'  |
		И     В форме "Контрагенты" в ТЧ "Список" я выбираю текущую строку
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Наименование' |
		| 'Покупатель 1'  |
		И     В форме "Контрагенты" в ТЧ "Список" я выбираю текущую строку
	И я выбираю товары
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Номенклатура" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Номенклатура" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000001' | 'Тестовая номенклатура' |
		И     В форме "Номенклатура" в ТЧ "Список" я выбираю текущую строку
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000002' | 'Номенклатура 1' |
		И     В форме "Номенклатура" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Номенклатура" я активизирую поле "Количество"
		И     в ТЧ "Номенклатура" в поле "Количество" я ввожу текст "1,000"
		И     в ТЧ "Номенклатура" я активизирую поле "Цена"
		И     в ТЧ "Номенклатура" в поле "Цена" я ввожу текст "120,00"
		И     В форме "Продажа (создание) *" в ТЧ "Номенклатура" я завершаю редактирование строки
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Номенклатура" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Номенклатура" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000001' | 'Тестовая номенклатура' |
		И     В форме "Номенклатура" в ТЧ "Список" я выбираю текущую строку
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000003' | 'Номенклатура 2' |
		И     В форме "Номенклатура" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     в ТЧ "Номенклатура" я активизирую поле "Количество"
		И     в ТЧ "Номенклатура" в поле "Количество" я ввожу текст "1,000"
		И     в ТЧ "Номенклатура" я активизирую поле "Цена"
		И     в ТЧ "Номенклатура" в поле "Цена" я ввожу текст "180,00"
		И     В форме "Продажа (создание) *" в ТЧ "Номенклатура" я завершаю редактирование строки
	И я провожу документ
		И     я нажимаю на кнопку "Провести"
	И Я проверяю сообщение пользователю
	Тогда результат проведения корректен
		Когда открылось окно "Продажа * от *"
		И     В текущем окне я нажимаю кнопку командного интерфейса "Движения документа"
		Тогда табличный документ формы с именем "Результат" стал равен:
			| 'Номенклатура'   | 'Сумма Приход'      | 'Сумма Расход'      | 'Партии количество приход' | 'Партии количество расход' |
			| 'Номенклатура 1' | ''                  | ''                  | ''                         | ''                         |
			| 'Номенклатура 2' | ''                  | ''                  | ''                         | ''                         |
			| 'Итого'          | ''                  | ''                  | ''                         | ''                         |
			| ''               | ''                  | ''                  | ''                         | ''                         |
			| 'Номенклатура'   | 'Количество Приход' | 'Количество Расход' | ''                         | ''                         |
			| 'Номенклатура 1' | ''                  | '1,000'             | ''                         | ''                         |
			| 'Номенклатура 2' | ''                  | '1,000'             | ''                         | ''                         |
			| 'Итого'          | ''                  | '2,000'             | ''                         | ''                         |
