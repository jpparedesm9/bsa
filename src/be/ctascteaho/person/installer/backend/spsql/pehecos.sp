/****************************************************************************/
/*     Archivo:     pehecos.sp                                              */
/*     Stored procedure: sp_help_costos                                     */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 02-Ene-1995                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa realiza el search/query de costos                      */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*       JUN/95       J.Gordillo     Personalizacion de Bco. Produccion     */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error          */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_costos')
  drop proc sp_help_costos
go

create proc sp_help_costos
(
  @s_ssn          int,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_user         varchar(30) = null,
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_org          char(1),
  @s_ofi          smallint,
  @s_rol          smallint,
  @s_org_err      char(1)=null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint=null,
  @i_tipo         char(1)=null,
  @i_filial       tinyint = null,
  @i_sucursal     smallint = null,
  @i_servicio     smallint= null,
  @i_categoria    catalogo= null,
  @i_rango        tinyint= null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int

  select
    @w_sp_name = 'sp_help_costos'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**Store Procedure**/' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      t_file = @t_file,
      t_from = @t_from,
      t_trn = @t_trn,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_tipo = @i_tipo,
      i_filial = @i_filial,
      i_sucursal = @i_sucursal,
      i_servicio = @i_servicio,
      i_categoria = @i_categoria,
      i_rango = @i_rango
    exec cobis..sp_end_debug
  end

  if @t_trn != 4058
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 351516
    return 351516
  end

  /* Consulta */
  if @i_operacion = 'S'
  begin
    set rowcount 15
    if @i_modo = 0
    begin
      if @i_tipo = 'S'
        select
          '1710' = sp_servicio_per,                  --SERVICIO
          '1896' = substring(vs_descripcion, 1, 35), --DESCRIPCION
          '1751' = sp_tipo_rango,                    --TIPO DE RANGO
          '1665' = sp_pro_final,                     --PRODUCTO FINAL
          '1200' = substring(pf_descripcion, 1, 45)  --DESCRIPCION DEL PROD. FIN.
        from   pe_servicio_per,
               pe_var_servicio,
               pe_pro_final
        where  sp_servicio_per in
               (select distinct
                  co_servicio_per
                from   pe_costo)
               and vs_servicio_dis = sp_servicio_dis
               and vs_rubro        = sp_rubro
               and pf_pro_final    = sp_pro_final
               and pf_filial       = @i_filial
               and pf_sucursal     = @i_sucursal
        order  by sp_servicio_per

      else if @i_tipo = 'C'
        select distinct
          '1063' = co_categoria,           --CATEGORIA
          '1896' = substring(valor, 1, 35) --DESCRIPCION
        from   pe_costo,
               cobis..cl_catalogo a,
               cobis..cl_tabla b
        where  co_servicio_per = @i_servicio
           and a.codigo        = co_categoria
           and a.tabla         = b.codigo
           and b.tabla         = 'pe_categoria'
        order  by co_categoria

      else if @i_tipo = 'R'
        select
          '1678' = co_rango, --RANGO
          '1213' = ra_desde, --DESDE
          '1398' = ra_hasta, --HASTA
          '1333' = ra_estado --ESTADO
        from   pe_costo,
               pe_rango
        where  co_servicio_per = @i_servicio
           and co_categoria    = @i_categoria
           and ra_rango        = co_rango
           and ra_tipo_rango   = co_tipo_rango
        order  by co_rango
    end

    else
    begin
      if @i_tipo = 'S'
        select
          '1710' = sp_servicio_per,                  --SERVICIO
          '1896' = substring(vs_descripcion, 1, 35), --DESCRIPCION
          '1751' = sp_tipo_rango,                    --TIPO DE RANGO
          '1665' = sp_pro_final,                     --PRODUCTO FINAL
          '1200' = substring(pf_descripcion, 1, 45)  --DESCRIPCION DEL PROD. FIN.
        from   pe_servicio_per,
               pe_var_servicio,
               pe_pro_final
        where  sp_servicio_per in
               (select distinct
                  co_servicio_per
                from   pe_costo)
               and vs_servicio_dis = sp_servicio_dis
               and vs_rubro        = sp_rubro
               and pf_pro_final    = sp_pro_final
               and pf_filial       = @i_filial
               and pf_sucursal     = @i_sucursal
               and sp_servicio_per > @i_servicio
        order  by sp_servicio_per

      else if @i_tipo = 'C'
        select distinct
          '1063' = co_categoria,           --CATEGORIA
          '1896' = substring(valor, 1, 35) --DESCRIPCION
        from   pe_costo,
               cobis..cl_catalogo a,
               cobis..cl_tabla b
        where  co_servicio_per = @i_servicio
           and a.codigo        = co_categoria
           and a.tabla         = b.codigo
           and b.tabla         = 'pe_categoria'
           and co_categoria    > @i_categoria
        order  by co_categoria

      else if @i_tipo = 'R'
        select
          '1678' = co_rango, --RANGO
          '1213' = ra_desde, --DESDE
          '1398' = ra_hasta, --HASTA
          '1333' = ra_estado --ESTADO
        from   pe_costo,
               pe_rango
        where  co_servicio_per = @i_servicio
           and co_categoria    = @i_categoria
           and ra_rango        = co_rango
           and ra_tipo_rango   = co_tipo_rango
           and co_rango        > @i_rango
        order  by co_rango

    end

    set rowcount 0

    return 0
  end

  /* Query */
  if @i_operacion = 'Q'
  begin
    if @i_tipo = 'S'
      select
        substring(vs_descripcion,
                  1,
                  35),
        sp_tipo_rango,
        sp_pro_final,
        substring(pf_descripcion,
                  1,
                  45)
      from   pe_servicio_per,
             pe_var_servicio,
             pe_pro_final
      where  sp_servicio_per in
             (select distinct
                co_servicio_per
              from   pe_costo)
             and vs_servicio_dis = sp_servicio_dis
             and vs_rubro        = sp_rubro
             and pf_pro_final    = sp_pro_final
             and pf_filial       = @i_filial
             and pf_sucursal     = @i_sucursal
             and sp_servicio_per = @i_servicio

    else if @i_tipo = 'C'
      select distinct
        substring(valor,
                  1,
                  35)
      from   cobis..cl_catalogo a,
             cobis..cl_tabla b,
             pe_costo
      where  co_servicio_per = @i_servicio
         and co_categoria    = @i_categoria
         and a.codigo        = co_categoria
         and a.tabla         = b.codigo
         and b.tabla         = 'pe_categoria'

    else if @i_tipo = 'R'
      select
        ra_desde,
        ra_hasta,
        ra_estado
      from   pe_costo,
             pe_rango
      where  co_servicio_per = @i_servicio
         and co_categoria    = @i_categoria
         and co_rango        = @i_rango
         and ra_rango        = co_rango

    if @@rowcount = 0
    begin
      /*Error en busqueda de parametros solicitados de costo*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351533
      return 351533
    end

    return 0
  end

GO 
