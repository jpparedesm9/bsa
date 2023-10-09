/************************************************************************/
/*   Stored procedure:     sp_causa_E012                                */
/*   Base de datos:        cob_ahorros                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   02/May/2016        J. Calderon     Migración a CEN                 */
/************************************************************************/

USE cob_ahorros
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_causa_E012')
    drop proc sp_causa_E012
go

create proc sp_causa_E012(
   @s_date        datetime,
   @s_user        login,
   @s_ofi         int         = null,
   @t_show_version bit = 0,
   @i_operacion   char(1),    -- 'E' -> Ejecutar, 'R' -> Reversar, 'A' -> Anular
   @i_idorden     int         = 0, 
   @i_ref1        int         = 0,
   @i_ref2        int         = 0,
   @i_ref3        varchar(30) = '',
   @i_debug       char(1)     = 'N',
   @i_interfaz    char(1)     = 'N'
)
as
declare 
@w_error            int,
@w_ofi              smallint,
@w_cta_banco        cuenta,
@w_ssn              int,
@w_ssn_corr         int,
@w_categoria        char(1),
@w_saldo            money,
@w_filial           tinyint,
@w_prod_banc        int,
@w_cliente          int,
@w_ah_moneda        smallint,
@w_clase_clte       char(1), 
@w_tipocta_super    char(1),
@w_indicador        tinyint,
@w_terminal         varchar(10),
@w_sp_name          varchar(30)


/* Captura del nombre del Store Procedure */

select @w_sp_name = 'sp_causa_E012'


---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = '+ @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
end
          
/* Encuentra el SSN inicial para la transaccion de servicio*/
begin tran

   select @w_ssn = se_numero
   from cobis..ba_secuencial

   if @@rowcount <> 1
   begin
      /* Error en lectura de SSN */   
      select @w_error = 201163 
      if @i_interfaz = 'S'
          return @w_error 
      else
          goto ERROR
   end
  
   update cobis..ba_secuencial
   set se_numero = @w_ssn + 1000000

   if @@rowcount <> 1
   begin
      /* Error en actualizacion de SSN */  
      select @w_error = 205031 
      if @i_interfaz = 'S'
          return @w_error 
      else
          goto ERROR
   end

commit tran

print '@i_operacion ' + @i_operacion  + ' @i_ref3 ' + @i_ref3 + ' @i_idorden ' + cast(@i_idorden as varchar) + ' @i_ref1 ' + cast(@i_ref1 as varchar)
--------------------------------------------------
--MARCAR COMO EJECUTADA UNA ORDEN DE COBRO O PAGO 
--------------------------------------------------

