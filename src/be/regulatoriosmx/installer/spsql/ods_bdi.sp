/************************************************************************/
/*   Archivo:                 sp_ods_bdi.sp                             */
/*   Stored procedure:        sp_ods_bdi                                */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Agosto 13 de 2018                         */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Generar reporte operativo de cartera y archivo plano respectivo    */
/************************************************************************/
/*                                  MODIFICACIONES                      */
/*   Fecha      Nombre              Proposito                           */
/*   13/08/2018 Santiago Mosquera   Emision Inicial - Req  #102659      */
/*   01/07/2019 M. Taco             Ajustes campo Tipo de Movimientos   */ 
/*   15/11/2019 M. Taco             Se debe ejecutar en doble cierre    */
/*   24/09/2020 ACH                 Caso:  146729                       */
/*   30/08/2023 KVI                 Req.195961-Archivo final Binario    */
/************************************************************************/

use cob_conta_super  
go

if not object_id('sp_ods_bdi') is null
   drop proc sp_ods_bdi
go

create proc sp_ods_bdi
   @i_param1   varchar(10) = null,--fecha
   @i_param2   varchar(10), --BATCH 
   @i_fecha_desde   datetime = null,   
   @i_fecha_hasta   datetime = null
   
as
declare 
@w_fecha_desde           datetime,
@w_fecha_hasta           datetime,
@w_batch                 int,
@w_ciudad_nacional       int,
@w_s_app                varchar(255),
@w_path                 varchar(255),
@w_destino              varchar(255),
@w_errores              varchar(255),
@w_error                int,
@w_comando              varchar(6000),
@w_fecha                datetime,
@w_destino_lineas       varchar(255),
@w_destino_cabecera     varchar(255),
@w_columna              varchar(50),
@w_col_id               int,
@w_cabecera             varchar(5000),
@w_mensaje              varchar(100),
@w_reversos             char(1),
@w_path_obj             varchar(255),
@w_msg                  varchar(200)

declare 
@resultadobcp           table (linea varchar(max))

select 
@w_fecha       = convert(datetime, isnull(@i_param1,'01/01/1900')),  --> Fecha de proceso (sarta 22)
@w_batch       = convert(int,@i_param2),                             --> Nro del proceso batch.
@w_reversos    = 'N',
@w_fecha_desde = @i_fecha_desde,
@w_fecha_hasta = @i_fecha_hasta


/* CIUDAD DE FERIADOS NACIONALES */
select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_path_obj = ba_path_fuente
from cobis..ba_batch
where ba_batch = 36007


/* SI LLEGA PARAM1 AJUSTAR FECHA DE INICIO Y FIN DEL REPORTE */
if @i_param1 is not null begin

   /*EVITAR GENERAR EL REPORTE EN EL INICIO DE DIA DEL DOBLE CIERRE*/
   --if exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha ) return 0 --Se debe ejecutar en doble cierre



   /* DETERMINAR FECHA DE CORTE DEL REPORTE POR EJECUCION EN SARTA 22*/
   select @w_fecha_hasta = dateadd(dd,-1,@w_fecha)


    
	while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_hasta) 
      select @w_fecha_hasta= dateadd(dd,-1,@w_fecha_hasta) 



    


   /* EN CASO QUE LA FECHA DE CORTE SEA UN FERIADO, EL REPORTE DEBE CONSIDERAR ESTAS TRANSACCIONES */
   select @w_fecha_desde = dateadd(dd,-1,@w_fecha_hasta)


  
    
	while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_desde) 
      select @w_fecha_desde= dateadd(dd,-1,@w_fecha_desde) 


    
   select @w_fecha_desde = dateadd(dd,+1,@w_fecha_desde)
   
    
   select @w_reversos = 'S'  --> solo reportamos reversos en los reportes diarios
    
end 


print 'desde'+convert(varchar(10),@w_fecha_desde,103)
print 'hasta'+convert(varchar(10),@w_fecha_hasta,103)



