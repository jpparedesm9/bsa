/************************************************************************/
/*      Archivo:                clrelval.sp                             */
/*      Stored procedure:       sp_relacion_validar                     */
/*      Base de datos:          cobis                                   */
/*      Producto:               MIS                                     */
/*      Disenado por:           Gabriel H Alvis S                       */
/*      Fecha de escritura:     26/ENE/2011                             */
/* **********************************************************************/
/*                            IMPORTANTE                                */
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
/* **********************************************************************/
/*                             PROPOSITO                                */
/*    Consulta de socios de una persona (J/N) de acuerdo a su           */
/*    participacion accionaria para revision en centrales de riesgo     */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR               RAZON                               */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if not object_id('sp_relacion_validar') is null
  drop proc sp_relacion_validar
go

create proc sp_relacion_validar
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_modo         char(1),
  @i_valida       char(1) = 'N',
  @i_frontend     char(1) = 'N'
as
  declare
    @w_return             int,
    @w_error              int,
    @w_sp_name            varchar(32),
    @w_rel_accionista_nat smallint,
    @w_rel_accionista_jur smallint,
    @w_rel_rep_legal      smallint,
    @w_max_socios_val     smallint,
    @w_cod_porc_part_acc  tinyint

  select
    @w_sp_name = 'sp_relacion_validar'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/* INI - CONSULTA DE PARAMETROS GENERALES */
  -- CODIGO DE RELACION ACCIONISTA PERSONA NATURAL
  select
    @w_rel_accionista_nat = pa_smallint
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'RL1'

  -- CODIGO DE RELACION ACCIONISTA PERSONA JURIDICA
  select
    @w_rel_accionista_jur = pa_smallint
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'RL2'

  -- CODIGO DE RELACION REPRESENTANTE LEGAL
  select
    @w_rel_rep_legal = pa_smallint
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'RL5'

  -- MAXIMA CANTIDAD DE SOCIOS A VALIDAR
  select
    @w_max_socios_val = pa_smallint
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'MXSOVA'

  -- CODIGO DEL PORCENTAJE DE PARTICIPACION ACCIONARIO
  select
    @w_cod_porc_part_acc = pa_tinyint
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'CPPAAC'
  /* FIN - CONSULTA DE PARAMETROS GENERALES */

  if @i_modo = 'M'
  begin
    -- CONSULTA DE ACCIONISTAS POR PARTICIPACION
    insert into #rel_validar
                (ente_sup,oficina,usuario,tramite,ente_inf,
                 porcentaje,secuencial)
      select
        in_ente_d,oficina,usuario,tramite,in_ente_i,
        convert(float, ai_valor),row_number()
          over(
            partition by in_ente_d
            order by convert(float, ai_valor) desc, in_ente_i asc)
      from   #tmp_validar
             inner join cl_instancia
                     on rol = 'D'
                        and in_ente_d = ente
                        and in_relacion in (@w_rel_accionista_nat,
                                            @w_rel_accionista_jur)
                        and in_lado = 'I'
             left outer join cl_at_instancia
                          on ai_ente_d = in_ente_d
                             and ai_ente_i = in_ente_i
                             and ai_relacion = in_relacion
                             and ai_atributo = @w_cod_porc_part_acc
    -- PORCENTAJE DE PARTICIPACION ACCIONARIA

    if @@error <> 0
    begin
      select
        @w_error = 107212
      goto ERROR
    end

    -- CONSULTA DE REPRESENTANTE LEGAL
    insert into #rel_validar
                (ente_sup,oficina,usuario,tramite,ente_inf,
                 secuencial)
      select
        in_ente_d,oficina,usuario,tramite,in_ente_i,
        0
      from   #tmp_validar,
             cl_instancia
      where  rol         = 'D'
         and in_ente_d   = ente
         and in_relacion = @w_rel_rep_legal
         and in_lado     = 'I'

    if @@error <> 0
    begin
      select
        @w_error = 107213
      goto ERROR
    end

    -- ELIMINACION DE SOCIOS DE MENOR PARTICIPACION POR SUPERAR LA CANTIDAD VALIDABLE
    if @i_valida = 'S'
    begin
      delete #rel_validar
      where  secuencial > @w_max_socios_val

      if @@error <> 0
      begin
        select
          @w_error = 107214
        goto ERROR
      end
    end
  end

  if @i_modo = 'C'
  begin
    create table #relaciones
    (
      ente_sup   int not null,
      ente_inf   int not null,
      relacion   int not null,
      porcentaje float null,
      secuencial int not null
    )

    insert into #relaciones
                (ente_sup,ente_inf,relacion,porcentaje,secuencial)
      select
        in_ente_d,in_ente_i,in_relacion,convert(float, ai_valor),row_number()
          over(
            order by convert(float, ai_valor) desc, in_ente_i asc)
      from   cl_instancia
             left outer join cl_at_instancia
                          on ai_ente_d = in_ente_d
                             and ai_ente_i = in_ente_i
                             and ai_relacion = in_relacion
                             and ai_atributo = @w_cod_porc_part_acc
      -- PORCENTAJE DE PARTICIPACION ACCIONARIA
      where  in_ente_d = @i_ente
         and in_relacion in (@w_rel_accionista_nat, @w_rel_accionista_jur)
         and in_lado   = 'I'

    if @@error <> 0
    begin
      select
        @w_error = 107212
      goto ERROR
    end

    insert into #relaciones
                (ente_sup,ente_inf,relacion,secuencial)
      select
        in_ente_d,in_ente_i,in_relacion,0
      from   cl_instancia
      where  in_ente_d   = @i_ente
         and in_relacion = @w_rel_rep_legal
         and in_lado     = 'I'

    if @@error <> 0
    begin
      select
        @w_error = 107213
      goto ERROR
    end

    -- ELIMINACION DE SOCIOS DE MENOR PARTICIPACION POR SUPERAR LA CANTIDAD VALIDABLE
    if @i_valida = 'S'
    begin
      delete #relaciones
      where  secuencial > @w_max_socios_val

      if @@error <> 0
      begin
        select
          @w_error = 107214
        goto ERROR
      end
    end

    select
      'RELACION' = 'TITULAR',
      'COD. CLIENTE' = @i_ente,
      'NOMBRE' = en_nomlar,
      'PORCENTAJE' = 0,
      'SECUENCIAL' = 0
    from   cl_ente
    where  en_ente = @i_ente
    union
    select
      'RELACION' = re_descripcion,
      'COD. CLIENTE' = ente_inf,
      'NOMBRE' = en_nomlar,
      'PORCENTAJE' = isnull(porcentaje,
                            0),
      'SECUENCIAL' = row_number()
                       over(
                         order by isnull(porcentaje, 0) desc, ente_inf asc)
    from   #relaciones,
           cl_ente,
           cl_relacion
    where  en_ente     = ente_inf
       and re_relacion = relacion
    order  by SECUENCIAL

  end

  return 0

  ERROR:

  if @i_frontend = 'S'
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error

    return 1
  end

  return @w_error

go

