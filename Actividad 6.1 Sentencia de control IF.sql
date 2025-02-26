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
	set @currency_name = p_currency_name; 
	set @currency_symbol = p_currency_symbol;
	set @exchange_rate = p_exchange_rate;
	set @country = p_country;

	INSERT INTO currencies (
		currency_name, currency_symbol, exchange_rate, country, ISO_CODE
	)
	VALUES (@currency_name, @currency_symbol, @exchange_rate,  @country, "GTQ");
	commit;  
END;
selec* from db_demo.curriencies WHERE currency_ID=9;
CALL db_demo.sp_upd_concurrency(0,9)
