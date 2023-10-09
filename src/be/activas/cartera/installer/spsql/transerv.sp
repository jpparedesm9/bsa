/************************************************************************/
/*      Archivo:                transerv.sp                             */
/*      Stored procedure:       sp_tran_servicio                        */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           P. Narvaez                              */
/*      Fecha de escritura:     17/12/1997                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.		                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Insercion de transacciones de servicio para cada tabla          */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_tran_servicio')
	drop proc sp_tran_servicio
go

---Mar-14-2011 Inc-18565  Ver.  partiendo de 1

create proc sp_tran_servicio
   @s_date                 datetime,
   @s_user                 login,
   @s_ofi                  smallint,
   @s_term                 varchar(30),
   @i_tabla                varchar(255),
   @i_clave1               varchar(255),
   @i_clave2               varchar(255) = null,
   @i_clave3               varchar(255) = null,
   @i_clave4               varchar(255) = null,
   @i_clave5               varchar(255) = null,
   @i_clave6               varchar(255) = null,
   @i_clave7               varchar(255) = null,
   @i_clave8               varchar(255) = null,
   @i_clave9               varchar(255) = null,
   @i_clave10              varchar(255) = null
as

declare 
   @w_error             int ,
   @w_operacionca       int ,
   @w_sp_name           descripcion

-- VARIABLES INICIALES
select @w_sp_name = 'sp_tran_servicio'

if @i_tabla = 'matriz_valor'
begin
   insert into ca_matriz_valor_ts
   select @s_user, @s_ofi, @s_term,'U', getdate(),  *
   from   ca_matriz_valor_tmp
   where mvt_matriz    = convert(char(10),@i_clave1)
   and   mvt_fecha_vig = convert(datetime,@i_clave2)
   and   mvt_rango1    = convert(int,@i_clave3) 
   and   mvt_rango2    = convert(int,@i_clave4) 
   and   mvt_rango3    = convert(int,@i_clave5) 
   and   mvt_rango4    = convert(int,@i_clave6) 
   and   mvt_rango5    = convert(int,@i_clave7) 
   and   mvt_rango6    = convert(int,@i_clave8) 
   and   mvt_rango7    = convert(int,@i_clave9) 
   and   mvt_valor     = convert(float,@i_clave10)    

   if @@error <> 0
      return 721902
end      

if @i_tabla = 'eje_rango'
begin
   insert into ca_eje_rango_ts
   select @s_user, @s_ofi, @s_term,@i_clave3, getdate(),  *
   from   ca_eje_rango_tmp
   where ert_matriz    = convert(char(10),@i_clave1)
   and   ert_fecha_vig = convert(datetime,@i_clave2)
   and   ert_eje       = convert(int,@i_clave4)
   and   ert_rango     = convert(int,@i_clave5)
   
   if @@error <> 0
      return 721903
end

if @i_tabla = 'eje'
begin
   insert into ca_eje_ts
   select @s_user, @s_ofi, @s_term,@i_clave3, getdate(),  *
   from   ca_eje_tmp
   where ejt_matriz    = convert(char(10),@i_clave1)
   and   ejt_fecha_vig = convert(datetime,@i_clave2)
   and   ejt_eje       = convert(int,@i_clave4)
   
   if @@error <> 0
      return 721904
end

if @i_tabla = 'ca_operacion'
begin
   insert into ca_operacion_ts
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_operacion
   where  op_operacion = convert(int,@i_clave1) 
   
   if @@error <> 0
      return 710047
end

if @i_tabla = 'ca_reajuste'
begin
   insert into ca_reajuste_ts 
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_reajuste
   where  re_operacion  = convert(int, @i_clave1)
   and    re_secuencial = convert(int, @i_clave2)
   
   if @@error <> 0
      return 710048
end

if @i_tabla = 'ca_reajuste_det'
begin
   insert into ca_reajuste_det_ts 
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_reajuste_det
   where  red_operacion  = convert(int,@i_clave1)
   and    red_secuencial = convert(int,@i_clave2)
   and    red_concepto   = convert(char(10), @i_clave3)
   
   if @@error <> 0
      return 710049
end

if @i_tabla = 'ca_default_toperacion'
begin
   insert into ca_default_toperacion_ts 
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_default_toperacion
   where  dt_toperacion   = @i_clave1
   and    dt_moneda       = convert(int,@i_clave2)
   
   if @@error <> 0
      return 710050
end

if @i_tabla = 'ca_rubro'
begin
   insert into ca_rubro_ts 
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_rubro
   where  ru_toperacion   = @i_clave1
   and    ru_moneda       = convert(tinyint,@i_clave2)
   and    ru_concepto     = @i_clave3
   
   if @@error <> 0
      return 710051
end

if @i_tabla = 'ca_rubro_op'
begin
   insert into ca_rubro_op_ts 
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_rubro_op
   where  ro_operacion   = convert(int,@i_clave1)
   and    ro_concepto    = @i_clave2
   
   if @@error <> 0
      return 710052
end

if @i_tabla = 'ca_valor_referencial'
begin
   insert into ca_valor_referencial_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, vr_tipo, vr_valor, vr_fecha_vig, vr_secuencial
   from   ca_valor_referencial
   where  vr_tipo      = @i_clave1
   and    vr_fecha_vig = @i_clave2
   and    vr_secuencial = convert(int,@i_clave3)
   
   if @@error <> 0
      return 710053
end