create table #tipos_trn(
tipo_tran    varchar(10) null,
reverso      varchar(10) null,
estado       int         null,
categoria_r  varchar(10) null,
categoria_a  varchar(10) null,
ods_trn      varchar(10) null,
ods_afect    varchar(10) null,
descripcion  varchar(64) null) --solo para conservar descripciones


                             --tran,  rev, e_ori, cat_r, cat_a, o_trn, o_afect

insert into #tipos_trn values('DES',  'N',     1,   'C',   '', 'DES1' , 'D', 'Desembolso: CAPITAL')
insert into #tipos_trn values('DES',  'N',     1,   'O',   '', 'DES2' , 'H', 'Desembolso: COMISION ')
insert into #tipos_trn values('DES',  'N',     1,   'A',   '', 'DES9' , 'H', 'Desembolso: IVA COMISION ')

insert into #tipos_trn values('DES',  'S',     1,   'C',   '', 'DES3' , 'H', 'Reverso - Desembolso: CAPITAL')
insert into #tipos_trn values('DES',  'S',     1,   'O',   '', 'DES4' , 'D', 'Reverso - Desembolso: COMISION ')
insert into #tipos_trn values('DES',  'S',     1,   'A',   '', 'DES10', 'D', 'Reverso - Desembolso: IVA COMISION ')

insert into #tipos_trn values('RES',  'N',     1,   'C',   '', 'DES5' , 'D', 'Reestructuraccion: CAPITAL')
insert into #tipos_trn values('RES',  'N',     1,   'O',   '', 'DES6' , 'H', 'Reestructuraccion: COMISION ')
insert into #tipos_trn values('RES',  'N',     1,   'A',   '', 'DES11', 'H', 'Reestructuraccion: IVA COMISION ')

insert into #tipos_trn values('RES',  'S',     1,   'C',   '', 'DES7' , 'H', 'Reverso - Reestructuracion:  CAPITAL')
insert into #tipos_trn values('RES',  'S',     1,   'O',   '', 'DES8' , 'D', 'Reverso - Reestructuracion: COMISION ')
insert into #tipos_trn values('RES',  'S',     1,   'A',   '', 'DES12', 'D', 'Reverso - Reestructuracion: IVA COMISION ')


insert into #tipos_trn values('PRV',  'N',     1,   'I',   '', 'PRV1' , 'D', 'Provision: INTERES (1301)')
insert into #tipos_trn values('PRV',  'N',     1,   'I',   '', 'PRV2' , 'H', 'Provision: INTERES (5105)')
insert into #tipos_trn values('PRV',  'S',     1,   'I',   '', 'PRV3' , 'H', 'Reverso - Provision: INTERES (1301)')
insert into #tipos_trn values('PRV',  'S',     1,   'I',   '', 'PRV4' , 'D', 'Reverso - Provision: INTERES (5105)')

insert into #tipos_trn values('VEN',  'N',     1,   'I',   '', 'FACT1' , 'H', 'Facuracion: INTERES')
insert into #tipos_trn values('VEN',  'S',     1,   'I',   '', 'FACT2' , 'D', 'Reverso - Facturacion : INTERES')
insert into #tipos_trn values('VEN',  'N',     1,   'A',  'I', 'FACT3' , 'H', 'Facuracion: IVA INT')
insert into #tipos_trn values('VEN',  'S',     1,   'A',  'I', 'FACT4' , 'D', 'Reverso - Facturacion : IVA INT')
insert into #tipos_trn values('VEN',  'N',     1,   'C',   '', 'FACT5' , 'H', 'Facuracion: CAPITAL')
insert into #tipos_trn values('VEN',  'S',     1,   'C',   '', 'FACT6' , 'D', 'Reverso - Facturacion : CAPITAL')