if @i_operacion = 'E' 
   begin
      select @w_ofi           = ah_oficina,
             @w_cta_banco     = ah_cta_banco,
             @w_saldo         = ah_disponible,
             @w_filial        = ah_filial,
             @w_prod_banc     = ah_prod_banc,
             @w_cliente       = ah_cliente,
             @w_ah_moneda     = ah_moneda,  
             @w_clase_clte    = ah_clase_clte,
             @w_tipocta_super = ah_tipocta_super,
             @w_categoria     = ah_categoria
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta = @i_ref1
      
      if @w_ofi <> @s_ofi
      begin
         select @w_error = 257076 -- TRANSACCION SE DEBE REALIZAR EN LA OFICINA DE LA CUENTA
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end
      
      ------------------------------------------------------------
      --Carga de datos del registro de cierre
      ------------------------------------------------------------       
      select @w_terminal  = terminal, 
             @w_indicador = case when valor > 0 then 1 else 3 end,
             @w_saldo     = case when valor > 0 then valor else val_cheque end
        from cob_ahorros..ah_his_cierre, 
             cob_cuentas..cc_tsot_ingegre
       where hc_cuenta        = @i_ref1
         and hc_sec_ord_pago  = @i_idorden
         and hc_sec_ord_pago  = sec_ord_pago
         and desc_referencia  = @w_cta_banco
         and usuario          = @s_user
         and oficina          = @s_ofi
         and tipo_tran        = 86
         and causa            = '012' 
         and estado_corr is null  
        
      if @@rowcount <> 1
      begin
         --No Existe Informacion del Pago de Cierre de Cuenta
         select @w_error = 257075
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end         
             
      ------------------------------------------------------------
      --Actualiza estado del registro de cierre
      ------------------------------------------------------------   
      update cob_ahorros..ah_his_cierre
      set    hc_estado        =  'P',
             hc_fecha_act     = @s_date,
             hc_usuario_pg    = @s_user
      where  hc_cuenta        = @i_ref1
      and    hc_sec_ord_pago  = @i_idorden       
      if @@error <> 0 or @@rowcount <> 1
      begin
         --Error al Actualizar Cuenta en Historico de Cierre
         select @w_error = 258004
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end

     ------------------------------------------------------------
     --Actualiza estado del registro en la tabla del tesoro
     ------------------------------------------------------------       
         
     /* Se valida que la cuenta este trasladada a la DTN */
     if exists (select 1 from cob_remesas..re_tesoro_nacional 
                   where tn_cuenta = @w_cta_banco
                     and tn_estado = 'P')
     begin
          /* Se le cambia el estado a reintegrada, a la Cuenta de la DTN */
          update cob_remesas..re_tesoro_nacional
          set tn_estado        = 'S',
              tn_fecha_r_saldo = @s_date,
              tn_oficina_r     = @s_ofi,
              tn_fecha_act     = @s_date,
              tn_autorizante   = @s_user  
        where tn_cuenta = @w_cta_banco
          and tn_estado   = 'P' 
        
          if @@rowcount <> 1
          begin
            /* Error al actualizar cuenta de ahorros */          
            select @w_error = 255001
            if @i_interfaz = 'S'
               return @w_error 
            else
               goto ERROR      
          end    

         /* Creacion de la transacicon de servicio para el traslado*/
         insert into ah_tran_servicio 
         (ts_secuencial,     ts_ssn_branch,     ts_cod_alterno,     ts_tipo_transaccion,
          ts_tsfecha,        ts_usuario,        ts_terminal,        ts_correccion,
          ts_ssn_corr,       ts_reentry,        ts_origen,          ts_cta_banco,
          ts_filial,         ts_oficina,        ts_cliente,         ts_estado,
          ts_clase_clte,     ts_categoria,      ts_indicador,       ts_moneda,
          ts_valor,          ts_interes,        ts_causa,           ts_oficina_cta,
          ts_hora,           ts_prod_banc,      ts_tipocta_super,   ts_endoso)
         values 
         (@w_ssn,       @w_ssn,        0,                 378,
         @s_date,       @s_user,       @w_terminal,       'N',
         null,          'N',           'L',               @w_cta_banco,  
         @w_filial,     @w_ofi,        @w_cliente,        null, 
         @w_clase_clte, @w_categoria,  @w_indicador,      @w_ah_moneda, 
         @w_saldo,      0,             null,              @w_ofi,
         getdate(),     @w_prod_banc,  @w_tipocta_super,  @i_idorden)
         if @@error <> 0
         begin
            /* ERROR EN INSERCION DE TRANSACCION DE SERVICIO */          
            select @w_error = 203005
            if @i_interfaz = 'S'
               return @w_error 
            else
               goto ERROR      
         end
                                
     end   
   return 0 
end 
   
--------------------------------------
-- REVERSAR UNA ORDEN DE COBRO O PAGO 
--------------------------------------

