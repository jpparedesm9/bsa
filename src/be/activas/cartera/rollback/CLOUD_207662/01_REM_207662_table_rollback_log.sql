use cob_cartera
go 

IF object_id ('dbo.ca_plazo_asis_med') IS NOT NULL
    --Antes
    SELECT * from cob_cartera..ca_plazo_asis_med

    IF OBJECT_ID('tempdb.dbo.#TempTableName', 'U') IS NOT NULL
        DROP TABLE #ca_plazo_orig;
    
    SELECT * INTO #ca_plazo_orig FROM cob_cartera..ca_plazo_asis_med WHERE pm_producto = 'INDIVIDUAL' AND pm_plazo in (3,6,9,12) AND pm_frecuencia ='M'

     --Columna coberturas 
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
                    WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_cobertura')
        BEGIN
            ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_cobertura
        END

    --Columna Servicio  MÉDICOS ESPECIALISTAS 
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_serv_medicos')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_serv_medicos
        END

    --Columna Servicio CHECK UP´S
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_serv_checkup')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_serv_checkup
        END

    --Columna Servicio DENTAL 
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_serv_dental')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_serv_dental
        END

    --Columna Linea EMBARAZO 
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_linea_embarazo')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_linea_embarazo
        END
        
    --Columna Linea DIABETES   
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_linea_diabetes')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_linea_diabetes
        END

    --Columna Linea VIOLENCIA INTRAFAMILIAR   
    IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ca_plazo_asis_med' AND COLUMN_NAME = 'pm_linea_violencia')
        BEGIN
          ALTER TABLE cob_cartera..ca_plazo_asis_med DROP COLUMN pm_linea_violencia
        END
    
    TRUNCATE TABLE cob_cartera..ca_plazo_asis_med
    
    INSERT INTO cob_cartera..ca_plazo_asis_med(pm_producto, pm_plazo, pm_frecuencia,pm_valor, pm_seguro) 
        SELECT 
            pm_producto,
            pm_plazo,
            pm_frecuencia,
            pm_valor,
            pm_seguro
        FROM #ca_plazo_orig

    DROP TABLE #ca_plazo_orig;
	
	--DESPUES
    SELECT * from cob_cartera..ca_plazo_asis_med
go
