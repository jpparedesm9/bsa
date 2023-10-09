/************************************************************************/
/*      Archivo:                renobat.sp                              */
/*      Stored procedure:       sp_renova_op                            */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 20-Sep-95                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa mueve la informacion de operacion anterior, a     */
/*      la nueva operacion, si es renovacion de venciada o es una       */
/*      instruccion de renovacion que llega a su fecha de vencimiento.  */
/************************************************************************/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */  
/*      12-Oct-1999  M. Cartagena O.  Adicion SQLSE65-E012, eliminacion */
/*                                    de envio de parametros innecesa-  */
/*                                    rios sp_renova_ant @i_observacion */
/*      04-May-00    Ximena Cartagena U Conversion de tasa Efectiva a   */
/*                                    tasa Nominal.                     */   
/*      19-Oct-2001  N. Silva         Correcciones BenchMark            */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_renova_op')
   drop proc sp_renova_op        
go
create proc sp_renova_op  (          
      @s_ssn                  int             = NULL,
      @s_ssn_branch           int             = NULL,          
      @s_user                 login           = NULL,
      @s_term                 varchar(30)     = NULL,
      @s_date                 datetime        = NULL,
      @s_sesn                 int             = NULL,
      @s_srv                  varchar(30)     = NULL,
      @s_lsrv                 varchar(30)     = NULL,
      @s_ofi                  smallint        = NULL,
      @s_rol                  smallint        = NULL,
      @t_debug                char(1)         = 'N',
      @t_file                 varchar(10)     = NULL,
      @t_from                 varchar(32)     = NULL,
      @t_trn                  smallint        = NULL,
      @t_rty                  char(1)         = NULL,
      @i_cuenta               cuenta         = NULL,
      @i_cuenta_banco         cuenta         = NULL,
      @i_cuenta_ant           cuenta         = NULL,
      @i_descripcion       descripcion     = NULL,
      @i_en_linea             char(1)         = 'S',
      @i_fecha_proceso        datetime,
      @i_ley               char(1)        = NULL,
      @i_fecha_cal_tasa       datetime       = NULL,
      @i_tasa_efectiva        float           = 0,   --04-May-2000 Tasa Efec/Nom
      @i_flag_tasaefec        char(1)         = 'N', --04-May-2000 Tasa Efec/Nom
      @i_tasa_variable        char(1)         = 'N', --12-Abr-2000 TASA VARIABLE
      @i_mnemonico_tasa       catalogo        = NULL,--12-Abr-2000 TASA VARIABLE
      @i_modalidad_tasa       char(1)         = NULL,--12-Abr-2000 TASA VARIABLE
      @i_periodo_tasa         smallint        = NULL,--12-Abr-2000 TASA VARIABLE
      @i_descr_tasa           descripcion     = NULL,--12-Abr-2000 TASA VARIABLE
      @i_operador             char(1)         = NULL,--12-Abr-2000 TASA VARIABLE
      @i_spread               float           = 0,   --12-Abr-2000 TASA VARIABLE
      @i_puntos               float           = 0,   --12-Abr-2000 TASA VARIABLE
      @i_aut_spread           login           = NULL,--12-Abr-2000 TASA VARIABLE
      @i_tipcuenta            char(3)         = NULL,
      @i_inicio               int             = NULL,
      @i_fin                  int             = NULL,
      @i_operacion            int             = NULL,
      @i_diahabil             char(1)         = 'S',
      @i_fecha_valor          datetime        = NULL,
      @i_plazo_orig           int             = NULL,
      @i_cotizacion           float           = 1,
      @i_calldate             datetime        = NULL,
      @i_modifica             char(1)         = 'N',
      @i_desmaterializado     char(1)         = 'N',
      @o_operacion_new        cuenta     out
)
with encryption
as
declare @w_sp_name                      varchar(32),
        @w_error                        int,
        @w_toperacion                   varchar(6),
        @w_operacionpf                  int,
        @w_sec                          int,
        @w_return                       int,
        @w_fecha_hoy         datetime,
        @w_retiene_imp_capital          char(1),
        @w_impuesto_capital             money,                      
       
/*  Variables para la operacion anterior en Renovacion */
   @w_p_operacionpf                int,
   @w_cuenta                       cuenta,
   @w_moneda                       smallint,
   @w_estado                       catalogo,
