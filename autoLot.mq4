//+------------------------------------------------------------------+
//|                                                      autoLot.mq4 |
//|                                                            d0as8 |
//|                                                             2.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version   "2.00"
#property strict

class Error {

   public:

      static string Msg( int code ) {
         switch ( code ) {
            case 0    : return( "0 - Нет ошибки" ); break;
            case 1    : return( "1 - Нет ошибки, но результат неизвестен" ); break;
            case 2    : return( "2 - Общая ошибка" ); break;
            case 3    : return( "3 - Неправильные параметры" ); break;
            case 4    : return( "4 - Торговый сервер занят" ); break;
            case 5    : return( "5 - Старая версия клиентского терминала" ); break;
            case 6    : return( "6 - Нет связи с торговым сервером" ); break;
            case 7    : return( "7 - Недостаточно прав" ); break;
            case 8    : return( "8 - Слишком частые запросы" ); break;
            case 9    : return( "9 - Недопустимая операция, нарушающая функционирование сервера" ); break;
            case 64   : return( "64 - Счет заблокирован" ); break;
            case 65   : return( "65 - Неправильный номер счета" ); break;
            case 128  : return( "128 - Истек срок ожидания совершения сделки" ); break;
            case 129  : return( "129 - Неправильная цена" ); break;
            case 130  : return( "130 - Неправильные стопы" ); break;
            case 131  : return( "131 - Неправильный объем" ); break;
            case 132  : return( "132 - Рынок закрыт" ); break;
            case 133  : return( "133 - Торговля запрещена" ); break;
            case 134  : return( "134 - Недостаточно денег для совершения операции" ); break;
            case 135  : return( "135 - Цена изменилась" ); break;
            case 136  : return( "136 - Нет цен" ); break;
            case 137  : return( "137 - Брокер занят" ); break;
            case 138  : return( "138 - Новые цены" ); break;
            case 139  : return( "139 - Ордер заблокирован и уже обрабатывается" ); break;
            case 140  : return( "140 - Разрешена только покупка" ); break;
            case 141  : return( "141 - Слишком много запросов" ); break;
            case 145  : return( "145 - Модификация запрещена, так как ордер слишком близок к рынку" ); break;
            case 146  : return( "146 - Подсистема торговли занята" ); break;
            case 147  : return( "147 - Использование даты истечения ордера запрещено брокером" ); break;
            case 148  : return( "148 - Количество открытых и отложенных ордеров достигло предела, установленного брокером" ); break;
            case 149  : return( "149 - Попытка открыть противоположный ордер в случае, если хеджирование запрещено" ); break;
            case 150  : return( "150 - Попытка закрыть позицию по инструменту в противоречии с правилом FIFO" ); break;
            case 4000 : return( "4000 - Нет ошибки" ); break;
            case 4001 : return( "4001 - Неправильный указатель функции" ); break;
            case 4002 : return( "4002 - Индекс массива - вне диапазона" ); break;
            case 4003 : return( "4003 - Нет памяти для стека функций" ); break;
            case 4004 : return( "4004 - Переполнение стека после рекурсивного вызова" ); break;
            case 4005 : return( "4005 - На стеке нет памяти для передачи параметров" ); break;
            case 4006 : return( "4006 - Нет памяти для строкового параметра" ); break;
            case 4007 : return( "4007 - Нет памяти для временной строки" ); break;
            case 4008 : return( "4008 - Неинициализированная строка" ); break;
            case 4009 : return( "4009 - Неинициализированная строка в массиве" ); break;
            case 4010 : return( "4010 - Нет памяти для строкового массива" ); break;
            case 4011 : return( "4011 - Слишком длинная строка" ); break;
            case 4012 : return( "4012 - Остаток от деления на ноль" ); break;
            case 4013 : return( "4013 - Деление на ноль" ); break;
            case 4014 : return( "4014 - Неизвестная команда" ); break;
            case 4015 : return( "4015 - Неправильный переход" ); break;
            case 4016 : return( "4016 - Неинициализированный массив" ); break;
            case 4017 : return( "4017 - Вызовы DLL не разрешены" ); break;
            case 4018 : return( "4018 - Невозможно загрузить библиотеку" ); break;
            case 4019 : return( "4019 - Невозможно вызвать функцию" ); break;
            case 4020 : return( "4020 - Вызовы внешних библиотечных функций не разрешены" ); break;
            case 4021 : return( "4021 - Недостаточно памяти для строки, возвращаемой из функции" ); break;
            case 4022 : return( "4022 - Система занята" ); break;
            case 4023 : return( "4023 - Критическая ошибка вызова DLL-функции" ); break;
            case 4024 : return( "4024 - Внутренняя ошибка" ); break;
            case 4025 : return( "4025 - Нет памяти" ); break;
            case 4026 : return( "4026 - Неверный указатель" ); break;
            case 4027 : return( "4027 - Слишком много параметров форматирования строки" ); break;
            case 4028 : return( "4028 - Число параметров превышает число параметров форматирования строки" ); break;
            case 4029 : return( "4029 - Неверный массив" ); break;
            case 4030 : return( "4030 - График не отвечает" ); break;
            case 4050 : return( "4050 - Неправильное количество параметров функции" ); break;
            case 4051 : return( "4051 - Недопустимое значение параметра функции" ); break;
            case 4052 : return( "4052 - Внутренняя ошибка строковой функции" ); break;
            case 4053 : return( "4053 - Ошибка массива" ); break;
            case 4054 : return( "4054 - Неправильное использование массива-таймсерии" ); break;
            case 4055 : return( "4055 - Ошибка пользовательского индикатора" ); break;
            case 4056 : return( "4056 - Массивы несовместимы" ); break;
            case 4057 : return( "4057 - Ошибка обработки глобальных переменных" ); break;
            case 4058 : return( "4058 - Глобальная переменная не обнаружена" ); break;
            case 4059 : return( "4059 - Функция не разрешена в тестовом режиме" ); break;
            case 4060 : return( "4060 - Функция не разрешена" ); break;
            case 4061 : return( "4061 - Ошибка отправки почты" ); break;
            case 4062 : return( "4062 - Ожидается параметр типа string" ); break;
            case 4063 : return( "4063 - Ожидается параметр типа integer" ); break;
            case 4064 : return( "4064 - Ожидается параметр типа double" ); break;
            case 4065 : return( "4065 - В качестве параметра ожидается массив" ); break;
            case 4066 : return( "4066 - Запрошенные исторические данные в состоянии обновления" ); break;
            case 4067 : return( "4067 - Ошибка при выполнении торговой операции" ); break;
            case 4068 : return( "4068 - Ресурс не найден" ); break;
            case 4069 : return( "4069 - Ресурс не поддерживается" ); break;
            case 4070 : return( "4070 - Дубликат ресурса" ); break;
            case 4071 : return( "4071 - Ошибка инициализации пользовательского индикатора" ); break;
            case 4072 : return( "4072 - Ошибка загрузки пользовательского индикатора" ); break;
            case 4099 : return( "4099 - Конец файла" ); break;
            case 4100 : return( "4100 - Ошибка при работе с файлом" ); break;
            case 4101 : return( "4101 - Неправильное имя файла" ); break;
            case 4102 : return( "4102 - Слишком много открытых файлов" ); break;
            case 4103 : return( "4103 - Невозможно открыть файл" ); break;
            case 4104 : return( "4104 - Несовместимый режим доступа к файлу" ); break;
            case 4105 : return( "4105 - Ни один ордер не выбран" ); break;
            case 4106 : return( "4106 - Неизвестный символ" ); break;
            case 4107 : return( "4107 - Неправильный параметр цены для торговой функции" ); break;
            case 4108 : return( "4108 - Неверный номер тикета" ); break;
            case 4109 : return( "4109 - Торговля не разрешена. Необходимо включить опцию \"Разрешить советнику торговать\" в свойствах эксперта" ); break;
            case 4110 : return( "4110 - Ордера на покупку не разрешены. Необходимо проверить свойства эксперта" ); break;
            case 4111 : return( "4111 - Ордера на продажу не разрешены. Необходимо проверить свойства эксперта" ); break;
            case 4112 : return( "4112 - Автоматическая торговля с помощью экспертов/скриптов запрещена на стороне сервера" ); break;
            case 4200 : return( "4200 - Объект уже существует" ); break;
            case 4201 : return( "4201 - Запрошено неизвестное свойство объекта" ); break;
            case 4202 : return( "4202 - Объект не существует" ); break;
            case 4203 : return( "4203 - Неизвестный тип объекта" ); break;
            case 4204 : return( "4204 - Нет имени объекта" ); break;
            case 4205 : return( "4205 - Ошибка координат объекта" ); break;
            case 4206 : return( "4206 - Не найдено указанное подокно" ); break;
            case 4207 : return( "4207 - Ошибка при работе с объектом" ); break;
            case 4210 : return( "4210 - Неизвестное свойство графика" ); break;
            case 4211 : return( "4211 - График не найден" ); break;
            case 4212 : return( "4212 - Не найдено подокно графика" ); break;
            case 4213 : return( "4213 - Индикатор не найден" ); break;
            case 4220 : return( "4220 - Ошибка выбора инструмента" ); break;
            case 4250 : return( "4250 - Ошибка отправки push-уведомления" ); break;
            case 4251 : return( "4251 - Ошибка параметров push-уведомления" ); break;
            case 4252 : return( "4252 - Уведомления запрещены" ); break;
            case 4253 : return( "4253 - Слишком частые запросы отсылки push-уведомлений" ); break;
            case 5001 : return( "5001 - Слишком много открытых файлов" ); break;
            case 5002 : return( "5002 - Неверное имя файла" ); break;
            case 5003 : return( "5003 - Слишком длинное имя файла" ); break;
            case 5004 : return( "5004 - Ошибка открытия файла" ); break;
            case 5005 : return( "5005 - Ошибка размещения буфера текстового файла" ); break;
            case 5006 : return( "5006 - Ошибка удаления файла" ); break;
            case 5007 : return( "5007 - Неверный хендл файла (файл закрыт или не был открыт)" ); break;
            case 5008 : return( "5008 - Неверный хендл файла (индекс хендла отсутствует в таблице)" ); break;
            case 5009 : return( "5009 - Файл должен быть открыт с флагом FILE_WRITE" ); break;
            case 5010 : return( "5010 - Файл должен быть открыт с флагом FILE_READ" ); break;
            case 5011 : return( "5011 - Файл должен быть открыт с флагом FILE_BIN" ); break;
            case 5012 : return( "5012 - Файл должен быть открыт с флагом FILE_TXT" ); break;
            case 5013 : return( "5013 - Файл должен быть открыт с флагом FILE_TXT или FILE_CSV" ); break;
            case 5014 : return( "5014 - Файл должен быть открыт с флагом FILE_CSV" ); break;
            case 5015 : return( "5015 - Ошибка чтения файла" ); break;
            case 5016 : return( "5016 - Ошибка записи файла" ); break;
            case 5017 : return( "5017 - Размер строки должен быть указан для двоичных файлов" ); break;
            case 5018 : return( "5018 - Неверный тип файла (для строковых массивов-TXT, для всех других-BIN)" ); break;
            case 5019 : return( "5019 - Файл является директорией" ); break;
            case 5020 : return( "5020 - Файл не существует" ); break;
            case 5021 : return( "5021 - Файл не может быть перезаписан" ); break;
            case 5022 : return( "5022 - Неверное имя директории" ); break;
            case 5023 : return( "5023 - Директория не существует" ); break;
            case 5024 : return( "5024 - Указанный файл не является директорией" ); break;
            case 5025 : return( "5025 - Ошибка удаления директории" ); break;
            case 5026 : return( "5026 - Ошибка очистки директории" ); break;
            case 5027 : return( "5027 - Ошибка изменения размера массива" ); break;
            case 5028 : return( "5028 - Ошибка изменения размера строки" ); break;
            case 5029 : return( "5029 - Структура содержит строки или динамические массивы" ); break;
            case 5200 : return( "5200 - URL не прошел проверку" ); break;
            case 5201 : return( "5201 - Не удалось подключиться к указанному URL" ); break;
            case 5202 : return( "5202 - Превышен таймаут получения данных" ); break;
            case 5203 : return( "5203 - Ошибка в результате выполнения HTTP запроса" ); break;
         };

         return( IntegerToString( code ) + " - Неизвестная ошибка"  );
      }
};

