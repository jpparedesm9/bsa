/************************************************************************/
/*   Archivo:              sp_reporte_castigos_condonaciones.sp         */
/*   Stored procedure:     sp_reporte_castigos_condonaciones            */
/*   Base de datos:        cob_conta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Pedro Romero                                 */
/*   Fecha de escritura:   Diciembre 2020                               */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Genera archivo de interface de Riesgo para reportar operaciones    */
/*   vigentes y vencidas del banco SANTANDER MX (Archivo 7 - HRC).      */
/*                              CAMBIOS                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR                DESCRICIPCION                   */
/* 15/12/2020      PRO                  EMISION INICIAL				    */
/* 06/04/2021      DCU                  Cambios Error 155184            */
/************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_reporte_castigos_condonaciones')
   drop proc sp_reporte_castigos_condonaciones
go
create proc sp_reporte_castigos_condonaciones
   @i_param1   datetime    = null   --FECHA
as
declare 
@w_error                int,
@w_return               int,
@w_mensaje              varchar(255),
@w_sql                  varchar(5000),
@w_fecha_proceso        datetime,
@w_presentar_antiguos	char(1),
@w_nom_arch        varchar(255),
@w_nom_arch_cab    varchar(255),
@w_nom_log         varchar(255),
@w_path  		varchar(255),
@w_destino              varchar(255),
@w_errores              varchar(255),
@w_archivo_cab          varchar(255),
@w_archivo_det          varchar(255),
@w_comando              varchar(8000),
@w_columna              varchar(50),
@w_col_id               int,
@w_cabecera             varchar(8000),
@w_nom_cabecera         varchar(8000), 
@w_nom_columnas         varchar(8000),
@w_cont_columnas        int,
@w_s_app           varchar(255),
@w_batch           int,
@w_cmd             varchar(5000),
@w_lineas          varchar(10),
@w_destino2        varchar(255),
@w_max_column		int,
@w_fecha_ini		datetime

select @w_fecha_proceso = @i_param1
select @w_fecha_ini = dateadd(dd,-datepart(dd,@w_fecha_proceso)+1,@w_fecha_proceso)

create table #sb_reporte_castigados(
ID_FILA									int IDENTITY(1,1),
fecha_tran								datetime,
transac                                 varchar(20),
ENTIDAD            						varchar(30) null,
CARTERA            						varchar(32) null,
SEGMENTO            					varchar(50) null,
SUCURSAL_O_CENTRO_DE_ALTA            	varchar(4) null,
CONTRATO            					varchar(16) null,
REGION            						varchar(30) null,
MONEDA            						varchar(3) null,
VALOR_DIVISA 							tinyint	null,
MES 									varchar(8) null,
FECHA_CONTABLE 							varchar(8) null,
FECHA_DE_OPERACION 						varchar(8) null,
BUC            							varchar(8) null,
NUM_CREDITO           					varchar(16) null,
NOMBRE            						varchar(80) null,
TOTAL_QUITAS							varchar(20) null,
TOTAL_CASTIGOS							varchar(8) null,
TOTAL_RECUPERACIONES_CONTABLE			varchar(8) null,
TOTAL_RECUPERACIONES_GESTION			varchar(8) null,
TOTAL_RECUPERACIONES_SECORSE			varchar(8) null,
TOTAL_GASTOS							varchar(8) null,
TOTAL_QUITAS_MO							varchar(8) null,
TOTAL_CASTIGOS_MO 						varchar(8) null,
PRODUCTO            					varchar(2) null,
SUBPRODUCTO            					varchar(4) null,
PAN_O_CUENTA            				varchar(16) null,
ORIGEN            						varchar(11) null,
OBSERVACIONES            				varchar(50) null,
FECHA_DE_CASTIGO 						varchar(8) null,
TIPO_DE_PAGO            				varchar(34) null,
GESTION_CONTABLE            			varchar(8) null,
IDENTIFICADOR_DE_OPERACION            	varchar(20) null,
DIAS_MOROSOS							smallint null,
BANDERA_BASILEA            				varchar(1) null,
desc_segmento_loc_1            			varchar(50) null,
desc_segmento_loc_2            			varchar(50) null,
desc_segmento_loc_3            			varchar(50) null,
desc_segmento_loc_4            			varchar(50) null,
desc_segmento_loc_5            			varchar(50) null,
FECHA_VENTA								varchar(8) null,
fecha_pago								varchar(8) null,
secuencial                              int        null
)

SELECT @w_presentar_antiguos = pa_char 
from cobis..cl_parametro 
where pa_nemonico = 'BTOPE' and pa_producto='REC'

truncate table sb_reporte_castigados
--TRANSACCIONES DE CASTIGOS
select tr_secuencial , tr_fecha_mov as fecha_mov, tr_moneda, tr_banco as banco, tr_operacion as operacion, tr_tran, tr_fecha_ref, tr_estado, tr_fecha_cont, tr_fecha_real, convert(money,0.00) as monto,convert(varchar(5),'CA') as tipo_trn
into #transacciones_cast
from cob_cartera..ca_transaccion--, #operaciones_cast 
where tr_tran ='ETM'
and tr_estado <> 'RV'
and tr_secuencial > 0
and tr_fecha_mov <= @w_fecha_proceso

select a.tr_secuencial, a.tr_fecha_mov, a.tr_moneda, a.tr_banco, a.tr_operacion, a.tr_tran, a.tr_fecha_ref, a.tr_estado, a.tr_fecha_cont, a.tr_fecha_real, b.monto as monto, b.tipo_trn as tipo_trn
into #transacciones_seguimiento
from cob_cartera..ca_transaccion a, #transacciones_cast b
where tr_banco = banco
and a.tr_tran in ('ETM','PAG')
AND a.tr_fecha_mov >= @w_fecha_ini AND a.tr_fecha_mov <= @w_fecha_proceso
and a.tr_fecha_mov >= fecha_mov
and a.tr_estado <> 'RV'
and a.tr_secuencial > 0
group by a.tr_secuencial, a.tr_fecha_mov, a.tr_moneda, a.tr_banco, a.tr_operacion, a.tr_tran, a.tr_fecha_ref, a.tr_estado, a.tr_fecha_cont, a.tr_fecha_real, b.monto, b.tipo_trn 

--Quitar Pagos condonados de operaciones castigadas

delete #transacciones_seguimiento
from cob_cartera..ca_abono,
cob_cartera..ca_abono_det
where tr_tran       = 'PAG'
and   tr_operacion  = ab_operacion
and   tr_secuencial = ab_secuencial_pag  
and   ab_operacion  = abd_operacion
and   ab_secuencial_ing = abd_secuencial_ing
and   abd_tipo          = 'CON'
--TRANSACCIONES DE CONDONADAS
truncate table #transacciones_cast


SELECT tr_secuencial , tr_fecha_mov as fecha_mov, tr_moneda, tr_banco as banco, tr_operacion as operacion, tr_tran, tr_fecha_ref, tr_estado, tr_fecha_cont, tr_fecha_real--, 0, 'CON'
into #pagos_condonados
from cob_cartera..ca_transaccion,
cob_cartera..ca_abono,
cob_cartera..ca_abono_det
where tr_tran = 'PAG'
and tr_secuencial > 0
and tr_estado <> 'RV'
and tr_operacion  = ab_operacion
and tr_secuencial = ab_secuencial_pag
and ab_operacion  = abd_operacion
and ab_secuencial_ing = abd_secuencial_ing
and tr_fecha_mov between @w_fecha_ini and @w_fecha_proceso
and abd_tipo = 'CON'
group by tr_secuencial,tr_fecha_mov,tr_moneda,tr_banco,tr_operacion, tr_tran, tr_fecha_ref, tr_estado, tr_fecha_cont, tr_fecha_real

insert into #transacciones_cast
select tr_secuencial , fecha_mov, tr_moneda, banco, operacion, tr_tran, tr_fecha_ref, tr_estado, tr_fecha_cont, tr_fecha_real, sum(dtr_monto), 'CON'
from #pagos_condonados,
cob_cartera..ca_det_trn
where operacion     = dtr_operacion
and   tr_secuencial = dtr_secuencial
and dtr_estado = 7
and   dtr_concepto  not in ('IVA_INT', 'IVA_ESPERA')
group by tr_secuencial, fecha_mov, tr_moneda, banco, operacion, tr_tran, tr_fecha_ref, tr_estado, tr_fecha_cont, tr_fecha_real--, 0, 'CON'



insert into #transacciones_seguimiento
select a.tr_secuencial, a.tr_fecha_mov, a.tr_moneda, a.tr_banco, a.tr_operacion, a.tr_tran, a.tr_fecha_ref, a.tr_estado, a.tr_fecha_cont, a.tr_fecha_real, b.monto as monto, b.tipo_trn as tipo_trn
from cob_cartera..ca_transaccion a, #transacciones_cast b
where tr_banco = banco
and a.tr_tran in ('PAG')
and a.tr_estado <> 'RV'
and a.tr_secuencial > 0
and a.tr_secuencial = b.tr_secuencial
order by tr_secuencial

--select * from #transacciones_seguimiento ORDER BY tr_banco, tr_fecha_mov asc

print 'PASO 1'
insert into #sb_reporte_castigados
select 
tr_fecha_mov,
tr_tran,
'Santander Inclusion Financiera',
'CONSUMO',
'MICROCREDITO',
null,
RTRIM(tr_banco),
null,
'MXN',
1,
replace(convert(VARCHAR(10),@w_fecha_proceso,103),'/',''),
replace(convert(VARCHAR(10),tr_fecha_mov,103),'/',''),
replace(convert(VARCHAR(10),tr_fecha_cont,103),'/',''),
null,
RTRIM(tr_banco),
null,
case tipo_trn when 'CON' then convert(varchar(20),round(monto,2)) else '' end,
null,
'',
'',
'',
'',
'',
'',
'96',
null,
RTRIM(tr_banco),
'',
'',
null,
'EFECTIVO',
'CONTABLE',
case tr_tran when 'ETM' then 'CASTIGO' when 'PAG' then case tipo_trn when 'CON' then 'CONDONACIONES' else 'RECUPERACION' end end,
null,
'0',
'',
'',
'',
'',
'',
'',
'',
tr_secuencial
from #transacciones_seguimiento

print 'PASO 2'
update #sb_reporte_castigados
set SUCURSAL_O_CENTRO_DE_ALTA		=	do_oficina,
	REGION							=	(select A.of_nombre
										  from cobis..cl_oficina A, cobis..cl_oficina B
										  where A.of_oficina = B.of_regional
										  and   B.of_oficina = do_oficina),
	SUBPRODUCTO						=	case do_tipo_operacion when 'GRUPAL' then '001' when 'REVOLVENTE' then '002' end,
	DIAS_MOROSOS					=	do_atraso_grupal
from sb_dato_operacion
where do_banco = CONTRATO
and do_fecha = @w_fecha_proceso 

if(@w_presentar_antiguos ='S')
begin
    print 'PASO 3'
	--PARA OPERACIONES ANTIGUAS
	update #sb_reporte_castigados
	set SUCURSAL_O_CENTRO_DE_ALTA		=	do_oficina,
		REGION							=	(select A.of_nombre
											  from cobis..cl_oficina A, cobis..cl_oficina B
											  where A.of_oficina = B.of_regional
											  and   B.of_oficina = do_oficina),
		SUBPRODUCTO						=	case do_tipo_operacion when 'GRUPAL' then '001' when 'REVOLVENTE' then '002' end,
		DIAS_MOROSOS					=	do_atraso_grupal
	from sb_dato_operacion
	where do_banco = CONTRATO
	and do_fecha = (select max(do_fecha) from sb_dato_operacion where do_banco=CONTRATO)
	and SUCURSAL_O_CENTRO_DE_ALTA is null
end

print 'PASO 4'

update #sb_reporte_castigados
set BUC 	= en_banco,
	NOMBRE	= upper(isnull(ltrim(rtrim(p_p_apellido)), '') + space(1) + isnull(ltrim(rtrim(p_s_apellido)), '') + space(1) + 
                        isnull(ltrim(rtrim(en_nombre)), '') + space(1) + isnull(ltrim(rtrim(p_s_nombre)), ''))
from cobis..cl_ente, cob_cartera..ca_operacion
where op_banco= CONTRATO
and op_cliente = en_ente

print 'PASO 5'


select 
ID_FILA as fila,
CONTRATO as oper,
sum(abs(dtr_monto)) as MONTO_CAST
into #dato_montos
from #sb_reporte_castigados,cob_cartera..ca_transaccion a,cob_cartera..ca_det_trn
where tr_banco   = CONTRATO
and a.tr_operacion = dtr_operacion
and a.tr_tran = 'ETM'
and a.tr_estado <> 'RV'
and a.tr_secuencial = dtr_secuencial
and a.tr_secuencial > 0
and dtr_estado  = 2
and dtr_concepto in ('CAP','INT', 'INT_ESPERA')
and IDENTIFICADOR_DE_OPERACION = 'CASTIGO'
and tr_fecha_mov between @w_fecha_ini and @w_fecha_proceso
group by ID_FILA,CONTRATO

update #sb_reporte_castigados
set TOTAL_CASTIGOS = MONTO_CAST
from #dato_montos
where ID_FILA = fila
and oper = CONTRATO
and IDENTIFICADOR_DE_OPERACION = 'CASTIGO'


update #sb_reporte_castigados
set FECHA_DE_CASTIGO = replace(convert(VARCHAR(10),tr_fecha_ref,103),'/','')
from #transacciones_seguimiento
where CONTRATO = tr_banco
and tr_tran = 'ETM'

select 
tr_banco as banco,
tr_secuencial as secuencial_rec,
sum(dtr_monto) as montos
into #recuperaciones
from #sb_reporte_castigados,cob_cartera..ca_transaccion,cob_cartera..ca_det_trn
WHERE tr_banco =CONTRATO
AND tr_operacion = dtr_operacion
AND tr_tran = 'PAG'
AND tr_estado <> 'RV'
AND tr_secuencial = dtr_secuencial
AND dtr_concepto = 'VAC0'
and tr_secuencial > 0
and tr_secuencial = secuencial
AND IDENTIFICADOR_DE_OPERACION ='RECUPERACION'
AND tr_fecha_mov between @w_fecha_ini and @w_fecha_proceso
GROUP BY tr_banco,tr_operacion, tr_secuencial

update #sb_reporte_castigados
set TOTAL_RECUPERACIONES_CONTABLE = montos
from #recuperaciones
where CONTRATO = banco
and IDENTIFICADOR_DE_OPERACION = 'RECUPERACION'
and secuencial_rec = secuencial

print 'PASO 6'

insert into sb_reporte_castigados
select 
ENTIDAD            			
,CARTERA            			
,SEGMENTO            		
,SUCURSAL_O_CENTRO_DE_ALTA   
,CONTRATO            		
,REGION            			
,MONEDA            			
,VALOR_DIVISA 				
,MES 						
,FECHA_CONTABLE 				
,FECHA_DE_OPERACION 			
,BUC            				
,NUM_CREDITO           		
,NOMBRE            			
,TOTAL_QUITAS				
,TOTAL_CASTIGOS				
,TOTAL_RECUPERACIONES_CONTABLE
,TOTAL_RECUPERACIONES_GESTION
,TOTAL_RECUPERACIONES_SECORSE
,TOTAL_GASTOS				
,TOTAL_QUITAS_MO				
,TOTAL_CASTIGOS_MO 			
,PRODUCTO            		
,SUBPRODUCTO            		
,PAN_O_CUENTA            	
,ORIGEN            			
,OBSERVACIONES            	
,FECHA_DE_CASTIGO 			
,TIPO_DE_PAGO            	
,GESTION_CONTABLE            
,IDENTIFICADOR_DE_OPERACION  
,DIAS_MOROSOS				
,BANDERA_BASILEA            	
,desc_segmento_loc_1         
,desc_segmento_loc_2         
,desc_segmento_loc_3         
,desc_segmento_loc_4         
,desc_segmento_loc_5         
,FECHA_VENTA					
,fecha_pago					
from #sb_reporte_castigados

print 'PASO 7'

select @w_nom_arch       = ba_arch_resultado,
       @w_path = ba_path_destino
from cobis..ba_batch 
where ba_batch = 287934

----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_reporte_castigados out '

select @w_destino  = @w_path + @w_nom_arch + replace(convert(varchar, @w_fecha_proceso, 102), '.', '') + '.txt',
       @w_destino2 = @w_path + 'lineasCastigos_'      + replace(convert(varchar, @w_fecha_proceso, 102), '.', '') + '.txt',
       @w_errores  = @w_path + @w_nom_arch + replace(convert(varchar, @w_fecha_proceso, 102), '.', '') + '_' + replace(convert(varchar, getdate(), 108), ':', '') + '.err'

select @w_comando = @w_cmd + @w_path + 'repcastigoscond -b5000 -c -T -e ' + @w_errores + ' -t";" ' + '-config ' + @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Reporte Operativo de Cartera'
   print @w_comando
   return 1
end


----------------------------------------
-- Lineas Plano
----------------------------------------

select @w_lineas = convert(varchar,isnull(count(1),0)) from cob_conta_super..sb_reporte_castigados
select @w_comando = 'echo ' + @w_lineas + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas'
   print @w_comando
   return 1
end

----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = ''
	   
select @w_max_column = max(c.colid)
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_reporte_castigados'
       
while 1 = 1 begin
   set rowcount 1
   select @w_columna = c.name,
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_reporte_castigados'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end

   if(@w_col_id <> @w_max_column)
		select @w_cabecera = @w_cabecera + @w_columna + ';'
	else
		select @w_cabecera = @w_cabecera + @w_columna
end
--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_comando
   return 1
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_destino + ' ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error generando Archivo de Lineas mas cabeceras'
   print @w_comando
   return 1
end

select @w_comando = 'copy ' + @w_destino2 + ' + ' + @w_path + 'repcastigoscond ' + @w_destino

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Agregando Cabeceras'
   print @w_comando
   return 1
end

--SE eliminan archivos innecesarios

select @w_comando = 'del ' + @w_destino2

exec @w_error = xp_cmdshell @w_comando


select @w_comando = 'del ' + @w_path + 'repcastigoscond'

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   print 'Error Eliminando'
   print @w_comando
   return 1
end

return 0
go


