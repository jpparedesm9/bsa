/************************************************************************/
/* Archivo:                cambio_fecha_pro.sp                          */
/* Stored procedure:       sp_cambio_fecha_pro                          */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:           Edison Eduardo Cazco                         */
/* Fecha de escritura:     24-Enero-2005                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA', representantes exclusivos para el Ecuador de la         */
/*    'NCR CORPORATION'.                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento al catalogo de Cuentas de un tipo de plan           */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    24-Ene-2005    E. Cazco        Emision Inicial                    */
/*    14-Sep-2017    J. Salazar      CGS-S132171                        */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_cambio_fecha_pro')
   drop proc sp_cambio_fecha_pro
go

create proc sp_cambio_fecha_pro
   @t_debug         char(1)     = 'N',
   @t_file          varchar(14) = null,
   @i_fecha         datetime,
   @i_formato_fecha int         = 103,
   @o_terror        int out
as
declare 
@w_date          datetime,
@w_fecha_actual  datetime,
@w_new_date      datetime,
@w_newdate       varchar(10),
@w_ciudad        int,
@w_control       smallint,
@w_prueba        smallint,
@w_sp_name       varchar(30),
@w_nueva_fecha   datetime,
@w_msg           varchar(255),
@w_error         int

select 
@w_sp_name = 'sp_cambio_fecha_pro',
@o_terror  = 0,
@i_fecha   = convert(varchar(10),@i_fecha,101),
@w_control = 0,
@w_msg     = '',
@i_formato_fecha = isnull(@i_formato_fecha,103)

select @w_ciudad = pa_smallint 
from cl_parametro
where pa_nemonico = 'CFN'

if @@rowcount = 0 begin
   select 
   @w_error  = 609318,
   @w_msg    = 'ERROR: NO EXISTE PARAMETRO CFN',
   @o_terror = 1
   goto ERROR
end

/* DETERMINAR LA FECHA DE PROCESO ACTUAL */
select @w_fecha_actual = fp_fecha
from cobis..ba_fecha_proceso


/* LA NUEVA FECHA NO PUEDE SER MENOR A LA FECHA ACTUAL */
if @i_fecha <= @w_fecha_actual begin
   select 
   @w_error  = 808066,
   @w_msg    = 'LA NUEVA FECHA NO PUEDE SER MENOR O IGUAL A LA FECHA ACTUAL DEL SISTEMA',
   @o_terror = 1
   goto ERROR
end


/* LA NUEVA FECHA NO PUEDE SER UN FERIADO EXCEPTO CUANDO ES INICIO DE MES */
if datepart(dd, @i_fecha) <> 1
and exists (select 1 from cobis..cl_dias_feriados
            where df_ciudad = @w_ciudad
            and df_fecha    = @i_fecha)
begin
   select 
   @w_error  = 808069,
   @w_msg    = 'LA NUEVA FECHA NO PUEDE SER UN FERIADO',
   @o_terror = 1
   goto ERROR
end 

/* DETERMINAR CUAL DEBERIA SER LA NUEVA FECHA DE PROCESO */
select @w_nueva_fecha = dateadd(dd, 1, @w_fecha_actual)     
while exists (select 1 from cobis..cl_dias_feriados where df_fecha = @w_nueva_fecha  and df_ciudad = @w_ciudad)
and   datepart(dd,@w_nueva_fecha) <> 1
begin
   select @w_nueva_fecha = dateadd(dd, 1, @w_nueva_fecha)
end

if @w_nueva_fecha <> @i_fecha begin
   select 
   @w_error  = 808068,
   @w_msg    = 'LA NUEVA FECHA DE PROCESO DEBERIA SER: ' + convert(varchar(10), @w_nueva_fecha, @i_formato_fecha),
   @o_terror = 1
   goto ERROR
end


return 0

ERROR:

exec cobis..sp_cerror
@t_debug  = @t_debug,
@t_file   = @t_file,
@t_from   = @w_sp_name,
@i_num    = @w_error,
@i_msg    = @w_msg

go

