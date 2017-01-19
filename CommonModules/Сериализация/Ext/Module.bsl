﻿
Функция Объект_в_XDTO(СериализуемыйОбъект) Экспорт
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	Возврат Сериализатор.ЗаписатьXDTO(СериализуемыйОбъект);	
	
КонецФункции

Функция Объект_в_строку(СериализуемыйОбъект) Экспорт
	
	ОбъектXDTO = Объект_в_XDTO(СериализуемыйОбъект);
	
	Возврат XDTO_в_строку(ОбъектXDTO);
	
КонецФункции

Функция Объект_в_XML(СериализуемыйОбъект) Экспорт
	
	Строка = Объект_в_строку(СериализуемыйОбъект);
	
	Возврат Строка_в_XML(Строка);
	
КонецФункции

Функция Объект_в_DOM(СериализуемыйОбъект) Экспорт
	
	ОбъектXDTO = Объект_в_XDTO(СериализуемыйОбъект);
	
	Возврат  XDTO_в_DOM(ОбъектXDTO);
	
КонецФункции


Функция XDTO_в_объект(ОбъектXDTO) Экспорт
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	
	Возврат Сериализатор.ПрочитатьXDTO(ОбъектXDTO);	
	
	
КонецФункции

Функция XDTO_в_строку(ОбъектXDTO) Экспорт
	
	ЗаписьXML = Новый ЗаписьXML; 
	ЗаписьXML.УстановитьСтроку("UTF-8"); 
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ФабрикаXDTO.ЗаписатьXML(ЗаписьXML, ОбъектXDTO,,,,НазначениеТипаXML.Явное); 
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции

Функция XDTO_в_XML(ОбъектXDTO) Экспорт
	
	Строка = XDTO_в_строку(ОбъектXDTO);
	
	Возврат Строка_в_XML(Строка);
	
КонецФункции

Функция XDTO_в_DOM(ОбъектXDTO) Экспорт
	
	ЧтениеXML = XDTO_в_XML(ОбъектXDTO);
	
	Возврат XML_в_DOM(ЧтениеXML);
	
КонецФункции


Функция Строка_в_объект(Строка) Экспорт
	
	ОбъектXDTO = Строка_в_XDTO(Строка);
	
	Возврат XDTO_в_объект(ОбъектXDTO);
	
КонецФункции

Функция Строка_в_XDTO(Строка) Экспорт
	
	ЧтениеXML = Строка_в_XML(Строка);
	
	Возврат ФабрикаXDTO.ПрочитатьXML(ЧтениеXML);
	
КонецФункции

Функция Строка_в_XML(Строка) Экспорт
	
	ЧтениеXML=Новый ЧтениеXML(); 
	ЧтениеXML.УстановитьСтроку(Строка);
	ЧтениеXML.Прочитать();
	
	Возврат ЧтениеXML;
	
КонецФункции

Функция Строка_в_DOM(Строка) Экспорт
	
	ЧтениеXML = Строка_в_XML(Строка);
	ПостроительDOM = Новый ПостроительDOM;
	
	Возврат ПостроительDOM.Прочитать(ЧтениеXML);
	
	
КонецФункции


Функция XML_в_DOM(ЧтениеXML) Экспорт
	
	ПостроительDOM = Новый ПостроительDOM;
	
	Возврат ПостроительDOM.Прочитать(ЧтениеXML);
	
КонецФункции


Функция DOM_в_объект(ОбъектDOM) Экспорт
	
	Строка = DOM_в_строку(ОбъектDOM);
	
	Возврат Строка_в_объект(Строка);
	
КонецФункции

Функция DOM_в_XDTO(ОбъектDOM) Экспорт
	
	Строка = DOM_в_строку(ОбъектDOM);
	
	Возврат Строка_в_XDTO(Строка);
	
КонецФункции

Функция DOM_в_строку(ОбъектDOM) Экспорт
	
	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.УстановитьСтроку("UTF-8"); 
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	
	ЗаписьDOM = Новый ЗаписьDOM();
	ЗаписьDOM.Записать(ОбъектDOM.ПервыйДочерний, ЗаписьXML);
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции

Функция ПолучитьОбъектИзФайла(ПутьКФайлу) Экспорт
	
	ЧтениеXML= Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ПутьКФайлу);

	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	Возврат Сериализатор.ПрочитатьXML(ЧтениеXML);
	
КонецФункции
Процедура СохранитьОбъектВФайл(Объект, ПутьКФайлу) Экспорт 
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	ЗаписьXML = Новый ЗаписьXML; 
	ЗаписьXML.ОткрытьФайл(ПутьКФайлу);
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	Сериализатор.ЗаписатьXML(ЗаписьXML, Объект);
	
КонецПроцедуры

Функция СериализоватьОбъект(СериализуемыйОбъект) Экспорт
	
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	ОбъектXDTO = Сериализатор.ЗаписатьXDTO(СериализуемыйОбъект);	
	
	ЗаписьXML = Новый ЗаписьXML; 
	ЗаписьXML.УстановитьСтроку("UTF-8"); 
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ФабрикаXDTO.ЗаписатьXML(ЗаписьXML, ОбъектXDTO,,,,НазначениеТипаXML.Явное); 
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции
Функция ДесериализоватьОбъект(Строка) Экспорт
	
	ЧтениеXML=Новый ЧтениеXML(); 
	ЧтениеXML.УстановитьСтроку(Строка);
	ЧтениеXML.Прочитать();
	
	ОбъектXDTO = ФабрикаXDTO.ПрочитатьXML(ЧтениеXML);
	Сериализатор = Новый СериализаторXDTO(ФабрикаXDTO);
	
	Возврат Сериализатор.ПрочитатьXDTO(ОбъектXDTO);	
	
КонецФункции

// json
Функция ОбъектВСтрокуJSON(СериализуемыйОбъект)
	
	КопияОбъекта = КопияКоллекции(СериализуемыйОбъект);
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	
	ЗаписатьJSON(ЗаписьJSON, КопияОбъекта); 
	
	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции
