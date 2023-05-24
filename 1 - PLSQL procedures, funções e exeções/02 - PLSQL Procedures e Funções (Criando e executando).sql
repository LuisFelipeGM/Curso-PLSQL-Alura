-- CRIANDO PROCEDURE
CREATE PROCEDURE incluir_segmercado
    (P_ID IN NUMBER, P_DESCRICAO IN VARCHAR2)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO) VALUES (P_ID, UPPER(P_DESCRICAO));
    COMMIT; 
END;

SELECT * FROM SEGMERCADO;

-- ESSAS 2 FORMAS EXECUT�O A PROCEDURE DA MESMA MANEIRA
EXECUTE incluir_segmercado(4, 'Farmaceuticos');

BEGIN
    incluir_segmercado(4, 'Farmaceuticos');
END;


--------------------------------------------------------------
-- ALTERANDO PROCEDURE
CREATE OR REPLACE PROCEDURE incluir_segmercado
    (P_ID IN SEGMERCADO.ID%TYPE, P_DESCRICAO IN SEGMERCADO.DESCRICAO%TYPE)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO) VALUES (P_ID, UPPER(P_DESCRICAO));
    COMMIT; 
END;

--------------------------------------------------------------
-- COMO EXCLUIR A PROCEDURE
CREATE OR REPLACE PROCEDURE incluir_segmercado2
    (P_ID IN SEGMERCADO.ID%TYPE, P_DESCRICAO IN SEGMERCADO.DESCRICAO%TYPE)
IS
BEGIN
    INSERT INTO SEGMERCADO (ID, DESCRICAO) VALUES (P_ID, UPPER(P_DESCRICAO));
    COMMIT; 
END;

DROP PROCEDURE incluir_segmercado2;


--------------------------------------------------------------
-- CRIANDO AS PROCEDURES PARA ALTERAR E EXCLUIR SEGMERCADO
CREATE OR REPLACE PROCEDURE alterar_segmercado
    (P_ID SEGMERCADO.ID%TYPE, P_DESCRICAO SEGMERCADO.DESCRICAO%TYPE)
IS
BEGIN
    UPDATE SEGMERCADO SET DESCRICAO = UPPER(P_DESCRICAO) WHERE ID = P_ID;
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE excluir_segmercado
    (P_ID SEGMERCADO.ID%TYPE)
IS
BEGIN
    DELETE FROM SEGMERCADO WHERE ID = P_ID;
    COMMIT;
END;

EXECUTE alterar_segmercado(4, 'Farmaceutica');

EXECUTE excluir_segmercado(4);

SELECT * FROM SEGMERCADO;


--------------------------------------------------------------
-- RETORNANDO O DESCRITOR (COLOCANDO O RESULTADO EM UMA VARIAVEL E RETORNANDO)
SET SERVEROUTPUT ON

DECLARE
    V_ID SEGMERCADO.ID%TYPE := 3;
    V_DESCRICAO SEGMERCADO.DESCRICAO%TYPE;
BEGIN
    SELECT DESCRICAO INTO V_DESCRICAO FROM SEGMERCADO WHERE ID = V_ID;
    DBMS_OUTPUT.PUT_LINE(V_DESCRICAO);
END;

-- Obs: O INTO V_VARIAVEL, ESPERA SOMENTE O RETORNO DE 1 CELULA PARA COLOCAR NA
-- VARIAVEL, LOGO SE QUISER PEGAR MAIS INFORMA��ES DE 1 SELECT PRECISA FAZER VARIOS
-- SELECTS DESSA MESMA FORMA, COMO POR EXEMPLO:

DECLARE
    V_ID SEGMERCADO.ID%TYPE := 3;
    V_DESCRICAO SEGMERCADO.DESCRICAO%TYPE;
    V_ID_SAIDA SEGMERCADO.ID%TYPE;
BEGIN
    SELECT DESCRICAO INTO V_DESCRICAO FROM SEGMERCADO WHERE ID = V_ID;
    SELECT ID INTO V_ID_SAIDA FROM SEGMERCADO WHERE ID = V_ID;
    DBMS_OUTPUT.PUT_LINE(V_DESCRICAO);
    DBMS_OUTPUT.PUT_LINE(V_ID_SAIDA);
END;

-- N�O � A MANEIRA MAIS EFICIENTE DE SE FAZER MAS EST� CORRETO.


--------------------------------------------------------------
-- DIFEREN�A ENTRA PROCEDURE E FUN��O:
-- PROCEDURE: UMA CAIXA PRETA ONDE PASSO PARAMETROS E ALGO � EXECUTADO ALI DENTRO.
-- FUN��O: PASSO PARAMETROS, SE EXECUTADO CORRETAMENTE SER� RETORNADO UM VALOR

-- CRIANDO FUN��O
CREATE OR REPLACE FUNCTION obter_descricao_segmercado
    (P_ID SEGMERCADO.ID%TYPE)
RETURN 
    SEGMERCADO.DESCRICAO%TYPE
IS
    V_DESCRICAO SEGMERCADO.DESCRICAO%TYPE;
BEGIN
    SELECT DESCRICAO INTO V_DESCRICAO FROM SEGMERCADO WHERE ID = P_ID;
    RETURN V_DESCRICAO;
END;

-- USANDO A FUN��O DENTRO DO SELECT

SELECT ID, obter_descricao_segmercado(ID), LOWER(DESCRICAO) FROM SEGMERCADO WHERE ID = 1;


--------------------------------------------------------------
-- OUTRAS MANEIRAS DE EXECUTAR FUN��ES


-- EXECUTANDO POR VARIAVEL DENTRO DO ORACLE
-- CRIA��O DE VARIAVEL DENTRO DO ORACLE
VARIABLE G_DESCRICAO VARCHAR2(100);
EXECUTE :G_DESCRICAO:=OBTER_DESCRICAO_SEGMERCADO(3);
PRINT G_DESCRICAO;

-- EXECUTANDO POR BLOCO DE COMANDO PL/SQL
SET SERVEROUTPUT ON
DECLARE
    V_DESCRICAO SEGMERCADO.DESCRICAO%TYPE;
    V_ID SEGMERCADO.ID%TYPE := 2;
BEGIN
    V_DESCRICAO := OBTER_DESCRICAO_SEGMERCADO(V_ID);
    DBMS_OUTPUT.PUT_LINE('A descri��o do segmento de mercado � ' || V_DESCRICAO);
END;



