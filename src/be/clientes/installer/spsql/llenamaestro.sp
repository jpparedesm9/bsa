/************************************************************************/
/*  Archivo:        llenamaestro.sp                                     */
/*  Stored procedure:   sp_llenamaestro                                 */
/*  Base de datos:      cobis                                           */
/*  Producto:               MIS                                         */
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
/*  Este programa permite llenar la tabla cl_maestro_cliente            */
/*      utilizando todos los datos de cl_ente                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR             RAZON                                 */
/*  25/Oct/2002 G. Solanilla   Emision Inicial                          */
/*  28/Ago/2003 E. Laguna      Ajustes orden campos                     */
/*  21/Sep/2003 A. Duque       Volumen y Estres                         */
/*  04/May/2016 T. Baidal      Migracion a CEN                          */
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
           where  name = 'sp_llenamaestro')
    drop proc sp_llenamaestro
go

create proc sp_llenamaestro
(
  @t_file         varchar(30) = null,
  @t_debug        varchar(1) = null,
  @t_show_version bit = 0,
  @i_intervalo    int = 100000
)
as
  declare
    @w_subtipo           char (1),
    @w_ente              int,
    @w_tipo_ced          char(2),
    @w_ced_ruc           numero,
    @w_sexo              sexo,
    @w_profesion         descripcion,
    @w_estado_civil      descripcion,
    @w_actividad         descripcion,
    @w_sector            descripcion,
    @w_situacion_cliente descripcion,
    @w_tipo_vinculacion  descripcion,
    @w_nivel_estudio     descripcion,
    @w_tipo_vivienda     descripcion,
    @w_num_cargas        tinyint,
    @w_ocupacion         descripcion,
    @w_total_activos     money,
    @w_total_pasivos     money,
    @w_patrimonio_tec    money,
    @w_nivel_egr         money,
    @w_nivel_ing         money,
    @w_pensionado        char(1),
    @w_categoria         descripcion,
    @w_tipo_compania     descripcion,
    @w_tipo_soc          descripcion,
    @w_num_empleados     smallint,
    @w_ciudad_dir_ppal   descripcion,
    @w_oficial           smallint,
    @w_banca             descripcion,
    @w_mala_referencia   char(1),
    @w_cont_malas        smallint,
    @w_direccion_ppal    varchar(254),
    @w_nomlar            varchar(254),
    @w_contador          int,
    @w_contadoraux       int,
    @w_sp_name           varchar(30),
    @w_today             datetime,
    @w_des_profesion     descripcion,
    @w_des_estado_civil  descripcion,
    @w_des_actividad     descripcion,
    @w_des_sector        descripcion,
    @w_des_situa         descripcion,
    @w_des_nivel         descripcion,
    @w_des_tipo_vivienda descripcion,
    @w_des_categoria     descripcion,
    @w_des_compania      descripcion,
    @w_des_sociedad      descripcion,
    @w_des_oficial       descripcion,
    @w_des_direccion     descripcion,
    @w_des_vinculacion   descripcion,
    @w_des_ciudad        descripcion,
    @w_des_banca         descripcion,
    @w_tabla_profesion   smallint,
    @w_tabla_ecivil      smallint,
    @w_tabla_actividad   smallint,
    @w_tabla_sectoreco   smallint,
    @w_tabla_situacion   smallint,
    @w_tabla_vinculacion smallint,
    @w_tabla_estudio     smallint,
    @w_tabla_vivienda    smallint,
    @w_tabla_categoria   smallint,
    @w_tabla_nat_jur     smallint,
    @w_tabla_tipo_soc    smallint,
    @w_tabla_banca       smallint,
    @w_num_entes         int,
    @w_valor_inicial     int,
    @w_valor_final       int,
    @w_intervalo         int,
    @w_fecha             datetime

  select
    @w_sp_name = 'sp_llenamaestro'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = getdate()

  truncate table cl_oficial_funcionario

  truncate table cl_maestro_cliente

  insert into cl_oficial_funcionario
    select
      fu_nombre,oc_oficial
    from   cl_funcionario,
           cc_oficial
    where  fu_funcionario = oc_funcionario

  select
    @t_file = 'llenamaestro.sp'
  select
    @t_debug = 'N'
  select
    @w_today = getdate()
  select
    @w_contador = 0
  select
    @w_contadoraux = 0

  select
    @w_tabla_profesion = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_profesion'

  select
    @w_tabla_ecivil = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_ecivil'

  select
    @w_tabla_actividad = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_actividad'

  select
    @w_tabla_sectoreco = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_sectoreco'

  select
    @w_tabla_situacion = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_situacion_cliente'

  select
    @w_tabla_vinculacion = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_relacion_banco'

  select
    @w_tabla_estudio = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_nivel_estudio'

  select
    @w_tabla_vivienda = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_tipo_vivienda'

  select
    @w_tabla_categoria = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_categoria'

  select
    @w_tabla_nat_jur = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_nat_jur'

  select
    @w_tabla_tipo_soc = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_tip_soc'

  select
    @w_tabla_banca = codigo
  from   cobis..cl_tabla
  where  tabla = 'cl_banca_cliente'

  select
    @w_intervalo = @i_intervalo

  select
    @w_valor_inicial = 1,
    @w_valor_final = @w_intervalo

  select
    @w_num_entes = max(en_ente)
  from   cobis..cl_ente

  while @w_valor_inicial < @w_num_entes
  begin
    begin tran
    insert into cl_maestro_cliente
                (ma_subtipo,ma_ente,ma_tipo_ced,ma_ced_ruc,ma_sexo,
                 ma_profesion,ma_estado_civil,ma_actividad,ma_sector,
                 ma_situacion_cliente,
                 ma_tipo_vinculacion,ma_nivel_estudio,ma_tipo_vivienda,
                 ma_num_cargas
                 ,ma_total_activos,
                 ma_total_pasivos,ma_patrimonio_tec,ma_egresos,ma_ingresos,
                 ma_pensionado,
                 ma_categoria,ma_tipo_compania,ma_tipo_soc,ma_num_empleados,
                 ma_ciudad_dir_ppal,
                 ma_oficial,ma_banca,ma_mala_referencia,ma_cont_malas,
                 ma_direccion_ppal,
                 ma_nomlar)
      select
        en_subtipo,en_ente,en_tipo_ced,en_ced_ruc,p_sexo,
        a.valor,b.valor,c.valor,d.valor,e.valor,
        f.valor,g.valor,h.valor,p_num_cargas,c_total_activos,
        c_total_pasivos,en_patrimonio_tec,p_nivel_egr,p_nivel_ing,en_pensionado,
        i.valor,j.valor,k.valor,c_num_empleados,ci_descripcion,
        of_nombre,l.valor,en_mala_referencia,en_cont_malas,di_descripcion,
        en_nomlar
      from   cl_ente
             left join cl_catalogo a
                    on p_profesion = a.codigo
                       and a.tabla = @w_tabla_profesion
             left join cl_catalogo b
                    on p_estado_civil = b.codigo
                       and b.tabla = @w_tabla_ecivil
             left join cl_catalogo c
                    on en_actividad = c.codigo
                       and c.tabla = @w_tabla_actividad
             left join cl_catalogo d
                    on en_actividad = d.codigo
                       and d.tabla = @w_tabla_sectoreco
             left join cl_catalogo e
                    on en_situacion_cliente = e.codigo
                       and e.tabla = @w_tabla_situacion
             left join cl_catalogo f
                    on en_tipo_vinculacion = f.codigo
                       and f.tabla = @w_tabla_vinculacion
             left join cl_catalogo g
                    on p_nivel_estudio = g.codigo
                       and g.tabla = @w_tabla_estudio
             left join cl_catalogo h
                    on p_nivel_estudio = h.codigo
                       and h.tabla = @w_tabla_vivienda
             left join cl_catalogo i
                    on en_categoria = i.codigo
                       and i.tabla = @w_tabla_categoria
             left join cl_catalogo j
                    on c_tipo_compania = j.codigo
                       and j.tabla = @w_tabla_nat_jur
             left join cl_catalogo k
                    on c_tipo_soc = k.codigo
                       and k.tabla = @w_tabla_tipo_soc
             left join cl_catalogo l
                    on en_banca = l.codigo
                       and l.tabla = @w_tabla_banca
             left join cl_oficial_funcionario
                    on en_oficial = of_oficial
             left join cl_direccion
                    on di_ente = en_ente
                       and di_principal = 'S'
             left join cl_ciudad
                    on di_ciudad = ci_ciudad
      where  en_ente >= @w_valor_inicial
         and en_ente <= @w_valor_final

    commit tran

    select
      @w_valor_inicial = @w_valor_final + 1,
      @w_valor_final = @w_valor_final + @w_intervalo
  end

  select
    @w_fecha = getdate()

go

