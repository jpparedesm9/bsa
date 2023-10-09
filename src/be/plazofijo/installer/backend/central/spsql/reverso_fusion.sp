/************************************************************************/
/*      Archivo:                revfusion.sp                            */
/*      Stored procedure:       sp_reverso_fusion                       */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Katty Tamayo                            */
/*      Fecha de documentacion: 01/Mar/05                               */
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
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      necesarias para reversar una cancelacion                        */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR            RAZON                               */
/*      01/Mar/05 Katty Tamayo      Emisi¢n Inicial                     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_reverso_fusion')
   drop proc sp_reverso_fusion
go

create proc sp_reverso_fusion (
   @s_ssn            int         = NULL,
   @s_user           login       = NULL,
   @s_sesn           int         = NULL,
   @s_term           varchar(30) = NULL,
   @s_date           datetime    = NULL,
   @s_srv            varchar(30) = NULL,
   @s_lsrv           varchar(30) = NULL,
   @s_ofi            smallint    = NULL,
   @s_rol            smallint    = NULL,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(10) = NULL,
   @t_from           varchar(32) = NULL,
   @t_trn            smallint,
   @i_operacion      char(1)     = NULL,   
   @i_id_operacion   int,
   @i_oficina        int         = NULL
)
with encryption
as
declare @w_sp_name                varchar(32),
        @w_return                 int,
        @w_observacion            descripcion,
        @w_id_operacion           int, 
        @w_num_banco              cuenta,
        @v_estado                 catalogo,
        @w_estado                 catalogo,
        @v_historia               smallint,
        @w_monto                  money,
        @v_accion_sig             catalogo,
        @w_accion_sig             catalogo,
        @v_fecha_mod              datetime,
        @v_mon_sgte               smallint,
        @w_num_banco_fusionada    cuenta,
        @w_estado_fusionada       catalogo,
        @v_estado_fusionada       catalogo,
        @v_historia_fusionada     smallint,
        @w_monto_fusionada        money,
        @v_accion_sig_fusionada   catalogo,
        @w_accion_sig_fusionada   catalogo,
        @v_fecha_mod_fusionada    datetime,
        @v_mon_sgte_fusionada     smallint,

/* Variables para pf_mov_monet*/
        @w_sec                      int, 
        @w_mt_sub_secuencia         tinyint,
        @w_mt_producto              catalogo,
        @w_mt_cuenta                cuenta,
        @w_mt_tipo                  char(1),
        @w_mt_beneficiario          int,
        @w_mt_impuesto              money,
        @w_mt_moneda                int,
        @w_mt_valor_ext             money,
        @w_mt_fecha_crea            datetime,
        @w_mt_fecha_mod             datetime,
        @w_mt_valor                 money,
        @w_mt_impuesto_capital_me   money,
        @w_mt_tipo_cliente          char(1),
        @w_mt_autorizado            char(1),
        @w_mt_cotizacion            money, 
        @w_mt_tipo_cotiza           char(1)


/* Inicializaci¢n de Variables */
/*******************************/
select @w_sp_name = 'sp_reverso_fusion',
       @v_estado = 'CAN',
       @w_estado = 'ACT',
       @v_estado_fusionada = 'ACT',
       @w_estado_fusionada = 'ANU',
       @w_observacion = 'REVERSO DE CONSOLIDACION',
       @w_accion_sig  = 'NULL',
       @w_accion_sig_fusionada = 'NULL'

/* Codigos de Transacciones */
/****************************/
if (@t_trn <> 14457 and @i_operacion = 'Q') or
   (@t_trn <> 14986 and @i_operacion is null)
begin
   exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 141112
      /*'Error en codigo de transaccion'*/
   return 1
end


