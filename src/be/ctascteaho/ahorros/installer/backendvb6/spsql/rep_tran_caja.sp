/************************************************************************/
/*      Archivo:                rep_tran_caja.sp                        */
/*      Stored procedure:       sp_rep_tran_caja                        */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Reporte Tran Caja                                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_rep_tran_caja')
   drop proc sp_rep_tran_caja
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_rep_tran_caja (
   @t_show_version        bit = 0,
   @i_param1              datetime  = null,
   @i_param2              datetime  = null
)
as

declare
@w_error            int,
@w_msg              varchar(250),
@w_sp_name          varchar(30),
@w_fecha_arch       varchar(10),
@w_comando          varchar(800),
@w_cmd              varchar(800),
@w_s_app            varchar(30),
@w_path             varchar(250),
@w_archivo          varchar(300),
@w_cabecera         varchar(500),
@w_fecha_ini        varchar(10),
@w_fecha_fin        varchar(10),
@w_errores          varchar(250),
@w_destino          varchar(100),
@w_fecha            datetime,
@w_mes              char(2),
@w_anio             char(4),
@w_mes1             char(2)

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_rep_tran_caja'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

SET ANSI_WARNINGS OFF

select @w_fecha_ini  = convert(varchar(10),@i_param1,101),
       @w_fecha_fin  = convert(varchar(10),@i_param2,101)

select @w_mes = datepart(mm,@w_fecha_ini)

select @w_anio = datepart(yy,@w_fecha_ini )

select @w_mes1 = datepart(mm,@w_fecha_fin)

if  @w_mes <> @w_mes1
begin
     select @w_msg = 'LA CONSULTA SE DEBE HACER MES A MES'
     goto ERROR
end

truncate table ah_rep_tran_caja

select @w_fecha = fp_fecha
 from cobis..ba_fecha_proceso


if @@rowcount = 0
begin
     select @w_msg = 'NO SE ENCONTRO FECHA DE PROCESO'
     goto ERROR
end

insert into ah_rep_tran_caja
select
convert(char(2),datepart(mm,ch_fecha )),
convert(char(4),datepart(yy,ch_fecha )),
ch_oficina,
ch_transaccion,
(select tn_descripcion from cobis..cl_ttransaccion where tn_trn_code  = a.ch_transaccion),
count(1),
sum(ch_efectivo) + sum(ch_cheque) +sum(ch_chq_locales) + sum(ch_chq_ot_plaza) + sum(ch_otros)
from cob_remesas..re_caja_his a
where ch_fecha  between  @w_fecha_ini  and @w_fecha_fin
and ch_transaccion <> 15
group by ch_oficina, ch_transaccion, datepart(mm,ch_fecha ),datepart(yy,ch_fecha )


if @@error <> 0
begin
       select @w_msg = 'ERROR EN INSERCION EN TABLA ah_rep_tran_caja '
       goto ERROR
end

if exists(select 1 from sysobjects where name = 'ah_data_temp')
   drop table ah_data_temp

create table ah_data_temp
(
 dt_data varchar(1000)
)

insert into ah_data_temp values('MES|ANIO|OFICINA|TRANSACCION|DESC. TRANSACCION|CANTIDAD|MONTO')

insert into ah_data_temp
select tc_mes  + '|' +  tc_anio   + '|' + convert(varchar(6),tc_oficina)   + '|' +   convert(varchar(8),tc_transaccion )  + '|' +  ts_destran + '|' +  convert(varchar(8),tc_cantidad)   + '|' +   convert(varchar(30),tc_monto)
from  ah_rep_tran_caja
order by tc_oficina

select @w_s_app = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

select @w_path = pp_path_destino
from cobis..ba_path_pro
where pp_producto = 4

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_ahorros..ah_data_temp out '

select
@w_destino  = @w_path + 'TRAN_CAJA_'+ @w_mes  + '_' +  @w_anio + '.txt',
@w_errores  = @w_path + 'TRAN_CAJA_'+ @w_mes  + '_' +  @w_anio + '.err'

select @w_comando = @w_cmd + @w_destino + ' -b5000  -c -e' + @w_errores + ' -t"|" ' + '-config '+ @w_s_app + 's_app.ini'

print @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0
begin
       select @w_msg = 'ERROR EN IGENERACION DE BCP '
       goto ERROR
end

return 0

ERROR:

exec sp_errorlog
@i_fecha   = @w_fecha,
@i_error   = 1,
@i_usuario = 'Operador',
@i_tran    = 0,
@i_cuenta  = '',
@i_descripcion = @w_msg

return 1

go

