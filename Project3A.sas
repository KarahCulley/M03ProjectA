/* Step 1: Assign file path */
FILENAME REFFILE '/home/u64364889/Project 3A/stock.csv';

/* Step 2: Import CSV */
PROC IMPORT DATAFILE=REFFILE
    DBMS=CSV
    OUT=WORK.RAW
    REPLACE;
    GETNAMES=YES;
RUN;

/* Step 3: Verify dataset */
PROC CONTENTS DATA=WORK.RAW;
RUN;

/* Univariate Statistics */
PROC UNIVARIATE DATA=WORK.IMPORT;
    VAR Stock;
RUN;

/* Summary Statistics */
PROC MEANS DATA=WORK.IMPORT N MEAN STD MIN MAX;
    VAR Stock;
RUN;

/* Time Series Plot */
PROC SGPLOT DATA=WORK.IMPORT;
    SERIES X=Date Y=Stock;
    TITLE "Time Series Plot of Stock Prices";
RUN;

/* Histogram */
PROC SGPLOT DATA=WORK.IMPORT;
    HISTOGRAM Stock;
    DENSITY Stock;
    TITLE "Histogram of Stock Prices";
RUN;

/* Boxplot */
PROC SGPLOT DATA=WORK.IMPORT;
    VBOX Stock;
    TITLE "Boxplot of Stock Prices";
RUN;