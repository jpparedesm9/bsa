/*cr_provi.sp***********************************************************/
/*   Archivo:                   cr_rep_provi.sp                        */
/*   Stored procedure:          sp_reporte_provision                   */
/*   Base de Datos:             cob_conta_super                        */
/*   Disenado por:              Jorge Baque                            */
/*   Producto:                  CONSOLIDADOR                           */
/*   Fecha de Documentacion:    08/Dic/2016                            */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de     */
/*   "MACOSA".                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como        */
/*   cualquier autorizacion o agregado hecho por alguno de sus         */
/*   usuario sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante                */
/***********************************************************************/
/*                              PROPOSITO                              */
/*  Reporte de provisiones.                                            */
/***********************************************************************/

use cob_conta_super
go

if exists (select * from sysobjects where name = 'sp_reporte_provision' )
   drop proc sp_reporte_provision
go

create proc sp_reporte_provision (
   @i_param1            varchar(255)
)
as
declare
   @i_fecha             datetime,
   @w_periodicidad      varchar(1),     

   @w_return            int,  
   @w_s_app             varchar(50),
   @w_path              varchar(50),
   @w_arch_titulos      varchar(2500),
   @w_arch_detalle      varchar(2500),
   @w_arch_final        varchar(2500),
   @w_error             int,
   @w_errores           varchar(1500),
   @w_comando           varchar(2500),
   
   @w_sp_name           varchar(32),
   @w_usuario           login,
   @w_mensaje           varchar(255),
   
   @w_caracter_orig     char(1),
   @w_caracter_reem     char(1),

   @w_est_vencido       tinyint,
   @w_est_vigente       tinyint
   
select 
@i_fecha          = convert(datetime, @i_param1),
@w_sp_name        = 'sp_reporte_provision',
@w_usuario        = 'crebatch',
@w_error          = 2100001,
@w_caracter_orig  = char(47), --/
@w_caracter_reem  = char(92)  --\

if (OBJECT_ID('tempdb..##reporte_titulo')) IS NOT NULL
   drop table tempdb..##reporte_titulo

if (OBJECT_ID('tempdb..##reporte_operacion')) IS NOT NULL
   drop table tempdb..##reporte_operacion
   
create table ##reporte_titulo
(
	titulo1		char(30),
	titulo2		char(30),
	titulo3		char(30),
	titulo4		char(30),
	titulo5		char(30),
	titulo6		char(30),
	titulo7		char(30),
	titulo8		char(30),
	titulo9		char(30)
)

if not exists(select 1 from cob_conta_super..sb_dato_provision)
begin
   select   @w_mensaje  = 'TABLA cob_conta_super..sb_dato_provision VACIA',
            @w_error    = 1
   goto ERRORFIN
end

select @w_s_app = pa_char
   from cobis..cl_parametro with (nolock)
   where pa_producto = 'ADM'
   and pa_nemonico = 'S_APP'

if @@error > 0 or @@rowcount <> 1
begin
   select   @w_mensaje  = 'NO EXISTE PARAMETRO S_APP',
            @w_error    = 1
   goto ERRORFIN
end

select @w_path = ba_path_destino
   from cobis..ba_batch
   where ba_batch = 21060

if @@error > 0 or @@rowcount <> 1
begin
   select   @w_mensaje = 'NO EXISTE RUTA PATH DESTINO',
            @w_error    = 1
   goto ERRORFIN
end

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error = cob_externos..sp_estados
   @i_producto    = 7,
   @o_est_vencido = @w_est_vencido out,
   @o_est_vigente = @w_est_vigente out
   
--GENERA INFORMACION DEL REPORTE
SELECT   'CLASE'						= cast(dp_clase_cartera as char(30)), 
         'TIPO'							= cast(dp_tipo_cartera as char(30)), 
         'SUBTIPO'						= cast(dp_subtipo_cartera as char(30)),  
         'ESTADO'						= cast(dp_estado_cartera as char(30)), 
         'SALDO GARANTIAS LIQUIDAS'		= cast(convert(money, sum (dp_saldo_cap_liq + dp_saldo_int_liq)) as char (30)), 
         'SALDO GARANTIAS HIPOTECARIAS' = cast(convert(money, sum (dp_saldo_cap_hip + dp_saldo_int_hip)) as char (30)),
         'SALDO DESCUBIERTO'			= cast(convert(money, sum(dp_saldo_cap_des + dp_saldo_int_des)) as char (30)),
         'PROVISION'					= cast(convert(money, sum(dp_provision_cap + case when dp_estado_cartera = @w_est_vigente then dp_provision_int else 0 end)) as char (30)),
         'PROVISION ADIC (INT/MORA)'	= cast(convert(money, sum(case when dp_estado_cartera = @w_est_vencido then dp_provision_int else 0 end)) as char (30))
