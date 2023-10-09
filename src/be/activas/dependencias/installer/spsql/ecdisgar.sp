/*ecdisgar.sp************************************************************/
/*   Archivo:             ecdisgar.sp                                   */
/*   Stored procedure:    sp_distrib_garantias                          */
/*   Base de datos:       cob_conta_super                               */
/*   Producto:            Regulatorios                                  */
/*   Disenado por:                                                      */
/*   Fecha de escritura:  Diciembre 2016                                */
/************************************************************************/
/*            IMPORTANTE                                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*            PROPOSITO                                                 */
/*   Procedimiento que realiza la distribucion de garantias en el       */
/*   consolidador para credito.                                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  12/02/2016  JORGE SALAZAR            MIGRACION COBIS CLOUD          */
/************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_distrib_garantias')
   drop proc sp_distrib_garantias
go

create proc sp_distrib_garantias
(
   @i_param1   varchar(255),
   @i_param2   varchar(64)   = null,  -- forzar una garantía
   @i_param3   varchar(64)   = null   -- forzar un préstamo
)

as 

declare
@w_sp_name            descripcion,
@w_aplicativo         int,
@w_mensaje            varchar(250),
@w_error              int,
@w_usuario            login,
@i_fecha              datetime,
@w_cob_cap            money,
@w_cob_int            money,
@w_dc_garantia        varchar(64),
@w_dg_garantia        varchar(64),
@w_dg_banco           varchar(24),
@w_dc_tipo_gar        varchar(14),
@w_dc_val_cobertura   money,
@w_do_cap_des         money,
@w_do_int_des         money,
@w_est_vencido        tinyint,
@w_est_vigente        tinyint

select 
@w_error         = 21001,
@w_usuario       = 'crebatch',
@w_sp_name       = 'sp_distrib_garantias',
@w_aplicativo    = 19,
@i_fecha         = convert(datetime, @i_param1)

--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error       = cob_externos..sp_estados
     @i_producto    = 7,
     @o_est_vencido = @w_est_vencido out,
     @o_est_vigente = @w_est_vigente out

if @w_error > 0 or @w_est_vencido is null or @w_est_vigente is null begin
   select @w_mensaje = 'No Encontro Estado Vencido/Vigente para Cartera '
   goto ERRORFIN
end

/* UNIVERSO DE PRESTAMOS A PROCESAR */
truncate table sb_distgar_op_tmp

insert into sb_distgar_op_tmp(
do_banco,         do_saldo_cap,   do_saldo_int,
do_dias_mora,     do_cap_liq,     do_cap_hip,
do_cap_des,       do_int_liq,     do_int_hip,
do_int_des)
select
do_banco,         do_saldo_cap,   do_saldo_int,   
do_dias_mora_365, 0,              0,
do_saldo_cap,     0,              0,
do_saldo_int
from  sb_dato_operacion
where do_aplicativo  = 7
and   do_fecha = @i_fecha
and   do_estado_cartera in (@w_est_vencido, @w_est_vigente) -- VIGENTES Y VENCIDOS
and   do_banco = isnull(@i_param3, do_banco)


if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando en sb_distgar_op_tmp '
   goto ERRORFIN
end


/* UNIVERSO DE BIENES EN CUSTODIA A PROCESAR */
truncate table sb_distgar_cu_tmp

insert into sb_distgar_cu_tmp(
dc_garantia,      dc_tipo_gar,       dc_val_cobertura, 
dc_val_utilizado, dc_val_disponible, dc_orden)
select
dc_garantia,      dc_categoria,      dc_valor_actual, 
0,                dc_valor_actual,   case dc_categoria when 'L' then 1 else 2 end
from  cob_conta_super..sb_dato_custodia
where dc_fecha   = @i_fecha
and   dc_estado  = 'V'
and   dc_categoria in ('L','H') --Liquidas e Hipotecarias
and   dc_aplicativo = 19
and   dc_garantia = isnull(@i_param2, dc_garantia)

if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando en sb_distgar_ga_tmp '
   goto ERRORFIN
end

/* UNIVERSO DE GARANTIAS A PROCESAR */
truncate table sb_distgar_ga_tmp

insert into sb_distgar_ga_tmp(
dg_garantia,      dg_banco,    dg_cobertura_cap, 
dg_cobertura_int, dg_dias_vcto)
select
dg_garantia,      dg_banco,    0,
0,                0
from  cob_conta_super..sb_dato_garantia
where dg_fecha  = @i_fecha
and   dg_garantia = isnull(@i_param2, dg_garantia)

if @@error <> 0 begin
   select @w_mensaje = 'Error Insertando en sb_distgar_ga_tmp '
   goto ERRORFIN
end

--Actualizar dias vencimiento
update sb_distgar_ga_tmp
set dg_dias_vcto = do_dias_mora
from sb_distgar_op_tmp
where do_banco = dg_banco

if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en sb_distgar_ga_tmp '
   goto ERRORFIN
end

--Cursor Garantias
declare garantias_cursor cursor for
select dc_garantia, dc_val_cobertura, dc_tipo_gar
from sb_distgar_cu_tmp
order by dc_orden

open garantias_cursor

fetch garantias_cursor into @w_dc_garantia, @w_dc_val_cobertura, @w_dc_tipo_gar

if @@fetch_status = -2 begin
     close garantias_cursor
     deallocate garantias_cursor
     select @w_mensaje = 'Error en cursor garantias_cursor '
     goto ERRORFIN
end else begin
   if @@fetch_status = -1 begin
        close garantias_cursor 
        deallocate garantias_cursor
        return 0
   end
end

