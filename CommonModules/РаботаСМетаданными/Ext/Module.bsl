﻿
Функция ИдентификаторПеречисленияПоСсылке(ЗначениеПеречисления) Экспорт
	
	ИмяПеречисления = ЗначениеПеречисления.Метаданные().Имя;
	ИндексЗначенияПеречисления = Перечисления[ИмяПеречисления].Индекс(ЗначениеПеречисления);
	Возврат Метаданные.Перечисления[ИмяПеречисления].ЗначенияПеречисления[ИндексЗначенияПеречисления].Имя;

КонецФункции

