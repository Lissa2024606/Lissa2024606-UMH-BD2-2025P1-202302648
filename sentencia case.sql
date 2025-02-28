SELECT country, product, saleprice,manufacturingprice, MonthName, Date
 FROM demodb. financialsample 
 WHERE Country = 'Mexico'
AND MonthNumber IN (1, 2)  -- 1 = Enero, 2 = Febrero
AND Year = 2014
ORDER BY date, Product;
DELIMITER //
DROP PROCEDURE sp_new_currency; 

DELIMITER //
CREATE procedure sp_new_currency(
	in p_currency_name varchar(45),
    in p_currency_symbol varchar(45), 
    in p_exchange_rate decimal, 
    in p_country varchar(45) 
) 
BEGIN  
Declare v_currency_name varchar(45) 
	Declare v_currency_symbol varchar(45) 
	Declare v_exchange_rate decimal(15.2);
	Declare v_country varchar(45)
    Declare v_iso_code varchar(45)
    
    when p_currency_name like"$dolar$" THEN
    set  v_currency_symbol="$";
	when p_currency_name  like"%peso%" THEN
    set  v_currency_symbol="%p%";
	when p_exchange_name like"%dyen%" THEN
    set  v_currency_symbol="¥";
    when p_currency_name  like"%euro%" THEN
     set  v_currency_symbol="£";
     
     else 
     set v_concurrency_symbol =p_concurrency_symbol;
     end case;


	INSERT INTO currencies (
		currency_name, currency_symbol, exchange_rate, country, ISO_CODE
	)
	VALUES (@currency_name, @currency_symbol, @exchange_rate,  @country, "GTQ");
	commit;  
END;
Call db_demo,sp_new_concurrecy_case(
"sol peruano","s.",0,"peru","pen"
);