insert into #tipos_trn values('PAG',  'N',     1,   'C',   '', 'PAG1' , 'H', 'Pago: CAPITAL')
insert into #tipos_trn values('PAG',  'N',     1,   'I',   '', 'PAG2' , 'H', 'Pago: INTERESES')
insert into #tipos_trn values('PAG',  'N',     1,   'A',  'I', 'PAG3' , 'H', 'Pago: IVA DEL INTERES')
insert into #tipos_trn values('PAG',  'N',     1,   'O',   '', 'PAG4' , 'H', 'Pago: COMISION')
insert into #tipos_trn values('PAG',  'N',     1,   'A',  'O', 'PAG5' , 'H', 'Pago: IVA COMISION')
insert into #tipos_trn values('PAG',  'S',     1,   'C',   '', 'PAG6' , 'D', 'Reverso - Pago: CAPITAL')
insert into #tipos_trn values('PAG',  'S',     1,   'I',   '', 'PAG7' , 'D', 'Reverso - Pago: INTERESES')
insert into #tipos_trn values('PAG',  'S',     1,   'A',  'I', 'PAG8' , 'D', 'Reverso - Pago: IVA INTERES')
insert into #tipos_trn values('PAG',  'S',     1,   'O',   '', 'PAG9' , 'D', 'Reverso - Pago: COMISION')
insert into #tipos_trn values('PAG',  'S',     1,   'A',  'O', 'PAG10', 'D', 'Reverso - Pago: IVA COMISION')

insert into #tipos_trn values('PAG',  'N',     2,   'C',   '', 'PAG11', 'H', 'Pago An: CAPITAL')
insert into #tipos_trn values('PAG',  'N',     2,   'I',   '', 'PAG12', 'H', 'Pago An: INTERESES')
insert into #tipos_trn values('PAG',  'N',     2,   'A',  'I', 'PAG13', 'H', 'Pago An: IVA DEL INTERES')
insert into #tipos_trn values('PAG',  'N',     2,   'O',   '', 'PAG14', 'H', 'Pago An: COMISION')
insert into #tipos_trn values('PAG',  'N',     2,   'A',  'O', 'PAG15', 'H', 'Pago An: IVA COMISION')
insert into #tipos_trn values('PAG',  'S',     2,   'C',   '', 'PAG16', 'D', 'Reverso - Pago An: CAPITAL')
insert into #tipos_trn values('PAG',  'S',     2,   'I',   '', 'PAG17', 'D', 'Reverso - Pago An: INTERESES')
insert into #tipos_trn values('PAG',  'S',     2,   'A',  'I', 'PAG18', 'D', 'Reverso - Pago An: IVA INTERES')
insert into #tipos_trn values('PAG',  'S',     2,   'O',   '', 'PAG19', 'D', 'Reverso - Pago An: COMISION')
insert into #tipos_trn values('PAG',  'S',     2,   'A',  'O', 'PAG20', 'D', 'Reverso - Pago An: IVA COMISION')

insert into #tipos_trn values('PAG',  'N',     3,   'C',   '', 'PAG21', 'H', 'Pago PrC: CAPITAL')
insert into #tipos_trn values('PAG',  'N',     3,   'I',   '', 'PAG22', 'H', 'Pago PrC: INTERESES')
insert into #tipos_trn values('PAG',  'N',     3,   'A',  'I', 'PAG23', 'H', 'Pago PrC: IVA DEL INTERES')
insert into #tipos_trn values('PAG',  'N',     3,   'O',   '', 'PAG24', 'H', 'Pago PrC: COMISION')
insert into #tipos_trn values('PAG',  'N',     3,   'A',  'O', 'PAG25', 'H', 'Pago PrC: IVA COMISION')
insert into #tipos_trn values('PAG',  'S',     3,   'C',   '', 'PAG26', 'D', 'Reverso - Pago PrC: CAPITAL')
insert into #tipos_trn values('PAG',  'S',     3,   'I',   '', 'PAG27', 'D', 'Reverso - Pago PrC: INTERESES')
insert into #tipos_trn values('PAG',  'S',     3,   'A',  'I', 'PAG28', 'D', 'Reverso - Pago PrC: IVA INTERES')
insert into #tipos_trn values('PAG',  'S',     3,   'O',   '', 'PAG29', 'D', 'Reverso - Pago PrC: COMISION')
insert into #tipos_trn values('PAG',  'S',     3,   'A',  'O', 'PAG30', 'D', 'Reverso - Pago PrC: IVA COMISION')

