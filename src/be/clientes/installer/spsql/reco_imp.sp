/************************************************************************/
/*  Archivo           :     reco_imp.sp                                 */
/*  Stored procedure  :     sp_impresion_ref_economicas                 */
/*  Base de datos     :     cobis                                       */
/*  Producto          :     Clientes                                    */
/*  Disenado por      :     Jaime Loyo                                  */
/*  Fecha de escritura:     08-Jul-1998                                 */
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
/*  Permite llevar los datos para imprimir las referencias              */
/*      economicas de un cliente                                        */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  08-Jul-1998 J. Loyo     Emision inicial                             */
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
           where  name = 'sp_impresion_ref_economicas')
    drop proc sp_impresion_ref_economicas
go

create proc sp_impresion_ref_economicas
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
  @i_ente         int
)
as
  declare @w_sp_name varchar (30)

  /*  Inicializacion de Variables  */
  select
    @w_sp_name = 'sp_impresion_ref_economicas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1377
  begin
    /*  Codigo de Transaccion errado  */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @t_from,
      @i_num  = 101147
    return 1
  end

/*  Extrae referencias economicas de un ente  */
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
    convert(char(10), fecha_registro, 101),
    telefono
  from   cl_catalogo,
         cl_tabla,
         cobis..cl_banco_rem,
         --cl_catalogo c1, cl_tabla t1
         cl_economica x
         left outer join cl_ciudad
                      on ci_ciudad = ciudad
         left outer join cl_tabla t1
                      on t1.tabla = 'cl_tipo_cuenta'
         left outer join cl_catalogo c1
                      on tipo_cta = c1.codigo
                         and t1.codigo = c1.tabla
  where  ente               = @i_ente
     and ba_banco           = banco
     --     and  ci_ciudad          = * ciudad
     and cl_tabla.tabla     = 'cl_rtipo'
     and cl_catalogo.tabla  = cl_tabla.codigo
     and cl_catalogo.codigo = x.tipo
  --     and  t1.tabla           = 'cl_tipo_cuenta'
  --     and  c1.tabla           = * t1.codigo
  --     and  c1.codigo          = * tipo_cta

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
    re_sucursal,
    re_ciudad,
    ci_descripcion,
    convert(char(10), ec_fec_exp_ref, 101),
    convert(char(10), ec_fec_apertura, 101),
    convert(char(10), re_fecha_registro, 101),
    re_vigencia,
    re_verificacion,
    re_telefono,
    re_estado,
    c2.valor
  from   cl_catalogo a,
         cl_tabla b,
         cl_catalogo c,
         cl_tabla d,
         cl_catalogo c2,
         cl_tabla t2,
         --        cl_catalogo c3, cl_tabla t3,
         cl_referencia
         left outer join cl_ciudad
                      on ci_ciudad = re_ciudad
         left outer join cl_tabla t3
                      on t3.tabla = 'cl_clase_tarjeta'
         left outer join cl_catalogo c3
                      on ec_tipo_cta = c3.codigo
                         and t3.codigo = c3.tabla
  where  re_ente   = @i_ente
     and re_tipo   = c.codigo
     and c.tabla   = d.codigo
     and d.tabla   = 'cl_rtipo'
     and ta_banco  = a.codigo
     and a.tabla   = b.codigo
     and b.tabla   = 'cl_tarjeta'
     and re_tipo   = 'T'
     and t2.tabla  = 'cl_ereferencia' --  'cl_posicion'
     and c2.tabla  = t2.codigo
     and c2.codigo = re_estado
  --    and  t3.tabla   = 'cl_clase_tarjeta'
  --    and  c3.tabla  = * t3.codigo
  --    and  c3.codigo = * ec_tipo_cta
  --    and  re_ciudad * = ci_ciudad

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
    verificacion,
    nacional,
    pa_descripcion
  from   cl_catalogo c1,
         cl_tabla t1,
         cl_pais,
         cl_comercial x
         left outer join cl_ciudad
                      on ciudad = ci_ciudad
  where  ente      = @i_ente
         --and  ci_ciudad  = * ciudad
         and t1.tabla  = 'cl_rtipo'
         and c1.tabla  = t1.codigo
         and c1.codigo = x.tipo
         and ci_pais   = pa_pais

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
     and c1.codigo = x.treferencia
  return 0

go