/* Variables definidas para nuevo requerimiento del Banco ASB */
        @w_imp                          char(1),
        @w_mm_valor                     money,
        @w_mm_producto                  catalogo,
        @w_mm_cuenta                    cuenta,
        @w_mm_impuesto                  money,
        @w_mm_moneda                    tinyint,
        @w_tn_descripcion               varchar(7),
        @w_desc_ctacte                  varchar(30),
        @w_alt                          int,
        @w_en_oficial                   int,
        @w_contador                     int,
        @w_comprobante                  int,
        @w_debcred                      char(1),
        @w_codval                       tinyint,
        @w_ajuste_mn                    money,
        @w_ajuste_me                    money,
        @w_asiento                      smallint,
        @w_op_int_total_prov_vencida    money,
        @w_op_tipo_plazo                catalogo,
        @w_op_tipo_deposito             catalogo,
        @w_op_oficina                   int,
        @w_op_ente                      int,
        @w_op_fecha_ven                 datetime,
        @w_op_fpago                     catalogo,
        @w_op_moneda                    tinyint,
        @w_descripcion                  varchar(64),
        @w_cotizacion                   money,
        @w_sec_historia                 int 


select @w_sp_name = 'sp_renova_op'        
/*---------------------------------*/
/* Verificar codigo de Transaccion */
/*---------------------------------*/
if   @t_trn <> 14918 
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 141112
        return 1
end 
 
select @w_fecha_hoy = convert(datetime,convert(varchar,@i_fecha_proceso,101)) 
select @w_estado                    = op_estado,
       @w_op_ente                   = op_ente,
       @w_op_int_total_prov_vencida = op_int_total_prov_vencida,
       @w_op_fecha_ven              = op_fecha_ven,
       @w_op_fpago                  = op_fpago,
       @w_op_moneda                 = op_moneda,
       @w_op_tipo_deposito          = op_toperacion,
       @w_op_tipo_plazo             = op_tipo_plazo,
       @w_op_oficina                = op_oficina
  from pf_operacion 
 where op_num_banco = @i_cuenta_ant
   and op_operacion >= @i_inicio
   and op_operacion <= @i_fin
if @@rowcount = 0
begin
   select @w_error= 141051   
   goto ERROR
end  

select @w_alt = 1
------------------------
-- Validacion de cuenta 
------------------------       
if ltrim(rtrim(@i_cuenta_banco)) IS   NULL
begin
   select @i_cuenta_banco = @i_cuenta
