-- ALTERAR TODOS OS SEGMERCADOS DOS CLIENTE
-- INTRODU��O A LOOPS

SELECT * FROM CLIENTE;

-- USANDO O LOOP PARA ALTERAR O SEGMERCADO DE TODOS OS CLIENTES
DECLARE
    V_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 2;
    V_ID CLIENTE.ID%TYPE := 1;
BEGIN
    LOOP
        ATUALIZAR_SEGMERCADO(V_ID, V_SEGMERCADO);
        V_ID := V_ID + 1;
    EXIT WHEN V_ID > 9;
    END LOOP;
END;
-- FIXAMOS O NUMERO DE VEZES QUE O LOOP VAI PERCORRER, SE FOR ADICIONADO MAIS DE
-- 9 CLIENTES O RESTO N�O SER� AFETADO

EXECUTE INCLUIR_CLIENTE(10, 'FARMACIA DO POVO', '1237894560', 1, 40000)

SELECT * FROM CLIENTE;

-- ATUALIZANDO LOOP FEITO ANTERIORMENTE

DECLARE
    V_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 2;
    V_ID CLIENTE.ID%TYPE := 1;
    V_NUMCLI INTEGER;
BEGIN
    SELECT COUNT(*) INTO V_NUMCLI FROM CLIENTE;
    LOOP
        ATUALIZAR_SEGMERCADO(V_ID, V_SEGMERCADO);
        V_ID := V_ID + 1;
    EXIT WHEN V_ID > V_NUMCLI;
    END LOOP;
END;

-- LEMBRANDO QUE ESSA L�GICA S� FUNCIONA COM IDS SEQUENCIAIS
-- NORMALMENTE UTILIZA O LOOPING DE (LOOP) QUANDO N�O SABEMOS QUANTAS VEZES �
-- PRECISO RODAR


--------------------------------------------------------------
-- UTILIZANDO O LOOP FOR
-- VOU ATUALIZAR O CODIGO ACIMA PARA SER UTILIZADO COM FOR LOOP

DECLARE
    V_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 4;
    V_NUMCLI INTEGER;
BEGIN
    SELECT COUNT(*) INTO V_NUMCLI FROM CLIENTE;
    -- ASSIM JA DETERMINA A QUANTIDADE DE VEZES QUE O LOOP VAI EXECUTAR, E USANDO
    -- O V_ID NO FOR N�O � NECESSARIO DECLARAR ELE
    FOR V_ID IN 1..V_NUMCLI LOOP
        ATUALIZAR_SEGMERCADO(V_ID, V_SEGMERCADO);
    END LOOP;
END;

SELECT * FROM CLIENTE;


--------------------------------------------------------------
-- PARAMETROS NOMEADOS
-- DESSA FORMA ESTAMOS NOMEANDO OS PARAMETROS DE ENTRADA DA PROCEDURE, LOGO
-- PODEMOS COLOCAR NA ORDEM QUE QUISERMOS OS PARAMETROS NA PROCEDURE

DECLARE
    V_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 1;
    V_NUMCLI INTEGER;
BEGIN
    SELECT COUNT(*) INTO V_NUMCLI FROM CLIENTE;
    FOR V_ID IN 1..V_NUMCLI LOOP
        ATUALIZAR_SEGMERCADO(P_SEGMERCADO_ID => V_SEGMERCADO, P_ID => V_ID);
    END LOOP;
END;

SELECT * FROM CLIENTE;


--------------------------------------------------------------
-- COMANDO DE EXIT DENTRO DO LOOP
-- EM VEZ DE USAR EXIT WHEN NO FINAL � POSSIVEL USAR O IF E ELSE PARA FAZER AS
-- CONDICIONAIS DO LOOP E ASSIM ADICIONAR O EXIT QUANDO FOR FALSO

DECLARE
    V_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 2;
    V_ID CLIENTE.ID%TYPE := 1;
    V_NUMCLI INTEGER;
BEGIN
    SELECT COUNT(*) INTO V_NUMCLI FROM CLIENTE;
    LOOP
        IF V_ID <= V_NUMCLI THEN
            ATUALIZAR_SEGMERCADO(V_ID, V_SEGMERCADO);
            V_ID := V_ID + 1;
        ELSE
            EXIT;
        END IF;
    END LOOP;
END;

SELECT * FROM CLIENTE;


--------------------------------------------------------------
-- ESTRUTURA WHILE
-- VOU FAZER O CODIGO ACIMA UTILIZANDO O WHILE

DECLARE
    V_SEGMERCADO CLIENTE.SEGMERCADO_ID%TYPE := 3;
    V_ID CLIENTE.ID%TYPE := 1;
    V_NUMCLI INTEGER;
