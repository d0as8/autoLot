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
};

class Price {

   private:

      double mAsk;
      double mBid;
      double mStopLoss;
      double mTakeProfit;

   public:

   Price( double stopLoss = 0.0, double takeProfit = 0.0, double ask = 0.0, double bid = 0.0 ) {
      Update( stopLoss, takeProfit, ask, bid );
   }

   void Update( double stopLoss, double takeProfit, double ask, double bid ) {
      this.mStopLoss   = stopLoss;
      this.mTakeProfit = takeProfit;
      this.mAsk        = ask;
      this.mBid        = bid;
   }

   double GetBuyPrice() {
      return( mAsk );
   }

   double GetBuySL() {
      return( mBid - mStopLoss );
   }

   double GetBuyTP() {
      return( mBid + mTakeProfit );
   }

   double GetSellPrice() {
      return( mBid );
   }

   double GetSellSL() {
      return( mAsk + mStopLoss );
   }

   double GetSellTP() {
      return( mAsk - mTakeProfit );
   }
};

class Order {

   private:

      double mFreeMargin;
      double mPriceSL;
      double mPriceTP;
      double mLot;
      double mTickValue;
      Price * pPrice;

      int    ATR;
      double MAX_PART;
      double COMMISSION;
      double FACTOR_SL;
      double FACTOR_TP;
      double LOT_COST;  // ��������� 1 ���� � ������� ������.
      double QUOTATION; // ���������
      double LOT_MIN;
      double LOT_MAX;        
      double PRESOLVE1;
      double PRESOLVE2;

   public:

      Order( double maxPart, double factorTP, double commision, double factorSL, int atr = 14 ) {
         ATR        = atr;
         MAX_PART   = maxPart;
         FACTOR_TP  = factorTP;
         COMMISSION = commision;
         FACTOR_SL  = factorSL;

         QUOTATION = GetQuotation();
         LOT_COST  = MarketInfo( NULL, MODE_LOTSIZE ) / AccountLeverage();
         LOT_MIN   = MarketInfo( NULL, MODE_MINLOT );
         LOT_MAX   = MarketInfo( NULL, MODE_MAXLOT );
         PRESOLVE1 = MAX_PART / LOT_COST / AccountLeverage();
         PRESOLVE2 = COMMISSION / AccountLeverage();

         pPrice = new Price( 0, 0, 0, 0 );

         Update();
      }

      ~Order() {
         delete( pPrice );
      }

      void Update() {
         mFreeMargin = AccountFreeMargin();
         if ( 0 > mFreeMargin ) mFreeMargin = 0;

         // get Lot by SL
         mPriceSL = FACTOR_SL   * MathAbs( iATR( NULL, 0, ATR, 0 ) );
         mLot     = mFreeMargin * PRESOLVE1 / ( mPriceSL / QUOTATION + PRESOLVE2 );

         if ( LOT_MIN > mLot ) mLot = LOT_MIN;
         if ( LOT_MAX < mLot ) mLot = LOT_MAX;
         mLot = Normalize( mLot );

         mTickValue = MarketInfo( NULL, MODE_TICKVALUE );

         // get SL by min Lot if SL price too expensive
         double tick = mLot * mTickValue / Point;
         if (MAX_PART * mFreeMargin < mPriceSL * tick + COMMISSION * LOT_COST * mLot) {
            mPriceSL = QUOTATION * ( ( mFreeMargin * PRESOLVE1 / mLot) - PRESOLVE2 );
         }

         mPriceTP   = FACTOR_TP * MAX_PART * mFreeMargin / tick;

         pPrice.Update( mPriceSL, mPriceTP, Ask, Bid );
      }

      static double Normalize( double value, int numbers = 2 ) {
         return( NormalizeDouble( ((int)(value * MathPow( 10 , numbers ) )) / MathPow( 10, numbers ), numbers ) );
      }

      static double GetQuotation() {
         string currency = AccountCurrency();
         string profit   = SymbolInfoString( NULL, SYMBOL_CURRENCY_PROFIT );

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
            "MP%G FM%G",
            MAX_PART, mFreeMargin
         );

