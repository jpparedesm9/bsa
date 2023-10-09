/*************************************************************************/
/*  Archivo:                sp_traslada_tablas_mig.sp                    */
/*  Stored procedure:       sp_traslada_tablas_mig                       */
/*  Base de datos:          cob_externos                                 */
/*  Producto:               AHORROS                                      */
/*  Disenado por:           GCU                                          */
/*  Fecha de escritura:     02-Ago-2016                                  */
/*************************************************************************/
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                              PROPOSITO                                */
/*  Realiza el traspaso de las tablas de migracion MIGs a las tablas     */
/*  definitivas.                                                         */
/*************************************************************************/

use cob_externos
go

if exists (select * from sysobjects where name = 'sp_traslada_tablas_mig')
   drop proc sp_traslada_tablas_mig
go

create proc sp_traslada_tablas_mig
(  
   @i_rango              int          = null,     
   @i_incre              char(1)      = null,   
   @i_param1             int          = null,     --i_rango
   @i_param2             char(1)      = null     --i_incre
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
   @w_totalcuenta       int,
   @w_clave_i           int,            --Registro Clave Inicial
   @w_clave_f           int,            --Registro Clave Final
   @w_comando           varchar(255),   --llamada al dump tran
   @w_comando_bat       varchar(500),   --comando para generar listado de errores via bcp
   @w_path_sapp         varchar(30),    --ruta del bcp
   @w_tab               char(1),        --separador del archivo plano de errores
   @w_ret               int,
   @w_path              varchar(200)
   
select @i_rango = @i_param1
select @i_incre = @i_param2

--------------------------------
-- INICIA LOS RANGOS
--------------------------------        
exec sp_inicia_rangos  
-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_sp_name        = 'sp_traslada_tablas_mig',
        @w_pase           = 0,
        @w_minimo         = 0,
        @w_registros      = 0,
        @w_tabla_pric     = 'ah_cuenta_mig',
        @w_rango          = @i_rango,
        @w_conteo         = (select rm_total from ah_rango_mig where rm_tabla = 'ah_cuenta_mig'),
        @w_clave_i        = 0,
        @w_clave_f        = @i_rango

       
--------------------------------
-- CREACION DE NUMERO DE CUENTA COBIS
-------------------------------- 
exec sp_crea_num_ctah_mig


--------------------------------
-- Eliminar Tablas Definitivas
--------------------------------
if upper(@i_incre) = 'N'
begin
   truncate table cob_ahorros..ah_linea_pendiente
   truncate table cob_ahorros..ah_tran_monet
   truncate table cob_ahorros..ah_his_movimiento
   truncate table cob_ahorros..ah_val_suspenso
   truncate table cob_ahorros..ah_his_inmovilizadas
   truncate table cob_ahorros..ah_ciudad_deposito
   truncate table cob_ahorros..ah_his_bloqueo
   truncate table cob_ahorros..ah_ctabloqueada
   truncate table cob_ahorros..ah_cuenta
   truncate table cob_remesas..re_detalle_cheque
   truncate table cob_remesas..re_cuenta_contractual
   truncate table cob_remesas..re_accion_nd
   delete cobis..cl_cliente where cl_det_producto in (select dp_det_producto  from cobis..cl_det_producto where  dp_producto = 4)
   delete cobis..cl_det_producto where dp_producto = 4
   truncate table cob_ahorros..ah_datos_adic
end

-- ------------------------------------------------------------------
-- - Validacion ah_cuenta
-- ------------------------------------------------------------------
select @w_totalcuenta = count(1)
from   ah_cuenta_mig
where  ah_estado_mig = 'VE'

if @w_totalcuenta = 0 
begin
    delete from ah_log_mig where lm_id_reg = '9999'
    insert into ah_log_mig (lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_error)
    values ('9999','ah_cuenta_mig','sp_traslada_tablas_mig','ah_cuenta',286)
    goto REPORTE
end 

update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
            
      --Ejecucion de traslado a definitivas     
      exec sp_traslada_ah_cuenta @i_clave_i = @w_clave_i,
                                 @i_clave_f = @w_clave_f                             
      
      --Obtener las cuentas
      select @w_registros = count(ah_cuenta)
      from   ah_cuenta_mig
      where  ah_cuenta between @w_clave_i and @w_clave_f
      
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
        where  rm_tabla = @w_tabla_pric   
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
                                      
      --Ejecucion de traslado a definitivas     
      exec sp_traslada_ah_ctabloqueada @i_clave_i = @w_clave_i,
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
        -- exec xp_cmdshell @w_comando, no_output
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
      
      --Ejecucion de traslado a definitivas                              
      exec sp_traslada_ah_his_bloqueo @i_clave_i = @w_clave_i,
                                      @i_clave_f = @w_clave_f                                
      
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
      --Ejecucion de traslado a definitivas                                
      exec sp_traslada_ah_ciudad_deposito @i_clave_i = @w_clave_i,
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
        -- exec xp_cmdshell @w_comando, no_output
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
   
      --Ejecucion de traslado a definitivas                                   
      exec sp_traslada_ah_his_inmovilizadas @i_clave_i = @w_clave_i,
                                    @i_clave_f = @w_clave_f     
      
      --Obtener los his inmovilizadas          
      select @w_registros = count(hi_codigo)
      from   ah_his_inmovilizadas_mig
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
      
      --Ejecucion de traslado a definitivas                             
      exec sp_traslada_ah_tran_monet @i_clave_i = @w_clave_i,
                                     @i_clave_f = @w_clave_f                                
      
      --Obtener los transacciones monetarias
      select @w_registros = count(tm_codigo)
      from   ah_tran_monet_mig
      where  tm_codigo between @w_clave_i and @w_clave_f
      
      
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
     
      --Ejecucion de traslado a definitivas                         
      exec sp_traslada_ah_his_movimiento @i_clave_i = @w_clave_i,
                                            @i_clave_f = @w_clave_f         

      --Obtener los ahorros programados  
      select top 1 @w_registros = count(hm_codigo)
      from ah_his_movimiento_mig
      where hm_codigo between @w_clave_i and @w_clave_f
      
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
-- - Validacion ah_val_suspenso_mig
-- ------------------------------------------------------------------
update ah_rango_mig set rm_fec_ini_val = getdate()
where rm_tabla = @w_tabla_pric

while @w_minimo < @w_conteo
begin  
   begin tran  
      
      --Ejecucion de traslado a definitivas                         
      exec sp_traslada_ah_val_suspenso @i_clave_i = @w_clave_i,
                                       @i_clave_f = @w_clave_f                              
      
      --Obtener los det ahorros programados        
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
        -- exec xp_cmdshell @w_comando, no_output
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
      
      --Ejecucion de traslado a definitivas                         
      exec sp_traslada_ah_linea_pendiente @i_clave_i = @w_clave_i,
                                          @i_clave_f = @w_clave_f                               
      
      --Obtener los det ahorros programados  
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
        -- exec xp_cmdshell @w_comando, no_output
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
      exec sp_traslada_re_accion_nd @i_clave_i = @w_clave_i,
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
           exec sp_traslada_re_cuenta_contractual    @i_clave_i = @w_clave_i,
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
      
      --Ejecucion de traslado a definitivas                     
      exec sp_traslada_detalle_cheque   @i_clave_i = @w_clave_i,
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
        -- exec xp_cmdshell @w_comando, no_output
      end 
   commit tran
end

update ah_rango_mig set rm_fec_fin_val    = getdate(),
                        rm_cant_reg_val   = (select count(*) from re_detalle_cheque_mig where dc_estado_mig = 'VE'),
                        rm_cant_reg_cobis = (select count(*) from cob_remesas..re_detalle_cheque)
where rm_tabla = @w_tabla_pric

-- ------------------------------------------------------------------
-- - Actualiza el numero de la cuenta migrada en la tabla de log
-- ------------------------------------------------------------------
update ah_log_mig 
set    lm_cta_banco_mig = ah_cta_banco
from   ah_log_mig, ah_cuenta_mig
where  lm_operacion = ah_cuenta 
and    lm_tabla in ('ah_ctabloqueada_mig','ah_his_bloqueo_mig', 'ah_ciudad_deposito_mig', 'ah_linea_pendiente_mig', 'ah_val_suspenso_mig') 
and    lm_cta_banco_mig IS NULL


REPORTE:
------------------------------------
--GENERA LISTADO DE ERRORES
------------------------------------
truncate table ah_rep_logmig

insert into ah_rep_logmig 
SELECT 'ID REGISTRO'        ,
       ' TABLA'             ,
       ' PROGRAMA'          ,
       ' COLUMNA'           ,
       ' DATO'              ,
       ' COD. OPERACION'    ,
       ' CUENTA MIGRACION'  ,
       ' COD. ERROR'        ,
       ' DESCRIPCION ERROR' 

insert into ah_rep_logmig 
select replicate('-',14),
       ' ' + replicate('-',19),
       ' ' + replicate('-',29),
       ' ' + replicate('-',14),
       ' ' + replicate('-',14),
       ' ' + replicate('-',14),
       ' ' + replicate('-',15),
       ' ' + replicate('-',09),
       ' ' + replicate('-',149)
       
insert into ah_rep_logmig 
SELECT 'ID REGISTRO'       = convert(CHAR(14) ,l.lm_id_reg), 
       'TABLA'             = ' ' + convert(CHAR(19) ,l.lm_tabla),
       'PROGRAMA'          = ' ' + convert(CHAR(29) ,l.lm_fuente),
       'COLUMNA'           = ' ' + convert(CHAR(14) ,l.lm_columna),
       'DATO'              = ' ' + convert(CHAR(14) ,l.lm_dato),
       'COD. OPERACION'    = ' ' + convert(CHAR(14) ,l.lm_operacion),
       'CUENTA MIGRACION'  = ' ' + convert(CHAR(15) ,l.lm_cta_banco_mig),
       'COD. ERROR'        = ' ' + convert(CHAR(09) ,l.lm_error),
       'DESCRIPCION ERROR' = ' ' + convert(CHAR(149),e.er_des)
FROM   ah_log_mig l, 
       ah_errores_mig e
WHERE  l.lm_error = e.er_cod

select @w_path_sapp = pa_char from cobis..cl_parametro where pa_producto = 'ADM' and pa_nemonico = 'S_APP'
select @w_tab = ''

select
@w_path = ba_path_destino
from   cobis..ba_batch
where  ba_batch = 4303 

select @w_comando_bat  = @w_path_sapp + 's_app' + ' bcp -auto -login cob_externos..ah_rep_logmig out ' 
                     + @w_path
                     + 'ah_rep_logmig.txt' +  ' -c -t"' + @w_tab + '" '
                     + '-config ' + @w_path_sapp + 's_app.ini'

execute @w_ret = master..xp_cmdshell @w_comando_bat


return 0
go