if @i_operacion = 'R' 
begin  
      ------------------------------------------------------------
      --Actualiza estado del registro de cierre
      ------------------------------------------------------------   
      update cob_ahorros..ah_his_cierre
      set    hc_estado        =  'C',
             hc_fecha_act     = null,
             hc_usuario_pg    = null
      where  hc_cuenta   =  @i_ref1    
      and    hc_estado   =  'P'
      and    hc_sec_ord_pago = @i_idorden
    

      if @@error <> 0 or @@rowcount <> 1 
      begin
         --Error al Actualizar Cuenta en Historico de Cierre
         select @w_error = 258004
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end
      
     ------------------------------------------------------------
     --Actualiza estado del registro en la tabla del tesoro
     ------------------------------------------------------------  
      select @w_cta_banco = ah_cta_banco
      from   cob_ahorros..ah_cuenta
      where  ah_cuenta = @i_ref1
     
     /* Se valida que la cuenta tengo estado de solicitud de reintegro de la DTN */
     if exists (select 1 from cob_remesas..re_tesoro_nacional 
                   where tn_cuenta = @w_cta_banco
                     and tn_estado = 'S')
     begin
           /* Se le cambia el estado de solicitud a procesada la cuenta en la DTN */
           update cob_remesas..re_tesoro_nacional
           set tn_estado        = 'P',
               tn_fecha_r_saldo = null,
               tn_oficina_r     = null,
               tn_fecha_act     = null,
               tn_autorizante   = 'AHO'  
         where tn_cuenta = @w_cta_banco
           and tn_estado   = 'S' 
         
           if @@rowcount <> 1
           begin
             /* Error al actualizar cuenta de ahorros */          
             select @w_error = 255001
             if @i_interfaz = 'S'
                return @w_error 
             else
                goto ERROR      
           end   
           
        select @w_ssn_corr      = ts_secuencial,
               @w_terminal      = ts_terminal,
               @w_filial        = ts_filial,
               @w_ofi           = ts_oficina,
               @w_cliente       = ts_cliente,
               @w_clase_clte    = ts_clase_clte,
               @w_categoria     = ts_categoria,
               @w_indicador     = ts_indicador,
               @w_ah_moneda     = ts_moneda,
               @w_saldo         = ts_valor,
               @w_prod_banc     = ts_prod_banc,
               @w_tipocta_super = ts_tipocta_super
          from ah_tran_servicio
        where ts_tipo_transaccion = 378
          and ts_correccion = 'N'
          and ts_ssn_corr is null
          and ts_reentry = 'N' 
          and ts_origen = 'L'
          and ts_cta_banco = @w_cta_banco
          and ts_estado is null
          and ts_causa is null  
          and ts_endoso =  @i_idorden    

         if @@rowcount = 0
         begin          
             /* No encontro transaccion de servicio */
             select @w_error = 208020
             if @i_interfaz = 'S'
                return @w_error 
             else
                goto ERROR 
         end          
           
         /*Marca transaccion original en estado de Reverso */
         update ah_tran_servicio
         set ts_estado = 'R'  
         where ts_tipo_transaccion = 378
          and ts_correccion = 'N'
          and ts_ssn_corr is null
          and ts_reentry = 'N' 
          and ts_origen = 'L'
          and ts_cta_banco = @w_cta_banco
          and ts_estado is null
          and ts_causa is null  
          and ts_endoso =  @i_idorden            
            
         if @@error <> 0                
         begin          
             /* Error en actualizacion de servicio */
             select @w_error = 105052
             if @i_interfaz = 'S'
                return @w_error 
             else
                goto ERROR 
         end
         
         /* Creacion de la transacicon de servicio para el reverso del traslado*/
         insert into ah_tran_servicio 
         (ts_secuencial,     ts_ssn_branch,     ts_cod_alterno,     ts_tipo_transaccion,
          ts_tsfecha,        ts_usuario,        ts_terminal,        ts_correccion,
          ts_ssn_corr,       ts_reentry,        ts_origen,          ts_cta_banco,
          ts_filial,         ts_oficina,        ts_cliente,         ts_estado,
          ts_clase_clte,     ts_categoria,      ts_indicador,       ts_moneda,
          ts_valor,          ts_interes,        ts_causa,           ts_oficina_cta,
          ts_hora,           ts_prod_banc,      ts_tipocta_super,   ts_endoso)
         values 
         (@w_ssn,       @w_ssn,        0,                 378,
         @s_date,       @s_user,       @w_terminal,       'S',
         @w_ssn_corr,   'N',           'L',               @w_cta_banco,  
         @w_filial,     @w_ofi,        @w_cliente,        'R', 
         @w_clase_clte, @w_categoria,  @w_indicador,      @w_ah_moneda, 
         @w_saldo,      0,             null,              @w_ofi,
         getdate(),     @w_prod_banc,  @w_tipocta_super,  @i_idorden)
         if @@error <> 0
         begin
            /* ERROR EN INSERCION DE TRANSACCION DE SERVICIO */          
            select @w_error = 203005
            if @i_interfaz = 'S'
               return @w_error 
            else
               goto ERROR      
         end                     
     end 
  return 0 
end

-------------------------------------------------
-- MARCAR COMO ANULADA UNA ORDEN DE COBRO O PAGO
------------------------------------------------- 

if @i_operacion = 'A' 
   begin
      ------------------------------------------------------------
      --Actualiza estado del registro de cierre
      ------------------------------------------------------------   

      update cob_ahorros..ah_his_cierre
      set    hc_estado   =  'R' --@i_operacion
      where  hc_cuenta   =  @i_ref1
        and  hc_sec_ord_pago = @i_idorden      

      if @@error <> 0 or @@rowcount <> 1
      begin
         --Error al Actualizar Cuenta en Historico de Cierre
         select @w_error = 258004
         if @i_interfaz = 'S'
            return @w_error 
         else
            goto ERROR
      end  
      return 0
   end

return 0

ERROR:
exec cobis..sp_cerror
@i_num = @w_error
return @w_error


go

