
/***********************************************************************/
/*  Archivo:                    custautom.sp                           */
/*  Stored procedure:           sp_custodia_automatica                 */
/*  Base de Datos:              cob_custodia                           */
/*  Producto:                   Garantias                              */
/*  Disenado por:               Andy Gonzalez                          */
/*  Fecha de Documentacion:     Marzo del 2017                         */
/***********************************************************************/
/*          IMPORTANTE                                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de      */ 
/*  "MACOSA",representantes exclusivos para el Ecuador de              */
/*  MACOSA                                                             */
/*  Su uso no autorizado queda expresamente prohibido asi como         */
/*  cualquier autorizacion o agregado hecho por alguno de sus          */
/*  usuario sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante                 */
/***********************************************************************/
/*          PROPOSITO                                                  */
/*  Proceso de creacion automatica de un valor en custodia en          */
/*      estado Propuesto.                                              */ 
/*  Insert, Delete                                                     */
/*                                                                     */
/***********************************************************************/
/*          MODIFICACIONES                                             */
/*  FECHA        AUTOR          RAZON                                  */
/*  Marzo-2017   AGO            Emision Inicial                        */
/***********************************************************************/



use cob_custodia
go

if exists (select * from sysobjects where name = 'sp_custodia_automatica')
drop proc sp_custodia_automatica
go

create proc sp_custodia_automatica (
@t_show_version         bit             = 0,  -- show the version of the stored procedure
@s_ssn                  int             = null,
@s_user                 login           = null,
@s_sesn                 int             = null,
@s_term                 varchar(30)     = null,
@s_date                 datetime        = null,
@s_srv                  varchar(30)     = null,
@s_lsrv                 varchar(30)     = null,
@s_rol                  smallint        = NULL,
@s_ofi                  smallint        = NULL,
@s_org_err              char(1)         = NULL,
@s_error                int             = NULL,
@s_sev                  tinyint         = NULL,
@s_msg                  descripcion     = NULL,
@s_org                  char(1)         = NULL,
@t_rty                  char(1)         = null,
@t_trn                  smallint        = null,
@t_debug                char(1)         = 'N',
@t_file                 varchar(14)     = null,
@t_from                 varchar(30)     = null,
@i_operacion            varchar(1)      = null,
@i_tipo_custodia        varchar(10)     = null,
@i_valor_inicial        money           = null,
@i_moneda               tinyint         = null,
@i_garante              int             = null,
@i_fecha_ing            datetime        = null,
@i_cliente              int             = null,
@i_clase                char(1)         = 'C',
@i_filial               int             = null,
@i_oficina              int             = null,
@i_ubicacion            varchar(10)     = null,
@i_tramite              int             = null,
@i_plazo_fijo           varchar(30)     = null,
@i_cuenta_hold          varchar(30)     = null,     
@i_cuenta_tipo          tinyint         = null,
@o_codigo_externo       varchar(64)     = null out --NUMERO DE LA GARANTIA
)
as
declare
@w_today                datetime,     /* fecha del dia */ 
@w_return               int,          /* valor que retorna */
@w_sp_name              varchar(32),  /* nombre stored proc*/
@w_existe               tinyint,      /* existe el registro*/
@w_ubicacion            varchar(10),
@w_tipo_docu            varchar(10),
@w_cod_externo          varchar(64),
@w_tramite              int,
@w_monto                money,
@w_custodia             int,
@w_gar_personal         catalogo,
@w_tc_cobertura         float

-------------------------------- VERSIONAMIENTO DEL PROGRAMA --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure cob_custodia..sp_custodia_automatica, Version 4.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------------- 

select @w_today  = isnull(@s_date, fp_fecha)
  from cobis..ba_fecha_proceso

select @w_sp_name = 'sp_custodia_automatica'


