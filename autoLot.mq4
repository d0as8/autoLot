//+------------------------------------------------------------------+
//|                                                      autoLot.mq4 |
//|                                                            d0as8 |
//|                                                             2.00 |
//+------------------------------------------------------------------+
#property copyright "d0as8"
#property version   "2.00"
#property strict

input double maxPart    = 0.01;  //maxPart. ������������ ���� �� ��������� ����� �� ������
input double commission = 0.1;   //commission. �������� (���� �� ������)
input int    stopLoss   = 100;   //stopLoss. ���� ���� (����)
input double takeProfit = 1;     //takeProfit. ���� ������ (���� �� ���� ����)
input bool   ASK        = true;  //ASK. ������������ ������s

string BUY_BUTTON    = "AUTOLOT_BUY_BUTTON";
string SELL_BUTTON   = "AUTOLOT_SELL_BUTTON";
string BUY_SL_HLINE  = "AUTOLOT_BUY_SL_HLINE";
string BUY_TP_HLINE  = "AUTOLOT_BUY_TP_HLINE";
string SELL_SL_HLINE = "AUTOLOT_SELL_SL_HLINE";
string SELL_TP_HLINE = "AUTOLOT_SELL_TP_HLINE";

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

bool CreateHLine( string id, int clr ) {
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

bool MoveHLine( string id, double price ) {
   if ( -1 == ObjectFind( 0, id ) ) return( false );

   ObjectSetDouble( 0, id, OBJPROP_PRICE, price );
   
   return( true );
}

bool EraseObject( string id ) {
   if ( -1 == ObjectFind( 0, id ) ) return( true );

   if( !ObjectDelete( 0, id ) ) {
      Print( __FUNCTION__, ": ", ErrorMsg( GetLastError() ) );
      return( false );
   }

   return( true );
}

int OnInit() {
   if ( 0.005 > maxPart && 0.5 < maxPart ) {
      Print( __FUNCTION__, ": �������� �������� maxPart" );
      return( INIT_PARAMETERS_INCORRECT );      
   }

   if ( 0.001 > commission && 1 < commission ) {
      Print( __FUNCTION__, ": �������� �������� commission" );
      return( INIT_PARAMETERS_INCORRECT );      
   }

   if ( 0 > takeProfit ) {
      Print( __FUNCTION__, ": �������� �������� takeProfit" );
      return( INIT_PARAMETERS_INCORRECT );      
   }

   CreateButton( BUY_BUTTON,    "BUY",  clrMidnightBlue, 70, 20 );
   CreateButton( SELL_BUTTON,   "SELL", clrDarkRed,  70, 45 );
   CreateHLine ( BUY_SL_HLINE,  clrMidnightBlue );
   CreateHLine ( SELL_SL_HLINE, clrDarkRed );
   CreateHLine ( SELL_TP_HLINE, clrDarkRed );
   CreateHLine ( BUY_TP_HLINE,  clrMidnightBlue );

   if ( EventSetMillisecondTimer( 500 ) ) {
      OnTimer();
      return( INIT_SUCCEEDED );
   } else 
      return( INIT_FAILED );
}

void OnDeinit( const int reason ) {
   EventKillTimer();

   EraseObject( BUY_BUTTON );
   EraseObject( SELL_BUTTON );
   EraseObject( BUY_SL_HLINE );
   EraseObject( BUY_TP_HLINE );
   EraseObject( SELL_SL_HLINE );
   EraseObject( SELL_TP_HLINE );
}

void OnChartEvent( const int id, const long &lparam, const double &dparam, const string &sparam ) {
   if ( id != CHARTEVENT_OBJECT_CLICK ) return;
   if ( BUY_BUTTON != sparam && SELL_BUTTON != sparam ) return;

   OrderData *orderData = new OrderData( maxPart, commission, stopLoss, takeProfit );
   
   if ( !ASK || IDYES == MessageBox( orderData.Comment(), sparam, MB_YESNO ) ) {
      int order = -1;

      double priceAsk = Ask;
      double priceBid = Bid;

      ResetLastError();
      if ( BUY_BUTTON == sparam )
         order = OrderSend( 
            Symbol(),
            OP_BUY,
            orderData.Lot(),
            priceAsk,
            0,
            priceBid - orderData.PriceSL(),
            priceAsk + orderData.PriceTP(),
            orderData.OrderComment(), 
            0, 0, clrBlue );
      else
         order = OrderSend( 
            Symbol(),
            OP_SELL,
            orderData.Lot(),
            priceBid,
            0,
            priceAsk + orderData.PriceSL(),
            priceBid - orderData.PriceTP(),
            orderData.OrderComment(),
            0, 0, clrRed );

      delete( orderData );

      if ( 0 > order ) {
         PlaySound( "timeout.wav" );
         
         string s1 = "OrderSend: " + ErrorMsg( GetLastError() );
         Print( s1 );         
         MessageBox( s1 );
      } else
         PlaySound( "Ok.wav" );
   }
   
   ObjectSetInteger( 0, sparam, OBJPROP_STATE, false );
   ChartRedraw();
}

void OnTimer() {
   OrderData *orderData = new OrderData( maxPart, commission, stopLoss, takeProfit );

   double priceAsk = Ask;
   double priceBid = Bid;

   MoveHLine( BUY_TP_HLINE,  priceAsk + orderData.PriceTP() );
   MoveHLine( BUY_SL_HLINE,  priceBid - orderData.PriceSL() );

   MoveHLine( SELL_SL_HLINE, priceAsk + orderData.PriceSL() );
   MoveHLine( SELL_TP_HLINE, priceBid - orderData.PriceTP() );

   Comment( orderData.Comment() );
   
   delete( orderData );
}

class OrderData {

   private:

      double m;
      double c;
      int    tp;
      int    sl;
      double priceTP;
      double priceSL;
      double lot;
      double lotNormal;
      double freeMargin; 
   
   public:

      OrderData( double maxPart, double commision, int stopLoss, double takeProfit ) {
      
         m = maxPart;
         c = commision;
         
         // ������ ��������� � ������� ������. ��������, ��� EURUSD = 100000$
         double LOTSIZE = MarketInfo( Symbol(), MODE_LOTSIZE );
      
         // ��������� 1 ���� � ������� ������. ��������, ��� EURUSD = 1000$
         double M1 = MarketInfo( Symbol(), MODE_LOTSIZE ) / AccountLeverage();  
      
         int A      = (int)MathPow( 10, Digits );
         sl         = stopLoss;
         tp         = (int)( takeProfit * stopLoss );
         freeMargin = AccountFreeMargin();
      
         lot  = freeMargin * m * GetQuotation() / LOTSIZE / ( sl * Point + c / AccountLeverage() );
      
         lotNormal = lot;
         if ( MarketInfo( Symbol(), MODE_MINLOT ) > lotNormal )
           lotNormal = MarketInfo( Symbol(), MODE_MINLOT );
      
         if ( freeMargin / M1 < lotNormal )
           lotNormal = freeMargin / M1;
      
         lotNormal = Normalize( lotNormal );
         priceSL  = NormalizeDouble( sl * Point, Digits );
         priceTP  = NormalizeDouble( tp * Point, Digits );
      }
     
      static double Normalize( double value ) {
         return( NormalizeDouble( value, 2 ) );
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
               Print(  __FUNCTION__, ": ", ErrorMsg( GetLastError() ) );
         }
         
         return( NormalizeDouble( res, Digits ) );
      }
      
      string OrderComment() {
         string res = StringFormat(
            "O%G FM%G LOT%G ",
            m, freeMargin, lotNormal
         );
         
         return( res );
      }

      string Comment() {
         string res = StringFormat( 
            "%-11s = %G %% (%G %s)\n%-11s = %G %% (%G %s)\n%-11s = %G pips\n%-11s = %G pips\n%-11s = %G\n",
            "maxPart",   m * 100, m * freeMargin, AccountCurrency(),
            "commission",   c * 100, m * freeMargin * c, AccountCurrency(),
            "stopLoss",  sl,
            "takeProfit",  tp,
            "LOT", lotNormal
         );
   
         return( res );
      };
      
      void operator=( const OrderData& orderData )
      {
         m          = orderData.m;
         c          = orderData.c;
         tp         = orderData.tp;
         sl         = orderData.sl;
         priceTP    = orderData.priceTP;
         priceSL    = orderData.priceSL; 
         lot        = orderData.lot;
         lotNormal  = orderData.lotNormal;
         freeMargin = orderData.freeMargin;
      }
     
      double PriceTP() {
         return priceTP;
      };
      
      double PriceSL() {
         return priceSL;
      };
      
      double Lot() {
         return lotNormal;
      };
};

