/* Turn on graphics */
ods graphics on;

/* Assign file path */
FILENAME REFFILE '/home/u64364889/Project 3A/stock.csv';

/* Import CSV */
PROC IMPORT DATAFILE=REFFILE
    DBMS=CSV
    OUT=WORK.RAW
    REPLACE;
    GETNAMES=YES;
RUN;

/* Verify dataset */
PROC CONTENTS DATA=WORK.RAW;
RUN;

/* Univariate Statistics */
PROC UNIVARIATE DATA=WORK.RAW;
    VAR Stock;
RUN;

/* Summary Statistics */
PROC MEANS DATA=WORK.RAW N MEAN STD MIN MAX;
    VAR Stock;
RUN;

/* Time Series Plot */
PROC SGPLOT DATA=WORK.RAW;
    SERIES X=Date Y=Stock;
    TITLE "Time Series Plot of Stock Prices";
RUN;

/* Histogram */
PROC SGPLOT DATA=WORK.RAW;
    HISTOGRAM Stock;
    DENSITY Stock;
    TITLE "Histogram of Stock Prices";
RUN;

/* Boxplot */
PROC SGPLOT DATA=WORK.RAW;
    VBOX Stock;
    TITLE "Boxplot of Stock Prices";
RUN;

/* Chapter 2 Continuation */

/* Correlation Analysis */
PROC CORR DATA=WORK.RAW;
    VAR Stock Basket_index EPS P_E_ratio Global_mkt_share 
        Media_analytics_index M1_money_supply_index Top_10_GDP;
RUN;

/* Regression Model */
PROC REG DATA=WORK.RAW plots=diagnostics(unpack);
    MODEL Stock = Basket_index EPS P_E_ratio 
              Media_analytics_index 
              M1_money_supply_index Top_10_GDP;
RUN;

/* Multicollinearity */
PROC REG DATA=WORK.RAW;
	MODEL Stock = Basket_index EPS P_E_ratio 
              Media_analytics_index 
              M1_money_supply_index Top_10_GDP;	
RUN;

/* ARIMA Model */
PROC ARIMA DATA=WORK.RAW;
    IDENTIFY VAR=Stock;
RUN;

PROC ARIMA DATA=WORK.RAW;
    IDENTIFY VAR=Stock;
    ESTIMATE P=1 Q=1;
    FORECAST LEAD=12 OUT=forecast;
RUN;

/* The CORR Procedure*/ 
proc corr data=work.raw;
    var Stock Basket_index EPS P_E_ratio 
        Media_analytics_index M1_money_supply_index Top_10_GDP;
run;

/* Durbin-Watson */
proc reg data=work.raw;
    model stock = basket_index eps p_e_ratio 
                  media_analytics_index 
                  m1_money_supply_index 
                  top_10_gdp / dw;
run;
quit;