/* EXTRAER EL UNIVERSO DE TRANSACCIONES A REPORTAR (PRV) */
select
fecha        = tp_fecha_mov,
toperacion   = convert(varchar(10),''),
banco        = convert(varchar(24),''),
operacion    = tp_operacion,
secuencial   = convert(int,0),
tipo_tran    = 'PRV',
reverso      = case when tp_monto < 0 then 'S' else 'N' end,
concepto     = tp_concepto,
categoria_r  = convert(char(1), ''),
categoria_a  = convert(char(1), ''),
estado       = convert(int,1),
monto        = sum(abs(tp_monto)),
dividendo    = max(tp_dividendo)
into #transacciones
from cob_cartera..ca_transaccion_prv, cob_cartera..ca_operacion
where tp_fecha_mov between @w_fecha_desde and @w_fecha_hasta
and   tp_estado    <> 'RV'
and  (tp_monto > 0 or @w_reversos = 'S')  --evitar reportar transacciones rv 
and   abs(tp_monto) >= 0.01
and   tp_operacion = op_operacion
group by tp_fecha_mov, 
         tp_operacion, 
         case when tp_monto < 0 then 'S' else 'N' end,
         tp_concepto




/* DETERMINAR NRO DE BANCO Y TIPO DE OPERACION */
update #transacciones set
banco = op_banco,
toperacion = op_toperacion
from cob_cartera..ca_operacion
where operacion = op_operacion


