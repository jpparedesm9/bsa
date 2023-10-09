/************************************************************************/
/*      Archivo:                cl_depur.sp                             */
/*      Stored procedure:       sp_depura_data                          */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Diego Fernando Duran R.                 */
/*      Fecha de escritura:     13-Jul-2004                             */
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
/*                             PROPOSITO                                */
/*   Este sp recibe los parametros de fecha inicio y final, con base a  */
/*   esto se llenan unas tablas temporales correspondientes a la        */
/*   informacion obtenida de la consulta efectuada a las tablas         */
/*   originales de cobis.                                               */
/*   cl_tran_servicio,cl_actualiza, cl_tran_servicio_conv, etc.  luego  */
/*   realiza borrado de la informacion  a las tablas originales.        */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    06/Jul/2004     D. Duran         Emision Inicial                  */
/*    May/02/2016     DFu              Migracion CEN                    */
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
           where  name = 'sp_depura_data')
  drop proc sp_depura_data
go

create proc sp_depura_data
(
  @i_fecha_ini    datetime,
  @i_fecha_fin    datetime,
  @s_ssn          int = null,
  @s_ssn_branch   int = null,
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
  @t_show_version bit = 0
)
as
  declare
    /** GENERALES **/
    @w_sp_name             descripcion,
    @w_total_tran_ser_tmp  int,
    @w_total_actualiza     int,
    @w_total_tran_conv     int,
    @w_total_tran_conv_mer int,
    @w_total_tran_conv_dir int,
    @w_total_tran_conv_tel int,
    @w_total_procesa_pit   int,
    @w_total_fi_tran_serv  int,
    @w_total_co_consolida  int,
    @w_fecha_proceso       datetime,
    @w_secuencial          int

  select
    @w_sp_name = 'sp_dbembargo'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_proceso = fp_fecha
  from   ba_fecha_proceso

/** OBTENER INFORMACION TABLAS ORIGINALES **/
  /* cl_tran_servicio*/

  insert into cl_tran_servicio_tmp
    select
      *
    from   cobis..cl_tran_servicio
    where  ts_fecha >= @i_fecha_ini
       and ts_fecha <= @i_fecha_fin

  /* cl_actualiza */
  insert into cl_actualiza_tmp
    select
      *
    from   cobis..cl_actualiza
    where  ac_fecha >= @i_fecha_ini
       and ac_fecha <= @i_fecha_fin

  /* cl_tran_servicio_conv*/
  insert into cl_tran_servicio_conv_tmp
    select
      *
    from   cobis..cl_tran_servicio_conv
    where  fecha_upd >= @i_fecha_ini
       and fecha_upd <= @i_fecha_fin

  /* cl_tran_servicio_conv_mer */
  insert into cl_tran_servicio_conv_mer_tmp
    select
      *
    from   cobis..cl_tran_servicio_conv_mer
    where  fecha_upd >= @i_fecha_ini
       and fecha_upd <= @i_fecha_fin

  /* cl_trn_servicio_conv_dir */
  insert into cl_tran_servicio_conv_dir_tmp
    select
      *
    from   cobis..cl_tran_servicio_conv_dir
    where  fecha_upd >= @i_fecha_ini
       and fecha_upd <= @i_fecha_fin

  /* cl_tran_servicio_conv_tel */
  insert into cl_tran_servicio_conv_tel_tmp
    select
      *
    from   cobis..cl_tran_servicio_conv_tel
    where  fecha_upd >= @i_fecha_ini
       and fecha_upd <= @i_fecha_fin

  /* fi_tran_servicio */
  insert into fi_tran_servicio_tmp
    select
      *
    from   firmas..fi_tran_servicio
    where  ts_tsfecha >= @i_fecha_ini
       and ts_tsfecha <= @i_fecha_fin

  /*REALIZA BORRADO DE TABLAS ORIGINALES. DEACUERDO AL RANGO INDICADO.*/

  begin tran

  delete cobis..cl_tran_servicio
  where  ts_fecha >= @i_fecha_ini
     and ts_fecha <= @i_fecha_fin

  delete cobis..cl_actualiza
  where  ac_fecha >= @i_fecha_ini
     and ac_fecha <= @i_fecha_fin

  delete cobis..cl_tran_servicio_conv
  where  fecha_upd >= @i_fecha_ini
     and fecha_upd <= @i_fecha_fin

  delete cobis..cl_tran_servicio_conv_mer
  where  fecha_upd >= @i_fecha_ini
     and fecha_upd <= @i_fecha_fin

  delete cobis..cl_tran_servicio_conv_dir
  where  fecha_upd >= @i_fecha_ini
     and fecha_upd <= @i_fecha_fin

  delete cobis..cl_tran_servicio_conv_tel
  where  fecha_upd >= @i_fecha_ini
     and fecha_upd <= @i_fecha_fin

  delete cobis..cl_procesa_pitembargo
  where  pp_fecha_embargo >= @i_fecha_ini
     and pp_fecha_embargo <= @i_fecha_fin

  delete firmas..fi_tran_servicio
  where  ts_tsfecha >= @i_fecha_ini
     and ts_tsfecha <= @i_fecha_fin

  commit tran

  return 0

go

