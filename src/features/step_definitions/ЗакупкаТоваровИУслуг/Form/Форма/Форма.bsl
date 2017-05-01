﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПодготавливаюВспомогательныеДанные()","ЯПодготавливаюВспомогательныеДанные","Допустим Я Подготавливаю вспомогательные данные","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздаюДокументЗакупкаТоваровИУслуг()","ЯСоздаюДокументЗакупкаТоваровИУслуг","Когда я создаю документ Закупка товаров и услуг","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗаполняюШапку()","ЯЗаполняюШапку","И Я заполняю шапку","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыбираюТовары()","ЯВыбираюТовары","И я выбираю товары","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПровожуДокумент()","ЯПровожуДокумент","И я провожу документ","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"РезультатПроведенияКорректен()","РезультатПроведенияКорректен","Тогда результат проведения корректен","","");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры

#Область ЗагрузкаFixture

&НаКлиенте
Функция ПолучитьПутьКФайлОтносительноКаталогоFeatures(ИмяФайлаСРасширением)
	ПутьКФайлу = "";
	
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	
	ПутьКТекущемуFeatureФайлу = СостояниеVanessaBehavior.ТекущаяФича.ПолныйПуть;
	
	ПутьКФайлу = Лев(ПутьКТекущемуFeatureФайлу, СтрНайти(ПутьКТекущемуFeatureФайлу, "features") - 1) + ИмяФайлаСРасширением;
	
	Возврат ПутьКФайлу;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакета(ИмяМакета)
	Ванесса.ЗапретитьВыполнениеШагов();
	
	НачальноеИмяФайла = ПолучитьПутьКФайлОтносительноКаталогоFeatures("tools\Выгрузка и загрузка данных XML.epf");
	
	Адрес = "";
	
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗагрузитьFixtureИзМакетаЗавершение", ЭтотОбъект, ИмяМакета), Адрес, НачальноеИмяФайла, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакетаЗавершение(УдалосьПоместитьФайл, Адрес, ВыбранноеИмяФайла, ИмяМакета) Экспорт
	ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета);
	
	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета)
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяВременногоФайла);
	
	ВнешняяОбработка = ВнешниеОбработки.Создать(ИмяВременногоФайла, Ложь);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	Текст = РеквизитФормыВЗначение("Объект").ПолучитьМакет(ИмяМакета).ПолучитьТекст();
	
	ВременныйДокумент = Новый ТекстовыйДокумент;
	ВременныйДокумент.УстановитьТекст(Текст);
	ВременныйДокумент.Записать(ИмяВременногоФайла, КодировкаТекста.UTF8);

	ВнешняяОбработка.ВыполнитьЗагрузку(ИмяВременногоФайла);
КонецПроцедуры

#КонецОбласти 

///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим Я Подготавливаю вспомогательные данные
//@ЯПодготавливаюВспомогательныеДанные()
Процедура ЯПодготавливаюВспомогательныеДанные() Экспорт
	
	ЗагрузитьFixtureИзМакета("Номенклатура");
	ЗагрузитьFixtureИзМакета("Контрагенты");
	
КонецПроцедуры

&НаКлиенте
//Когда я создаю документ Закупка товаров и услуг
//@ЯСоздаюДокументЗакупкаТоваровИУслуг()
Процедура ЯСоздаюДокументЗакупкаТоваровИУслуг() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И Я заполняю шапку
//@ЯЗаполняюШапку()
Процедура ЯЗаполняюШапку() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я выбираю товары
//@ЯВыбираюТовары()
Процедура ЯВыбираюТовары() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//И я провожу документ
//@ЯПровожуДокумент()
Процедура ЯПровожуДокумент() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры

&НаКлиенте
//Тогда результат проведения корректен
//@РезультатПроведенияКорректен()
Процедура РезультатПроведенияКорректен() Экспорт
	//Ванесса.ПосмотретьЗначение(Парам01,Истина);
	ВызватьИсключение "Не реализовано.";
КонецПроцедуры