class Price {

   public:
      
      double price;
      double TP;
      double SL;
      
   Price( double p, double tp, double sl ) {
      Init( p, tp, sl );
   }
   
   void Init( double p, double tp, double sl ) {
      this.price = p;
      this.TP    = tp;
      this.SL    = sl;
   }
   
};

class Order {

   private:

      double freeMargin;
      double lot;
      Price * _Ask;
      Price * _Bid;
      
      double MAX_PART;
      double COMMISSION;
      int    TP;
      int    SL;
      double PRICE_TP;
      double PRICE_SL;
      double LOT_COST;  // Стоимость 1 лота в базовой валюте.
      double QUOTATION; // Котировка

      double PRESOLVE;

   public:

      Order( double maxPart, double commision, int stopLoss, double takeProfit ) {
         MAX_PART    = maxPart;
         COMMISSION  = commision;
         QUOTATION   = GetQuotation();
         LOT_COST    = MarketInfo( Symbol(), MODE_LOTSIZE ) / AccountLeverage();
         SL          = stopLoss;
         TP          = (int)( stopLoss * takeProfit );
         PRICE_SL    = NormalizeDouble( SL * Point, Digits );
         PRICE_TP    = NormalizeDouble( TP * Point, Digits );
         PRESOLVE    = MAX_PART / LOT_COST / AccountLeverage() / ( SL * Point / QUOTATION +  COMMISSION / AccountLeverage() );

         _Ask = new Price( 0, 0, 0 );
         _Bid = new Price( 0, 0, 0 );

         Recalc();
      }

