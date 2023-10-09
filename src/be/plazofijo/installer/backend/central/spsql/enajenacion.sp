/************************************************************************/
/*      Archivo:                enajenacion.sp                          */
/*      Stored procedure:       sp_enajenacion                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Yecid Martinez                          */
/*      Fecha de documentacion: 07/08/2009                              */
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
/*      Genera los comprobantes contables para la Enajenacion de opera- */
/*      ciones.                                                         */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR               RAZON                         */
/*      08-Jul-09     Y.Martinez          Emision Inicial               */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_enajenacion') IS NOT NULL
   drop proc sp_enajenacion
go

create proc sp_enajenacion
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@t_debug                 char(1)     = 'N',
@t_file                  varchar(10) = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_trn                  int             = 14248,
@i_operacion            varchar(2),
@i_descripcion          descripcion     = NULL,
@i_operacionpf          int,
@i_monto                money           = NULL,
@i_ente                 int             = NULL,
@i_tipo_cliente         varchar(10)     = NULL,
@o_comprobante          int             = NULL out
with encryption
as
declare @w_sp_name  descripcion,
@w_perfil               varchar(10),
@w_numdeci              tinyint,
@w_numdecicm            tinyint,
@w_numdecips            tinyint,
@w_usadeci              char(1),
@w_error                int,
@w_cotizacion_compra    money,
@w_cotizacion_venta     money,
@w_cotizacion_valor     money,
@w_cotizacion           money,
@w_descripcion          varchar(50),
@w_contador             smallint,
@w_cont                 smallint,
@w_cont_aux             smallint,
@w_codval               tinyint,
@w_codval_aux           tinyint,
@w_debcred              char(1),
@w_return               int,
@w_valor                money,
@w_valor_ext            money,
@w_valor_me             money,
@w_valor_ee             money,
@w_comprobante          int ,
@w_area_dest            smallint,
@w_area_orig            smallint,
@w_tot_deb              money,
@w_tot_cred             money,
@w_tot_deb_me           money,
@w_tot_cred_me          money,
@w_mm_subsecuencia      int,
@w_mm_producto          catalogo,
@w_mm_moneda            smallint,
@w_mm_cuenta            cuenta,
@w_mm_valor             money,
@w_mm_valor_ext         money,
@w_tasa                 float,
@w_flag                 tinyint,
@w_ente                 int,
@w_toperacion           catalogo,
@w_estado               catalogo,
@w_num_banco            cuenta,
@w_fpago                catalogo,
@w_numdias              int,
@w_moneda               tinyint,
@w_tipo_ente            catalogo,
@w_base_ee              money,
@w_impto_ee             float,
@w_cod_cons_ee          varchar(10),
@w_tplazo               catalogo,
@w_producto             tinyint,
@w_ofic_orig            smallint,
@w_tot_provcorrmonet    float,
@w_mon_sgte             int,
@w_pt_secuencia         tinyint,
@w_pt_beneficiario      int,
@w_sub_sec              tinyint,
@w_historia             smallint,
@w_operacionpf          int,
@w_retiene_capital      char(1),
@w_rol_deceval          tinyint,
@w_mig_aplicativo       smallint,
@w_fecha_jornada        datetime,
@w_tipo_jornada         char(1),
@w_fecha_aux            datetime,
@w_jornada_rol          char(1),
@w_op_oficina           smallint,
@w_total_int_retenido   money,
@w_forma_pago           catalogo,
@w_secuencial           int,
@w_tot_enajenado        money,
@w_suma_total           money,
@w_tipo_cliente         varchar(10),
@w_embargo				money


select   
@w_sp_name  = 'sp_enajenacion',
@w_valor    = 0,
@w_tot_deb  = 0,
@w_tot_cred = 0,
@w_flag = 0

select @w_ente = @i_ente

if @i_operacion = 'Q'
begin
   select   
   'Secuencial'      = convert(varchar(4),en_secuencial),
   'Fecha'           = convert(varchar(20),en_fecha),
   'Nombre Ente'     = (select convert(varchar(50),en_nomlar) from cobis..cl_ente where en_ente = E.en_ente),
   'Valor Enajenado' = convert(varchar(25),en_valor_enajenado),
   'Descripcion'     = convert(varchar(40),en_descripcion),
   'Usuario'         = convert(varchar(20),en_usuario),
   'Oficina'         = (select of_nombre from cobis..cl_oficina where of_oficina = E.en_oficina) --convert(varchar(10)en_oficina)
   from  pf_enajenacion E
   where en_operacion = @i_operacionpf

   select sum(en_valor_enajenado)
   from   pf_enajenacion E
   where  en_operacion = @i_operacionpf
