/*****************************************************************************/
/*  ARCHIVO:         sp_mensual_monetarias                                   */
/*  NOMBRE LOGICO:   sp_consolidador                                         */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Ingresar informacion a las tablas de REC.                                 */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_mensual_monetarias')
   drop proc sp_mensual_monetarias
go

create proc sp_mensual_monetarias(
@i_param2          datetime,
@i_param1          datetime)
with encryption
as
declare
  @i_fecha_ini         datetime,
  @i_fecha_fin         datetime,

  @w_error               int,
  @w_msg                 descripcion,
  @w_fecha_proc          datetime,
  @w_fecha_ini           datetime,
  @w_ciudad              int,
  @w_sig_habil           datetime,
  @w_fin_mes             char(1),
  @w_sp_name             varchar(155),
  @w_proceso             int,
  @w_fecha_fin           varchar(10),
 
--variables para bcp   
  @w_path_destino        Varchar(100),
  @w_s_app               Varchar(50),
  @w_cmd                 Varchar(255),   
  @w_comando             Varchar(255),
  @w_nombre_archivo      Varchar(255),  
  @w_anio                varchar(4),
  @w_mes                 varchar(2),
  @w_dia                 varchar(2)

select @w_sp_name      = 'sp_mensual_monetarias',
       @w_proceso      = 14011,       
       @i_fecha_ini    = @i_param1,
       @i_fecha_fin    = @i_param2

if exists(select 1 from sysobjects where name = 'tmp_transacciones')
   drop table tmp_transacciones

if exists(select 1 from sysobjects where name = 'tmp_plano')
   drop table tmp_plano

create table tmp_plano (orden int not null, cadena varchar(2000) not null)

select @w_anio = convert(varchar(4),datepart(yyyy,@i_fecha_fin)),
       @w_mes = convert(varchar(2),datepart(mm,@i_fecha_fin)), 
       @w_dia = convert(varchar(2),datepart(dd,@i_fecha_fin))  

select @w_fecha_fin  = (@w_anio + right('00' + @w_mes,2) + right('00'+ @w_dia,2))

select
'Mes'              = DATENAME (month, @i_fecha_fin),
'Producto'         = '14',
'Tipo_Tran'        = tn_descripcion,
'Concepto'         = eq_val_interfaz,
'Descrip_concepto' = eq_descripcion,
'Num_registros'    = count(1),
'valor'            = sum(case when  tp_tran = '14919' then (td_monto* (-1)) else td_monto end),
'Estado'           = case when tr_estado = 'RV' then 'R' else 'A' end
into  tmp_transacciones
from  pf_transaccion,
      pf_operacion,
      pf_tranperfil,
      cobis..cl_ttransaccion,
      pf_transaccion_det,
      pf_equivalencias
where tr_fecha_mov    >= @i_fecha_ini
and   tr_fecha_mov    <= @i_fecha_fin
--and   tr_estado       <> 'RV'
and   tp_trn_rec      is not null
and   tr_operacion    = op_operacion
and   tr_tran         = tp_tran
and   tp_estado       = 'N'
and   tr_tran         = tn_trn_code
and   tr_operacion    = td_operacion
and   tr_secuencial   = td_secuencial
and   eq_tabla        = 'TIPCONCEPT'
and   eq_val_pfijo    = td_concepto
group by tn_descripcion,eq_val_interfaz,tr_estado,eq_descripcion

if @@error <> 0 begin
   select
   @w_error = 147000,
   @w_msg = 'Error al eliminar registros en #transacciones'
   return 0
end

/* GENERACION ARCHIVO PLANO */
Print '--> Path Archivo Resultante'

Select @w_path_destino = ba_path_destino
from cobis..ba_batch
where ba_batch = @w_proceso
if @@rowcount = 0 Begin
   select
   @w_error = 147000,
   @w_msg = 'No Existe path_destino para el proceso : ' +  cast(@w_proceso as varchar)
   GOTO ERROR
End 

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'
if @@rowcount = 0 Begin
      select
   @w_error = 147000,
   @w_msg = 'NO EXISTE RUTA DEL S_APP'
   GOTO ERROR   
End 

-- Arma Nombre del Archivo
print 'Generar el archivo plano TRANS_PFIJO_AAAAMMDD.txt !!!!! ' 
insert into tmp_plano (orden, cadena) values (0,'Mes | Producto | Tipo_Tran | Codigo_Tran | Descrip_Tran | Num_registros | Valor |Estado')


insert into tmp_plano (orden, cadena)
select 
row_number() over (order by Tipo_Tran),
Mes + 
'|' + Producto+
'|' + Tipo_Tran +
'|' + Concepto +
'|' + Descrip_concepto + 
'|' + convert(varchar,Num_registros) +
'|' + convert(varchar,valor) +
'|' + Estado
from tmp_transacciones
order by Tipo_Tran

select @w_nombre_archivo = @w_path_destino + 'TRANS_PFIJO_' + @w_fecha_fin + '.txt' 
Print @w_nombre_archivo

select @w_cmd       =  'bcp ''select cadena from cob_pfijo..tmp_plano order by orden '' queryout ' 
select @w_comando   = @w_cmd + @w_nombre_archivo + ' -b5000 -c -t"|" -T -S'+ @@servername + ' -eFNG.err' 
PRINT @w_comando
exec @w_error = xp_cmdshell @w_comando

If @w_error <> 0 Begin
   select @w_msg = 'Error Generando BCP' + @w_comando
   Goto ERROR 
End   

ERROR:
exec cob_conta_super..sp_errorlog
     @i_fuente = @w_sp_name
    

Return 0
go