      ~Order() {
         delete( _Bid );
         delete( _Ask );
      }

      void Recalc() {
         freeMargin = AccountFreeMargin();

         lot = freeMargin * PRESOLVE;
         
         double a = Ask;
         _Ask.Init( a, a + PRICE_TP, a - PRICE_SL );
         
         double b = Bid;
         _Bid.Init( b, b - PRICE_TP, b + PRICE_SL );
      }

      static double Normalize( double value, int numbers = 2 ) {
         return( NormalizeDouble( ((int)(value * MathPow( 10 , numbers ) )) / MathPow( 10, numbers ), numbers ) );
      }

      static double GetQuotation() {
         string currency = AccountCurrency();
         string profit   = SymbolInfoString( Symbol(), SYMBOL_CURRENCY_PROFIT );

         double res = 1.0;
         if ( 0 == StringCompare( currency, profit ) )
            return( res );

         ResetLastError();
         res = MarketInfo( StringConcatenate( currency, profit ), MODE_ASK );
         if ( 4106 == GetLastError() ) {
            ResetLastError();
            res = 1.0 / MarketInfo( StringConcatenate( profit, currency ), MODE_BID );
            if ( 0 != GetLastError() )
               Alert(  __FUNCTION__, ": ", Error::Msg( GetLastError() ) );
         }

         return( NormalizeDouble( res, Digits ) );
      }

