/************************************************************************/
/* ARCHIVO:         rtacifin.sp                                         */
/* NOMBRE LOGICO:   sp_consulta_rta_cifin                               */
/* PRODUCTO:        AHORROS                                             */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/* Realiza la consulta de la respuesta de la solicitud de               */
/* marcación y desmarcación enviada a CIFIN para una cuenta.            */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/* FECHA       AUTOR               RAZON                                */
/* 21-02-12    Luis Carlos Moreno  Emisión Inicial - Req: 315           */
/* 05/May/2016 T. Baidal   Migracion a CEN                              */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_consulta_rta_cifin')
           drop proc sp_consulta_rta_cifin
go

create proc sp_consulta_rta_cifin
(
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @t_trn          smallint = null,
  @s_ssn          int = null,
  @s_srv          varchar(30) = null,
  @s_sesn         int = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @t_show_version bit = 0,
  @i_cuenta       cuenta
)
as
  --  DECLARACION DE VARIABLES DE USO INTERNO
  declare
    @w_sp_name      varchar(32),
    @w_error        int,
    @w_tipo_ced     char(2),
    @w_cedula       char(15),
    @w_secuencial   int,
    @w_tipo_ide     varchar(16),
    @w_num_ide      varchar(20),
    @w_cliente      varchar(254),
    @w_est_ide      varchar(30),
    @w_fec_exp_ide  varchar(10),
    @w_lug_exp_ide  varchar(30),
    @w_msg_exencion varchar(260),
    @w_tipo_ent     varchar(10),
    @w_nom_ent      varchar(100),
    @w_num_cuenta   varchar(24),
    @w_oficina      varchar(100),
    @w_est_cuenta   varchar(2),
    @w_fec_ini_exe  varchar(10),
    @w_fec_fin_exe  varchar(10),
    @w_tipo_cuenta  varchar(64),
    @w_concepto     varchar(65),
    @w_usuario      varchar(20)

  --  INCIALIZACION DE VARIABLES
  select
    @w_sp_name = 'sp_consulta_rta_cifin'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --  CONSULTAR MARCACIONES

  select
    @w_tipo_ced = en_tipo_ced,
    @w_cedula = en_ced_ruc
  from   cob_ahorros..ah_cuenta with (nolock),
         cobis..cl_ente with (nolock)
  where  ah_cta_banco = @i_cuenta
     and ah_cliente   = en_ente

  if @w_tipo_ced in ('N', 'NI')
    select
      @w_cedula = left(rtrim(ltrim(@w_cedula)),
                       len(rtrim(ltrim(@w_cedula))) - 1)
  -- SIN DIGITO DE VERIFICACION
  else
    select
      @w_cedula = rtrim(ltrim(@w_cedula))

  -- Devuelve la consulta al front
  set rowcount 1
  select
    @w_secuencial = mcg_cod,
    @w_tipo_ide = mcg_tipo_ide,
    @w_num_ide = mcg_num_ide,
    @w_cliente = mcg_nom_cli,
    @w_est_ide = mcg_est_ide,
    @w_fec_exp_ide = mcg_fec_exp,
    @w_lug_exp_ide = mcg_lug_exp,
    @w_msg_exencion = mcg_cod_msg + '-' + mcg_desc_msg
  from   cobis..cl_marc_cifin_gen with (nolock)
  where  mcg_num_ide = @w_cedula
  order  by mcg_cod desc

  if @@rowcount = 0
  begin
    select
      @w_error = 101159
    goto ERROR
  end

  select
    @w_tipo_ent = mcc_tipo_ent,
    @w_nom_ent = mcc_nom_ent,
    @w_num_cuenta = mcc_num_cta,
    @w_oficina = mcc_nom_suc,
    @w_est_cuenta = mcc_cod_est_cta,
    @w_fec_ini_exe = mcc_fec_ini_exe,
    @w_fec_fin_exe = mcc_fec_fin_exe
  from   cobis..cl_marc_cifin_ctas with (nolock)
  where  mcc_cod = @w_secuencial
  order  by mcc_fec_ini_exe desc

  set rowcount 0

  /* ACTUALIZA TIPO DE CUENTA EN CASO DE SER BANCAMIA */
  select
    @w_tipo_cuenta = pb_descripcion
  from   cob_ahorros..ah_cuenta with (nolock),
         cob_remesas..pe_pro_bancario with (nolock)
  where  upper(@w_nom_ent) like '%BANCAMIA%'
     and ah_cta_banco    = @w_num_cuenta
     and pb_pro_bancario = ah_prod_banc

  /* ACTUALIZA CONCEPTO DE EXENCION Y USUARIO EN CASO DE SER BANCAMIA */
  select
    @w_concepto = ce_descripc,
    @w_usuario = case
                   when @w_fec_fin_exe = '' then eg_usuario
                   else eg_usuario_desm
                 end
  from   cob_ahorros..ah_exenta_gmf with (nolock),
         cob_remesas..re_concep_exen_gmf with (nolock)
  where  upper(@w_nom_ent) like '%BANCAMIA%'
     and eg_cta_banco = @w_num_cuenta
     and ce_concepto  = eg_concepto

  /* RETORNA LA CONSULTA AL FRONT */
  select
    @w_tipo_ide,
    @w_num_ide,
    @w_cliente,
    @w_est_ide,
    @w_fec_exp_ide,
    @w_lug_exp_ide,
    @w_msg_exencion,
    @w_tipo_ent,
    @w_nom_ent,
    @w_num_cuenta,
    @w_oficina,
    @w_tipo_cuenta,
    @w_est_cuenta,
    @w_usuario,
    @w_concepto,
    @w_fec_ini_exe,
    @w_fec_fin_exe

  return 0

  ERROR:
  exec cobis..sp_cerror
    @t_from = @w_sp_name,
    @i_num  = @w_error
  return @w_error

go