if @i_tabla = 'ca_valor'
begin
   insert into ca_valor_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_valor
   where  va_tipo      = @i_clave1
   
	if @@error <> 0
	   return 710054
end


if @i_tabla = 'ca_valor_det'
begin
   insert into ca_valor_det_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_valor_det
   where  vd_tipo   = @i_clave1
   and    vd_sector = @i_clave2
   
   if @@error <> 0
      return 710055
end

if @i_tabla = 'ca_estados_man'
begin
   insert into ca_estados_man_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_estados_man
   where  em_toperacion  = @i_clave1
   and    em_tipo_cambio = @i_clave2
   and    em_estado_ini  = convert(tinyint,@i_clave3)
   and    em_estado_fin  = convert(tinyint,@i_clave4)
   
   if @@error <> 0
      return 710056
end

if @i_tabla = 'ca_estados_rubro'
begin
   insert into ca_estados_rubro_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_estados_rubro
   where  er_toperacion  = @i_clave1 
   and    er_concepto    = @i_clave2
   and    er_estado      = convert(tinyint,@i_clave3)
   
   if @@error <> 0
      return 710057
end

if @i_tabla = 'ca_dividendo'
begin
   insert into ca_dividendo_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_dividendo
   where  di_operacion   = convert(int,@i_clave1)
   and    di_dividendo   = convert(int,@i_clave2)
   
   if @@error <> 0
      return 721600
end

-- CEH REQ 264 DESEMBOLSOS GMF
if @i_tabla = 'ca_desembolso'
begin
   insert into ca_desembolso_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, *
   from   ca_desembolso
   where  dm_operacion   = convert(int,@i_clave1)
   
   if @@error <> 0
      return 721600 
end
-- FIN REQ 264
if @i_tabla = 'ca_param_condona'
begin
   insert into ca_param_condona_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, @i_clave2, *
   from   ca_param_condona
   where  pc_codigo   = convert(smallint,@i_clave1)
   
   if @@error <> 0
      return 721600 
end

if @i_tabla = 'ca_rol_condona'
begin
   insert into ca_rol_condona_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, @i_clave3, *
   from   ca_rol_condona
   where  rc_rol   = convert(tinyint,@i_clave1)
   and    rc_condonacion = convert(smallint,@i_clave2)
   
   if @@error <> 0
      return 721600 
end

if @i_tabla = 'ca_rol_autoriza_condona'
begin
   insert into ca_rol_autoriza_condona_ts
   
   select @s_date, getdate(), @s_user, @s_ofi, @s_term, @i_clave3, *
   from   ca_rol_autoriza_condona
   where  rac_rol_condona   = convert(tinyint,@i_clave1)
   and    rac_rol_autoriza  = convert(smallint,@i_clave2)
   
   if @@error <> 0
      return 721600 
end

if @i_tabla = 'ca_condonacion'
begin

   if @i_clave4 = 'I'
   begin
      insert into ca_condonacion_ts  (
      cos_fecha_proceso_ts,cos_fecha_ts        ,cos_usuario_ts      ,cos_oficina_ts  ,            
      cos_terminal_ts     ,cos_operacion_ts,    cos_secuencial      ,cos_operacion   ,
      cos_fecha_aplica    ,cos_valor           ,cos_porcentaje      ,cos_concepto    ,
      cos_estado_concepto ,cos_usuario         ,cos_rol_condona     ,cos_autoriza    ,
      cos_estado          ,cos_excepcion       ,cos_porcentaje_par )
      select 
      @s_date            ,getdate()           ,@s_user              ,@s_ofi          ,
      @s_term            ,@i_clave4           ,co_secuencial        ,co_operacion    ,
      co_fecha_aplica    ,co_valor            ,co_porcentaje        ,co_concepto     ,
      co_estado_concepto ,co_usuario          ,co_rol_condona       ,co_autoriza     ,
      co_estado          ,co_excepcion        ,co_porcentaje_par 
      from   ca_condonacion
      where  co_operacion   = convert(int,@i_clave1)
      and    co_secuencial  = convert(int,@i_clave2)
      and    co_concepto    = convert(varchar(10),@i_clave3)
   
      if @@error <> 0
         return 721600 
   end

   if @i_clave4 in ('A','E','R')
   begin
      insert into ca_condonacion_ts (
      cos_fecha_proceso_ts,cos_fecha_ts        ,cos_usuario_ts      ,cos_oficina_ts      ,cos_terminal_ts     ,cos_operacion_ts    ,
      cos_secuencial      ,cos_operacion       ,cos_fecha_aplica    ,cos_valor           ,cos_porcentaje      ,
      cos_concepto        ,cos_estado_concepto ,cos_usuario         ,cos_rol_condona     ,cos_autoriza        ,
      cos_estado          ,cos_excepcion       ,cos_porcentaje_par         )
      
      select @s_date      ,getdate()           ,@s_user             ,@s_ofi             ,@s_term            , @i_clave4, 
      min(co_secuencial)  ,min(co_operacion)    ,min(co_fecha_aplica),sum(co_valor)      , 0,
      ''                  ,min(co_estado_concepto), min(co_usuario)  ,min(co_rol_condona), min(co_autoriza),
      min(co_estado)      ,min(co_excepcion)    , min(co_porcentaje_par)
      from   ca_condonacion
      where  co_operacion   = convert(int,@i_clave1)
      and    co_secuencial  = convert(int,@i_clave2)
      
      if @@error <> 0
         return 721600 
   end

end

return 0

go