end

if @i_operacion = 'I'
begin
   /*********************  Lectura de manjeo de decimales  ********************/

   select @w_usadeci = mo_decimales
   from   cobis..cl_moneda
   where  mo_moneda = @w_moneda

   if @w_usadeci = 'S'
   begin
      select @w_numdeci  = isnull(pa_tinyint,0)
      from   cobis..cl_parametro
      where  pa_nemonico    = 'DCI'
      and    pa_producto  = 'PFI'
   end
   else
      select @w_numdeci = 0
   /******************* consultamos operacion de Plazo Fijo *********************/
   select   
   @w_toperacion           = op_toperacion,
   @w_operacionpf          = op_operacion,
   @w_estado               = op_estado,
   @w_numdias              = op_num_dias,
   @w_num_banco            = op_num_banco,
   @w_historia             = op_historia,
   @w_moneda               = op_moneda,
   @w_fpago                = op_fpago,
   @w_tplazo               = op_tipo_plazo,
   @w_producto             = op_producto,
   @w_total_int_retenido   = op_total_int_retenido,   --*-*
   @w_mon_sgte             = op_mon_sgte,
   @w_op_oficina           = op_oficina,
   @w_embargo              = isnull(op_monto_blq, 0) + isnull(op_monto_blqlegal, 0) + isnull(op_monto_pgdo, 0) + isnull(op_monto_int_blqlegal, 0)
   from  cob_pfijo..pf_operacion
   where    op_operacion = @i_operacionpf

   if @@rowcount <= 0
   begin
      select @w_error = 145001
      goto ERROR
   end

   select   @w_descripcion = 'ENAJENACION(' + @w_num_banco + ')'

/*Validar que el titulo no tenga ningun Valor Bloqueado por Embargo*/
if @w_embargo > 0 
begin
      select @w_error = 141200
      goto ERROR