      string GetOrderComment() {
         string res = StringFormat(
            "MP%G FM%G SL%G LOT%G",
            MAX_PART, freeMargin, SL, Lot()
         );

         return( res );
      }

      string GetComment() {
         double lotNormal = Lot();
         string currency  = AccountCurrency();
         double tickValue = lotNormal * MarketInfo( Symbol(), MODE_TICKVALUE );

         string res = StringFormat(
            "%-11s = %G %% (%G %s)\n%-11s = %G %% (%G %s)\n%-11s = %G pips (%G %s)\n%-11s = %G pips (%G %s)\n%-11s = %G (%G)\n",
            "maxPart",    MAX_PART   * 100, Normalize( MAX_PART * freeMargin ),             currency,
            "commission", COMMISSION * 100, Normalize( COMMISSION * LOT_COST * lotNormal ), currency,
            "stopLoss",   SL, Normalize( SL * tickValue ),                                  currency,
            "takeProfit", TP, Normalize( TP * tickValue ),                                  currency,
            "LOT",        lotNormal, lot
         );

         return( res );
      }

      double PriceTP() {
         return PRICE_TP;
      }

      double PriceSL() {
         return PRICE_SL;
      }

      double Lot() {
         double lotNormal = lot;

         double minLot = MarketInfo( Symbol(), MODE_MINLOT );
         double maxLot = MarketInfo( Symbol(), MODE_MAXLOT );
         if ( minLot > lotNormal )
           lotNormal = minLot;
         if ( maxLot < lotNormal )
           lotNormal = maxLot;

         return Normalize( lotNormal );
      }

