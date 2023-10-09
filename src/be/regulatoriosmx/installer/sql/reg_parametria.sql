/************************************************************************/
/*    ARCHIVO:         reg_parametria.sql                               */
/*    NOMBRE LOGICO:   reg_parametria.sql                               */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*  Creacion de parametria inicial para el envio de notificacion        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA           AUTOR                   RAZON                       */
/*  25/08/2016      Ignacio Yupa            Emision Inicial             */
/*  31/08/2016      Jorge Salazar           AHO-H81321-Reporte R08      */
/*  21/12/2016      Jorge Salazar           CCA-H90878 REPORTES         */
/*                                              R0451-R0453             */
/************************************************************************/

use cobis
go
delete cobis..cl_parametro
 where pa_producto = 'REC'
   and pa_nemonico in ('OFCU','NCLN','NOBA','MANO','CLAVEN','SUBREP','FECSIC','CLAPRE','CLASIC', 'MSDIND','ANTCLI','NCATR4','NIATR4','NCATR6','NIATR6','CCCON',
                       'CURB','NURB','TTBC','EXFCAP','NSOFON','RFCBAN','MNBRCD','NUBRCD','NRBRCD','DRBCD1','DRBCD2','DRBCD3', 'CPOSTA','NROPII','RALERT','CLPSAT','RFCGEN','NEJECU',
					   'CLUNSA','NPAMRE','NLICRE','MECETC','DPELCR','FPELCR', 'APERN4','MECMC','PHCMCC','SMCLP')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICIAL DE CUMPLIMIENTO', 'OFCU', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE CLIENTES NOTIFICAR', 'NCLN', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NOMBRE BANCO', 'NOBA', 'C', 'Cobis Cloud Banking', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAIL DE NOTIFICADOR', 'MANO', 'C', 'cobiscloud@cobiscorp.com', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CLAVE DE ENTIDAD', 'CLAVEN', 'C', '123456', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SUBREPORTE', 'SUBREP', 'C', '841', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA CONSULTA SIC', 'FECSIC', 'D', NULL, NULL, NULL, NULL, NULL, '01/01/1900', NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CLAVE DE PREVENCION SIC', 'CLASIC', 'C', '1234567890', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MTOSDO INDIVIDUAL', 'MSDIND', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.085, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ANTIGUEDAD CLIENTE ATR', 'ANTCLI', 'I', NULL, NULL, NULL, 28, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE CICLOS ATR4', 'NCATR4', 'I', NULL, NULL, NULL, 2, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE INTEGRANTES ATR4', 'NIATR4', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE CICLOS ATR6', 'NCATR6', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE INTEGRANTES ATR6', 'NIATR6', 'I', NULL, NULL, NULL, 15, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CLASE CONSUMO', 'CCCON', 'C', '9', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO DE CUENTA - CODIGO POSTAL SOFOM', 'CPOSTA', 'C', '01219', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RPT - APERTURA N4', 'APERN4', 'C', 'Aperturas', null, null, null, null, null, null,  'REC')
go

insert into cl_parametro values ('CLAVE USUARIO REPORTE BURO','CURB','C','0329',null,null,null,null,null,null,'REC')
insert into cl_parametro values ('NOMBRE USUARIO REPORTE BURO','NURB','C','BANCO COBIS',null,null,null,null,null,null,'REC')
insert into cl_parametro values ('TIPO TELEFONO BURO CREDITO','TTBC','C','D',null,null,null,null,null,null,'REC')
insert into cl_parametro values ('EXTENSION FORMATO CORTO ACTUALIZACIONES PARCIALES','EXFCAP','C','ext',null,null,null,null,null,null,'REC')
go
insert into cobis..cl_parametro values ('NOMBRE DE SOFOM', 'NSOFON', 'C', '170801',  null,null, null, null, null, null, 'REC')
insert into cobis..cl_parametro values ('NUMERO DE RFC DEL BANCO', 'RFCBAN', 'C', 'SIF170801PYA',  null,null, null, null, null, null, 'REC')

insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - MEMBER CODE','MNBRCD','C','SS10340001','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - NOMBRE USUARIO','NUBRCD','C','PRUEBA','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - NOMBRE REPORTE','NRBRCD','C','Santander_Inclusion','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - DIRECCION P1 REPORTE','DRBCD1','C','VASCO DE QUIROGA 3900 TORRE A','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - DIRECCION P2 REPORTE','DRBCD2','C','PISO 19 LOMAS DE SANTA FE ','REC')
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - DIRECCION P3 REPORTE','DRBCD3','C','CONTADERO 05300','REC')
go
--parametros caso Matrix de riesgo
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE REPORTE OPERACIONES INUSUALES', 'NROPII', 'C', 'operacion_inusuales', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA ALERTAS', 'RALERT', 'C', 'D:\Reportes\Alertas\', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go
-- ------------------------------------------------------------------------------------------
DELETE cobis..ns_template WHERE te_id = 1 
GO