/* Chequeo de Existencias */
/**************************/
if @i_operacion = 'Q' 
begin

   if not exists(select * from pf_fusfra where fu_operacion_new = @i_id_operacion 
            and fu_estado = 'A' and fu_descripcion = 'FUSION')
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_msg    = 'Operación invalida para reverso de consolidación',
         @i_num   = 141051
      return 1 
   end

   select   'NUMERO DE OPERACION' = op_num_banco,
      'VALOR'               = op_monto,
      'TASA'                = fu_tasa,
      'PLAZO'               = fu_plazo,
      'TIPO OPERACION'      = fu_toperacion,
      'DESCRIPCION TIPO OPERACION' = td_descripcion,
      'TITULAR'             = op_descripcion,   --+-+fu_nomlar,
      'CODIGO TITULAR'      = op_ente, 
      'CODIGO OPERACION'    = op_operacion,
      'CODIGO OFICINA'      = op_oficina,
      'CODIGO MONEDA'       = op_moneda,
      'SECUENCIA MOV MONET' = op_mon_sgte
   from pf_fusfra, pf_operacion, pf_tipo_deposito
   where fu_operacion_new = @i_id_operacion
      and fu_operacion     = op_operacion
      and fu_toperacion    = td_mnemonico
      and fu_estado        = 'A'
   order by fu_secuencial
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 1
      /* ERROR : NO EXISTE OPERACION */
   end

   select 'COD MONEDA NAC' = pa_tinyint
   from cobis..cl_parametro
   where pa_nemonico = 'CMNAC'
      and pa_producto = 'ADM'   
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141140
      return 1
   end
   return 0
