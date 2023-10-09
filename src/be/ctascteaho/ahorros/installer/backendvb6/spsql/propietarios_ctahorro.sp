/************************************************************************/
/*  Archivo:            propietarios_ctahorro.sp                        */
/*  Stored procedure:   sp_propietarios_ctahorro                        */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 16-Dic-1993                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de ingreso y eliminacion       */
/*  de propietarios de una cuenta corriente.                            */
/*  206 = Insercion de un nuevo cliente duenio de una ctahorro          */
/*  207 = Eliminacion de un cliente duenio de una ctahorro              */
/*  208 = Consulta del detalle de producto de una ctahorro              */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA       AUTOR         RAZON                                 */
/*  16/Dic/1993     P Mena        Emision inicial                       */
/*  02/May/2016     Juan Tagle    Migración a CEN                       */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_propietarios_ctahorro')
    drop proc sp_propietarios_ctahorro
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_propietarios_ctahorro (
    @s_ssn            int,
    @s_ssn_branch     int,
    @s_srv            varchar(30) = null,
    @s_lsrv           varchar(30) = null,
    @s_user           varchar(30) = null,
    @s_sesn           int,
    @s_term           varchar(10),
    @s_date           datetime,
    @s_org            char(1),
    @s_ofi            smallint,    /* Localidad origen transaccion */
    @s_rol            smallint = 1,
    @s_org_err        char(1) = null, /* Origen de error:[A], [S] */
    @s_error          int = null,
    @s_sev            tinyint = null,
    @s_msg            mensaje = null,
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_rty            char(1) = 'N',
    @t_trn            smallint,
    @t_show_version   bit = 0,
    @i_cta            cuenta,
    @i_mon            tinyint,
    @i_cli            int = null,
    @i_dprod          int = null,
    @i_rolcli         char(1) = null,
    @i_cedruc         varchar(30) = null,
    @i_turno          smallint = null,
    @o_det_prod       int = null out,
    @o_oficina_cta    smallint=null out
)
as
declare
    @w_return               int,
    @w_sp_name              varchar(30),
    @w_cuenta               int,
    @w_cliente              int,
    @w_est                  char(1),
    @w_oficina_cta          smallint,
    @w_cli                  int,
    @w_prod_banc            smallint,
    @w_tipocta_super        char(1)

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_propietarios_ctahorro'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @i_turno is null
    select @i_turno = @s_rol

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
        s_ssn       = @s_ssn,
        s_srv       = @s_srv,
        t_debug     = @t_debug,
        t_file      = @t_file,
        t_from      = @t_from,
        i_cta       = @i_cta,
        i_mon       = @i_mon,
        i_cli       = @i_cli,
        i_dprod     = @i_dprod,
        i_rolcli    = @i_rolcli,
        i_cedruc    = @i_cedruc
    exec cobis..sp_end_debug
end

if  @t_trn not in (296, 295, 208)
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201048
   return 1
end

/* Chequeo de existencias */
select
@w_cuenta        = ah_cuenta,
@w_est           = ah_estado,
@w_oficina_cta   = ah_oficina,
@w_tipocta_super =ah_tipocta_super,
@w_prod_banc     = ah_prod_banc
from  cob_ahorros..ah_cuenta
where ah_cta_banco = @i_cta
and   ah_moneda    = @i_mon

if @@rowcount <> 1
begin
   /* No existe cuenta_banco */
   exec cobis..sp_cerror
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_num       = 201004
   return 1
end

select @o_oficina_cta = @w_oficina_cta

/* Validaciones */
if @w_est <> 'A'
begin
  /* Cuenta no activa o cancelada */
   exec cobis..sp_cerror
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_num       = 251002
   return 1
end