/* EXTRAER EL UNVIERSO DE TRANSACCIONES A REPORTAR (OTRAS TRANSACCIONES) */
insert into  #transacciones
select 
fecha        = tr_fecha_mov,
toperacion   = tr_toperacion,
banco        = tr_banco,
operacion    = tr_operacion,
secuencial   = tr_secuencial,
tipo_tran     = tr_tran,
reverso      = case when tr_secuencial < 0 then 'S' else 'N' end,
concepto     = dtr_concepto,
categoria_r  = convert(char(1),''),
categoria_a  = convert(char(1),''),
estado       = case when tr_tran in ('EST', 'ETM') then dtr_estado else 1 end,
monto        = sum(dtr_monto),
dividendo    = max(dtr_dividendo)
from cob_cartera..ca_transaccion, cob_cartera..ca_det_trn
where tr_fecha_mov between @w_fecha_desde and @w_fecha_hasta
and   tr_tran       in (select distinct tipo_tran from #tipos_trn)
and   tr_estado    <> 'RV'
and   tr_tran      <> 'PRV'
and   dtr_codvalor  > 9999
and   tr_operacion  = dtr_operacion
and   tr_secuencial = dtr_secuencial
and  (tr_secuencial > 0 or @w_reversos = 'S')  --evitar reportar transacciones rv 
group by tr_fecha_mov,
         tr_toperacion,
         tr_banco,
         tr_operacion,
         tr_secuencial,
         tr_tran,
         case when tr_secuencial < 0 then 'S' else 'N' end,
         dtr_concepto,
         case when tr_tran in ('EST', 'ETM') then dtr_estado else 1 end



/* DETERMINAR LA CATEGORIA DE LOS RUBROS */
update #transacciones set
categoria_r = co_categoria
from cob_cartera..ca_concepto
where concepto = co_concepto



/* DETERMINAR LA CATEGORIA DE LOS RUBROS ASOCIADOS */
update #transacciones set
categoria_a = co_categoria
from cob_cartera..ca_rubro_op, cob_cartera..ca_concepto
where concepto    = ro_concepto
and   operacion   = ro_operacion
and   co_concepto = ro_concepto_asociado 

/* BORRAR REGISTROS DESTINO EN LOS CAMBIOS DE ESTADO */
delete #transacciones
where monto > 0
and   tipo_tran in ('EST','ETM')


/* LOS REGISTROS ORIGEN SE DEBEN REPORTAR EN POSITIVO */
update #transacciones set
monto = abs(monto)
where monto < 0
and   tipo_tran in ('EST','ETM')


/* DETERMINAR SI LOS PAGOS SON ADELANTOS DE CAPITAL */
select distinct
pa_operacion  = operacion, 
pa_secuencial = secuencial
into #pagos_adelantados
from #transacciones, cob_cartera..ca_transaccion, cob_cartera..ca_det_trn, cob_cartera..ca_dividendo
where tipo_tran     = 'PAG'
and   operacion     = tr_operacion
and   secuencial    = tr_secuencial
and   operacion     = dtr_operacion
and   secuencial    = dtr_secuencial
and   operacion     = di_operacion
and   dtr_dividendo = di_dividendo
and   dtr_concepto  = 'CAP'
and   di_fecha_ini  > tr_fecha_ref


update #transacciones set
estado = 2  --pagos adelantados
from #pagos_adelantados
where  operacion    = pa_operacion
and    secuencial   = pa_secuencial


/* REGISTRO HISTORICO DE CANCELACIONES */
select 
pc_fecha      = fecha,
pc_operacion  = operacion, 
pc_secuencial = max(secuencial)
into #pagos_cancelacion
from #transacciones, cob_cartera..ca_operacion, cob_cartera..ca_transaccion
where tipo_tran     = 'PAG'
and   reverso       = 'N'
and   operacion     = op_operacion
and   op_estado     = 3 --cancelado
and   operacion     = tr_operacion
and   secuencial    = tr_secuencial
and   tr_fecha_ref  = op_fecha_ult_proceso
group by fecha, operacion



delete cob_cartera..ca_abono_can_bdi where ac_fecha between @w_fecha_desde and @w_fecha_hasta

insert into cob_cartera..ca_abono_can_bdi
select pc_fecha, pc_operacion, pc_secuencial
from #pagos_cancelacion


/* RECUPERAR TIPO DE PAGO EN REVERSOS */
update #transacciones set
estado = 3 --pago adelantado con cancelacion del prestamo
from cob_cartera..ca_abono_can_bdi
where  operacion      = ac_operacion
and   abs(secuencial) = ac_secuencial_pag
and    tipo_tran      = 'PAG'
AND    estado         = 2  -- pago adelantado


/* GENERAR TABLA DEL REPORTE BDI */

truncate table cob_conta_super..sb_ods_bdi  

insert into cob_conta_super..sb_ods_bdi     
select 
FEC_DATA             = convert(VARCHAR(10),fecha,112),
COD_ENTIDAD          = '0078',
COD_CENTRO           = '1090',
COD_PRODUCTO         = '96',
COD_SUBPRODU         = case a.toperacion when 'GRUPAL' then '0001' when 'INDIVIDUAL' then '0002'  when 'REVOLVENTE' then '0002' else '0003' end,
NUM_CUENTA           = replace(banco, ' ', ''),
NUM_SECUENCIA_CTO    = '000',
COD_ORIGEN           = a.tipo_tran,
COD_SIGNO_MOVIMIENTO = ods_afect,
COD_TIPO_MOVIMIENTO  = ods_trn,
COD_DIVISA           = 'MXP',
IMP_MOVIMIENTO_MO    = monto,
NUM_RECIBO           = case a.tipo_tran when 'DES' then 0 else dividendo end
from #transacciones a, #tipos_trn b
where  a.tipo_tran   = b.tipo_tran
and    a.reverso     = b.reverso
and    a.estado      = b.estado
and    a.categoria_r = b.categoria_r
and    a.categoria_a = b.categoria_a

--select * from cob_conta_super..sb_ods_bdi

----------------------------------------
--Generar Archivo Plano
----------------------------------------
select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_batch

select 
@w_destino  = @w_path + 'BMXP_MOVIMIENTOS_COB_D' + replace(convert(varchar, @w_fecha_hasta, 12), '.', '') ,
@w_errores  = @w_path + 'BMXP_MOVIMIENTOS_COB_D' + replace(convert(varchar, @w_fecha_hasta, 12), '.', '') + '.err'


select @w_comando = @w_s_app + 's_app bcp -auto -login cob_conta_super..sb_ods_bdi out '
    
select  
@w_destino_lineas   = @w_path + 'BMXP_MOVIMIENTOS_COB_lineas'    +  replace(convert(varchar, @w_fecha_hasta, 12), '.', '') ,
@w_destino_cabecera = @w_path + 'BMXP_MOVIMIENTOS_COB_cabecera'  + replace(convert(varchar,  @w_fecha_hasta, 12), '.', '') ,
@w_destino          = @w_path + 'BMXP_MOVIMIENTOS_COB_D'          +  replace(convert(varchar, @w_fecha_hasta, 102), '.', '') ,  -- caso#146729
@w_errores          = @w_path + 'BMXP_MOVIMIENTOS_COB_D'          +  replace(convert(varchar, @w_fecha_hasta, 102), '.', '')  + '.err'  -- caso#146729
    
select @w_comando =@w_comando + @w_destino_lineas+ ' -b5000 -c -T -e ' + @w_errores + + ' -t"|" ' + '-config ' + @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando
    
if @w_error <> 0 begin
   select
   @w_error = 724676,
   @w_mensaje = 'Error generando Reporte ODS BDI'
   goto ERROR
end
    



    
----------------------------------------
--Generar Archivo de Cabeceras
----------------------------------------
select 
@w_col_id   = 0,
@w_columna  = '',
@w_cabecera = ''
           
while 1 = 1 begin

   set rowcount 1
   
   select 
   @w_columna = c.name,
   @w_col_id  = c.colid
   from cob_conta_super..sysobjects o, cob_conta_super..syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_ods_bdi'
   and   c.colid > @w_col_id
   order by c.colid
        
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
      
   select @w_cabecera = @w_cabecera + @w_columna + '^|'
end

select @w_cabecera = substring(@w_cabecera,0,len(@w_cabecera)-1)
--Escribir Cabecera
select @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_destino_cabecera
    
exec @w_error = xp_cmdshell @w_comando
    
if @w_error <> 0 begin
   select
   @w_error = 724677,
   @w_mensaje = 'Error generando Archivo de Cabeceras Reporte ODS BDI'
   goto ERROR
end
    
select @w_comando = 'copy /B ' + @w_destino_cabecera + ' + ' + @w_destino_lineas + ' ' + @w_destino -- Agregado(/B )-Req.195961
PRINT '@w_comando3>> '+ convert(VARCHAR(300),@w_comando)
    
exec @w_error = xp_cmdshell @w_comando
    
if @w_error <> 0 begin
   select
   @w_error = 724678,
   @w_mensaje = 'Error generando Archivo Completo Reporte ODS BDI'
   goto ERROR
end

select @w_comando = 'del ' + @w_destino_cabecera+' '+@w_destino_lineas

exec @w_error =xp_cmdshell @w_comando

if @w_error <> 0 begin
   select
   @w_error = 724678,
   @w_mensaje = 'Error borrando archivos temporales Reporte ODS BDI'
   goto ERROR
end

/*******************************************/

select @w_comando = @w_path_obj + 'reg_archivos.bat ' + @w_destino + ' ' + @w_path_obj

/* EJECUTAR CON CMDSHELL */
delete from @resultadobcp
insert into @resultadobcp
exec xp_cmdshell @w_comando

select * from @resultadobcp


drop table #tipos_trn
drop table #transacciones

return 0


ERROR:

exec cobis..sp_errorlog 
@i_fecha        = @w_fecha,
@i_error        = @w_error,
@i_usuario      = 'usrbatch',
@i_tran         = null,
@i_descripcion  = @w_mensaje,
@i_tran_name    =null,
@i_rollback     ='S'

return @w_error
go