         return( res );
      }

      string GetComment() {
         string currency  = AccountCurrency();
         double tick      = mLot * mTickValue / Point;

         string res = StringFormat(
            "%-11s = %G %% (%G %s)\n%-11s = %G %% (%G %s)\n%-11s = %G (%G %s)\n%-11s = %G (%G %s)\n%-11s = %G",
            "maxPart",    MAX_PART   * 100,                    NormalizeDouble( MAX_PART * mFreeMargin, 2 ),       currency,
            "commission", COMMISSION * 100,                    NormalizeDouble( COMMISSION * LOT_COST * mLot, 2 ), currency,
            "stopLoss",   NormalizeDouble( mPriceSL, Digits ), NormalizeDouble( mPriceSL * tick, 2 ),              currency,
            "takeProfit", NormalizeDouble( mPriceTP, Digits ), NormalizeDouble( mPriceTP * tick, 2 ),              currency,
            "LOT",        mLot
         );

         return( res );
      }

      double GetLot() {
         return( mLot );
      }

      Price * GetPrice() {
         return( pPrice );
      }
};

class Drawer {

   private:

      Order * pOrder;

      bool ASK;

      string BUY_BUTTON;
      string SELL_BUTTON;
      string BUY_SL_HLINE;
      string BUY_TP_HLINE;
      string SELL_SL_HLINE;
      string SELL_TP_HLINE;

   public:

      Drawer( Order * order, bool ask ) {
         this.pOrder = order;
         this.ASK    = ask;

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
         pOrder.Update();

         MoveLine( BUY_TP_HLINE,  pOrder.GetPrice().GetBuyTP() );
         MoveLine( SELL_TP_HLINE, pOrder.GetPrice().GetSellTP() );
         MoveLine( BUY_SL_HLINE,  pOrder.GetPrice().GetBuySL() );
         MoveLine( SELL_SL_HLINE, pOrder.GetPrice().GetSellSL() );

         Comment( pOrder.GetComment() );
     }

      void OnButtonClick( const string &buttonName ) {
         if ( BUY_BUTTON != buttonName && SELL_BUTTON != buttonName ) return;

         pOrder.Update();

         if ( !ASK || IDYES == MessageBox( pOrder.GetComment(), buttonName, MB_YESNO ) ) {
            ResetLastError();

            pOrder.Update();

            int orderId = -1;
            if ( BUY_BUTTON == buttonName )
               orderId = OrderSend(
                  NULL,
                  OP_BUY,
                  pOrder.GetLot(),
                  pOrder.GetPrice().GetBuyPrice(),
                  0,
                  pOrder.GetPrice().GetBuySL(),
                  pOrder.GetPrice().GetBuyTP(),
                  pOrder.GetOrderComment(),
                  0, 0, clrBlue );
            else
               orderId = OrderSend(
                  NULL,
                  OP_SELL,
                  pOrder.GetLot(),
                  pOrder.GetPrice().GetSellPrice(),
                  0,
                  pOrder.GetPrice().GetSellSL(),
                  pOrder.GetPrice().GetSellTP(),
                  pOrder.GetOrderComment(),
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

// Events

input double inMaxPart    = 0.01;  //������������ ���� �� ��������� ����� �� ������
input double inTakeProfit = 2.0;   //������ (���� �� ����� ������)
input double inCommission = 0.01;  //�������� (���� �� ��������� 1 ���� � ������� ������)
input double inStopLoss   = 2.0;   //���� ���� (���� �� ATR)
input int    inATRPeriod  = 50;    //������ ATR
input bool   inAsk        = true;  //������������� �������� ������

Order  * gOrder;
Drawer * gDrawer;

int OnInit() {
   gOrder  = new Order( inMaxPart, inTakeProfit, inCommission, inStopLoss, inATRPeriod );
   gDrawer = new Drawer( gOrder, inAsk );

   if ( EventSetMillisecondTimer( 500 ) ) {
      OnTimer();
      return( INIT_SUCCEEDED );
   } else
      return( INIT_FAILED );
}

void OnTimer() {
   gDrawer.Update();
}

void OnDeinit( const int reason ) {
   EventKillTimer();

   delete( gDrawer );
   delete( gOrder );
}

void OnChartEvent( const int id, const long &lparam, const double &dparam, const string &sparam ) {
   if ( id != CHARTEVENT_OBJECT_CLICK ) return;

   gDrawer.OnButtonClick( sparam );
}