if @i_operacion = 'L'   --Ingreso de custodia automatico en estado Propuesta
begin

   if @i_tipo_custodia = NULL
   begin
     /* Error parametro  */
     exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1903012,    /*Tipo de operacion nulo*/
          @i_msg   = "[sp_custodia_automatica] Error parametro con el tipo de operacion es nulo"
     return 1 
   end
   
   if @i_ubicacion = null
   begin
      select @i_ubicacion=pa_char
        from cobis..cl_parametro
       where pa_producto='GAR'
         and pa_nemonico='UBIVCU'

      if @@rowcount=0 
      begin
         /* Error no existe parametro de ubicacion default */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 1909027,
            @i_msg   = "[sp_custodia_automatica] Error no existe parametro de ubicacion default"
         return 1 
      end
   end

   --atomicidad en la transaccion 
   begin tran
 
      select @w_tc_cobertura = tc_porcen_cobertura
        from cu_tipo_custodia
       where tc_tipo = @i_tipo_custodia
         
   
      exec @w_return              = cob_custodia..sp_custodia
           @s_ssn                 = @s_ssn,
           @s_date                = @s_date,
           @s_user                = @s_user,
           @s_term                = @s_term,
           @s_ofi                 = @s_ofi,
           @t_trn                 = 19090,
           @i_operacion           = 'I',
           @i_filial              = @i_filial,
           @i_sucursal            = @i_oficina,
           @i_oficina_contabiliza = @i_oficina,
           @i_tipo                = @i_tipo_custodia,
           @i_ente                = @i_cliente,
           @i_estado              = "P",   
           @i_fecha_ingreso       = @i_fecha_ing, 
           @i_valor_inicial       = @i_valor_inicial,
           @i_valor_actual        = @i_valor_inicial,
           @i_moneda              = @i_moneda,
           @i_abierta_cerrada     = @i_clase,
           @i_plazo_fijo          = @i_plazo_fijo,
           @i_garante             = @i_garante,
           @i_clase_custodia      = 'O',
           @i_agotada             ='N',
           @i_grupal              = 'S',
           @o_cod_custodia        = @w_cod_externo out

      if @w_return != 0
      begin
          /* Error en insercion de custodia */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 1903014,
              @i_msg   = "[sp_custodia_automatica] Error en insercion de custodia"
         return 1 
      end

      select @o_codigo_externo = @w_cod_externo

      select @w_custodia = cu_custodia from cu_custodia 
       where cu_codigo_externo = @w_cod_externo

      --asociar cliente a garantia 
      exec @w_return    = cob_custodia..sp_cliente_garantia 
           @s_date      = @s_date,
           @s_user      = @s_user,
           @s_term      = @s_term,
           @s_ofi       = @s_ofi,
           @t_trn       = 19040,
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @t_from,
           @i_operacion = 'I',
           @i_modo      = 0,
           @i_filial    = @i_filial,
           @i_sucursal  = @i_oficina,
           @i_custodia  = @w_custodia,
           @i_tipo_cust = @i_tipo_custodia,
           @i_ente      = @i_cliente,
           @i_principal = 'S'

      if @w_return != 0
      begin
         /* Error en insercion de custodia */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 1903015,
              @i_msg   = "[sp_cliente_garantia ] Error en insercion de cliente garantia"
         return 1 
      end


      --asociar garantia al tramite
      insert into cob_credito..cr_gar_propuesta(
             gp_tramite,
             gp_garantia,
             gp_abierta,
             gp_deudor,
             gp_est_garantia,
             gp_porcentaje,
             gp_valor_resp_garantia,
             gp_fecha_mod
      )
      values(
             @i_tramite,
             @w_cod_externo,
             @i_clase,
             @i_cliente,
             'V',  
             0,
             0,
             getdate()
      )

      if @@error != 0
      begin
         /* Error en insercion de garantia */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 1903016,
              @i_msg   = "[sp_custodia_automatica] Error en insercion de garantia"
         return 1 
      end


      --Manejo de cambios de estado.
      exec @w_return     = cob_custodia..sp_cambios_estado
       @s_ssn            = @s_ssn,
       @s_date           = @s_date,
       @s_user           = @s_user,
       @s_term           = @s_term, 
       @s_ofi            = @s_ofi,
       @t_trn            = @t_trn,
       @i_operacion      = 'I',
       @i_estado_ini     = 'P',
       @i_estado_fin     = 'V',
       @i_codigo_externo = @w_cod_externo


      if @w_return != 0
      begin
         /* Error en insercion de garantia */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file, 
              @t_from  = @w_sp_name,
              @i_num   = 1903016,
              @i_msg   = "[sp_custodia_automatica] Error en insercion de garantia"
         return 1 
      end

   commit tran  --fin atomicidad de la transaccio 
end 
return 0
go

