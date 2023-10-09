/************************************************************************/
/*      Archivo:                sp_validacion_principal_mig.sp          */
/*      Stored procedure:       sp_validacion_principal_mig             */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:                 Cuentas de Ahorros                    */
/*      Disenado por:              MBA                                  */
/*      Fecha de escritura:     22-Jul-2015                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la migracion de apertura de cuenta        */
/*      de ahorros.                                                     */
/************************************************************************/

use cob_externos
go

if exists (select * from sysobjects where name = 'sp_validacion_principal_mig')
   drop proc sp_validacion_principal_mig
go

create proc sp_validacion_principal_mig
(  
      @i_param1             int          = null   --rango
)
as

declare
   @w_sp_name           varchar(30),    --Setea nombre del Sp
   @w_pase              int,            --Numero de Ciclos
   @w_minimo            int,            --Rango minimo de registros
   @w_registros         int,            --Cantidad de registros
   @w_tabla_pric        varchar(30),    --Tabla en uso
   @w_rango             int,            --Rango de seleccion de registro
   @w_conteo            int,            --Cantidad de registro en tabla principal
   @w_clave_i           int,            --Registro Clave Inicial
   @w_clave_f           int  ,          --Registro Clave Final
   @i_rango              int         
   
  select @i_rango = @i_param1
 --------------------------------
-- INICIA LOS RANGOS
--------------------------------        
exec sp_inicia_rangos       

   -- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_sp_name        = 'sp_validacion_principal_mig',
        @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_cuenta_mig',
        @w_rango          = @i_rango,
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_cuenta_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        --@w_comando        = 'isql' + ' ' + '-U' + @i_user + ' ' + '-P' + @i_pass + ' ' + '-S' + @i_server + ' ' + '-n -idump.txt'
        -- @w_comando        = 'isql -U' + @i_user + ' -P' + @i_pass + ' -S' + @i_server + ' -n -i/cobis/MIGRACION/Migracion_Pasivas/Ahorros_mig/sql/dump.sql'
        --@w_comando        = 'isql -U' + @i_user + ' -P' + @i_pass + ' -S' + @i_server + ' -n -i' + @i_pwd + '/../sql/dump.sql'



--------------------------------
-- REINICIA LOS LOGS
--------------------------------
delete from ah_log_mig
--where lm_tabla = @w_tabla_pric


-- ------------------------------------------------------------------
-- - Validacion ah_cuenta
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_cuenta         
       exec sp_valida_ah_cuenta @i_clave_i = @w_clave_i,
                                 @i_clave_f = @w_clave_f
            
     --Obtener las cuentas
      select @w_registros = count(ah_cuenta)
      from ah_cuenta_mig
      where ah_cuenta between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros     
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
        -- exec xp_cmdshell @w_comando, no_output
      end
   commit tran
end

update ah_cuenta_mig set ah_default = ah_cliente where ah_tipo_def = 'C'

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_cuenta_mig where ah_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_cuenta)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_ctabloqueada_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_ctabloqueada_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_ctabloqueada
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones cl_direccion         
      exec sp_valida_ah_ctabloqueada @i_clave_i = @w_clave_i,
                                     @i_clave_f = @w_clave_f
      
      --Obtener los clientes          
      select @w_registros = count(cb_cuenta)
      from ah_ctabloqueada_mig
      where cb_cuenta between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
         --exec xp_cmdshell @w_comando, no_output
      end
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_ctabloqueada_mig where cb_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_ctabloqueada)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_his_bloqueo_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_his_bloqueo_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_his_bloqueo
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin 

   begin tran  
      --Ejecucion de Validaciones ah_his_bloqueo         
      exec sp_valida_ah_his_bloqueo @i_clave_i = @w_clave_i,
                                    @i_clave_f = @w_clave_f
                             
      /*exec sp_traslada_ah_his_bloqueo @i_clave_i = @w_clave_i,
                                      @i_clave_f = @w_clave_f         */                         
      
      --Obtener los clientes          
      select @w_registros = count(hb_cuenta)
      from ah_his_bloqueo_mig
      where hb_cuenta between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
        -- exec xp_cmdshell @w_comando, no_output
      end
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_his_bloqueo_mig where hb_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_his_bloqueo)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_ciudad_deposito_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_ciudad_deposito_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_ciudad_deposito
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_ciudad_deposito         
      exec sp_valida_ah_ciudad_deposito @i_clave_i = @w_clave_i,
                                        @i_clave_f = @w_clave_f
                                   
      --Obtener las ciudades          
      select @w_registros = count(cd_cuenta)
      from ah_ciudad_deposito_mig
      where cd_cuenta between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
       --  exec xp_cmdshell @w_comando, no_output
      end
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_ciudad_deposito_mig where cd_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_ciudad_deposito)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_his_inmovilizadas_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_his_inmovilizadas_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_his_inmovilizadas
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric


while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_his_inmovilizadas         
      exec sp_valida_ah_his_inmovilizadas @i_clave_i = @w_clave_i,
                                          @i_clave_f = @w_clave_f                                
      
      --Obtener los his inmovilizadas          
      select @w_registros = count(hi_codigo)
      from ah_his_inmovilizadas_mig
      where  hi_codigo between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
        -- exec xp_cmdshell @w_comando, no_output
      end   
   commit tran
end
/*exec sp_traslada_ah_his_inmovilizadas*/
update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_his_inmovilizadas_mig where hi_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_his_inmovilizadas)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_tran_monet_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_tran_monet_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_tran_monet
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_tran_monet         
      exec sp_valida_ah_tran_monet @i_clave_i = @w_clave_i,
                                   @i_clave_f = @w_clave_f
                                
      
      --Obtener las transacciones monetarias
      select @w_registros = count(tm_codigo)
      from ah_tran_monet_mig
      where tm_codigo between @w_clave_i and @w_clave_f
      
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
      --   exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_tran_monet_mig where tm_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_tran_monet)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
  select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_his_movimiento_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_his_movimiento_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_his_movimiento
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_his_movimiento
      exec sp_valida_ah_his_movimiento @i_clave_i = @w_clave_i,
                                       @i_clave_f = @w_clave_f
    
      --Obtener los historicos de movimientos  
      select top 1 @w_registros = count(hm_codigo)
      from ah_his_movimiento_mig
      where  hm_codigo between  @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
       --  exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_his_movimiento_mig where hm_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros_his..ah_his_movimiento)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_val_suspenso_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_val_suspenso_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_val_suspenso
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_val_suspenso
      exec sp_valida_ah_val_suspenso @i_clave_i = @w_clave_i,
                                     @i_clave_f = @w_clave_f
                                
      --Obtener los valores que estan suspensos     
      select top 1 @w_registros = count(vs_cuenta)
      from    ah_val_suspenso_mig a
      where  vs_cuenta between @w_clave_i and @w_clave_f
            
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
       --  exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_val_suspenso_mig where vs_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_val_suspenso)
where rm_tabla = @w_tabla_pric
                        
-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_linea_pendiente_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_linea_pendiente_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion ah_linea_pendiente
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones ah_linea_pendiente
      exec sp_valida_ah_linea_pendiente @i_clave_i = @w_clave_i,
                                        @i_clave_f = @w_clave_f
                                
      --Obtener las lineas pendientes 
      select top 1 @w_registros = count(convert(int,lp_cuenta))
      from ah_linea_pendiente_mig
      where lp_cuenta between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
       --  exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from ah_linea_pendiente_mig where lp_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_ahorros..ah_linea_pendiente)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 're_accion_nd_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 're_accion_nd_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion re_accion_nd
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones re_accion_nd
      exec sp_valida_re_accion_nd @i_clave_i = @w_clave_i,
                                  @i_clave_f = @w_clave_f
                                
      --Obtener las acciones  
      select top 1 @w_registros = count(convert(int,an_causa))
      from re_accion_nd_mig
      where an_causa between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
       --  exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from re_accion_nd_mig where an_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_remesas..re_accion_nd)
where rm_tabla = @w_tabla_pric
        
        
 -- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 're_cuenta_contractual_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 're_cuenta_contractual_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion re_detalle_cheque
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones re_detalle_cheque_mig
           exec sp_valida_re_cuenta_contractual    @i_clave_i = @w_clave_i,
                                            @i_clave_f = @w_clave_f
                                
       --Obtener los clientes 
      select top 1 @w_registros = cc_profinal
      from re_cuenta_contractual_mig      
      where cc_profinal between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
       --  exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from re_cuenta_contractual_mig where cc_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_remesas..re_cuenta_contractual)
where rm_tabla = @w_tabla_pric
                               
        
-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 're_detalle_cheque_mig',
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 're_detalle_cheque_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango
        
-- ------------------------------------------------------------------
-- - Validacion re_detalle_cheque
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      --Ejecucion de Validaciones re_detalle_cheque_mig
           exec sp_valida_detalle_cheque    @i_clave_i = @w_clave_i,
                                            @i_clave_f = @w_clave_f
                                
       --Obtener los clientes 
      select top 1 @w_registros = count(convert(int,dc_codigo))
      from re_detalle_cheque_mig      
      where convert(int,dc_codigo) between @w_clave_i and @w_clave_f
      
      --Actualizar Rangos
      select @w_clave_i = @w_clave_i + @w_rango
      select @w_clave_f = @w_clave_f + @w_rango
      
      select @w_minimo = @w_minimo + @w_registros 
      
      if @w_registros <> 0
      begin
         select @w_pase = @w_pase + 1
         update ah_rango_mig set rm_valor_regis  = isnull(@w_minimo,0), 
                                 rm_valor_rango  = isnull(@w_clave_i,0), 
                                 rm_ciclos       = @w_pase
         where rm_tabla = @w_tabla_pric   
      --   exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from re_detalle_cheque_mig where dc_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_remesas..re_detalle_cheque)
where rm_tabla = @w_tabla_pric
                        
return 0
go

