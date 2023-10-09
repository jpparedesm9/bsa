USE cob_conta
GO

declare 
	@w_proceso_cierre   INT ,
	@w_nemonico         VARCHAR(6),
	@w_secuencial       INT ,
	@w_mes_ing          SMALLINT,
	@w_ctr_cuenta_mn    VARCHAR(30),
	@w_ctr_cuenta_usd   VARCHAR(30),
	@w_moneda_mn        SMALLINT,
	@w_moneda_usd       SMALLINT
	

--///////////////////////////////
SELECT @w_proceso_cierre  = 6079 --- CIERRE DE CUENTAS DE PYG 
SELECT @w_nemonico        = 'MESFPE'
SELECT @w_mes_ing         = 1
SELECT @w_ctr_cuenta_mn   = '420301'
SELECT @w_ctr_cuenta_usd  = '420302'
SELECT @w_moneda_mn       = 0
SELECT @w_moneda_usd      = 1
--///////////////////////////////


--/////////////////////////////////////////////////////////
-- CREACION DEL PARAMETRO MES COMPROBANTE FIN PERIODO
--/////////////////////////////////////////////////////////

DELETE FROM cobis..cl_parametro WHERE pa_nemonico = @w_nemonico

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MES INGRESO COMPROBANTE FIN PERIODO CONTABLE', @w_nemonico, 'I', NULL, NULL, NULL, @w_mes_ing, NULL, NULL, NULL, 'CON')


if not exists(select *
              from cobis..cl_parametro
              where pa_nemonico = 'CRFINP')
    insert into cobis..cl_parametro (pa_parametro             , pa_nemonico, pa_tipo, pa_char, pa_producto)
                       values('CODIGO REP. FIN PERIODO', 'CRFINP'   , 'C'    , 'CIERRE', 'CON'      ) 
--///////////////////////////////////////////
-- DEFINIR ERRORES DE VALIDACION
--///////////////////////////////////////////
if not exists(select 1
              from cobis..cl_errores
              where numero = 601315)
    insert into  cobis..cl_errores(numero, severidad, mensaje)
                    values (601315, 0        , 'Proceso de cierre fuera del mes de ENERO')
      
      
if not exists(select 1
              from cobis..cl_errores
              where numero = 601316)
    insert into  cobis..cl_errores(numero, severidad, mensaje)
                    values (601316, 0        , 'El parametro MESFPE, que controla el mes de ingreso del comprobante contable de fin de periodo debe ser 1 o 12')      
      
      
      
if not exists(select 1
              from cobis..cl_errores
              where numero = 601317)
    insert into  cobis..cl_errores(numero, severidad, mensaje)
                    values (601317, 0        , 'El corte de la fecha de ingreso del comprobante de fin de periodo está cerrado')      
            

if not exists(select 1
              from cobis..cl_errores
              where numero = 601318)
    insert into  cobis..cl_errores(numero, severidad, mensaje)
                    values (601318, 0        , 'El corte de la fecha de fin de año está abierto')      
                  
if not exists(select 1
              from cobis..cl_errores
              where numero = 601319)
    insert into  cobis..cl_errores(numero, severidad, mensaje)
                    values (601319, 0        , 'Error al calcular la feha habil')      
     

if not exists(select 1
              from cobis..cl_errores
              where numero = 601320)
    insert into  cobis..cl_errores(numero, severidad, mensaje)
                    values (601320, 0        , 'Error no tiene provisiones para la fecha de comprobante')     


--///////////////////////////////////////////
-- DEFINIR EL NUEVO TIPO DE REPORTE
--///////////////////////////////////////////
if not exists(select 1 from cb_listado_reportes_reg where lr_reporte = 'CIERRE')
   insert into cb_listado_reportes_reg(lr_reporte, lr_descripcion  , lr_estado, lr_depende_pro)
                                values('CIERRE'   , 'Proceso de Cierre de Período Contable', 'V'      , 'N'           )

--///////////////////////////////////////////
-- DEFINIR LAS CUENTAS DEL PROCESO DE CIERRE
--///////////////////////////////////////////

DELETE cb_cuenta_proceso WHERE cp_empresa = 1
AND cp_proceso = @w_proceso_cierre

INSERT INTO dbo.cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre)
VALUES (@w_proceso_cierre, 1, '5', 0, 0, '0', '1', '', '')

INSERT INTO dbo.cb_cuenta_proceso (cp_proceso, cp_empresa, cp_cuenta, cp_oficina, cp_area, cp_imprima, cp_condicion, cp_texto, cp_quiebre)
VALUES (@w_proceso_cierre, 1, '6', 0, 0, '0', '1', '', '')

--///////////////////////////////////////////
-- DEFINIR LAS CUENTAS ASOCIADAS
--///////////////////////////////////////////

DELETE cb_cuenta_asociada WHERE ca_empresa = 1
AND ca_proceso = @w_proceso_cierre

SELECT @w_secuencial = max(ca_secuencial) FROM cob_conta..cb_cuenta_asociada
SELECT @w_secuencial = isnull(@w_secuencial, 0)


-- DEFINIR LAS CONTRAPARTIDAS DE LAS CUENTAS DEL PROCESO DE CIERRE
-- usa la CONDICION para poner la MONEDA

-- MONEDA NACIONAL = 0
INSERT INTO dbo.cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred)
VALUES (1, '5', 1, 1, @w_proceso_cierre, @w_secuencial + 1, 0, '420301', 9001, 1, 'D')

INSERT INTO dbo.cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred)
VALUES (1, '6', 1, 1, @w_proceso_cierre, @w_secuencial + 2, 0, '420301', 9001, 1, 'D')

-- MONEDA DOLARES = 1
INSERT INTO dbo.cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred)
VALUES (1, '5', 1, 1, @w_proceso_cierre, @w_secuencial + 3, 1, '420302', 9001, 1, 'D')

INSERT INTO dbo.cb_cuenta_asociada (ca_empresa, ca_cuenta, ca_oficina, ca_area, ca_proceso, ca_secuencial, ca_condicion, ca_cta_asoc, ca_oficina_destino, ca_area_destino, ca_debcred)
VALUES (1, '6', 1, 1, @w_proceso_cierre, @w_secuencial + 4, 1, '420302', 9001, 1, 'D')


--////////////////////////////////////////////////////////////


SELECT * FROM cob_conta..cb_cuenta_proceso WHERE cp_empresa = 1
AND cp_proceso = @w_proceso_cierre

SELECT * FROM cob_conta..cb_cuenta_asociada WHERE ca_empresa = 1
AND ca_proceso = @w_proceso_cierre

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = @w_nemonico
GO



USE cob_conta
go
alter TABLE cb_retencion ALTER COLUMN re_identifica VARCHAR(30)
GO

