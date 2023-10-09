/************************************************************************/
/*  Archivo:            prente.sp                                       */
/*  Stored procedure:   sp_pr_ente                                      */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Sandra Ortiz                                    */
/*  Fecha de escritura: 02-Aug-1994                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Extrae la informacion requerida para la impresion de datos del      */
/*      cliente de acuerdo a los criterios de busqueda dados en el front*/
/*      end.                                                            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  02-Aug-1994 S Ortiz     Emision inicial                             */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_pr_ente')
    drop proc sp_pr_ente
go

create proc sp_pr_ente
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_ente         int,
  @i_direccion    char (1) = 'N',
  @i_apartado     char (1) = 'N',
  @i_propiedad    char (1) = 'N',
  @i_refeco       char (1) = 'N',
  @i_refper       char (1) = 'N',
  @i_empleo       char (1) = 'N',
  @i_completo     char (1) = 'N',
  @i_filiales     char (1) = 'N',
  @i_filial       tinyint = 0
)
as
  declare
    @w_sp_name varchar (30),
    @w_manejo  char(1)

  --Version /*    28-Aug-2009 E Laguna        caso513   */

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_pr_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1239
  begin
    /*  Codigo de Transaccion errado  */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @t_from,
      @i_num   = 101147
    return 1
  end

  if @i_filiales = 'S'
  begin
    select
      fi_filial,
      fi_nombre
    from   cl_filial
    where  fi_filial = @i_filial
  end

  /*  Extrae direcciones y Telefonos de un ente */
  if @i_direccion = 'S'
  begin
    select
      di_direccion,
      di_descripcion,
      di_ciudad,
      ci_descripcion,
      di_parroquia,
      --   pq_descripcion,
      di_tipo,
      c1.valor,
      di_sector,
      pv_descripcion,
      di_zona,
      c2.valor,
      convert(char(10), di_fecha_registro, 101),
      convert(char(10), di_fecha_modificacion, 101),
      di_verificado,
      di_barrio,
      di_provincia
    from   cl_direccion,
           cl_ciudad,
           cl_provincia,
           cl_catalogo c1,
           cl_tabla t1,
           cl_catalogo c2,
           cl_tabla t2
    where  di_ente      = @i_ente
           --   and  pq_parroquia = di_parroquia
           --   and  pq_ciudad    = convert(tinyint,di_ciudad)
           --   and  ci_ciudad    = convert(int,di_ciudad)
           and ci_ciudad    = di_ciudad
           --   and  pv_provincia = convert(tinyint,di_sector)
           and pv_provincia = di_provincia
           and t2.tabla     = 'cl_zona'
           and c2.tabla     = t2.codigo
           and c2.codigo    = di_zona
           and t1.tabla     = 'cl_tdireccion'
           and c1.tabla     = t1.codigo
           and c1.codigo    = di_tipo

    select
      te_direccion,
      te_secuencial,
      te_valor,
      te_tipo_telefono,
      cl_catalogo.valor,
      te_prefijo
    from   cl_telefono x,
           cl_tabla,
           cl_catalogo
    where  te_ente            = @i_ente
       and cl_tabla.tabla     = 'cl_ttelefono'
       and cl_catalogo.tabla  = cl_tabla.codigo
       and cl_catalogo.codigo = x.te_tipo_telefono

  end

  /*  Extrae Apartados Postales de un ente  */
  if @i_apartado = 'S'
  begin
    select
      cs_casilla,
      cs_valor,/*cs_zona, */
      cs_tipo,
      cs_ciudad,
      cs_provincia,
      pv_descripcion,/*cs_sucursal,  */
      ci_descripcion,
      convert(char(10), cs_fecha_registro, 101),
      convert(char(10), cs_fecha_modificacion, 101),
      cs_verificado
    from   cl_casilla
           left outer join cl_ciudad
                        on cs_ciudad = ci_ciudad
           left outer join cl_provincia
                        on cs_provincia = pv_provincia
    where  cs_ente = @i_ente
    --  and    ci_ciudad = * cs_ciudad
    --  and    pv_provincia = * cs_provincia

    select
      cs_casilla,
      cs_valor,/*cs_zona, */
      cs_tipo,
      cs_provincia,
      cs_sucursal,
      pv_descripcion,
      sc_descripcion
    from   cl_casilla,
           cl_suc_correo,
           cl_provincia
    where  cs_ente      = @i_ente
       and cs_provincia = pv_provincia
       and cs_provincia = sc_provincia
       and cs_sucursal  = sc_sucursal

  end

  /*  Extrae propiedades de un ente  */
  if @i_propiedad = 'S'
  begin
    select
      pr_propiedad,
      pr_descripcion,
      pr_valor,
      pr_moneda,
      mo_descripcion,
      pr_tbien,
      c1.valor,
      pr_gravada,
      pr_gravamen_afavor,
      pr_ciudad,
      ci_descripcion,
      pr_matricula,
      pr_escritura,
      pr_vigencia,
      pr_verificado,
      convert(char(10), pr_fecha_registro, 101),
      convert(char(10), pr_fecha_modificacion, 101)
    from   cl_moneda,
           cl_tabla t1,
           cl_catalogo c1,
           cl_propiedad x
           left outer join cl_ciudad
                        on pr_ciudad = ci_ciudad
    where  pr_persona = @i_ente
       and mo_moneda  = pr_moneda
       --  and  pr_ciudad  * = ci_ciudad
       and t1.tabla   = 'cl_tbien'
       and c1.tabla   = t1.codigo
       and c1.codigo  = x.pr_tbien
    order  by pr_tbien
  end

  /*  Extrae referencias economicas de un ente  */
  if @i_refeco = 'S'
  begin
    /*************** referencias BANCARIAS ************/
    select
      referencia,
      tipo,
      cl_catalogo.valor,
      banco,
      ba_descripcion,
      cuenta,
      tipo_cta,
      c1.valor,
      convert(char(10), fec_exp_ref, 101),
      convert(char(10), fec_apertura, 101),
      monto,
      sucursal,
      ciudad,
      ci_descripcion,
      vigencia,
      verificacion,
      convert(char(10), fecha_registro, 101)
    from   cl_catalogo,
           cl_tabla,
           cobis..cl_banco_rem,
           cl_catalogo c1,
           cl_tabla t1,
           cl_economica x
           left outer join cl_ciudad
                        on ci_ciudad = ciudad
    where  ente               = @i_ente
       and ba_banco           = banco
       -- and  ci_ciudad         = * ciudad
       and cl_tabla.tabla     = 'cl_rtipo'
       and cl_catalogo.tabla  = cl_tabla.codigo
       and cl_catalogo.codigo = x.tipo
       and t1.tabla           = 'cl_tipo_cuenta'
       and c1.tabla           = t1.codigo
       and c1.codigo          = tipo_cta

    /*************** referencia TARJETAS ************/

    select
      re_referencia,
      re_tipo,
      c.valor,
      ta_banco,
      substring(a.valor,
                1,
                30),
      ta_cuenta,
      ec_tipo_cta,
      c3.valor,
      monto,
      re_sucursal,/*INNUC*/
      re_ciudad,/*INNUC*/
      ci_descripcion,
      convert(char(10), ec_fec_exp_ref, 101),
      convert(char(10), ec_fec_apertura, 101),
      convert(char(10), ec_fec_exp_ref, 101),
      re_vigencia,
      re_verificacion,
      re_telefono,/*INNUC*/
      re_calificacion,
      c2.valor
    from   cl_catalogo a,
           cl_tabla b,
           cl_catalogo c,
           cl_tabla d,
           cl_referencia
           left outer join cl_ciudad
                        on ci_ciudad = re_ciudad
           left outer join cl_tabla t2
                        on t2.tabla = 'cl_posicion'
           left outer join cl_catalogo c2
                        on re_calificacion = c2.codigo
                           and t2.codigo = c2.tabla
           left outer join cl_tabla t3
                        on t3.tabla = 'cl_clase_tarjeta'
           left outer join cl_catalogo c3
                        on ec_tipo_cta = c3.codigo
                           and t3.codigo = c3.tabla
    where  re_ente  = @i_ente
       and re_tipo  = 'T'
       and re_tipo  = c.codigo
       and c.tabla  = d.codigo
       and d.tabla  = 'cl_rtipo'
       and ta_banco = a.codigo
       and a.tabla  = b.codigo
       and b.tabla  = 'cl_tarjeta'

  /*  and    t2.tabla = 'cl_posicion'
      and    c2.tabla = * t2.codigo
      and    c2.codigo = * re_calificacion
  
      and    t3.tabla = 'cl_clase_tarjeta'
      and    c3.tabla = * t3.codigo
      and    c3.codigo = * ec_tipo_cta
  
      and    re_ciudad * = ci_ciudad   **/
    /*************** referencias COMERCIALES ************/
    select
      referencia,
      tipo,
      c1.valor,
      institucion,
      ciudad,
      ci_descripcion,
      sucursal,
      monto,
      convert(char(10), fecha_ingr_en_inst, 101),
      convert(char(10), fec_exp_ref, 101),
      convert(char(10), fecha_registro, 101),
      vigencia,
      verificacion
    from   cl_catalogo c1,
           cl_tabla t1,
           cl_comercial x
           left outer join cl_ciudad
                        on ci_ciudad = ciudad
    where  ente      = @i_ente
           --  and   ci_ciudad = * ciudad
           and t1.tabla  = 'cl_rtipo'
           and c1.tabla  = t1.codigo
           --  and   c1.codigo = convert(char(10),x.tipo)
           and c1.codigo = x.tipo

    /*************** referencias FINANCIERAS ************/
    select
      referencia,
      treferencia,
      c1.valor,
      institucion,
      ba_descripcion,
      convert(char(10), fec_inicio, 101),
      monto,
      cupo_usado,
      monto_vencido,
      vigencia,
      verificacion,
      tclase,
      toperacion,
      convert(char(10), fec_vencimiento, 101),
      convert(char(10), fec_exp_ref, 101),
      convert(char(10), fecha_registro, 101),
      estatus
    from   cl_financiera x,
           cobis..cl_banco_rem,
           cl_catalogo c1,
           cl_tabla t1
    where  cliente   = @i_ente
       and ba_banco  = institucion
       and t1.tabla  = 'cl_rtipo'
       and c1.tabla  = t1.codigo
       --  and   c1.codigo = convert(char(10),x.treferencia)
       and c1.codigo = x.treferencia
  end

  /*  Extrae referencias personales de un ente  */
  if @i_refper = 'S'
  begin
    select
      x.rp_referencia,
      x.rp_nombre,
      x.rp_p_apellido,
      x.rp_s_apellido,
      x.rp_direccion,
      x.rp_telefono_d,
      x.rp_telefono_e,
      x.rp_telefono_o,
      x.rp_parentesco,
      x.rp_verificacion,
      convert(varchar(10), x.rp_fecha_registro, 101),
      c1.valor
    from   cl_ref_personal x,
           cl_tabla t1,
           cl_catalogo c1
    where  rp_persona = @i_ente
       and t1.tabla   = 'cl_parentesco'
       and c1.tabla   = t1.codigo
       and c1.codigo  = x.rp_parentesco
    order  by rp_referencia

  end

  /*  Extrae empleos de un ente  */
  if @i_empleo = 'S'
  begin
    select
      tr_trabajo,
      tr_empresa,
      (select
         en_nombre
       from   cl_ente
       where  convert(varchar(64), en_ente) = x.tr_empresa),
      tr_cargo,
      tr_sueldo,
      tr_moneda,
      mo_descripcion,
      convert(char(10), tr_fecha_ingreso, 101),
      convert(char(10), tr_fecha_salida, 101),
      --JAN JUN/00        tr_nom_empresa
      nombre
    from   cl_trabajo x,
           cl_compania,
           cl_moneda
    where  tr_persona = @i_ente
           --and  tr_empresa = compania
           and mo_moneda  = tr_moneda
  end

go