end      
   /*********************  Cotizacion para otras monedas *****************/

   if @w_moneda <> 0
   begin
      set rowcount 1

      select   
      @w_cotizacion_compra = ct_compra ,
      @w_cotizacion_venta  = ct_venta,
      @w_cotizacion_valor  = ct_valor
      from   cob_conta..cb_cotizacion
      where  ct_moneda = @w_moneda
      and    ct_fecha = @s_date
      
      if @@rowcount = 0
      begin
         select @w_error = 149051
         goto ERROR
      end

      select @w_cotizacion = @w_cotizacion_valor
      select @w_valor_ext    = round (@w_valor_me * @w_cotizacion, @w_numdecicm)

   end
   else
      select @w_cotizacion = 0


   --print 'ENAJENA @w_total_int_retenido %1!  @i_monto %2! ',@w_total_int_retenido, @i_monto


   /*********************  Validar montos enajenados anteriores ********************/

   select @w_tot_enajenado = isnull(sum(en_valor_enajenado), 0)
   from   pf_enajenacion
   where  en_operacion = @i_operacionpf

   select   @w_suma_total = @w_tot_enajenado + @i_monto

   --print '@w_suma_total %1! , @w_tot_enajenado %2! @w_total_int_retenido %3! ',  @w_suma_total, @w_tot_enajenado, @w_total_int_retenido

   if @w_suma_total  > @w_total_int_retenido
   begin
      select @w_error = 143064
      goto ERROR
   end

   select   @w_mm_subsecuencia   = 1

   -- Parametro que indica la forma de pago exigible para ser cobrado por orden de emision de pago

   select @w_forma_pago  = pa_char
   from   cobis..cl_parametro
   where  pa_nemonico    = 'VXP'
   and    pa_producto = 'PFI'

   if @@rowcount = 0 begin
      select @w_error = 141140
      goto ERROR
   end



   -- Inserccion de enajenacion

   select @w_secuencial = isnull(max(en_secuencial),0) + 1
   from   pf_enajenacion
   where  en_operacion =    @w_operacionpf

   --print 'enajenacion.sp  CUENTA %1! w_secuencial %2! ',@w_operacionpf, @w_secuencial

   begin tran  --*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

   insert into pf_enajenacion (
   en_operacion, en_secuencial,       en_fecha,
   en_ente,      en_valor_enajenado,  en_descripcion,
   en_usuario,   en_oficina)
   values(
   @w_operacionpf, @w_secuencial,    @s_date,
   @w_ente,        @i_monto,         @i_descripcion,
   @s_user,        @s_ofi)

   if @@error <> 0
   begin
      
      --PRINT ' ENAJENACION.SP ERROR AL INSERTAR EN ENAJENACION'
      select @w_error = 143061
      goto ERROR
   end


   if @i_tipo_cliente is null
      select @w_tipo_cliente = 'M'
   else
      select @w_tipo_cliente = @i_tipo_cliente


   -- Inserccion de movimiento monetario

   insert pf_mov_monet( 
   mm_operacion,     mm_tran,          mm_secuencia,
   mm_secuencial,    mm_sub_secuencia, mm_producto,
   mm_cuenta,        mm_valor,         mm_fecha_crea,
   mm_fecha_mod,     mm_tipo,          mm_moneda,
   mm_estado,        mm_beneficiario,  mm_fecha_aplicacion,
   mm_user,          mm_usuario,       mm_tipo_cliente)
   values      (  
   @w_operacionpf,   @t_trn,           @w_mon_sgte,
   0,                1,                @w_forma_pago,
   @w_num_banco,     @i_monto,         @s_date,
   NULL,             'C',              @w_moneda,
   NULL,             @w_ente,          null,
   @s_user,          @s_user,          @w_tipo_cliente)
   
   if @@error <> 0
   begin
      PRINT ' ENAJENACION.SP ERROR AL INSERTAR EN LA PF_MOV_MONET'
      select @w_error = 143022
      goto ERROR
   end


   exec  @w_return=sp_aplica_mov
   @s_ssn      = @s_ssn,
   @s_user     = @s_user,
   @s_ofi      = @s_ofi,
   @s_date     = @s_date,
   @s_srv      = @s_srv,
   @s_term     = @s_term,
   @t_trn      = @t_trn,
   @i_operacionpf    = @w_operacionpf,
   @i_fecha_proceso  = @s_date ,
   @i_secuencia      = @w_mon_sgte ,
   @i_tipo           = 'N',
   @i_sub_secuencia  = 1,
   @i_en_linea       = 'S'

   if @w_return <> 0
   begin
      rollback tran
      return @w_return
   end


   exec @w_return = cob_pfijo..sp_aplica_conta
   @s_date           = @s_date,
   @s_user           = @s_user,
   @s_term           = @s_term,
   @i_fecha          = @s_date,
   @i_tran           = @t_trn,
   @i_operacionpf    = @i_operacionpf,
   @i_afectacion     = 'N',
   @i_impuesto       = @i_monto,
   @i_secuencia      = @w_mon_sgte,
   @o_comprobante    = @o_comprobante out
   
   if @w_return <> 0
   begin
      --print '-- Error en contabilizacion enajenacion de la operacion       '
      select @w_error = 148068
      goto ERROR
   end

   /**  INSERCION HISTORICO **/
   insert pf_historia ( 
   hi_operacion,     hi_secuencial,    hi_fecha,
   hi_trn_code,      hi_valor,         hi_funcionario,
   hi_oficina,       hi_observacion,   hi_fecha_crea,
   hi_fecha_mod)
   values      (  
   @w_operacionpf,   @w_historia,      @s_date,
   @t_trn,           @i_monto,         @s_user,
   @s_ofi,           @i_descripcion,   @s_date,
   @s_date)
   if @@error <> 0
   begin
      select @w_error = 143006
      goto ERROR
   end

   select   @w_mon_sgte       = @w_mon_sgte + 1
   select   @w_historia       = @w_historia + 1

   update pf_operacion set
   op_mon_sgte = @w_mon_sgte,
   op_historia = @w_historia
   where op_operacion   = @w_operacionpf

   if @@error <> 0
   begin
      select @w_error = 143006
      goto ERROR
   end

   commit tran
end


return 0

ERROR:

if @@trancount > 0 rollback tran

--print 'ENAJENACION.SP error @w_error   %1!'+ cast(@w_error  as varchar)
 exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error
      return @w_error
go

