DELIMITER //

CREATE PROCEDURE Simulador_Ahorro(
    IN monto_constante DECIMAL(10,2), 
    IN Numero_meses INT
)
BEGIN
    
    -- Crear una tabla temporal para almacenar los resultados
    CREATE TEMPORARY TABLE Simulacion_Ahorro (
      Numero_Mes INT,
        Monto_constante DECIMAL(10,2),
        Saldo_Acumulado DECIMAL(10,2)
    );

    -- Variables para iteración
    DECLARE i INT DEFAULT 1;
    DECLARE saldo_constante DECIMAL(10,2) DEFAULT 0;

    -- Bucle para calcular el ahorro mes a mes
    WHILE i <= meses DO
        SET saldo = saldo + monto;
        INSERT INTO Simulacion_Ahorro (Numero_Mes, Monto_constate, Saldo_Acumulado) 
        VALUES (i, monto_constante, saldo_acumulado)
        SET i = i + 1;
    END WHILE;

    -- Mostrar los resultados
    SELECT * FROM Simulacion_Ahorro;
END //

