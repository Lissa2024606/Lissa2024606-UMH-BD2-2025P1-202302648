select*from transacciones;
DELIMITER //

CREATE PROCEDURE registrar_transaccion(
    IN p_numero_cuenta VARCHAR(20),
    IN p_tipo ENUM('DEBITO', 'CREDITO'),
    IN p_monto DECIMAL(10,2)
)
BEGIN
    DECLARE v_saldo_actual DECIMAL(10,2);
    DECLARE v_cuenta_existe INT;

    -- Verificar si la cuenta existe
    SELECT COUNT(*) INTO v_cuenta_existe 
    FROM cuentas 
    WHERE numero_cuenta = p_numero_cuenta;

    IF v_cuenta_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cuenta especificada no existe';
    END IF;

    -- Obtener saldo actual
    SELECT saldo INTO v_saldo_actual 
    FROM cuentas 
    WHERE numero_cuenta = p_numero_cuenta;

    -- Validación de saldo suficiente para débito
    IF p_tipo = 'DEBITO' AND p_monto > v_saldo_actual THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo insuficiente para la transacción';
    END IF;

    -- Insertar transacción
    INSERT INTO transacciones (numero_cuenta, tipo, monto)
    VALUES (p_numero_cuenta, p_tipo, p_monto);

    -- Actualizar cuenta
    IF p_tipo = 'DEBITO' THEN
        UPDATE cuentas
        SET saldo = saldo - p_monto,
            total_debitos = total_debitos + p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    ELSE
        UPDATE cuentas
        SET saldo = saldo + p_monto,
            total_creditos = total_creditos + p_monto
        WHERE numero_cuenta = p_numero_cuenta;
end;
DROP PROCEDURE IF EXISTS registrar_transaccion;
CALL registrar_transaccion('20010001', 'CREDITO', 500.00);
SELECT * FROM cuentas WHERE numero_cuenta = '20010001';