BEGIN
    SELECT COUNT(*) INTO V_NUMCLI FROM CLIENTE;
    WHILE V_ID <= V_NUMCLI LOOP
        ATUALIZAR_SEGMERCADO(V_ID, V_SEGMERCADO);
        V_ID := V_ID + 1;
    END LOOP;
END;

SELECT * FROM CLIENTE;



--------------------------------------------------------------
-- FAZENDO EXERCICIOS DA AULA
-- EX 1

CREATE OR REPLACE PROCEDURE NUMEROS_FIBONACCI (P_INTERACOES IN FLOAT, P_NUMEROFIBO OUT FLOAT)
IS
   V_FIBO1 FLOAT := 0;
   V_FIBO2 FLOAT := 1;
   V_FIBO_ATUAL FLOAT := 0;
   V_CONTADOR FLOAT := 1;
   V_INTERACOES FLOAT := 1;
BEGIN
   IF P_INTERACOES > 1 THEN
      LOOP
         V_FIBO_ATUAL := V_FIBO1 + V_FIBO2;
         V_FIBO1 := V_FIBO2;
         V_FIBO2 := V_FIBO_ATUAL;
         V_CONTADOR := V_CONTADOR + 1;
      EXIT WHEN V_CONTADOR >= P_INTERACOES;
      END LOOP;
   END IF;
   P_NUMEROFIBO := V_FIBO_ATUAL;
END;

-- TESTANDO
SET SERVEROUTPUT ON;
DECLARE
   V_FIBO INTEGER;
BEGIN
   NUMEROS_FIBONACCI(45, V_FIBO);
   dbms_output.put_line(V_FIBO);
END;

--------------------------------------------------------------
-- EX2
-- Fa�a uma procedure que percorra, de forma sequencial, o valor do identificador
-- da venda (ID) e atualize, na tabela PRODUTO_VENDA_EXERCICIO, as colunas 
-- VALOR_TOTAL e PERCENTUAL_IMPOSTO.

INSERT INTO PRODUTO_VENDA_EXERCICIO
VALUES (3, '41232',TO_DATE('01/02/2022','DD/MM/YYYY'), 250, 20, 0, 0);
INSERT INTO PRODUTO_VENDA_EXERCICIO
VALUES (4, '32223',TO_DATE('03/02/2022','DD/MM/YYYY'), 200, 16, 0, 0);
INSERT INTO PRODUTO_VENDA_EXERCICIO
VALUES (5, '92347',TO_DATE('05/02/2022','DD/MM/YYYY'), 200, 16, 0, 0);
INSERT INTO PRODUTO_VENDA_EXERCICIO
VALUES (6, '41232',TO_DATE('02/03/2022','DD/MM/YYYY'), 210, 19, 0, 0);
INSERT INTO PRODUTO_VENDA_EXERCICIO
VALUES (7, '33854',TO_DATE('05/03/2022','DD/MM/YYYY'), 180, 21, 0, 0);
INSERT INTO PRODUTO_VENDA_EXERCICIO
VALUES (8, '92347',TO_DATE('09/03/2022','DD/MM/YYYY'), 170, 20, 0, 0);

SELECT * FROM PRODUTO_VENDA_EXERCICIO;


CREATE OR REPLACE PROCEDURE ATUALIZAR_VALOR_PERCENTUAL_EX
IS
    V_ID PRODUTO_VENDA_EXERCICIO.ID%TYPE := 1;
    V_NUM_PROD INTEGER;
    V_COD_PRODUTO PRODUTO_VENDA_EXERCICIO.COD_PRODUTO%type;
    V_QUANTIDADE PRODUTO_VENDA_EXERCICIO.QUANTIDADE%TYPE;
    V_PRECO PRODUTO_VENDA_EXERCICIO.PRECO%TYPE;
    V_VALOR_TOTAL PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE;
    V_PERCENTUAL PRODUTO_VENDA_EXERCICIO.PERCENTUAL_IMPOSTO%TYPE;
BEGIN
    SELECT COUNT(*)INTO V_NUM_PROD FROM PRODUTO_VENDA_EXERCICIO;
    LOOP
        SELECT COD_PRODUTO, QUANTIDADE, PRECO INTO V_COD_PRODUTO, V_QUANTIDADE, V_PRECO 
        FROM PRODUTO_VENDA_EXERCICIO WHERE ID = V_ID;
        
        V_VALOR_TOTAL := V_QUANTIDADE * V_PRECO;
        V_PERCENTUAL := RETORNA_IMPOSTO(V_COD_PRODUTO);
        
        UPDATE PRODUTO_VENDA_EXERCICIO SET VALOR_TOTAL = V_VALOR_TOTAL,
        PERCENTUAL_IMPOSTO = V_PERCENTUAL WHERE ID = V_ID;
        V_ID := V_ID + 1;
    EXIT WHEN V_ID > V_NUM_PROD;
    END LOOP;
    COMMIT;
