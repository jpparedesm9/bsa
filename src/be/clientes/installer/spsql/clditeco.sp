/*************************************************************************/
/*    ARCHIVO:         clditeco.sp                                       */
/*    NOMBRE LOGICO:   sp_dir_tel_cons                                   */
/*    PRODUCTO:        cobis                                             */
/*************************************************************************/
/*                     IMPORTANTE                                        */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                     PROPOSITO                                         */
/*   Este stored procedure retorna los datos y las                       */
/*   direcciones y teléfonos de un cliente específico                    */
/*************************************************************************/
/*                     MODIFICACIONES                                    */
/*   FECHA          AUTOR           RAZON                                */
/*   28/Mar/2001    V.Torres        Emision Inicial                      */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/*************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_dir_tel_cons')
  drop proc sp_dir_tel_cons
go

create proc sp_dir_tel_cons
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = 1414,
  @t_show_version bit = 0,
  @i_ente         int,
  @i_datos        estado = 'N'
)
as
  declare
    @w_sp_name  varchar(32),
    @w_subtipo  estado,
    @w_ced_ruc  varchar(30),
    @w_refInhib estado,--Referencia Inhibitoria
    @w_refCom   estado --Referencia Comercial

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --nombre del sp
  select
    @w_sp_name = 'sp_dir_tel_cons'

  --Busca el tipo de cliente
  select
    @w_subtipo = en_subtipo,
    @w_ced_ruc = isnull(en_ced_ruc,
                        p_pasaporte)
  from   cl_ente
  where  en_ente = @i_ente

  if @@rowcount = 0
  begin
    /*  No existe cliente  */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 101146
    return 1
  end

  if @i_datos = 'S'
  begin
    /* Referencia Inhibitoria, busqueda en listas Negras */
    select
      @w_refInhib = 'N'
    if exists (select
                 1
               from   cl_refinh
               where  in_ced_ruc = @w_ced_ruc)
      select
        @w_refInhib = 'S'

    --Persona
    if @w_subtipo = 'P'
      select
        en_subtipo,
        en_ente,
        p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
        en_ced_ruc,
        en_tipo_ced,
        convert(varchar(10), p_fecha_nac, 101),
        en_oficial,
        en_categoria,
        @w_refInhib
      from   cl_ente
      where  en_ente = @i_ente

    --Compania
    if @w_subtipo = 'C'
      select
        en_subtipo,
        en_ente,
        en_nombre,
        en_ced_ruc,
        en_tipo_ced,
        convert(varchar(10), c_fecha_const, 101),
        en_oficial,
        en_categoria,
        @w_refInhib
      from   cl_ente
      where  en_ente = @i_ente

  end

  -- Retornar el numero de direcciones del cliente
  select
    count(*)
  from   cl_direccion
  where  di_ente = @i_ente

  -- Retornar el numero de telefonos del cliente
  select
    count(*)
  from   cl_telefono
  where  te_ente = @i_ente

  -- Retornar las direcciones del cliente
  select
    di_direccion,
    di_descripcion
  from   cl_direccion
  where  di_ente = @i_ente

  -- Retornar los telefonos del cliente
  select
    te_direccion,
    te_valor
  from   cl_telefono
  where  te_ente = @i_ente

  -- Retornar datos adicionales

  /* Referencia Comercial*/
  select
    @w_refCom = 'N'
  if exists (select
               1
             from   cl_mercado
             where  me_ced_ruc = @w_ced_ruc)
    select
      @w_refCom = 'S'

  --Persona
  if @w_subtipo = 'P'
    select
      p_pasaporte,
      en_asosciada,
      p_tipo_persona,
      @w_refCom,
      substring(isnull(c_tipo_compania,
                       'P'),
                1,
                1)
    from   cl_ente
    where  en_ente = @i_ente

  --Compania
  if @w_subtipo = 'C'
    select
      p_pasaporte,
      en_asosciada,
      c_tipo_soc,
      @w_refCom,
      substring(isnull(c_tipo_compania,
                       'P'),
                1,
                1)
    from   cl_ente
    where  en_ente = @i_ente

  return 0

go