      Price * GetAsk() {
         return( _Ask );
      }
      
      Price * GetBid() {
         return( _Bid );
      }
};

class Drawer {

   private:

      Order * order;

      bool ASK;

      string BUY_BUTTON;
      string SELL_BUTTON;
      string BUY_SL_HLINE;
      string BUY_TP_HLINE;
      string SELL_SL_HLINE;
      string SELL_TP_HLINE;

   public:

      Drawer(Order *order, bool ask) {
         this.order = order;
         this.ASK   = ask;

         BUY_BUTTON    = "AUTOLOT_BUY_BUTTON";
         SELL_BUTTON   = "AUTOLOT_SELL_BUTTON";
         BUY_SL_HLINE  = "AUTOLOT_BUY_SL_HLINE";
         BUY_TP_HLINE  = "AUTOLOT_BUY_TP_HLINE";
         SELL_SL_HLINE = "AUTOLOT_SELL_SL_HLINE";
         SELL_TP_HLINE = "AUTOLOT_SELL_TP_HLINE";

         CreateButton( BUY_BUTTON,    "BUY",  clrMidnightBlue, 70, 20 );
         CreateButton( SELL_BUTTON,   "SELL", clrDarkRed,  70, 45 );
         CreateLine(   SELL_TP_HLINE, clrDarkRed );
         CreateLine(   BUY_TP_HLINE,  clrMidnightBlue );
         CreateLine(   SELL_SL_HLINE, clrDarkRed );
         CreateLine(   BUY_SL_HLINE,  clrMidnightBlue );
      }

      ~Drawer() {
         EraseObject( BUY_SL_HLINE );
         EraseObject( SELL_SL_HLINE );
         EraseObject( BUY_TP_HLINE );
         EraseObject( SELL_TP_HLINE );
         EraseObject( BUY_BUTTON );
         EraseObject( SELL_BUTTON );
      }

      void Update() {
         order.Recalc();

         MoveLine( BUY_TP_HLINE,  order.GetAsk().TP );
         MoveLine( SELL_TP_HLINE, order.GetBid().TP );
         MoveLine( BUY_SL_HLINE,  order.GetAsk().SL );
         MoveLine( SELL_SL_HLINE, order.GetBid().SL );

         Comment( order.GetComment() );
     }

      void OnButtonClick( const string &buttonName ) {
         if ( BUY_BUTTON != buttonName && SELL_BUTTON != buttonName ) return;

         order.Recalc();

         if ( !ASK || IDYES == MessageBox( order.GetComment(), buttonName, MB_YESNO ) ) {
            ResetLastError();

            order.Recalc();

            int orderId = -1;
            if ( BUY_BUTTON == buttonName )
               orderId = OrderSend(
                  Symbol(),
                  OP_BUY,
                  order.Lot(),
                  order.GetAsk().price,
                  0,
                  order.GetAsk().SL,
                  order.GetAsk().TP,
                  order.GetOrderComment(),
                  0, 0, clrBlue );
            else
               orderId = OrderSend(
                  Symbol(),
                  OP_SELL,
                  order.Lot(),
                  order.GetBid().price,
                  0,
                  order.GetBid().SL,
                  order.GetBid().TP,
                  order.GetOrderComment(),
                  0, 0, clrRed );
                     
            if ( 0 > orderId ) {
               PlaySound( "timeout.wav" );

               string s1 = "OrderSend: " + Error::Msg( GetLastError() );
               Alert( s1 );
               MessageBox( s1 );
            } else
               PlaySound( "Ok.wav" );
         }

         ObjectSetInteger( 0, buttonName, OBJPROP_STATE, false );
         ChartRedraw();
      }

