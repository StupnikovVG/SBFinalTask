﻿
Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр ОстаткиТоваров Приход
	Движения.ПартииТоваров.Записывать = Истина;
	Движения.ОстаткиТоваров.Записывать = Истина;
	Для Каждого ТекСтрокаНоменклатура Из Номенклатура Цикл
		Движение = Движения.ОстаткиТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Номенклатура = ТекСтрокаНоменклатура.Номенклатура;
		Движение.Количество = ТекСтрокаНоменклатура.Количество;
		
		// регистр ПартииТоваров Приход
		Движение = Движения.ПартииТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Номенклатура = ТекСтрокаНоменклатура.Номенклатура;
		Движение.Партия = Ссылка;
		Движение.Количество = ТекСтрокаНоменклатура.Количество;
		Движение.Сумма = ТекСтрокаНоменклатура.Сумма;
	КонецЦикла;


КонецПроцедуры
