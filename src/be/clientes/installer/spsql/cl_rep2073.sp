/************************************************************************/
/*  Archivo:            cl_rep2073.sp                                   */
/*  Stored procedure:   sp_rep2073                                      */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Rafael Adames                                   */
/*  Fecha de escritura: 12-Dec-2006                                     */
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
/*  Este stored procedure procesa:                                      */
/*  generacion de tabla temporal para los reportes 2073 y 2065 de       */
/*  estadisticas de clientes bloqueados y de detalles de clientes       */
/*  bloqueados respectivamente                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR        RAZON                                      */
/* 12-Dec-2006  R.Adames     Version inicial                            */
/* May/02/2016  DFu          Migracion CEN                              */
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
           where  name = 'sp_rep2073')
  drop proc sp_rep2073
go

create proc sp_rep2073
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

  --      @i_operacion    char(1),
  @i_ente         int = 1,
  @o_retorno      char(1) = null output
)
as
  declare
    @w_today       datetime,
    @w_sp_name     varchar(32),
    @w_return      int,
    @w_subtipo     char(1),
    @w_tipo_ced    char(2),
    @w_fec_nac     datetime,
    @w_ced_ruc     numero,
    @w_cont_val    smallint,
    @w_dep_nac     int,
    @w_ciudad_nac  int,
    @w_nomlar      varchar(254),
    @w_profesion   catalogo,
    @w_actividad   catalogo,
    @w_otros_ing   descripcion,
    @w_relacint    char(1),
    @w_fec_finan   datetime,
    @w_activos     money,
    @w_pasivos     money,
    @w_ingresos    money,
    @w_egresos     money,
    @w_patrimonio  money,
    @w_tipo_soc    catalogo,
    @w_rep_legal   int,
    @w_legal_ente  int,
    @w_subtipo_rl  char(1),
    @w_ced_ruc_rl  numero,
    @w_nomlar_rl   varchar(254),
    @w_asalariado  varchar(10),
    @w_ot_ing      int,
    @w_ot_ingop    int,
    @w_act_default varchar(10),
    -- Vairables para opci=n M      
    @w_ente        int,
    @w_fec_proceso datetime,
    @w_conerror    char(1),
    @w_msg         descripcion,
    @w_cliente     char(1),
    @w_ocupacion   varchar(10),
    @w_min_ente    int,
    @w_max_ente    int,
    @w_min         int,
    @w_max         int,
    @w_lote        int,
    @w_avance      float
  declare
    @val1       smallint,
    @val2       smallint,
    @val3       smallint,
    @val4       smallint,
    @val5       smallint,
    @val6       smallint,
    @val7       smallint,
    @val8       smallint,
    @val9       smallint,
    @val10      smallint,
    @val11      smallint,
    @val12      smallint,
    @val13      smallint,
    @val14      smallint,
    @val15      smallint,
    @val16      smallint,
    @val17      smallint,
    @val18      smallint,
    @val19      smallint,
    @val20      smallint,
    @val21      smallint,
    @val22      smallint,
    @val23      smallint,
    @val24      smallint,
    @val25      smallint,
    @val26      smallint,
    @val27      smallint,
    @val28      smallint,
    @w_ente_ant int,
    @w_oficina  smallint

  select
    @w_sp_name = 'sp_rep2073'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  select
    @w_fec_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_min_ente = 1

  select
    @w_max_ente = max(en_ente)
  from   cobis..cl_ente

  -- Borrado de temporales

  truncate table cl_temp2_2073

  truncate table cl_temp_2073

  -- se recorren todas las oficinas

  set rowcount 1
  select
    @w_oficina = of_oficina
  from   cobis..cl_oficina
  where  of_oficina > 0
     and of_oficina < 10000

  while @@rowcount > 0
  begin
    set rowcount 0
    --  print 'Procesando la oficina: %1!', @w_oficina

    insert into cl_temp_2073
      select
        @w_oficina,lb_num_causa,datediff(day,
                 lb_fecha_registro,
                 @w_today)
      from   cobis..cl_log_bloqueo_opt,
             cobis..cl_ente
      where  en_oficina = @w_oficina
         and lb_ente    = en_ente

    set rowcount 1
    select
      @w_oficina = of_oficina
    from   cobis..cl_oficina
    where  of_oficina > @w_oficina
       and of_oficina < 10000
  end
  set rowcount 0

  if not exists (select
                   *
                 from   sysindexes
                 where  id   = object_id('dbo.cl_temp_2073')
                    and name = 'cl_temp_2073_Key')
    create nonclustered index cl_temp_2073_Key
      on cl_temp_2073(oficina)

  set rowcount 1
  select
    @w_oficina = of_oficina
  from   cobis..cl_oficina
  where  of_oficina > 0
     and of_oficina < 10000

  while @@rowcount > 0
  begin
    set rowcount 0
    --  print 'Procesando la oficina: %1!', @w_oficina

    insert into cl_temp2_2073
      select
        @w_oficina,num_causa,dias,count(1)
      from   cl_temp_2073
      where  oficina = @w_oficina
      group  by num_causa,
                dias

    set rowcount 1
    select
      @w_oficina = of_oficina
    from   cobis..cl_oficina
    where  of_oficina > @w_oficina
       and of_oficina < 10000

  end
  set rowcount 0
  -- borrado de temporal no utilizada

  truncate table cl_temp_2073

  return 0

go

