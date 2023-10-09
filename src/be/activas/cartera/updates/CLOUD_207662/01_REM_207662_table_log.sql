use cob_cartera
go 

IF object_id ('dbo.ca_plazo_asis_med') IS NOT NULL
    --Antes
    SELECT * from cob_cartera..ca_plazo_asis_med

     --Columna coberturas 
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
                    WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_cobertura')
        BEGIN
            ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_cobertura VARCHAR(5)         
        END

    --Columna Servicio  MÉDICOS ESPECIALISTAS 
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_serv_medicos')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_serv_medicos VARCHAR(16)
        END

    --Columna Servicio CHECK UP´S
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_serv_checkup')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_serv_checkup VARCHAR(16)
        END

    --Columna Servicio DENTAL 
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_serv_dental')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_serv_dental VARCHAR(16)
        END

    --Columna Linea EMBARAZO 
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_linea_embarazo')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_linea_embarazo VARCHAR(5)
        END
        
    --Columna Linea DIABETES   
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_linea_diabetes')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_linea_diabetes VARCHAR(5)
        END

    --Columna Linea VIOLENCIA INTRAFAMILIAR   
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_linea_violencia')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med add pm_linea_violencia VARCHAR(5)
        END
        
IF object_id('dbo.ca_plazo_asis_med') IS NULL
    CREATE TABLE dbo.ca_plazo_asis_med
    (
        pm_producto       VARCHAR(10),
        pm_plazo          INT,
        pm_frecuencia     VARCHAR(10),
        pm_valor          MONEY,
        pm_seguro         VARCHAR(16),
        pm_cobertura      VARCHAR(5),
        pm_serv_medicos   VARCHAR(16),
        pm_serv_checkup   VARCHAR(16),
        pm_serv_dental    VARCHAR(5),
        pm_linea_embarazo VARCHAR(5)
    )
    
use cob_cartera 
go

--Actualiza registros para Individual, plazo de 3 meses
IF EXISTS (SELECT * FROM cob_cartera..ca_plazo_asis_med 
            WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 3 AND pm_frecuencia = 'M')
    UPDATE cob_cartera..ca_plazo_asis_med 
        SET
            pm_cobertura = '3',
            pm_serv_medicos = '2 eventos',
            pm_serv_checkup = '1 evento',
            pm_serv_dental = '1 evento',
            pm_linea_embarazo = '4E',
            pm_linea_diabetes = '2E',
            pm_linea_violencia = '2E'
        WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 3 AND pm_frecuencia = 'M'
ELSE
    INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
        VALUES ('INDIVIDUAL', 3,  'W', 52.5, 'EXTENDIDO', '3', '2 eventos', '1 evento', '1 evento', '4E', '2E', '2E')
         
--Actualiza registros para Individual, plazo de 6 meses
IF EXISTS (SELECT * FROM cob_cartera..ca_plazo_asis_med 
            WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 6 AND pm_frecuencia = 'M')
    UPDATE cob_cartera..ca_plazo_asis_med 
        SET
            pm_cobertura = '6',
            pm_serv_medicos = '4 eventos',
            pm_serv_checkup = '2 eventos',
            pm_serv_dental = '2 eventos',
            pm_linea_embarazo = '8E',
            pm_linea_diabetes = '4E',
            pm_linea_violencia = '4E'
        WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 6 AND pm_frecuencia = 'M'
ELSE
     INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
        VALUES ('INDIVIDUAL', 6,  'M', 52.5, 'EXTENDIDO', '6', '4 eventos', '2 eventos', '2 eventos', '8E', '4E', '4E')
        
--Actualiza registros para Individual, plazo de 9 meses
IF EXISTS (SELECT * FROM cob_cartera..ca_plazo_asis_med 
            WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 9 AND pm_frecuencia = 'M')
    UPDATE cob_cartera..ca_plazo_asis_med 
        SET
            pm_cobertura = '9',
            pm_serv_medicos = '6 eventos',
            pm_serv_checkup = '3 eventos',
            pm_serv_dental = '3 eventos',
            pm_linea_embarazo = '12E',
            pm_linea_diabetes = '6E',
            pm_linea_violencia = '6E'
        WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 9 AND pm_frecuencia = 'M'
ELSE
    INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
        VALUES ('INDIVIDUAL', 9,  'M', 52.5, 'EXTENDIDO', '9', '6 eventos', '3 eventos', '3 eventos', '12E', '6E', '6E')
 
--Actualiza registros para Individual, plazo de 12 meses
IF EXISTS (SELECT * FROM cob_cartera..ca_plazo_asis_med 
            WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 12 AND pm_frecuencia = 'M')
    UPDATE cob_cartera..ca_plazo_asis_med 
        SET
            pm_cobertura = '12',
            pm_serv_medicos = '8 eventos',
            pm_serv_checkup = '4 eventos',
            pm_serv_dental = '4 eventos',
            pm_linea_embarazo = '16E',
            pm_linea_diabetes = '8E',
            pm_linea_violencia = '8E'
        WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo = 12 AND pm_frecuencia = 'M'
ELSE
   INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia) 
        VALUES ('INDIVIDUAL', 12,  'M', 52.5, 'EXTENDIDO', '12', '8 eventos', '4 eventos', '4 eventos', '16E', '8E', '8E')
        
--Insercion de nuevos registros

--Grupales
DELETE cob_cartera..ca_plazo_asis_med WHERE pm_producto = 'GRUPAL' AND pm_plazo = 4 AND pm_frecuencia = 'M'
    INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
        VALUES ('GRUPAL', 4,  'M', null, 'EXTENDIDO', '4', '2 eventos', '1 evento', '1 evento', '4E', '2E', '2E')



DELETE cob_cartera..ca_plazo_asis_med WHERE pm_producto = 'GRUPAL' AND pm_plazo = 6 AND pm_frecuencia = 'M'
    INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
        VALUES ('GRUPAL', 6,  'M', null, 'EXTENDIDO', '6', '4 eventos', '2 eventos', '2 eventos', '8E', '4E', '4E')

--Renovaciones

DELETE cob_cartera..ca_plazo_asis_med WHERE pm_producto = 'RENOVACION' AND pm_plazo = 4 AND pm_frecuencia = 'M'

INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
    VALUES ('RENOVACION', 4,  'M', null, 'EXTENDIDO', '4', '2 eventos', '1 evento', '1 evento', '4E', '2E', '2E')


DELETE cob_cartera..ca_plazo_asis_med WHERE pm_producto = 'RENOVACION' AND pm_plazo = 6 AND pm_frecuencia = 'M'
    INSERT INTO ca_plazo_asis_med (pm_producto, pm_plazo, pm_frecuencia, pm_valor, pm_seguro, pm_cobertura, pm_serv_medicos, pm_serv_checkup, pm_serv_dental, pm_linea_embarazo, pm_linea_diabetes, pm_linea_violencia)  
        VALUES ('RENOVACION', 6,  'M', null, 'EXTENDIDO', '6', '4 eventos', '2 eventos', '2 eventos', '8E', '4E', '4E')

--Despues
SELECT * FROM cob_cartera..ca_plazo_asis_med

go
