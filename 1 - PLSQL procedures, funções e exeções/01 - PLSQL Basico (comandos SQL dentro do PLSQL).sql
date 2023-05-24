-- INCLUS�O DE SEGEMENTO DE MERCADO
DECLARE
    V_ID SEGMERCADO.ID%TYPE := 4;
    V_DESCRICAO SEGMERCADO.DESCRICAO%TYPE := 'Atacado';

BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO) VALUES (V_ID, UPPER(V_DESCRICAO));
    COMMIT;
END;

-- ALTERA��O DE SEGMENTO DE MERCADO
DECLARE
    V_ID SEGMERCADO.ID%TYPE := 3;
    V_DESCRICAO SEGMERCADO.DESCRICAO%TYPE := 'Atacadista';
BEGIN
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(V_DESCRICAO) WHERE ID = V_ID;
    COMMIT;
END;

-- EXCLUS�O DE SEGMENTO DE MERCADO
DECLARE
    V_ID SEGMERCADO.ID%TYPE := 4;
BEGIN
    DELETE FROM SEGMERCADO WHERE ID = V_ID;
    COMMIT;
END;