end
else
begin
   select @w_sec = 0

   select @w_num_banco_fusionada  = op_num_banco,
      @w_monto_fusionada      = op_monto,
      @v_historia_fusionada   = op_historia,
      @v_accion_sig_fusionada = op_accion_sgte,
      @v_fecha_mod_fusionada  = op_fecha_mod,
      @v_mon_sgte_fusionada   = op_mon_sgte
   from pf_operacion 
   where op_operacion = @i_id_operacion
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 1
      /* ERROR : NO EXISTE OPERACION */
   end

   begin tran  --************************************************************************************
   
   declare reverso_fusion  cursor
   for select  fu_operacion,
         op_num_banco,
         op_historia,
         op_monto,
         op_accion_sgte,
         op_fecha_mod,
         op_mon_sgte
   from pf_fusfra, 
   pf_operacion
   where fu_operacion_new = @i_id_operacion
      and fu_operacion     = op_operacion
      and op_estado        = @v_estado

   open   reverso_fusion
   fetch reverso_fusion into 
         @w_id_operacion,  @w_num_banco,
         @v_historia,      @w_monto,
         @v_accion_sig,    @v_fecha_mod,
         @v_mon_sgte
   
   while @@FETCH_STATUS = 0
   begin
      select   @w_mt_sub_secuencia = mt_sub_secuencia,
         @w_mt_producto      = mt_producto,
         @w_mt_cuenta        = mt_cuenta,
         @w_mt_valor         = mt_valor,
         @w_mt_tipo          = mt_tipo,
         @w_mt_beneficiario  = mt_beneficiario,
         @w_mt_impuesto      = mt_impuesto,
         @w_mt_moneda        = mt_moneda,
         @w_mt_valor_ext     = mt_valor_ext,
         @w_mt_fecha_crea    = mt_fecha_crea,
         @w_mt_fecha_mod     = mt_fecha_mod,
         @w_mt_impuesto_capital_me = mt_impuesto_capital_me,
         @w_mt_tipo_cliente  = mt_tipo_cliente,
         @w_mt_autorizado    = mt_autorizado,
         @w_mt_cotizacion    = mt_cotizacion,
         @w_mt_tipo_cotiza   = mt_tipo_cotiza
      from pf_mov_monet_tmp
      where mt_usuario   = @s_user
         and mt_sesion    = @s_sesn
         and mt_operacion = @w_id_operacion
      if @@rowcount = 0
         break

      select @w_sec = @w_sec + 1

      insert pf_mov_monet (mm_operacion, mm_tran, mm_secuencia, mm_secuencial, mm_sub_secuencia, 
                           mm_fecha_aplicacion, mm_producto, mm_cuenta, mm_valor, mm_estado,
                           mm_tipo, mm_beneficiario, mm_impuesto, mm_moneda, mm_valor_ext,
                           mm_fecha_crea, mm_fecha_mod, mm_impuesto_capital_me, mm_user, 
                           mm_tipo_cliente, mm_autorizado, mm_cotizacion, mm_tipo_cotiza, mm_oficina,
                           mm_usuario,mm_fecha_valor,mm_fecha_real)
      values (@w_id_operacion, @t_trn, @v_mon_sgte, @s_ssn, @w_mt_sub_secuencia,
                           @s_date, @w_mt_producto, @w_mt_cuenta, @w_mt_valor, 'A',
                           'B', @w_mt_beneficiario, @w_mt_impuesto, @w_mt_moneda, @w_mt_valor_ext,
                           @s_date, @s_date, @w_mt_impuesto_capital_me, @s_user, 
                           @w_mt_tipo_cliente, @w_mt_autorizado, @w_mt_cotizacion, @w_mt_tipo_cotiza, @i_oficina,
                           @s_user,@s_date,getdate())
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 143021
         return 1
      end

      insert into ts_mov_monet (secuencial, tipo_transaccion, clase, fecha, usuario,
                                terminal, srv, lsrv, operacion, transaccion, 
                                secuencia, sub_secuencia, producto, cuenta, valor,
                                tipo, beneficiario, impuesto, moneda, valor_ext,
                                fecha_crea, fecha_mod, estado)
      values (@s_ssn, @t_trn, 'N', @s_date, @s_user,
                                @s_term, @s_srv, @s_lsrv, @w_id_operacion, @t_trn,
                                @w_sec, @w_mt_sub_secuencia, @w_mt_producto, @w_mt_cuenta, @w_mt_valor,
                                @w_mt_tipo, @w_mt_beneficiario, @w_mt_impuesto, @w_mt_moneda, @w_mt_valor_ext, 
                                @s_date, @s_date, null)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug       = @t_debug,
            @t_file        = @t_file,
            @t_from        = @w_sp_name,
            @i_num         = 143005
         return 1
      end

      update pf_fusfra
      set   fu_estado     = 'R',
         fu_estado_ant = fu_estado
      where fu_operacion  = @w_id_operacion
         and fu_estado     = 'A'
         and fu_operacion_new = @i_id_operacion
      if @@error  <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 145049
            --Error en actualizacion de estado de fusi¢n-fraccionamiento
         return 1
      end

      update pf_operacion 
      set   op_estado      = @w_estado,
         op_historia    = @v_historia + 1,
         op_accion_sgte = @w_accion_sig,
         op_fecha_mod   = @s_date,
         op_fecha_cancela = NULL,   --+-+
         op_mon_sgte    = @v_mon_sgte + 1   
      where op_num_banco = @w_num_banco
         and op_estado    = @v_estado
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num = 145001
         return 1
      end
      
      --Actualiza cuotas a vigentes
      update pf_cuotas
      set cu_estado = 'V'
      where cu_operacion = @w_id_operacion
      and cu_estado = 'F'     
      

      /*Inserci¢n transacci¢n de servicio previo*/
      insert ts_operacion (secuencial, tipo_transaccion, clase,
                           usuario, terminal, srv, lsrv, fecha, num_banco, 
                           operacion, historia, estado, fecha_mod,
                           descripcion, accion_sgte, mon_sgte)
      values (@s_ssn, @t_trn,'P',
                           @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco,
                           @w_id_operacion, @v_historia, @v_estado, @v_fecha_mod, 
                           @w_observacion, @v_accion_sig, @v_mon_sgte)
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num = 143005
         return 1
      end

      /*Inserci¢n transacci¢n de servicio actualizado*/
      insert ts_operacion (secuencial, tipo_transaccion, clase,
                           usuario, terminal, srv, lsrv, fecha, num_banco, 
                           operacion, historia, estado, fecha_mod, 
                           descripcion, accion_sgte, mon_sgte)
      values (@s_ssn, @t_trn,'A',
                           @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco,
                           @w_id_operacion, @v_historia + 1, @w_estado, @s_date, 
                           @w_observacion, @w_accion_sig, @v_mon_sgte + 1) 
      if @@error <> 0
      begin
         exec cobis..sp_cerror 
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num = 143005
         return 1
      end

      exec @w_return = sp_aplica_conta
      @i_anulacion     = 'S',
      @i_operacionpf   = @w_id_operacion,
      @i_tipo_trn      = 'CAN',
      @i_fecha         = @s_date

      if @w_return <> 0 begin
         rollback tran
         close reverso_fusion
         deallocate  reverso_fusion
         exec cobis..sp_cerror
         @t_from          = @w_sp_name,
         @i_num           = @w_return
   
         return @w_return
      end

      /*Inserci¢n de hist¢rico*/
      insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
                          hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
                          hi_observacion, hi_fecha_crea, hi_fecha_mod) 
      values (@w_id_operacion, @v_historia, @s_date,
                          @t_trn,@w_monto, @s_user, @s_ofi, 
                          @w_observacion, @s_date, @s_date)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num = 143006
         return 1
      end
        
      fetch reverso_fusion into  @w_id_operacion, 
                                @w_num_banco,   @v_historia,
                                @w_monto, @v_accion_sig,
                                @v_fecha_mod,   @v_mon_sgte
   end --del while
   
   if @@FETCH_STATUS = -2
   begin   
      close reverso_fusion
      deallocate reverso_fusion
      raiserror ('200001 - Fallo lectura del cursor reverso_fusion', 16, 1)
      return 0
   end

   close reverso_fusion
   deallocate reverso_fusion

   select   @w_mt_sub_secuencia = mt_sub_secuencia,
      @w_mt_producto      = mt_producto,
      @w_mt_cuenta        = mt_cuenta,
      @w_mt_valor         = mt_valor,
      @w_mt_tipo          = mt_tipo,
      @w_mt_beneficiario  = mt_beneficiario,
      @w_mt_impuesto      = mt_impuesto,
      @w_mt_moneda        = mt_moneda,
      @w_mt_valor_ext     = mt_valor_ext,
      @w_mt_fecha_crea    = mt_fecha_crea,
      @w_mt_fecha_mod     = mt_fecha_mod,
      @w_mt_impuesto_capital_me = mt_impuesto_capital_me,
      @w_mt_tipo_cliente  = mt_tipo_cliente,
      @w_mt_autorizado    = mt_autorizado,
      @w_mt_cotizacion    = mt_cotizacion,
      @w_mt_tipo_cotiza   = mt_tipo_cotiza
   from pf_mov_monet_tmp
   where mt_usuario   = @s_user
      and mt_sesion    = @s_sesn
      and mt_operacion = @i_id_operacion
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 1
      /* ERROR : NO EXISTE OPERACION */
   end

   select @w_sec = @w_sec + 1

   insert pf_mov_monet (mm_operacion, mm_tran, mm_secuencia, mm_secuencial, mm_sub_secuencia, 
                           mm_fecha_aplicacion, mm_producto, mm_cuenta, mm_valor, mm_estado,
                           mm_tipo, mm_beneficiario, mm_impuesto, mm_moneda, mm_valor_ext,
                           mm_fecha_crea, mm_fecha_mod, mm_impuesto_capital_me, mm_user, 
                           mm_tipo_cliente, mm_autorizado, mm_cotizacion, mm_tipo_cotiza, mm_oficina,
                           mm_usuario,mm_fecha_valor,mm_fecha_real)
   values (@i_id_operacion, @t_trn, @v_mon_sgte_fusionada, @s_ssn, @w_mt_sub_secuencia,
                           @s_date, @w_mt_producto, @w_mt_cuenta, @w_mt_valor, 'A',
                           'B', @w_mt_beneficiario, @w_mt_impuesto, @w_mt_moneda, @w_mt_valor_ext,
                           @s_date, @s_date, @w_mt_impuesto_capital_me, @s_user, 
                           @w_mt_tipo_cliente, @w_mt_autorizado, @w_mt_cotizacion, @w_mt_tipo_cotiza, @i_oficina,
                           @s_user,@s_date,getdate())
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143021
      return 1
   end

   insert into ts_mov_monet (secuencial, tipo_transaccion, clase, fecha, usuario,
                                terminal, srv, lsrv, operacion, transaccion, 
                                secuencia, sub_secuencia, producto, cuenta, valor,
                                tipo, beneficiario, impuesto, moneda, valor_ext,
                                fecha_crea, fecha_mod, estado)
   values (@s_ssn, @t_trn, 'N', @s_date, @s_user,
                                @s_term, @s_srv, @s_lsrv, @w_id_operacion, @t_trn,
                                @w_sec, @w_mt_sub_secuencia, @w_mt_producto, @w_mt_cuenta, @w_mt_valor,
                                @w_mt_tipo, @w_mt_beneficiario, @w_mt_impuesto, @w_mt_moneda, @w_mt_valor_ext, 
                                @s_date, @s_date, null)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug       = @t_debug,
         @t_file        = @t_file,
         @t_from        = @w_sp_name,
         @i_num         = 143005
      return 1
   end   

   /* Reverso de Comprobantes Contables */
   update pf_relacion_comp
   set rc_estado    = 'R'
   where rc_num_banco = @w_num_banco_fusionada
      and rc_tran      = 'FUS'
      and rc_estado    = 'N'

   update pf_scomprobante 
   set sc_estado = 'R'
   from pf_relacion_comp 
   where sc_comprobante = rc_comp
      and sc_estado = 'I'
      and rc_estado = 'R'
      and rc_tran   = 'FUS'
      and rc_num_banco = @w_num_banco_fusionada
   if @@error  <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 143041
      return 1
   end

   exec @w_return = sp_aplica_conta
   @i_anulacion     = 'S',
   @i_operacionpf   = @i_id_operacion,
   @i_tipo_trn      = 'APE',
   @i_fecha         = @s_date

   if @w_return <> 0 begin
      rollback tran
      exec cobis..sp_cerror
      @t_from          = @w_sp_name,
      @i_num           = @w_return
   
      return @w_return
   end

   update pf_operacion 
   set op_estado      = @w_estado_fusionada,
      op_historia    = @v_historia_fusionada + 1,
      op_accion_sgte = @w_accion_sig_fusionada,
      op_fecha_mod   = @s_date,
      op_mon_sgte    = @v_mon_sgte_fusionada + 1    
   where op_operacion = @i_id_operacion
      and op_estado    = @v_estado_fusionada
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141051
      return 1
      /* ERROR : NO EXISTE OPERACION */
   end


   /*Inserci¢n transacci¢n de servicio previo*/
   insert ts_operacion (secuencial, tipo_transaccion, clase,
                        usuario, terminal, srv, lsrv, fecha, num_banco, 
                        operacion, historia, estado, fecha_mod,
                        descripcion, accion_sgte, mon_sgte)
   values (@s_ssn, @t_trn,'P',
                        @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco_fusionada,
                        @i_id_operacion,  @v_historia_fusionada, @v_estado_fusionada, @v_fecha_mod_fusionada, 
                        @w_observacion, @v_accion_sig_fusionada, @v_mon_sgte_fusionada)
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num = 143005
      return 1
   end

   /*Inserci¢n transacci¢n de servicio actualizado*/
   insert ts_operacion (secuencial, tipo_transaccion, clase,
                        usuario, terminal, srv, lsrv, fecha, num_banco, 
                        operacion, historia, estado, fecha_mod,
                        descripcion, accion_sgte, mon_sgte)
   values (@s_ssn, @t_trn,'A',
                        @s_user, @s_term, @s_srv, @s_lsrv, @s_date, @w_num_banco_fusionada,
                        @i_id_operacion, @v_historia_fusionada + 1, @w_estado_fusionada, @s_date, 
                        @w_observacion, @w_accion_sig_fusionada, @v_mon_sgte_fusionada + 1) 
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num = 143005
      return 1
   end

   /*Inserci¢n de hist¢rico*/
   insert pf_historia (hi_operacion, hi_secuencial, hi_fecha,
                       hi_trn_code, hi_valor, hi_funcionario, hi_oficina,
                       hi_observacion, hi_fecha_crea, hi_fecha_mod) 
   values (@i_id_operacion, @v_historia_fusionada, @s_date,
                       @t_trn,@w_monto_fusionada, @s_user, @s_ofi, 
                       @w_observacion, @s_date, @s_date)
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num = 143006
      return 1
   end

   delete pf_mov_monet_tmp 
   where mt_usuario = @s_user 
   and mt_sesion = @s_sesn
 
   commit tran --*************************************************************************************
 
   return 0
end

return 0
go