into ##reporte_operacion
FROM cob_conta_super..sb_dato_provision
group by dp_clase_cartera, dp_tipo_cartera, dp_subtipo_cartera, dp_estado_cartera 

--GENERA TITULOS DEL REPORTE
insert into ##reporte_titulo
SELECT   'CLASE', 
         'TIPO', 
         'SUBTIPO', 
         'ESTADO',
         'SALDO GARANTIAS LIQUIDAS', 
         'SALDO GARANTIAS HIPOTECARIAS',
         'SALDO DESCUBIERTO',
         'PROVISION',
         'PROVISION ADIC (INT/MORA)'

--Ejecucion para Generar archivo de cabecera
select @w_comando = @w_s_app + 's_app bcp -auto -login tempdb..##reporte_titulo out '

select   @w_arch_titulos= @w_path + 'cabecera_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.txt',
         @w_errores     = @w_path + 'cabecera_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.err'

select @w_comando = @w_comando + @w_arch_titulos + ' -b5000 -c -e -T -C' + @w_errores + ' -t"\t" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

print @w_comando
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select   @w_mensaje  = 'ERROR EN EJECUCION ' + @w_comando,
            @w_error    = 1
   goto ERRORFIN
end

select @w_comando = ''

--Ejecucion para Generar archivo de detalle
select @w_comando = @w_s_app + 's_app bcp -auto -login tempdb..##reporte_operacion out '

select @w_arch_detalle  = @w_path + 'detalle' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.txt',
       @w_errores       = @w_path + 'detalle' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.err'

select @w_comando = @w_comando + @w_arch_detalle + ' -b5000 -c -e -T -C' + @w_errores + ' -t"\t" ' + '-config '+ @w_s_app + 's_app.ini'

exec @w_error = xp_cmdshell @w_comando

print @w_comando
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select   @w_mensaje  = 'ERROR EN EJECUCION ' + @w_comando,
            @w_error    = 1
   goto ERRORFIN
end

--Ejecucion para Generar archivo final
select @w_comando = ''

select @w_arch_final  = @w_path + 'Estimaciones_' + convert(varchar, datepart(yy, @i_fecha)) + right('0'+ convert(varchar,datepart(mm,@i_fecha)),2) + '.txt'

--Unificar archivos cabecera y detalle
select	@w_arch_titulos = REPLACE(@w_arch_titulos, @w_caracter_orig, @w_caracter_reem),
         @w_arch_detalle = REPLACE(@w_arch_detalle, @w_caracter_orig, @w_caracter_reem),
         @w_arch_final = REPLACE(@w_arch_final, @w_caracter_orig, @w_caracter_reem)

select @w_comando = 'Copy/b ' + @w_arch_titulos + ' + ' + @w_arch_detalle + ' ' + @w_arch_final

print @w_comando
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select   @w_mensaje  = 'ERROR EN EJECUCION ' + @w_comando,
            @w_error    = 1
   goto ERRORFIN  
end

select @w_comando = 'DEL ' + @w_arch_titulos
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select   @w_mensaje  = 'ERROR EN EJECUCION ' + @w_comando,
            @w_error    = 1
   goto ERRORFIN  
end

select @w_comando = 'DEL ' + @w_arch_detalle
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
   select   @w_mensaje  = 'ERROR EN EJECUCION ' + @w_comando,
            @w_error    = 1
   goto ERRORFIN  
end
return 0

ERRORFIN: 

insert into sb_errorlog (er_fecha, er_fecha_proc, er_fuente, er_origen_error, er_descrp_error) 
                 values (@i_fecha, getdate(), @w_sp_name, convert(varchar, @w_error) + ' - CONSOLIDADOR', @w_mensaje)

return 1

go

