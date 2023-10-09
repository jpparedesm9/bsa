/************************************************************************/
/*   Stored procedure:     sp_ente_bloqueado                            */
/*   Base de datos:        cobis                                        */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                            PROPOSITO                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_ente_bloqueado_masivo')
  drop proc sp_ente_bloqueado_masivo
go

create proc sp_ente_bloqueado_masivo
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_ente         int = null,
  @o_retorno      char(1) output
)
as
  declare
    @w_today        datetime,
    @w_sp_name      varchar(32),
    @w_return       int,
    @w_subtipo      char(1),
    @w_tipo_ced     char(2),
    @w_fec_nac      datetime,
    @w_ced_ruc      numero,
    @w_cont_val     smallint,
    @w_dep_nac      int,
    @w_ciudad_nac   int,
    @w_nomlar       varchar(254),
    @w_profesion    catalogo,
    @w_actividad    catalogo,
    @w_otros_ing    descripcion,
    @w_relacint     char(1),
    @w_fec_finan    datetime,
    @w_activos      money,
    @w_pasivos      money,
    @w_ingresos     money,
    @w_egresos      money,
    @w_tipo_soc     catalogo,
    @w_rep_legal    int,
    @w_legal_ente   int,
    @w_subtipo_rl   char(1),
    @w_ced_ruc_rl   numero,
    @w_nomlar_rl    varchar(254),
    @w_fecha_emi    datetime,
    @w_pais_emi     smallint,
    @w_depa_emi     smallint,
    @w_pais_nac     smallint,
    @w_sexo         descripcion,
    @w_est_civil    catalogo,
    @w_sector       catalogo,
    @w_tipo         catalogo,
    @w_estrato      varchar(10),
    @w_exc_sipla    char(1),
    @w_exc_por2     char(1),
    @w_rioe         char(1),
    @w_impuesto     char(1),
    @w_retencion    char(1),
    @w_grancont     char(1),
    @w_usu_cred     catalogo,
    @w_procedencia  varchar(10),
    @w_reg_fiscal   catalogo,
    @w_ocupacion    catalogo,
    @w_tvinculacion catalogo,
    @w_influencia   char(1),
    @w_victima      char(1),
    @w_recurso_pub  char(1),
    @w_persona_pub  char(1),
    @w_accion       varchar(10)

  select
    @w_sp_name = 'sp_ente_bloqueado_masivo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  select
    @w_rep_legal = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'RL5'
     and pa_producto = 'MIS'

  if @i_operacion = 'B'
  begin
    if @t_trn != 175
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      return 151051
    end

    select
      @w_subtipo = en_subtipo,
      @w_tipo_ced = en_tipo_ced,
      @w_fec_nac = p_fecha_nac,
      @w_ced_ruc = en_ced_ruc,
      @w_nomlar = en_nomlar,
      @w_dep_nac = p_depa_nac,
      @w_ciudad_nac = p_ciudad_nac,
      @w_profesion = p_profesion,
      @w_actividad = en_actividad,
      @w_otros_ing = en_otringr,
      @w_relacint = en_relacint,
      @w_fec_finan = en_fbalance,
      @w_activos = c_total_activos,
      @w_pasivos = c_total_pasivos,
      @w_ingresos = p_nivel_ing,
      @w_egresos = p_nivel_egr,
      @w_tipo_soc = c_tipo_soc,
      @w_fecha_emi = p_fecha_emision,
      @w_pais_emi = p_pais_emi,
      @w_depa_emi = p_depa_emi,
      @w_pais_nac = en_pais,
      @w_sexo = p_sexo,
      @w_est_civil = p_estado_civil,
      @w_sector = en_sector,
      @w_tipo = p_tipo_persona,
      @w_estrato = en_estrato,
      @w_exc_sipla = en_exc_sipla,
      @w_exc_por2 = en_exc_por2,
      @w_rioe = en_rep_sib,
      @w_impuesto = en_reestructurado,
      @w_retencion = en_retencion,
      @w_grancont = en_gran_contribuyente,
      @w_usu_cred = en_casilla_def,
      @w_procedencia = en_procedencia,
      @w_reg_fiscal = en_asosciada,
      @w_ocupacion = en_concordato,
      @w_tvinculacion = en_tipo_vinculacion,
      @w_influencia = en_influencia,
      @w_victima = en_victima,
      @w_recurso_pub = en_recurso_pub,
      @w_accion = en_accion
    from   cobis..cl_ente
    where  en_ente = @i_ente

    if @@rowcount != 1
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103000
      return 103000
    end

    select
      @o_retorno = 'N'

    if @w_tipo_ced in ('EN', 'EJ')
    begin
      print 'TIPO DE IDENTIDAD DEL CLIENTE CON ERROR'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_fec_nac is null
       and @w_subtipo = 'P'
    begin
      print 'NO TIENE FECHA DE NACIMIENTO DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_ced_ruc is null
    begin
      print 'NO TIENE NUMERO DE DOCUMENTO DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    select
      @w_cont_val = charindex ("FALTA NOMBRE",
                               @w_nomlar)
    select
      @w_cont_val = @w_cont_val + charindex ("FALTA APELLIDO", @w_nomlar)

    if @w_cont_val > 0
       and @w_subtipo = 'P'
    begin
      print 'FALTA EL NOMBRE  DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_dep_nac = 0
         or @w_dep_nac is null)
       and @w_subtipo = 'P'
    begin
      print 'FALTA DEPARTAMENTO DE NACIMIENTO DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_ciudad_nac = 0
         or @w_ciudad_nac is null)
       and @w_subtipo = 'P'
    begin
      print 'FALTA CIUDAD DE NACIMIENTO DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_profesion is null
       and @w_subtipo = 'P'
    begin
      print 'FALTA INGRESAR PROFESION DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_ocupacion is null
       and @w_subtipo = 'P'
    begin
      print 'FALTA INGRESAR LA OCUPACION DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_tvinculacion is null
       and @w_subtipo = 'P'
    begin
      print 'FALTA INGRESAR EL TIPO DE VINCULACION DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_actividad is null
    begin
      print 'FALTA ACTIVIDAD ECONOMICA CIIU DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_relacint = 'S'
    begin
      if exists (select
                   1
                 from   cl_relacion_inter
                 where  ri_ente = @i_ente)
      begin
        select
          @w_cont_val = 0
      end
      else
      begin
        print 'FALTA INGRESAR DETALLE DE LA RELACION INTERNACIONAL'
        select
          @o_retorno = 'S'
        return 0
      end
    end

    if @w_accion is null
       and @w_subtipo = 'P'
    begin
      print 'FALTA ESPECIFICAR LA ACCION DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if exists (select
                 1
               from   cobis..cl_direccion
               where  di_ente = @i_ente)
    begin
      select
        @w_cont_val = 0
    end
    else
    begin
      print 'FALTA DIRECCION DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if exists (select
                 1
               from   cobis..cl_telefono
               where  te_ente = @i_ente)
    begin
      select
        @w_cont_val = 0
    end
    else
    begin
      print 'FALTA TELEFONO DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if exists (select
                 1
               from   cobis..cl_origen_fondos
               where  of_ente = @i_ente)
    begin
      select
        @w_cont_val = 0
    end
    else
    begin
      print 'FALTA ESPECIFICAR EL ORIGEN DE FONDOS DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if exists (select
                 1
               from   cobis..cl_mercado_objetivo_cliente
               where  mo_ente = @i_ente)
    begin
      select
        @w_cont_val = 0
    end
    else
    begin
      print 'FALTA ESPECIFICAR EL MERCADO Y LA BANCA DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_fec_finan is null
    begin
      print 'FALTA FECHA DE BALANCE DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_activos is null
         or @w_activos = 0)
    begin
      print 'FALTA INGRESAR ACTIVOS DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_pasivos is null)
    begin
      print 'FALTA INGRESAR PASIVOS DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_ingresos is null
         or @w_ingresos = 0)
    begin
      print 'FALTA INGRESAR INGRESOS DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_egresos is null
         or @w_egresos = 0)
    begin
      print 'FALTA INGRESAR EGRESOS DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_tipo_soc is null
       and @w_subtipo = 'C'
    begin
      print 'FALTA INGRESAR LA NATURALEZA JURIDICA DEL CLIENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_sector is null)
    begin
      print 'FALTA INGRESAR EL SECTOR A QUE CORRESPONDE LA ACTIVIDAD'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_tipo is null)
    begin
      print 'FALTA INGRESAR EL TIPO DE PERSONA'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_exc_sipla is null)
    begin
      print 'FALTA ESPECIFICAR SI EL CLIENTES ES EXENTO DE VERIFICACIONES SIPLA'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_exc_por2 is null)
    begin
      print 'FALTA ESPECIFICAR SI EL CLIENTES SE EXCLUYE O NO DEL 2 o/oo'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_rioe is null)
    begin
      print 'FALTA ESPECIFICAR SI EL CLIENTES ES EXENTO O NO DE RIOE'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_retencion is null)
    begin
      print 'FALTA ESPECIFICAR SI EL CLIENTE TIENE O NO RETENCION'
      select
        @o_retorno = 'S'
      return 0
    end

    if (@w_grancont is null)
    begin
      print 'FALTA ESPECIFICAR SI EL CLIENTE ES O NO GRAN CONTRIBUYENTE'
      select
        @o_retorno = 'S'
      return 0
    end

    if @w_subtipo = 'C'
    begin
      select
        @w_legal_ente = in_ente_d
      from   cobis..cl_instancia
      where  in_relacion = @w_rep_legal
         and in_ente_i   = @i_ente

      if @w_legal_ente is null
      begin
        select
          @w_legal_ente = in_ente_i
        from   cobis..cl_instancia
        where  in_relacion = @w_rep_legal
           and in_ente_d   = @i_ente
      end

      if @w_legal_ente is null
      begin
        print 'FALTA REPRESENTATE LEGAL DEL CLIENTE'
        select
          @o_retorno = 'S'
        return 0
      end

      select
        @w_subtipo_rl = en_subtipo,
        @w_ced_ruc_rl = en_ced_ruc,
        @w_nomlar_rl = en_nomlar
      from   cobis..cl_ente
      where  en_ente = @w_legal_ente

      if @w_ced_ruc_rl is null
      begin
        print 'NO TIENE NUMERO DE DOCUMENTO DEL REPRESENTE LEGAL'
        select
          @o_retorno = 'S'
        return 0
      end

      if exists (select
                   1
                 from   cobis..cl_direccion
                 where  di_ente = @w_legal_ente)
      begin
        select
          @w_cont_val = 0
      end
      else
      begin
        print 'FALTA DIRECCION DEL REPRESENTE LEGAL'
        select
          @o_retorno = 'S'
        return 0
      end

      if exists (select
                   1
                 from   cobis..cl_telefono
                 where  te_ente = @w_legal_ente)
      begin
        select
          @w_cont_val = 0
      end
      else
      begin
        print 'FALTA TELEFONO DEL REPRESENTE LEGAL'
        select
          @o_retorno = 'S'
        return 0
      end

      select
        @w_cont_val = 0
      select
        @w_cont_val = charindex ("FALTA NOMBRE",
                                 @w_nomlar_rl)
      select
        @w_cont_val = @w_cont_val + charindex ("FALTA APELLIDO", @w_nomlar_rl)

      if @w_cont_val > 0
      begin
        print 'FALTA EL NOMBRE  DEL REPRESENTE LEGAL'
        select
          @o_retorno = 'S'
        return 0
      end
    end

    if @w_subtipo = 'P'
    begin
      if (@w_fecha_emi is null)
      begin
        print 'FALTA INGRESAR LA FECHA DE EMISION DEL DOCUMENTO'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_pais_emi is null)
      begin
        print 'FALTA INGRESAR EL PAIS DE EMISION DEL DOCUMENTO'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_depa_emi is null)
      begin
        print 'FALTA INGRESAR EL DEPARTAMENTO DE EMISION DEL DOCUMENTO'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_sexo is null)
      begin
        print 'FALTA INGRESAR EL SEXO DEL CLIENTE'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_est_civil is null)
      begin
        print 'FALTA INGRESAR EL SEXO DEL CLIENTE'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_estrato is null)
      begin
        print 'FALTA INGRESAR EL ESTRATO DEL CLIENTE'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_impuesto is null)
      begin
        print
      'FALTA ESPECIFICAR SI EL CLIENTE ES O NO DECLARANTE DE IMPUESTO DE RENTA'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_reg_fiscal is null)
      begin
        print 'FALTA ESPECIFICAR SI EL CLIENTE ES O NO GRAN CONTRIBUYENTE'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_influencia is null)
      begin
        print 'FALTA ESPECIFICAR SI EL CLIENTE INFLUYE EN POLITICA'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_victima is null)
      begin
        print 'FALTA ESPECIFICAR SI EL CLIENTE ES VICTIMA DE HECHOS VIOLENTOS'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_relacint is null)
      begin
        print
      'FALTA ESPECIFICAR SI EL CLIENTE REALIZA OPERACIONES EN MONEDA EXTRANJERA'
        select
          @o_retorno = 'S'
        return 0
      end

      if (@w_recurso_pub is null)
      begin
        print 'FALTA ESPECIFICAR SI EL CLIENTE MANEJA RECURSOS PUBLICOS'
        select
          @o_retorno = 'S'
        return 0
      end

    end

    return 0
  end

go

