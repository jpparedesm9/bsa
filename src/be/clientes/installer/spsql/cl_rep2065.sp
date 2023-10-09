/************************************************************************/
/*  Archivo:            cl_rep2065.sp                                   */
/*  Stored procedure:   sp_rep2065                                      */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Rafael Adames                                   */
/*  Fecha de escritura: 12-Dec-2006                                     */
/************************************************************************/
/*                      IMPORTANTE                                      */
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
/*                      PROPOSITO                                       */
/*  Este stored procedure procesa:                                      */
/*  generacion de tabla temporal para el reporte 2065 de                */
/*  de detalles de clientes bloqueados por oficina                      */
/************************************************************************/
/*                     MODIFICACIONES                                   */
/*  FECHA       AUTOR        RAZON                                      */
/* 12-Dec-2006  R.Adames     Version inicial                            */
/* 05/Jul/2007  Felipe R.    Optimizacion                               */
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
           where  name = 'sp_rep2065')
  drop proc sp_rep2065
go

create proc sp_rep2065
(
  @t_show_version bit = 0,
  @i_oficina      smallint
)
as
  declare
    @w_today       datetime,
    @w_sp_name     varchar(32),
    @w_return      int,
    @w_fec_proceso datetime

  select
    @w_sp_name = 'sp_rep2065'

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

  -- Borrado de temporales
  truncate table cl_tempo_2065
  truncate table cl_tempo1_2065

  insert into cl_tempo_2065
              (ente,nombre)
    select
      en_ente,en_nomlar
    from   cl_ente
    where  en_oficina = @i_oficina

  update cl_tempo_2065
  set    cod_direccion = di_direccion,
         direccion = di_descripcion
  from   cl_direccion
  where  di_ente      = ente
     and di_principal = 'S'

  update cl_tempo_2065
  set    telefono = te_valor
  from   cl_telefono
  where  te_ente      = ente
     and te_direccion = cod_direccion

  insert into cl_tempo1_2065
    select
      ente,nombre,(select
         cb_causa
       from   cl_causa_bloqueo
       where  A.lb_num_causa = cb_num_causa),datediff(day,
               lb_fecha_registro,
               @w_today),direccion,
      telefono
    from   cl_tempo_2065,
           cl_log_bloqueo_opt A
    where  ente = lb_ente

  if @@rowcount = 0
    return -999
  else
    return 0

go

