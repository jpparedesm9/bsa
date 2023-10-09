/************************************************************************/
/*  Archivo:            solicita_ec_ah.sp                               */
/*  Stored procedure:   sp_solicita_ec_ah                               */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 07-Dic-1993                                     */
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
/*              PROPOSITO                                               */
/*  Este programa realiza la transaccion de solicitud de emision        */
/*  de estado de cuenta de ahorros.                                     */
/*  234 = Solicitud del estado de cuenta de ahorros.                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA         AUTOR        RAZON                                    */
/*  07/Dic/1993   P Mena       Emision inicial                          */
/*  20/Dic/1994   J. Bucheli   Personalizacion para Banco de            */
/*                             la Produccion                            */
/*  23/Sep/1998   S. Gonzalez  Personalizacion Banco del Caribe         */
/*  14/Mar/2000   M. Sanguino  Personalizacion Banco del Caribe         */
/*  24/Mar/2005   L. Bernuil   Personalizaci¢n de Costos                */
/*  02/May/2016   Juan Tagle   Migración a CEN                          */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_solicita_ec_ah')
   drop proc sp_solicita_ec_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_solicita_ec_ah (
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
    @t_show_version   bit     = 0,
    @i_filial         tinyint,
    @i_cta            cuenta,
    @i_mon            tinyint,
    @i_fecha_ini      smalldatetime,
    @i_fecha_fin      smalldatetime,
    @i_turno          smallint = null,
    @o_oficina_cta    smallint=null out
)
as
declare @w_return       int,
   @w_sp_name           varchar(30),
   @w_est               char(1),
   @w_cuenta            int,
   @w_cta_banco         cuenta,
   @w_categoria         char(1), /* Para la Personalizacion */
   @w_valor_cobro       money,
   @w_personalizada     char(1),
   @w_tipo_def          char(1),
   @w_default           int,
   @w_rol_ente          char(1),
   @w_promedio1         money,
   @w_prod_banc         money,
   @w_tipo_ente         char(1),
   @w_saldo_contable    money,
   @w_saldo_para_girar  money,
   @w_disponible        money,
   @w_funcionario       char(1),
   @w_oficina_cta       smallint,
   @w_transacciones     int,
   @w_diario            int,
   @w_historico         int,
   @w_factor            int,
   @w_total             int,
   @w_valor_fijo        money,
   @w_mensaje           mensaje,
   @w_tipocta_super     char(1)

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_solicita_ec_ah'

--- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

if @i_turno is null
    select @i_turno = @s_rol

/* Validacion del codigo de transaccion */
if  @t_trn <> 234
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num   = 201048
   return 1
end


/*Parametro Correspondiente al numero de transaciones*/

select @w_transacciones = pa_smallint
 from cobis..cl_parametro
where pa_producto = 'AHO'
 and pa_nemonico = 'NTEA'
if @@rowcount <> 1
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201196
   return 1
end

/* Obtencion de datos de la cuenta */

select  @w_cuenta   = ah_cuenta,
    @w_est      = ah_estado,
        @w_funcionario  = ah_cta_funcionario,
    @w_oficina_cta  = ah_oficina
from  cob_ahorros..ah_cuenta
where ah_cta_banco = @i_cta
  and ah_moneda = @i_mon
if @@rowcount <> 1
begin
  /* No existe cuenta_banco */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 251001
   return 1
end

select @o_oficina_cta = @w_oficina_cta

/* Verificacion de cuentas de funcionarios para oficiales autorizados */
if @w_funcionario = 'S'
  begin
    if not exists ( select 1
                      from cob_remesas..re_ofi_personal,
                           cobis..cc_oficial,
                           cobis..cl_funcionario
                     where fu_login = @s_user
                       and fu_funcionario = oc_funcionario
                       and op_oficial = oc_oficial)
      begin
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 201123
        return 1
      end
  end

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