END;

-- TESTANDO
EXECUTE ATUALIZAR_VALOR_PERCENTUAL_EX;

SELECT * FROM PRODUTO_VENDA_EXERCICIO;

--------------------------------------------------------------
-- EX3
-- Refa�a-a o c�digo da procedure para a s�rie de Fibonacci, usando a estrutura FOR.

CREATE OR REPLACE PROCEDURE NUMEROS_FIBONACCI_FOR (P_INTERACOES IN FLOAT, P_NUMEROFIBO OUT FLOAT)
IS
   V_FIBO1 FLOAT := 0;
   V_FIBO2 FLOAT := 1;
   V_FIBO_ATUAL FLOAT := 0;
BEGIN
   IF P_INTERACOES > 1 THEN
      FOR v_CONTADOR IN 2..P_INTERACOES LOOP
        V_FIBO_ATUAL := V_FIBO1 + V_FIBO2;
         V_FIBO1 := V_FIBO2;
         V_FIBO2 := V_FIBO_ATUAL;
      END LOOP;
   END IF;
   P_NUMEROFIBO := V_FIBO_ATUAL;
END;

-- TESTANDO
SET SERVEROUTPUT ON;
DECLARE
   V_FIBO INTEGER;
BEGIN
   NUMEROS_FIBONACCI_FOR(45, V_FIBO);
   dbms_output.put_line(V_FIBO);
END;

--------------------------------------------------------------
-- EX4
-- Com quantas vendas no ano o valor total atingiu 20.000?
-- Fa�a uma procedure que retorne este valor (nome: SOMA_VENDAS), que use um FOR
-- e que execute o EXIT no meio do LOOP.

CREATE OR REPLACE PROCEDURE SOMA_VENDAS
(P_VENDA_LIMITE IN PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE, 
P_ID_RETORNO OUT PRODUTO_VENDA_EXERCICIO.ID%TYPE)
IS
    V_ID PRODUTO_VENDA_EXERCICIO.ID%TYPE := 1;
    V_VALOR PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE;
    V_SOMA PRODUTO_VENDA_EXERCICIO.VALOR_TOTAL%TYPE := 0;
BEGIN
    LOOP
        SELECT  VALOR_TOTAL INTO V_VALOR FROM PRODUTO_VENDA_EXERCICIO WHERE ID = V_ID;
        V_SOMA := V_SOMA + V_VALOR;
        IF V_SOMA >= P_VENDA_LIMITE THEN
            EXIT;
        ELSE
            V_ID := V_ID + 1;
        END IF;
    END LOOP;
    P_ID_RETORNO := V_ID;
END;

-- TESTANDO
SET SERVEROUTPUT ON;
DECLARE
    V_ID PRODUTO_VENDA_EXERCICIO.ID%TYPE;
BEGIN
    SOMA_VENDAS(20000, V_ID);
    dbms_output.put_line(V_ID);
END;

SELECT * FROM PRODUTO_VENDA_EXERCICIO;


--------------------------------------------------------------
-- EX5
-- Refa�a-a o c�digo da procedure para a s�rie de Fibonacci, usando a estrutura WHILE.

CREATE OR REPLACE PROCEDURE NUMEROS_FIBONACCI_WHILE (P_INTERACOES IN FLOAT, P_NUMEROFIBO OUT FLOAT)
IS
   V_FIBO1 FLOAT := 0;
   V_FIBO2 FLOAT := 1;
   V_CONTADOR FLOAT := 1;
   V_FIBO_ATUAL FLOAT := 0;
   v_INTERACOES FLOAT := 1;
BEGIN
   IF P_INTERACOES > 1 THEN
      WHILE V_CONTADOR < P_INTERACOES LOOP
         V_FIBO_ATUAL := V_FIBO1 + V_FIBO2;
         V_FIBO1 := V_FIBO2;
         V_FIBO2 := V_FIBO_ATUAL;
         V_CONTADOR := V_CONTADOR + 1;
      END LOOP;
   END IF;
   P_NUMEROFIBO := V_FIBO_ATUAL;
END;

-- TESTANDO
SET SERVEROUTPUT ON;
DECLARE
   V_FIBO INTEGER;
BEGIN
   NUMEROS_FIBONACCI_WHILE(45, V_FIBO);
   dbms_output.put_line(V_FIBO);
END;