/* Insercion de un nuevo cliente propietario de una ctacte */
if @t_trn = 296
begin
   select @w_cli = cl_cliente
   from  cobis..cl_cliente,
         cobis..cl_det_producto
   where cl_det_producto = @i_dprod
   and   cl_cliente      = @i_cli
   and   cl_det_producto = dp_det_producto
   if @@rowcount <> 0
   begin
      exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 253010
      return 1
   end

   begin tran
      exec @w_return = cobis..sp_in_cliente
      @i_cli        = @i_cli,
      @i_dprod      = @i_dprod,
      @i_rol        = @i_rolcli,
      @i_cedruc     = @i_cedruc,
      @i_fecha      = @s_date
      if @w_return <> 0
         return @w_return

      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tscliente_ctahorro (
      secuencial,  ssn_branch,   tipo_transaccion, tsfecha,      clase,
      usuario,     terminal,     oficina,          reentry,      origen,
      cta_banco,   moneda,       cliente,          det_producto, rol_cliente,
      cedula_ruc,  oficina_cta,  turno,            prod_banc,    tipocta_super)
      values (
      @s_ssn,     @s_ssn_branch, @t_trn,           @s_date,      'N',
      @s_user,    @s_term,       @s_ofi,           @t_rty,       @s_org,
      @i_cta,     @i_mon,        @i_cli,           @i_dprod,     @i_rolcli,
      @i_cedruc,  @w_oficina_cta,@i_turno,         @w_prod_banc, @w_tipocta_super)

      if @@error <> 0
      begin
         /* Error en creacion de transaccion de servicio */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203005
         return 1
      end
   commit tran
   return 0
end

/* Eliminacion de un cliente propietario de una ctacte */
if @t_trn = 295
begin
   select @w_cliente = en_ente
   from   cobis..cl_ente
   where  en_ente = @i_cli
   if @@rowcount = 0
   begin
      /* No existe ente */
      exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 101042
      return 101042
   end

   exec @w_return  = cob_interfase..sp_icte_firmantes
   @s_ssn        = @s_ssn,
   @s_srv        = @s_srv,
   @s_user       = @s_user,
   @s_sesn       = @s_sesn,
   @s_term       = @s_term,
   @s_date       = @s_date,
   @s_org        = @s_org,
   @s_ofi        = @s_ofi,
   @s_rol        = @s_rol,
   @s_org_err    = @s_org_err,
   @s_error      = @s_error,
   @s_sev        = @s_sev,
   @s_msg        = @s_msg,
   @s_lsrv       = @s_lsrv,
   @i_operacion = 'D',
   @i_producto  = 'AHO',     --Nemonico del producto cobis ('AHO', 'CTE')
   @i_cuenta    = @i_cta,    --string de la cuenta
   @i_moneda    = @i_mon,    --codigo moneda
   @i_ente      = @i_cli,    --cod_ente
   @t_trn        = 3030

   if @w_return <> 0
      return @w_return

   /* Creacion de transaccion de servicio */
   insert into cob_ahorros..ah_tscliente_ctahorro (
   secuencial,  ssn_branch, tipo_transaccion,  tsfecha,       clase,
   usuario,     terminal,   oficina,           reentry,       origen,
   cta_banco,   moneda,     cliente,           det_producto,
   oficina_cta, turno,      prod_banc,         tipocta_super)
   values (
   @s_ssn,         @s_ssn_branch, @t_trn,       @s_date,      'B',
   @s_user,        @s_term,       @s_ofi,       @t_rty,       @s_org,
   @i_cta,         @i_mon,        @i_cli,       @i_dprod,
   @w_oficina_cta, @i_turno,      @w_prod_banc, @w_tipocta_super)
   if @@error <> 0
   begin
      /* Error en creacion de transaccion de servicio */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
      return 1
   end
   return 0
end

/* Consulta del detalle de producto de una ctacte */
if @t_trn = 208
begin
   select @o_det_prod = dp_det_producto
   from   cobis..cl_det_producto
   where  dp_cuenta   = @i_cta
   and    dp_producto = 4
   and    dp_moneda   = @i_mon
end
return 0

go

