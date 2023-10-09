/****************************************************************************/
/*     Archivo:     pehecos2.sp                                             */
/*     Stored procedure: sp_help2_costos                                    */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 05-Ene-1995                                      */
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
/*     Este programa realiza una consulta general de costo                  */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*      JUN/95       J.Gordillo    Personalizacion Bco.Produccion           */
/*      Nov 07 2002  Jorge Galeano Cambia texto Medio por Base              */
/*     30/Sep/2003      Gloria Rueda    Retornar c¢digos de error          */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_help2_costos')
  drop proc sp_help2_costos
go

create proc sp_help2_costos
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
  @i_operacion    char(3),
  @i_filial       tinyint = null,
  @i_sucursal     smallint = null,
  @i_servicio     smallint= null,
  @i_categoria    catalogo= null,
  @i_tipo_rango   tinyint= null,
  @i_rango        tinyint= null,
  @i_secuencial   int = 0
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_today   smalldatetime

  select
    @w_sp_name = 'sp_help2_costos',
    @w_today = @s_date

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
      t_from = @t_from,
      t_file = @t_file,
      t_trn = @t_trn,
      i_operacion = @i_operacion,
      i_filial = @i_filial,
      i_sucursal = @i_sucursal,
      i_servicio = @i_servicio,
      i_categoria = @i_categoria,
      i_tipo_rango = @i_tipo_rango,
      i_rango = @i_rango
    exec cobis..sp_end_debug
  end

  if @t_trn != 4059
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
    select
      '1710' = c.co_servicio_per,                                  --SERVICIO
      '1897' = substring(vs_descripcion, 1, 35),                   --DESCRIPCION DE SERVICIO
      '1751' = c.co_tipo_rango,                                    --TIPO DE RANGO
      '1894' = substring(tr_descripcion, 1, 35),                   --DESCRIPCION DE TIPO RANGO
      '1665' = sp_pro_final,                                       --PRODUCTO FINAL
      '1200' = substring(pf_descripcion, 1, 35),                   --DESCRIPCION DE PROD.FIN.
      '1063' = c.co_categoria,                                     --CATEGORIA
      '1898' = substring(a.valor, 1, 35),                          --DESCRIPCION DE CATEGORIA
      '1381' = c.co_grupo_rango,                                   --GRUPO
      '1678' = c.co_rango,                                         --RANGO
      '1026' = c.co_val_medio,                                     --BASE
      '1478' = c.co_minimo,                                        --MINIMO
      '1471' = c.co_maximo                                         --MAXIMO
    from   pe_costo c,
           pe_servicio_per,
           pe_var_servicio,
           pe_tipo_rango,
           cobis..cl_catalogo a,
           cobis..cl_tabla b,
           pe_pro_final
    where  sp_servicio_per   = c.co_servicio_per
       and vs_servicio_dis   = sp_servicio_dis
       and vs_rubro          = sp_rubro
       and pf_pro_final      = sp_pro_final
       and pf_filial         = @i_filial
       and pf_sucursal       = @i_sucursal
       and tr_tipo_rango     = c.co_tipo_rango
       and b.tabla           = 'pe_categoria'
       and a.tabla           = b.codigo
       and a.codigo          = c.co_categoria
       and c.co_fecha_vigencia in
           (select
              max(d.co_fecha_vigencia)
            from   pe_costo d
            where  d.co_servicio_per = c.co_servicio_per
               and d.co_categoria    = c.co_categoria
               and d.co_tipo_rango   = c.co_tipo_rango
               and d.co_rango        = c.co_rango)
       and c.co_secuencial in
           (select
              max(e.co_secuencial)
            from   pe_costo e
            where  e.co_servicio_per = c.co_servicio_per
               and e.co_categoria    = c.co_categoria
               and e.co_tipo_rango   = c.co_tipo_rango
               and e.co_rango        = c.co_rango
               and e.co_categoria    = c.co_categoria)
       and (c.co_servicio_per > @i_servicio
             or (c.co_servicio_per = @i_servicio
                 and c.co_categoria    > @i_categoria)
             or (c.co_servicio_per = @i_servicio
                 and c.co_categoria    = @i_categoria
                 and c.co_rango        > @i_rango))
    order  by c.co_servicio_per,
              c.co_categoria,
              c.co_tipo_rango,
              c.co_rango

    set rowcount 0
    return 0
  end

  /* Consulta de Valores a entrar en vigencia */
  if @i_operacion = 'CVV'
  begin
    set rowcount 15

    select
      '1367' = convert(char(10), cc_fecha_vigencia, 101), --FECHA DE VIGENCIA
      '1899' = substring(vs_descripcion, 1, 35),          --SERVICIO PERSONALIZABLE
      '1063' = substring(b.valor, 1, 20),                 --CATEGORIA
      '1751' = substring(tr_descripcion, 1, 35),          --TIPO DE RANGO
      '1382' = cc_grupo_rango,                            --GRUPO DE RANGO
      '1678' = cc_rango,                                  --RANGO
      '1213' = ra_desde,                                  --DESDE
      '1398' = ra_hasta,                                  --HASTA  
      '1478' = cc_minimo,                                 --MINIMO
      '1026' = cc_val_medio,                              --BASE
      '1471' = cc_maximo,                                 --MAXIMO
      cc_secuencial
    from   pe_cambio_costo,
           pe_var_servicio,
           pe_tipo_rango,
           pe_servicio_per,
           pe_rango,
           cobis..cl_tabla a,
           cobis..cl_catalogo b,
           pe_pro_final
    where  sp_servicio_per = cc_servicio_per
       and vs_servicio_dis = sp_servicio_dis
       and vs_rubro        = sp_rubro
       and pf_pro_final    = sp_pro_final
       and pf_filial       = @i_filial
       and pf_sucursal     = @i_sucursal
       and tr_tipo_rango   = cc_tipo_rango
       and ra_tipo_rango   = cc_tipo_rango
       and ra_grupo_rango  = cc_grupo_rango
       and ra_rango        = cc_rango
       and a.tabla         = 'pe_categoria'
       and b.tabla         = a.codigo
       and b.codigo        = cc_categoria
       and cc_en_linea     = 'N'
       and cc_secuencial   > @i_secuencial
    order  by cc_fecha_vigencia,
              cc_secuencial

    set rowcount 0
    return 0
  end

GO 
