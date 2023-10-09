/************************************************************************/
/*    Archivo:             ahtconre.sp                                  */
/*    Stored procedure:    sp_con_ahr_ref_ah                            */
/*    Base de datos:       cob_ahorros                                  */
/*    Producto:            Cuentas de Ahorros                           */
/*    Disenado por:  Mauricio Bayas/Sandra Ortiz                        */
/*    Fecha de escritura: 26-Feb-1993                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de consulta especifica       */
/*    para las referencias y las constancias de cuentas de ahorros      */
/*    301 = Consulta especifica para Referencias y constancias          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      28/Jul/1998     V. Molina       Emision Inicial                 */
/*      27/May/1999     M. Sanguino     Personalizacion B. Caribe       */
/*      17/Mar/2000     Yenny Rivero    Cambio en el calculo de promedio*/
/*      02/May/2016     J. Calderon     Migración a CEN                 */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_con_ahr_ref_ah')
  drop proc sp_con_ahr_ref_ah

go
create proc sp_con_ahr_ref_ah
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint = 1,
  @s_org_err      char(1) = null,/* Origen de error:[A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_oficina      smallint,
  @i_tipo_ref     char(1)
)
as
  declare
    @w_return             int,
    @w_sp_name            varchar(30),
    @w_cuenta             int,
    @w_estado             char(1),
    @w_tipo_def           char(1),
    @w_moneda             tinyint,
    @w_filial             tinyint,
    @w_oficina            smallint,
    @w_oficial            smallint,
    @w_categoria          char(1),
    @w_tipo_promedio      char(1),
    @w_capitalizacion     char(1),
    @w_tipocta            char(1),
    @w_rol_ente           char(1),
    @w_tpromedio_des      descripcion,
    @w_estado_des         descripcion,
    @w_mon_des            descripcion,
    @w_categ_des          descripcion,
    @w_oficial_des        descripcion,
    @w_capit_des          descripcion,
    @w_saldo_para_girar   money,
    @w_saldo_contable     money,
    @w_comision           money,
    @w_funcionario        char(1),
    @w_personalizada      char(1),
    @w_ciudad_desc        varchar(50),
    @w_ah_fecha_aper      varchar(10),
    @w_promedio1          money,
    @w_promedio2          money,
    @w_promedio3          money,
    @w_promedio4          money,
    @w_promedio5          money,
    @w_promedio6          money,
    @w_disponible         money,
    @w_contable           money,
    @w_promedio_semestral money,
    @w_prom_disponible    money,
    @w_prod_banc          smallint,
    @w_producto           tinyint,
    @w_tipo               char(1),
    @w_prod_bancario      varchar(20),
    @w_default            int
  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_con_ahr_ref_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_oficina = @i_oficina,
      i_tipo_ref = @i_tipo_ref
    exec cobis..sp_end_debug
  end

  if @t_trn <> 301
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  select
    @w_ah_fecha_aper = convert(varchar(10), ah_fecha_aper, 101),
    @w_cuenta = ah_cuenta,
    @w_estado = ah_estado,
    @w_oficial = ah_oficial,
    @w_prod_banc = ah_prod_banc,
    @w_tipocta = ah_tipocta,
    @w_producto = ah_producto,
    @w_tipo = ah_tipo,
    @w_categoria = ah_categoria,
    @w_moneda = ah_moneda,
    @w_tipo_promedio = ah_tipo_promedio,
    @w_capitalizacion = ah_capitalizacion,
    @w_funcionario = ah_cta_funcionario,
    @w_oficina = ah_oficina,
    @w_filial = ah_filial,
    @w_disponible = ah_disponible,
    @w_contable = ah_disponible + ah_12h + ah_24h + ah_48h + ah_remesas,
    @w_promedio1 = ah_promedio1,
    @w_promedio2 = ah_promedio2,
    @w_promedio3 = ah_promedio3,
    @w_promedio4 = ah_promedio4,
    @w_promedio5 = ah_promedio5,
    @w_promedio6 = ah_promedio6,
    @w_prom_disponible = ah_prom_disponible
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  /* Chequeo de existencias */
  if @@rowcount <> 1
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  select
    @w_prod_bancario = pb_descripcion
  from   cob_remesas..pe_pro_bancario
  where  pb_pro_bancario = @w_prod_banc

  if @@rowcount <> 1
  begin
    /* No existe producto bancario */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 121102
    return 1
  end

  /* Calculo el promedio semestral   lgr
  
  
     /*select @w_promedio_semestral = (@w_promedio1 + @w_promedio2 + @w_promedio3
          + @w_promedio4 + @w_promedio5 + @w_promedio6)/6     */
  
  
     select @w_promedio_semestral = ( @w_promedio2 + @w_promedio3
          + @w_promedio4 + @w_promedio5 + @w_promedio6)/5     
  
      if @i_tipo_ref = 'R' and (@w_promedio_semestral <= 0 or @w_disponible <= 0)
  
      begin
       /* Saldo disponible o saldo promedio menor a cero */
           exec cobis..sp_cerror
                  @t_debug    = @t_debug,
                  @t_file     = @t_file,
                  @t_from     = @w_sp_name,
                  @i_num      = 201234
                  return 201234
          end
  
  */
  exec @w_return = cob_remesas..sp_genera_costos
    @i_fecha       = @s_date,
    @i_categoria   = @w_categoria,
    @i_tipo_ente   = @w_tipocta,
    @i_rol_ente    = @w_rol_ente,
    @i_tipo_def    = @w_tipo_def,
    @i_prod_banc   = @w_prod_banc,
    @i_producto    = @w_producto,
    @i_moneda      = @w_moneda,
    @i_tipo        = @w_tipo,
    @i_codigo      = @w_default,
    @i_servicio    = 'REFB',
    @i_rubro       = '81',
    @i_disponible  = @w_disponible,
    @i_contable    = @w_contable,
    @i_promedio    = @w_promedio1,
    @i_prom_disp   = @w_prom_disponible,
    @i_personaliza = @w_personalizada,
    @i_filial      = @w_filial,
    @i_oficina     = @w_oficina,
    @o_valor_total = @w_comision out

  if @w_return <> 0
    return @w_return

  if @w_comision > 0
  begin
    exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_srv    = @s_srv,
      @s_ofi    = @s_ofi,
      @s_ssn    = @s_ssn,
      @s_user   = @s_user,
      @s_term   = @s_term,
      @t_trn    = 264,
      @i_cta    = @i_cta,
      @i_val    = @w_comision,
      @i_cau    = '11',
      @i_mon    = @i_mon,
      @i_fecha  = @s_date,
      @i_imp    = 'S',
      @i_cobiva = 'S'
    if @w_return <> 0
      return @w_return
  end

  /* Verificacion de cuentas de funcionarios para oficiales autorizados */
  if @w_funcionario = 'S'
  begin
    if not exists (select
                     *
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 1
    end
  end

/* Validaciones */
/* No se valida que la cuenta se encuentre activa */
  /* Envio de resultados al Front End */

  select
    @w_ciudad_desc = ci_descripcion
  from   cobis..cl_oficina,
         cobis..cl_ciudad
  where  of_oficina = @i_oficina
     and of_ciudad  = ci_ciudad
  if @@rowcount = 0
  begin
    /* No existe el dato solicitado */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 210105
    return 1
  end

  --if @w_prod_banc = 1 or @w_prod_banc = 2
  select
    @w_prod_bancario = 'DE AHORROS ' + @w_prod_bancario

  select
    @w_ah_fecha_aper,
    @w_promedio_semestral,
    @w_disponible,
    @w_ciudad_desc,
    @w_prod_bancario

  return 0

go