end
begin tran
   ----------------------
   -- Operacion renovada
   ----------------------
   exec @w_return=sp_renova_ant
        @s_ssn                 = @s_ssn, 
         @s_ssn_branch          = @s_ssn_branch,
        @s_user                = @s_user,
        @s_sesn                = @s_sesn,
        @s_ofi                 = @s_ofi,
        @s_date                = @s_date,
        @t_trn                 = 14919,
        @s_srv                 = @s_srv, 
        @s_term                = @s_term,
        @t_file                = @t_file,
        @t_from                = @w_sp_name, 
        @t_debug               = @t_debug,
        @i_cuenta              = @i_cuenta_ant,
        @i_en_linea            = @i_en_linea,
   @i_fecha_proceso       = @w_fecha_hoy,
        @i_inicio              = @i_inicio,
        @i_fin                 = @i_fin,
        @i_alt                 = @w_alt,
        @o_retiene_imp_capital = @w_retiene_imp_capital out,
        @o_impuesto_capital    = @w_impuesto_capital out,
        @o_historia            = @w_sec_historia out
   if @w_return <> 0
   begin
      select @w_error= @w_return
      goto ERROR
   end
   if @i_cuenta IS   NULL
   begin
      select @w_p_operacionpf = op_operacion,
             @w_toperacion = op_toperacion,
             @w_moneda = op_moneda
        from pf_operacion 
       where op_num_banco = @i_cuenta_ant
          and op_operacion >= @i_inicio
          and op_operacion <= @i_fin
      if @@rowcount = 0
      begin
         select @w_error= 141051   
         goto ERROR
      end              

      ---------------------
      -- Nuevo Cambio Asb
      ---------------------
      select @w_operacionpf = @i_operacion
      select @w_cuenta      = @i_cuenta_banco
   end  
   else
   begin

      ---------------------
      -- Nuevo Cambio Asb
      ---------------------
      select @w_operacionpf = @i_operacion
      select @w_cuenta      = @i_cuenta_ant
   end
   /*-------------------------------------------------------------------*/
   /* Nuevo proceso para ASB-Todo debe verse reflejado en la cuenta NSI */
   /*-------------------------------------------------------------------*/
   --------------------------------------------------------------------
   -- Buscar Forma de pago sobre pf_mov_monet para afectacion a cuenta
   --------------------------------------------------------------------
   select @w_mm_valor                   = op_monto,
          @w_mm_producto                = mm_producto,
          @w_mm_cuenta                  = mm_cuenta,
          @w_mm_impuesto                = mm_impuesto,
          @w_mm_moneda                  = mm_moneda
     from pf_mov_monet,
          pf_operacion
    where mm_operacion = op_operacion
      and mm_operacion = @w_operacionpf
      and mm_tran      = 14901
      and mm_secuencia = (select max(mm_secuencia) 
                            from pf_mov_monet
                           where mm_operacion   = @w_operacionpf
                             and mm_tran        = 14901)
   ------------------------------------------------
   -- Evaluar si el producto retiene impuesto o no
   ------------------------------------------------
   if @w_mm_impuesto > 0
      select @w_imp = 'S'
   else
      select @w_imp = 'N'

   ---------------------------
   -- Nueva operacion renovada
   ---------------------------
   exec @w_return = sp_renova_act
        @s_ssn                 = @s_ssn, 
        @s_ssn_branch          = @s_ssn_branch,
        @s_user                = @s_user,
        @s_sesn                = @s_sesn,
        @s_ofi                 = @s_ofi,
        @s_date                = @s_date,
        @t_trn                 = 14920,
        @s_srv                 = @s_srv, 
        @s_term                = @s_term,
        @t_file                = @t_file,
        @t_from                = @w_sp_name,
        @t_debug               = @t_debug,
        @i_cuenta              = @w_cuenta,
        @i_cuenta_ant          = @i_cuenta_ant,
        @i_operacionpf         = @w_operacionpf,
        @i_en_linea            = @i_en_linea,
        @i_fecha_proceso       = @w_fecha_hoy,
        @i_descripcion         = @i_descripcion,
        @i_ley                 = @i_ley,
        @i_fecha_cal_tasa      = @i_fecha_cal_tasa,
        @i_estado_ant          = @w_estado,         -- Para Activacion 
        @i_impuesto_capital    = @w_impuesto_capital,
        @i_retiene_imp_capital = @w_retiene_imp_capital,
        @i_tasa_efectiva       = @i_tasa_efectiva,  --04-May-2000 Tasa Efec/Nom
        @i_flag_tasaefec       = @i_flag_tasaefec,  --04-May-2000 Tasa Efec/Nom
        @i_tasa_variable       = @i_tasa_variable,  --12-Abr-2000 TASA VARIABLE
        @i_mnemonico_tasa      = @i_mnemonico_tasa, --12-Abr-2000 TASA VARIABLE
        @i_modalidad_tasa      = @i_modalidad_tasa, --12-Abr-2000 TASA VARIABLE
        @i_periodo_tasa        = @i_periodo_tasa,   --12-Abr-2000 TASA VARIABLE
        @i_descr_tasa          = @i_descr_tasa,     --12-Abr-2000 TASA VARIABLE
        @i_operador            = @i_operador,       --12-Abr-2000 TASA VARIABLE
        @i_spread              = @i_spread,         --12-Abr-2000 TASA VARIABLE 
        @i_puntos              = @i_puntos,         --12-Abr-2000 TASA VARIABLE 
        @i_aut_spread          = @i_aut_spread,     --12-Abr-2000 TASA VARIABLE
        @i_tipcuenta           = @i_tipcuenta,
        @i_cuenta_banco        = @i_cuenta_banco,
        @i_inicio              = @i_inicio,
        @i_fin                 = @i_fin,
        @i_diahabil            = @i_diahabil,
        @i_plazo_orig          = @i_plazo_orig,
        @i_cotizacion          = @i_cotizacion,
        @i_calldate            = @i_calldate,
        -- @i_modifica            = @i_modifica,        -- GAL 31/AGO/2009 - CSQL
        @i_historia            = @w_sec_historia,
        @i_desmaterializar     = @i_desmaterializado

   if @w_return <> 0
   begin
      select @w_error = @w_return
      goto ERROR 
   end

   select @o_operacion_new = @w_cuenta
commit tran
return 0
-------------------
-- Manejo de Error
-------------------
ERROR:
  rollback tran 
  if @i_en_linea = 'N'
  begin

      set rowcount 0

      update pf_renovacion
      set re_estado = 'X' 
      where re_operacion= @w_operacionpf
      
      delete pf_rubro_op_i where roi_operacion  = @w_operacionpf

      delete pf_rubro_op_tmp where rot_operacion = @w_operacionpf

      update pf_operacion
      set op_accion_sgte = 'NULL',
          op_causa_mod   = 'NULL'
      where op_operacion = @w_operacionpf

      update pf_mov_monet 
      set mm_estado = 'E'
      where mm_tran      = 14904
      and mm_operacion = @w_operacionpf	
      and mm_estado    is null

      update pf_det_pago 
      set dp_estado       = 'E'   /*ERIKA se pone E en vez de I */
      where dp_operacion   = @w_operacionpf
      and dp_estado_xren = 'S'
      and dp_estado      = 'I'

     exec sp_errorlog 
          @i_fecha   = @s_date,
          @i_error   = @w_error, 
          @i_usuario = @s_user,
          @i_tran    = @t_trn,
          @i_cuenta  = @i_cuenta   
  end
  else
  begin
     exec cobis..sp_cerror 
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_error
  end
  return @w_error
go

