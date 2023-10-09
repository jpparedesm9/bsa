/* ***********************************************************************/
/*      Archivo:                cl_alianza_def_ente.sp                   */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           A.Zuluaga                                */
/*      Fecha de escritura:     19-Jun-2014                              */
/* ***********************************************************************/
/*              IMPORTANTE                                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de COBISCorp.                                                        */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* ***********************************************************************/
/*              PROPOSITO                                                */
/*  Permite consultar las alianzas comerciales existentes (defaults)     */
/* ***********************************************************************/
/*                 MODIFICACIONES                                        */
/*  FECHA          AUTOR            RAZON                                */
/*  19-Jun-2014    A.Zuluaga        Emision inicial                      */
/*  May/02/2016    DFu              Migracion CEN                        */
/*************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_alianzas_defaults_ente')
  drop proc sp_alianzas_defaults_ente
go

create proc sp_alianzas_defaults_ente
(
  @s_ssn           int,
  @t_trn           smallint = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_show_version  bit = 0,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_rol           smallint = null,
  @s_ofi           smallint = null,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           descripcion = null,
  @s_org           char(1) = null,
  @i_alianza       int = null,
  @i_operacion     char(1) = null,
  @i_modo          tinyint = 0,
  @i_campo         varchar(255) = null,
  @i_des_campo     varchar(255) = null,
  @i_valor_default varchar(255) = null
)
as
  declare
    @w_sp_name varchar(64),
    @w_alianza int,
    @w_existe  tinyint,
    @w_msg     varchar(255),
    @w_num     int

  select
    @w_sp_name = 'sp_alianzas_defaults_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Buscar Datos par ael FE
  if @i_operacion = 'S'
  begin
    if @i_modo = 0
    begin
      --Grid Asociados
      select
        'Descripcion Campo' = mr_des_campo,
        'Nombre Campo' = mr_nom_campo,
        'Valor Default' = mr_valor_default
      from   cl_msv_relacion_default_ente
      where  mr_alianza = @i_alianza

      --Grid por Asociar
      create table #temporal
      (
        descampo varchar(30) null,
        nomcampo varchar(30) null
      )

      insert into #temporal
        select
          'Oficina','mc_ofi'

      insert into #temporal
        select
          'Sexo','mc_sexo'

      insert into #temporal
        select
          'Fecha Nac.','mc_fecha_nac'

      insert into #temporal
        select
          'Ciudad Nac.','mc_ciudad_nac'

      insert into #temporal
        select
          'Lugar Doc.','mc_lugar_doc'

      insert into #temporal
        select
          'Estado Civil','mc_estado_civil'

      insert into #temporal
        select
          'Actividad Ec.','mc_actividad'

      insert into #temporal
        select
          'Fecha Emision','mc_fecha_emision'

      insert into #temporal
        select
          'Sector','mc_sector'

      insert into #temporal
        select
          'Tipo Productor','mc_tipo_productor'

      insert into #temporal
        select
          'Regimen Fiscal','mc_regimen_fiscal'

      insert into #temporal
        select
          'Antiguedad','mc_antiguedad'

      insert into #temporal
        select
          'Estrato','mc_estrato'

      insert into #temporal
        select
          'Recuros Publ.','mc_recurso_pub'

      insert into #temporal
        select
          'Influencia','mc_influencia'

      insert into #temporal
        select
          'Persona Pub.','mc_persona_pub'

      insert into #temporal
        select
          'Victima','mc_victima'

      insert into #temporal
        select
          'Descripcion','mc_descripcion'

      insert into #temporal
        select
          'Tipo','mc_tipo'

      insert into #temporal
        select
          'Principal','mc_principal'

      insert into #temporal
        select
          'Ciudad','mc_ciudad'

      insert into #temporal
        select
          'Rural/Urbano','mc_rural_urb'

      insert into #temporal
        select
          'Observacion','mc_observacion'

      insert into #temporal
        select
          'Valor','mc_valor'

      insert into #temporal
        select
          'Tipo Telefono','mc_tipo_telefono'

      insert into #temporal
        select
          'Origen Fondos','mc_origen_fondos'

      insert into #temporal
        select
          'Mercado Obj.','mc_mercado_objetivo'

      insert into #temporal
        select
          'Subtipo Mercado','mc_subtipo_mo'

      insert into #temporal
        select
          'Banca','mc_banca'

      insert into #temporal
        select
          'Segmento','mc_segmento'

      insert into #temporal
        select
          'Subsegmento','mc_subsegmento'

      select
        *
      from   #temporal

    end
  end

  --Asignar un campo a la tabla de defaults
  if @i_operacion = 'A'
  begin
    insert into cl_msv_relacion_default_ente
    values      (@i_alianza,@i_des_campo,@i_campo,null)

    select
      *
    from   cl_msv_relacion_default_ente
    if @@error <> 0
    begin
      select
        @w_msg = 'Error Insertando Asociacion de Defaults para la Alianza',
        @w_num = 1
      goto ERROR
    end

  end

  --DesAsignar un campo a la tabla de defaults
  if @i_operacion = 'D'
  begin
    delete cl_msv_relacion_default_ente
    where  mr_alianza   = @i_alianza
       and mr_nom_campo = @i_campo

    if @@error <> 0
    begin
      select
        @w_msg = 'Error Eliminando Asociacion de Defaults para la Alianza',
        @w_num = 1
      goto ERROR
    end

  end

  --Grabar en el campo el valor default
  if @i_operacion = 'U'
  begin
    update cl_msv_relacion_default_ente
    set    mr_valor_default = @i_valor_default
    where  mr_alianza   = @i_alianza
       and mr_nom_campo = @i_campo

    if @@error <> 0
    begin
      select
        @w_msg = 'Error Actualizando Valor Default para el Campo',
        @w_num = 1
      goto ERROR
    end

  end

  return 0

  ERROR:

  exec sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_num,
    @i_msg   = @w_msg
  return @w_num

go