while @@fetch_status = 0 begin

    --Cursor Relacion Prestamos - Garantias
    declare relacion_cursor cursor for
    select dg_banco
    from  sb_distgar_ga_tmp
	where dg_garantia = @w_dc_garantia
    order by dg_dias_vcto asc
	for update
    
    open relacion_cursor
    
    fetch relacion_cursor into @w_dg_banco
    
    if @@fetch_status = -2 begin
         close relacion_cursor
         deallocate relacion_cursor
         select @w_mensaje = 'Error en cursor relacion_cursor '
         goto ERRORFIN
    end else begin
       if @@fetch_status = -1 begin
            close relacion_cursor 
            deallocate relacion_cursor
            return 0
       end
    end
    
    while @@fetch_status = 0 begin
    
        --Obtener valor de saldo capital y saldo interes
		select
		@w_do_cap_des = isnull(do_cap_des,0),
		@w_do_int_des = isnull(do_int_des,0)
		from sb_distgar_op_tmp
		where do_banco = @w_dg_banco
		
		if @@rowcount = 0 begin 
		   select
		   @w_do_cap_des = 0,
		   @w_do_int_des = 0
		end
		
		if @w_dc_val_cobertura >= @w_do_cap_des begin
		   select @w_cob_cap = @w_do_cap_des
		end else begin
		   select @w_cob_cap = @w_dc_val_cobertura
        end
		
		select @w_dc_val_cobertura = @w_dc_val_cobertura - @w_cob_cap
		
		if @w_dc_val_cobertura >= @w_do_int_des begin
		   select @w_cob_int = @w_do_int_des
		end else begin
		   select @w_cob_int = @w_dc_val_cobertura
        end
		
		select @w_dc_val_cobertura = @w_dc_val_cobertura - @w_cob_int
		
		update sb_distgar_ga_tmp set
 		dg_cobertura_int = dg_cobertura_int + @w_cob_int,
		dg_cobertura_cap = dg_cobertura_cap + @w_cob_cap
 		where dg_banco = @w_dg_banco
 		and   dg_garantia = @w_dc_garantia
 		
 		if @@error <> 0 begin
           select @w_mensaje = 'Error Actualizando en sb_distgar_ga_tmp '
           goto ERRORFIN
        end
		
		update sb_distgar_op_tmp set 
		do_cap_liq = do_cap_liq + case @w_dc_tipo_gar when 'L' then @w_cob_cap else 0 end,
		do_int_liq = do_int_liq + case @w_dc_tipo_gar when 'L' then @w_cob_int else 0 end,
		do_cap_hip = do_cap_hip + case @w_dc_tipo_gar when 'H' then @w_cob_cap else 0 end,
		do_int_hip = do_int_hip + case @w_dc_tipo_gar when 'H' then @w_cob_int else 0 end,
		do_cap_des = do_cap_des - @w_cob_cap,
		do_int_des = do_int_des - @w_cob_int
 		where do_banco = @w_dg_banco
 		
        if @@error <> 0 begin
           select @w_mensaje = 'Error Actualizando en sb_distgar_ga_tmp '
           goto ERRORFIN
        end

		fetch relacion_cursor into @w_dg_banco
    
        if @@fetch_status = -2 begin
    	   close relacion_cursor
           deallocate relacion_cursor
           select @w_mensaje = 'Error en cursor relacion_cursor '
           goto ERRORFIN
        end
    end
    -- Cerrar y liberar el cursor
    close relacion_cursor
    deallocate relacion_cursor

    fetch garantias_cursor into @w_dc_garantia, @w_dc_val_cobertura, @w_dc_tipo_gar

    if @@fetch_status = -2 begin
	   close garantias_cursor
       deallocate garantias_cursor
       select @w_mensaje = 'Error en cursor garantias_cursor '
       goto ERRORFIN
    end
end
-- Cerrar y liberar el cursor liquidas_cursor
close garantias_cursor
deallocate garantias_cursor

--Actualizar sb_dato_operacion
update sb_dato_operacion set 
do_cap_liq = d.do_cap_liq,
do_int_liq = d.do_int_liq,
do_cap_hip = d.do_cap_hip,
do_int_hip = d.do_int_hip,
do_cap_des = d.do_cap_des,
do_int_des = d.do_int_des
from sb_distgar_op_tmp d, sb_dato_operacion c
where c.do_banco = d.do_banco
and   c.do_fecha = @i_fecha
and   c.do_aplicativo = 7
and   c.do_estado_cartera in (@w_est_vencido, @w_est_vigente) -- VIGENTES Y VENCIDOS
 
if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en sb_dato_operacion '
   goto ERRORFIN
end

--Actualizar sb_dato_custodia
update sb_dato_custodia set
dc_valor_uti_opera = dg_cobertura_int + dg_cobertura_cap
from sb_distgar_ga_tmp
where dc_garantia = dg_garantia
and   dc_fecha = @i_fecha
and   dc_aplicativo = 19
	
if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en sb_dato_custodia '
   goto ERRORFIN
end

--Actualizar sb_dato_garantia
update sb_dato_garantia set 
dg_cobertura_cap = d.dg_cobertura_cap,
dg_cobertura_int = d.dg_cobertura_int
from sb_distgar_ga_tmp d, sb_dato_garantia c
where c.dg_garantia = d.dg_garantia
and   c.dg_fecha    = @i_fecha
 
if @@error <> 0 begin
   select @w_mensaje = 'Error Actualizando en sb_dato_garantia '
   goto ERRORFIN
end

return 0

ERRORFIN:

exec cob_conta_super..sp_errorlog
     @i_operacion     = 'I',
     @i_fecha_fin     = @i_fecha,
     @i_fuente        = @w_sp_name,
     @i_origen_error  = '28040',
     @i_descrp_error  = @w_mensaje           

return 1
go