INSERT INTO cobis..ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1,'XSLT', 'NEUTRAL', 'NotificacionesEC_ctas.xslt', 'A', '1.0.0.0')
GO

--Parametro CLAVE DE PRODUCTO SAT
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLAVE DE PRODUCTO SAT', 'CLPSAT', 'C', '84121500', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

--Parametro que contiene el RFC Genrico para Facturas SAT
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RFC GENERICO', 'RFCGEN', 'C', 'XAXX010101000', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

--Parametro que contiene el numero de ejecucion para enviar pdf estado de cuenta
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NÚMERO EJECUCIÓN ETCUE', 'NEJECU', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'REC')
GO

--Parametro clave de Unidad
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLAVE UNIDAD SAT', 'CLUNSA', 'C', 'E48', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

--parametro para el numero de pagos revolventes en un mes
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE PAGOS REVOLVENTE MES', 'NPAMRE', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'REC')
go
--parametro para el numero de pagos de su limite de credito REVOLVENTE
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO LIMITE CREDITO REVOLVENTE MES', 'NLICRE', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'REC')
  go

--Parametro numero de meses para eliminar carpetas de interfactura
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES ELIMINACION ESTADO CUENTA', 'MECETC', 'I', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'REC')
go
--Parametro para el dia de la semana en el que va iniciar la ejecucion del job ETCLCR
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIA PROCESAMIENTO ECTLCR', 'DPELCR', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'REC')
go
--Parametro para el numero de dia en el que finalizara la ejecucion del job ETCLCR
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIA FIN PROCESAMIENTO ECTLCR', 'FPELCR', 'I', NULL, NULL, NULL, 28, NULL, NULL, NULL, 'REC')
go
--PArametro numero de meses de Eliminacion carpetas mc COLLECT
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES ELIMINACION MC COLLECT', 'MECMC', 'I', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'REC')
go
--Segunda fase mc COLLECT
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PATH COBRANZA COBIS MC', 'PHCMCC', 'C', 'D:\WorkFolder\MCCollect\Cobis\', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')

--Parametro simulacion de interfactura
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SIMULACION COMPLEMENTO PAGO', 'SMCLP', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')

go

--- CREACION DE PARAMETRO PARA RUTA  ref.caso150202
delete from cobis..cl_parametro where pa_nemonico = 'RREFX1'  and pa_producto = 'REC'
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA REFACTURACION GEN XML 1', 'RREFX1', 'C', 'D:\WorkFolder\ReFactGenXML\', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

delete from cl_parametro where pa_nemonico = 'BTOPE' and pa_producto='REC'

INSERT INTO cl_parametro(pa_parametro, pa_nemonico,pa_tipo,pa_char,pa_producto)
VALUES('PRESENTAR TODOS LOS CASTIGADOS EN REPRORTE','BTOPE','C','S')
go

use cobis
go

select * from cl_parametro where pa_nemonico = 'NUFAEM'

if not exists(select 1 from cl_parametro where pa_nemonico = 'NUFAEM')
begin
   insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo,   pa_int,  pa_producto)
   values ('NUMERO FACTURAS EMPAQUETAR'  , 'NUFAEM'   , 'I'    ,   10000 ,  'ADM')
end

select  top 1 * from cl_parametro where pa_nemonico = 'NUFAEM'



select * from cl_parametro where pa_nemonico = 'NOPAFA'

if not exists(select 1 from cl_parametro where pa_nemonico = 'NOPAFA')
begin
   insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char  , pa_producto)
   values ('NOMBRE PAQUETE FACTURAS'         , 'NOPAFA'   , 'C'    , 'BSA_I_1', 'ADM')
end

select * from cl_parametro where pa_nemonico = 'NOPAFA'



select * from cl_parametro where pa_nemonico = 'NOPACO'

if not exists(select 1 from cl_parametro where pa_nemonico = 'NOPACO')
begin
   insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char  , pa_producto)
   values ('NOMBRE PAQUETE COMPLEMENTOS'         , 'NOPACO'   , 'C'    , 'BSA_C_1', 'ADM')
end

select * from cl_parametro where pa_nemonico = 'NOPACO'

use cobis
go

delete cl_parametro where pa_nemonico = 'NUDIVI' and pa_producto='ADM'

INSERT INTO cl_parametro(pa_parametro, pa_nemonico,pa_tipo,pa_int,pa_producto)
VALUES('NUMERO DIA VIERNES','NUDIVI','I',6,'ADM')

delete cl_parametro where pa_nemonico = 'DIMAPR' and pa_producto='ADM'

INSERT INTO cl_parametro(pa_parametro, pa_nemonico,pa_tipo,pa_int,pa_producto)
VALUES('DIA MAXIMO PROCESAMIENTO','DIMAPR','I',8,'ADM')


