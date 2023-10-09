/************************************************************************/
/*   Archivo:             cb_ult_fecha_habil.sp                         */
/*   Stored procedure:    sp_calcula_ultima_fecha_habil                 */
/*   Base de datos:       cob_conta		                                */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Pedro Montenegro                              */
/*   Fecha de escritura:  Septiembre.2017.                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Calcula la ultima fecha habil antes de la fecha de fin de mes		*/
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_calcula_ultima_fecha_habil')
   drop proc sp_calcula_ultima_fecha_habil
go

create proc sp_calcula_ultima_fecha_habil
(
	@t_debug			   char(1)		= 'N',
	@t_file				varchar(14) = null,
	@i_reporte			varchar(6),
   @i_fecha 			datetime    = null,
	@o_existe_solicitud char (1) = 'N'  out,
	@o_ini_mes			datetime = null out,
	@o_fin_mes			datetime = null out,
	@o_fin_mes_hab		datetime = null out,
	@o_fin_mes_ant		datetime = null out,
	@o_fin_mes_ant_hab	datetime = null out
)
as 
declare	
		@w_error			   int,
		@w_mensaje        varchar(150),
		@w_sp_name			varchar(30),
		@w_msg				varchar(255),
		@w_feriado        char(1),
		@w_fecha_proc     datetime,
		@w_fecha_aux      datetime,
		@w_ini_mes			datetime,
		@w_fin_mes			datetime,
		@w_fin_mes_hab		datetime,
		@w_fin_mes_ant		datetime,
		@w_fin_mes_ant_hab	datetime,
		@w_ciudad         smallint

select @w_sp_name = 'sp_calcula_ultima_fecha_habil'

select @w_fecha_proc = fp_fecha from cobis..ba_fecha_proceso

if @@error != 0 or @@ROWCOUNT != 1
begin
	select @w_error = 609321
	goto ERROR_PROCESO
end

--obtiene parametro DISTRITO FERIADO NACIONAL
select @w_ciudad = pa_smallint 
	from cobis..cl_parametro 
	where pa_nemonico = 'CFN' 
	AND pa_producto = 'ADM'

if @@error != 0 or @@ROWCOUNT != 1
begin
	select @w_error = 609318
	goto ERROR_PROCESO
end

select @o_existe_solicitud = 'N'

if (@i_reporte = 'NINGUN' and @i_fecha is not null)
begin
   select @w_fecha_aux = @i_fecha, @o_existe_solicitud = 'S'
end
else
begin
   if (datepart(dd, @w_fecha_proc) = 1)
   begin
      select @w_fecha_aux = DATEADD(MM, -1, @w_fecha_proc)
      
      select @o_existe_solicitud = 'S'
   end
   else
   begin
       if exists(select 1 from cob_conta..cb_solicitud_reportes_reg
                where sr_reporte = @i_reporte and sr_status  = 'I')
       begin	   
         select @o_existe_solicitud = 'S'
         
         select @w_fecha_aux = convert(datetime, (convert(varchar, sr_anio) + '/' + convert(varchar, sr_mes) + '/01'))
         from  cob_conta..cb_solicitud_reportes_reg
         where sr_reporte = @i_reporte
         and   sr_status  = 'I'

         if @@error != 0 or @@ROWCOUNT != 1
         begin
           select @w_error = 609319 
            goto ERROR_PROCESO      
         end
      end
   end
end

if @o_existe_solicitud = 'N' goto SALIDA_PROCESO

select @w_ini_mes = @w_fecha_aux

--FECHA FIN DE MES (ACTUAL)
select @w_fin_mes = DATEADD(dd, -1, DATEADD(MM, 1, @w_fecha_aux))

if @@error != 0
begin
	select @w_error = 609319
	goto ERROR_PROCESO
end

--Calcular el ultimo dia habil del mes (ACTUAL)
select @w_fecha_aux = @w_fin_mes,
       @w_feriado   = 'S'

while @w_feriado = 'S'
begin
    if exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_aux and df_ciudad = @w_ciudad)
        select @w_fecha_aux = dateadd(dd,-1, @w_fecha_aux)
    else
        select @w_feriado = 'N'
			
	if @@error != 0
	begin
		select @w_error = 609322
		goto ERROR_PROCESO
	end
end

select @w_fin_mes_hab = @w_fecha_aux

--Calcular el ultimo dia habil del mes (ANTERIOR)
select @w_fecha_aux = DATEADD(dd, -1, @w_ini_mes),
       @w_feriado   = 'S'

select @w_fin_mes_ant = @w_fecha_aux

while @w_feriado = 'S'
begin
    if exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_fecha_aux and df_ciudad = @w_ciudad)
        select @w_fecha_aux = dateadd(dd,-1, @w_fecha_aux)
    else
        select @w_feriado = 'N'
			
	if @@error != 0
	begin
		select @w_error = 609322
		goto ERROR_PROCESO
	end
end

select @w_fin_mes_ant_hab = @w_fecha_aux

select	@o_ini_mes			= @w_ini_mes,
		@o_fin_mes			= @w_fin_mes,
		@o_fin_mes_hab		= @w_fin_mes_hab,
		@o_fin_mes_ant		= @w_fin_mes_ant,
		@o_fin_mes_ant_hab	= @w_fin_mes_ant_hab


SALIDA_PROCESO:		
    return 0
   
ERROR_PROCESO:
	
    exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = @w_error
				
--select @o_msg = ltrim(rtrim(@w_msg))
    return @w_error

go