string ErrorMsg( int code ) {
   switch ( code ) {
      case 0    : return( "0 - ��� ������" ); break;
      case 1    : return( "1 - ��� ������, �� ��������� ����������" ); break;
      case 2    : return( "2 - ����� ������" ); break;
      case 3    : return( "3 - ������������ ���������" ); break;
      case 4    : return( "4 - �������� ������ �����" ); break;
      case 5    : return( "5 - ������ ������ ����������� ���������" ); break;
      case 6    : return( "6 - ��� ����� � �������� ��������" ); break;
      case 7    : return( "7 - ������������ ����" ); break;
      case 8    : return( "8 - ������� ������ �������" ); break;
      case 9    : return( "9 - ������������ ��������, ���������� ���������������� �������" ); break;
      case 64   : return( "64 - ���� ������������" ); break;
      case 65   : return( "65 - ������������ ����� �����" ); break;
      case 128  : return( "128 - ����� ���� �������� ���������� ������" ); break;
      case 129  : return( "129 - ������������ ����" ); break;
      case 130  : return( "130 - ������������ �����" ); break;
      case 131  : return( "131 - ������������ �����" ); break;
      case 132  : return( "132 - ����� ������" ); break;
      case 133  : return( "133 - �������� ���������" ); break;
      case 134  : return( "134 - ������������ ����� ��� ���������� ��������" ); break;
      case 135  : return( "135 - ���� ����������" ); break;
      case 136  : return( "136 - ��� ���" ); break;
      case 137  : return( "137 - ������ �����" ); break;
      case 138  : return( "138 - ����� ����" ); break;
      case 139  : return( "139 - ����� ������������ � ��� ��������������" ); break;
      case 140  : return( "140 - ��������� ������ �������" ); break;
      case 141  : return( "141 - ������� ����� ��������" ); break;
      case 145  : return( "145 - ����������� ���������, ��� ��� ����� ������� ������ � �����" ); break;
      case 146  : return( "146 - ���������� �������� ������" ); break;
      case 147  : return( "147 - ������������� ���� ��������� ������ ��������� ��������" ); break;
      case 148  : return( "148 - ���������� �������� � ���������� ������� �������� �������, �������������� ��������" ); break;
      case 149  : return( "149 - ������� ������� ��������������� ����� � ������, ���� ������������ ���������" ); break;
      case 150  : return( "150 - ������� ������� ������� �� ����������� � ������������ � �������� FIFO" ); break;
      case 4000 : return( "4000 - ��� ������" ); break;
      case 4001 : return( "4001 - ������������ ��������� �������" ); break;
      case 4002 : return( "4002 - ������ ������� - ��� ���������" ); break;
      case 4003 : return( "4003 - ��� ������ ��� ����� �������" ); break;
      case 4004 : return( "4004 - ������������ ����� ����� ������������ ������" ); break;
      case 4005 : return( "4005 - �� ����� ��� ������ ��� �������� ����������" ); break;
      case 4006 : return( "4006 - ��� ������ ��� ���������� ���������" ); break;
      case 4007 : return( "4007 - ��� ������ ��� ��������� ������" ); break;
      case 4008 : return( "4008 - �������������������� ������" ); break;
      case 4009 : return( "4009 - �������������������� ������ � �������" ); break;
      case 4010 : return( "4010 - ��� ������ ��� ���������� �������" ); break;
      case 4011 : return( "4011 - ������� ������� ������" ); break;
      case 4012 : return( "4012 - ������� �� ������� �� ����" ); break;
      case 4013 : return( "4013 - ������� �� ����" ); break;
      case 4014 : return( "4014 - ����������� �������" ); break;
      case 4015 : return( "4015 - ������������ �������" ); break;
      case 4016 : return( "4016 - �������������������� ������" ); break;
      case 4017 : return( "4017 - ������ DLL �� ���������" ); break;
      case 4018 : return( "4018 - ���������� ��������� ����������" ); break;
      case 4019 : return( "4019 - ���������� ������� �������" ); break;
      case 4020 : return( "4020 - ������ ������� ������������ ������� �� ���������" ); break;
      case 4021 : return( "4021 - ������������ ������ ��� ������, ������������ �� �������" ); break;
      case 4022 : return( "4022 - ������� ������" ); break;
      case 4023 : return( "4023 - ����������� ������ ������ DLL-�������" ); break;
      case 4024 : return( "4024 - ���������� ������" ); break;
      case 4025 : return( "4025 - ��� ������" ); break;
      case 4026 : return( "4026 - �������� ���������" ); break;
      case 4027 : return( "4027 - ������� ����� ���������� �������������� ������" ); break;
      case 4028 : return( "4028 - ����� ���������� ��������� ����� ���������� �������������� ������" ); break;
      case 4029 : return( "4029 - �������� ������" ); break;
      case 4030 : return( "4030 - ������ �� ��������" ); break;
      case 4050 : return( "4050 - ������������ ���������� ���������� �������" ); break;
      case 4051 : return( "4051 - ������������ �������� ��������� �������" ); break;
      case 4052 : return( "4052 - ���������� ������ ��������� �������" ); break;
      case 4053 : return( "4053 - ������ �������" ); break;
      case 4054 : return( "4054 - ������������ ������������� �������-���������" ); break;
      case 4055 : return( "4055 - ������ ����������������� ����������" ); break;
      case 4056 : return( "4056 - ������� ������������" ); break;
      case 4057 : return( "4057 - ������ ��������� ���������� ����������" ); break;
      case 4058 : return( "4058 - ���������� ���������� �� ����������" ); break;
      case 4059 : return( "4059 - ������� �� ��������� � �������� ������" ); break;
      case 4060 : return( "4060 - ������� �� ���������" ); break;
      case 4061 : return( "4061 - ������ �������� �����" ); break;
      case 4062 : return( "4062 - ��������� �������� ���� string" ); break;
      case 4063 : return( "4063 - ��������� �������� ���� integer" ); break;
      case 4064 : return( "4064 - ��������� �������� ���� double" ); break;
      case 4065 : return( "4065 - � �������� ��������� ��������� ������" ); break;
      case 4066 : return( "4066 - ����������� ������������ ������ � ��������� ����������" ); break;
      case 4067 : return( "4067 - ������ ��� ���������� �������� ��������" ); break;
      case 4068 : return( "4068 - ������ �� ������" ); break;
      case 4069 : return( "4069 - ������ �� ��������������" ); break;
      case 4070 : return( "4070 - �������� �������" ); break;
      case 4071 : return( "4071 - ������ ������������� ����������������� ����������" ); break;
      case 4072 : return( "4072 - ������ �������� ����������������� ����������" ); break;
      case 4099 : return( "4099 - ����� �����" ); break;
      case 4100 : return( "4100 - ������ ��� ������ � ������" ); break;
      case 4101 : return( "4101 - ������������ ��� �����" ); break;
      case 4102 : return( "4102 - ������� ����� �������� ������" ); break;
      case 4103 : return( "4103 - ���������� ������� ����" ); break;
      case 4104 : return( "4104 - ������������� ����� ������� � �����" ); break;
      case 4105 : return( "4105 - �� ���� ����� �� ������" ); break;
      case 4106 : return( "4106 - ����������� ������" ); break;
      case 4107 : return( "4107 - ������������ �������� ���� ��� �������� �������" ); break;
      case 4108 : return( "4108 - �������� ����� ������" ); break;
      case 4109 : return( "4109 - �������� �� ���������. ���������� �������� ����� \"��������� ��������� ���������\" � ��������� ��������" ); break;
      case 4110 : return( "4110 - ������ �� ������� �� ���������. ���������� ��������� �������� ��������" ); break;
      case 4111 : return( "4111 - ������ �� ������� �� ���������. ���������� ��������� �������� ��������" ); break;
      case 4112 : return( "4112 - �������������� �������� � ������� ���������/�������� ��������� �� ������� �������" ); break;
      case 4200 : return( "4200 - ������ ��� ����������" ); break;
      case 4201 : return( "4201 - ��������� ����������� �������� �������" ); break;
      case 4202 : return( "4202 - ������ �� ����������" ); break;
      case 4203 : return( "4203 - ����������� ��� �������" ); break;
      case 4204 : return( "4204 - ��� ����� �������" ); break;
      case 4205 : return( "4205 - ������ ��������� �������" ); break;
      case 4206 : return( "4206 - �� ������� ��������� �������" ); break;
      case 4207 : return( "4207 - ������ ��� ������ � ��������" ); break;
      case 4210 : return( "4210 - ����������� �������� �������" ); break;
      case 4211 : return( "4211 - ������ �� ������" ); break;
      case 4212 : return( "4212 - �� ������� ������� �������" ); break;
      case 4213 : return( "4213 - ��������� �� ������" ); break;
      case 4220 : return( "4220 - ������ ������ �����������" ); break;
      case 4250 : return( "4250 - ������ �������� push-�����������" ); break;
      case 4251 : return( "4251 - ������ ���������� push-�����������" ); break;
      case 4252 : return( "4252 - ����������� ���������" ); break;
      case 4253 : return( "4253 - ������� ������ ������� ������� push-�����������" ); break;
      case 5001 : return( "5001 - ������� ����� �������� ������" ); break;
      case 5002 : return( "5002 - �������� ��� �����" ); break;
      case 5003 : return( "5003 - ������� ������� ��� �����" ); break;
      case 5004 : return( "5004 - ������ �������� �����" ); break;
      case 5005 : return( "5005 - ������ ���������� ������ ���������� �����" ); break;
      case 5006 : return( "5006 - ������ �������� �����" ); break;
      case 5007 : return( "5007 - �������� ����� ����� (���� ������ ��� �� ��� ������)" ); break;
      case 5008 : return( "5008 - �������� ����� ����� (������ ������ ����������� � �������)" ); break;
      case 5009 : return( "5009 - ���� ������ ���� ������ � ������ FILE_WRITE" ); break;
      case 5010 : return( "5010 - ���� ������ ���� ������ � ������ FILE_READ" ); break;
      case 5011 : return( "5011 - ���� ������ ���� ������ � ������ FILE_BIN" ); break;
      case 5012 : return( "5012 - ���� ������ ���� ������ � ������ FILE_TXT" ); break;
      case 5013 : return( "5013 - ���� ������ ���� ������ � ������ FILE_TXT ��� FILE_CSV" ); break;
      case 5014 : return( "5014 - ���� ������ ���� ������ � ������ FILE_CSV" ); break;
      case 5015 : return( "5015 - ������ ������ �����" ); break;
      case 5016 : return( "5016 - ������ ������ �����" ); break;
      case 5017 : return( "5017 - ������ ������ ������ ���� ������ ��� �������� ������" ); break;
      case 5018 : return( "5018 - �������� ��� ����� (��� ��������� ��������-TXT, ��� ���� ������-BIN)" ); break;
      case 5019 : return( "5019 - ���� �������� �����������" ); break;
      case 5020 : return( "5020 - ���� �� ����������" ); break;
      case 5021 : return( "5021 - ���� �� ����� ���� �����������" ); break;
      case 5022 : return( "5022 - �������� ��� ����������" ); break;
      case 5023 : return( "5023 - ���������� �� ����������" ); break;
      case 5024 : return( "5024 - ��������� ���� �� �������� �����������" ); break;
      case 5025 : return( "5025 - ������ �������� ����������" ); break;
      case 5026 : return( "5026 - ������ ������� ����������" ); break;
      case 5027 : return( "5027 - ������ ��������� ������� �������" ); break;
      case 5028 : return( "5028 - ������ ��������� ������� ������" ); break;
      case 5029 : return( "5029 - ��������� �������� ������ ��� ������������ �������" ); break;
      case 5200 : return( "5200 - URL �� ������ ��������" ); break;
      case 5201 : return( "5201 - �� ������� ������������ � ���������� URL" ); break;
      case 5202 : return( "5202 - �������� ������� ��������� ������" ); break;
      case 5203 : return( "5203 - ������ � ���������� ���������� HTTP �������" ); break;
   };
   
   return( IntegerToString( code ) + " - ����������� ������"  );
}