   private:

      bool CreateButton( string id, string name, int clr, int x, int y ) {
         ObjectCreate(     0, id, OBJ_BUTTON,        0, 100, 100 );
         ObjectSetInteger( 0, id, OBJPROP_COLOR,     clrWhite );
         ObjectSetInteger( 0, id, OBJPROP_BGCOLOR,   clr );
         ObjectSetInteger( 0, id, OBJPROP_CORNER,    CORNER_RIGHT_UPPER );
         ObjectSetInteger( 0, id, OBJPROP_XDISTANCE, x );
         ObjectSetInteger( 0, id, OBJPROP_YDISTANCE, y );
         ObjectSetInteger( 0, id, OBJPROP_XSIZE,     50 );
         ObjectSetInteger( 0, id, OBJPROP_YSIZE,     20 );
         ObjectSetString ( 0, id, OBJPROP_FONT,      "Arial" );
         ObjectSetInteger( 0, id, OBJPROP_FONTSIZE,  10 );
         ObjectSetString ( 0, id, OBJPROP_TEXT,      name );

         return( true );
      }

      bool CreateLine( string id, int clr ) {
         ObjectCreate(     0, id, OBJ_HLINE,         0, 0, 0 );
         ObjectSetInteger( 0, id, OBJPROP_COLOR,     clr );
         ObjectSetInteger( 0, id, OBJPROP_STYLE,     STYLE_DOT );
         ObjectSetInteger( 0, id, OBJPROP_WIDTH,     1 );
         ObjectSetInteger( 0, id, OBJPROP_BACK,      true );
         ObjectSetInteger( 0, id, OBJPROP_SELECTABLE,false );
         ObjectSetInteger( 0, id, OBJPROP_SELECTED,  false );
         ObjectSetInteger( 0, id, OBJPROP_HIDDEN,    true );

         return( true );
      }

      bool MoveLine( string id, double price ) {
         if ( -1 == ObjectFind( 0, id ) ) return( false );

         ObjectSetDouble( 0, id, OBJPROP_PRICE, price );

         return( true );
      }

      bool EraseObject( string id ) {
         if ( -1 == ObjectFind( 0, id ) ) return( true );

         if( !ObjectDelete( 0, id ) ) {
            Alert( __FUNCTION__, ": ", Error::Msg( GetLastError() ) );
            return( false );
         }

         return( true );
      }

};

Drawer * drawer;

// Events

input double inMaxPart    = 0.01;  //Максимальная доля от свободной маржи на сделку
input double inCommission = 0.01;  //Комиссия (доля от стоимости 1 лота в базовой валюте)
input int    inStopLoss   = 100;   //Стоп лосс (пипс)
input double inTakeProfit = 2.0;   //Тейк профит (доля от стоп лосс)
input bool   inAsk        = true;  //Подтверждение открытия сделки

int OnInit() {
   drawer = new Drawer(new Order( inMaxPart, inCommission, inStopLoss, inTakeProfit ), inAsk );

   if ( EventSetMillisecondTimer( 500 ) ) {
      OnTimer();
      return( INIT_SUCCEEDED );
   } else
      return( INIT_FAILED );
}

void OnTimer() {
   drawer.Update();
}

void OnDeinit( const int reason ) {
   EventKillTimer();

   delete( drawer );
}

void OnChartEvent( const int id, const long &lparam, const double &dparam, const string &sparam ) {
   if ( id != CHARTEVENT_OBJECT_CLICK ) return;

   drawer.OnButtonClick( sparam );
}