/* Calcular el saldo */
exec @w_return = cob_ahorros..sp_ahcalcula_saldo
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_cuenta       = @w_cuenta,
                        @i_fecha        = @s_date,
                        @o_saldo_para_girar = @w_saldo_para_girar out,
                        @o_saldo_contable   = @w_saldo_contable out
if @w_return <> 0
        return @w_return


select  @w_categoria     = ah_categoria,
    @w_tipo_def      = ah_tipo_def,
    @w_default       = ah_default,
    @w_rol_ente      = ah_rol_ente,
    @w_personalizada = ah_personalizada,
    @w_prod_banc     = ah_prod_banc,
    @w_tipo_ente     = ah_tipocta,
    @w_promedio1     = ah_promedio1,
    @w_disponible    = ah_disponible,
    @w_tipocta_super = ah_tipocta_super
  from  cob_ahorros..ah_cuenta
 where  ah_cuenta = @w_cuenta

 /*Personalizacion Costo por numero de Transacciones*/

/* Encuentra el costo por solicitud estado de cuenta on line */
   exec @w_return = cob_remesas..sp_genera_costos
    @i_filial       = @i_filial,
    @i_oficina      = @w_oficina_cta,
        @i_categoria            = @w_categoria,
        @i_tipo_ente            = @w_tipo_ente,
        @i_rol_ente             = @w_rol_ente,
        @i_tipo_def             = @w_tipo_def,
        @i_prod_banc            = @w_prod_banc,
        @i_producto             = 4,
        @i_moneda               = @i_mon,
        @i_tipo                 = 'R',
        @i_codigo               = @w_default,
        @i_servicio             = 'SECU',
        @i_rubro                = '15',
        @i_disponible           = @w_disponible,
        @i_contable             = @w_saldo_contable,
        @i_promedio             = @w_promedio1,
        @i_valor                = 1,
        @i_personaliza          = @w_personalizada,
        @i_fecha                = @s_date,
        @o_valor_total          = @w_valor_cobro out
        if @w_return <> 0
           return @w_return

--   select @w_valor_cobro = @w_valor_cobro * @w_factor

/* Inicio de la transaccion como tal */
begin tran
      /* Creacion de transaccion de servicio */
      insert into cob_ahorros..ah_tssolicita_ec
           (secuencial, ssn_branch, tipo_transaccion, tsfecha,
        usuario, terminal, oficina, reentry, origen,
        cta_banco, moneda, oficina_cta,
        turno, prod_banc,tipocta_super)
    values (@s_ssn, @s_ssn_branch, @t_trn, @s_date,
        @s_user, @s_term, @s_ofi, @t_rty, @s_org,
        @i_cta, @i_mon, @w_oficina_cta,
        @i_turno,@w_prod_banc,@w_tipocta_super)
      if @@error <> 0
      begin
     /* Error en creacion de transaccion de servicio */
     exec cobis..sp_cerror
          @t_debug  = @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 203005
     return 1
      end

      if @w_valor_cobro > 0
      begin
           /* Generacion de la Nota de Debito */
           exec @w_return = cob_ahorros..sp_ahndc_automatica
                @s_srv         = @s_srv,
                @s_ofi         = @s_ofi,
                @s_ssn         = @s_ssn,
                @s_ssn_branch  = @s_ssn_branch,
                @s_rol         = @s_rol,
                @s_user        = @s_user,
                @s_term        = @s_term,
                @t_trn         = 264,
                @i_cta         = @i_cta,
                @i_val         = @w_valor_cobro,
                @i_cau         = '92',
                @i_mon         = @i_mon,
                @i_alt         = 10,
                @i_fecha       = @s_date,
                @i_imp         = 'S',
                @i_turno       = @i_turno,
                @i_cobiva      = 'S'

      if @w_return <> 0
         begin

           select @w_mensaje = 'Error al genera la nota de debito por cobro'

           exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 203078,
            @i_sev      = 1,
            @i_msg      = @w_mensaje

            return @w_return
         end

      end

commit tran
return 0

go

