/********************************************************************/
/*  Archivo:                  ahcretmp.sp                           */
/*  Base de datos:            cob_ahorros                           */
/*  Producto:                 Cuentas de Ahooros                    */
/*  Disenado por:             Boris Mosquera                        */
/*  Fecha de escritura:       17/Feb/1995                           */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                          PROPOSITO                               */
/*  Creacion de Tablas Temporales para Genera Costos                */
/********************************************************************/
/*                          MODIFICACIONES                          */
/*  FECHA           AUTOR            RAZON                          */
/*  07/Jun/1996     A. Villarreal    Creacion de Tablas Temporales  */
/*  08/Mar/1999     J. Cadena        Personalizacion B. del Caribe  */
/*  24/Abr/2000     M. Gracia        Eliminacion de mensajes        */
/*                                      Informativos                */
/*  04/Oct/2000     X. Gellibert     Optimizacion                   */
/*  03/May/2016     J. Salazar       Migracion COBIS CLOUD MEXICO   */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_crea_tem_person')
  drop proc sp_crea_tem_person
go

/****** Object:  StoredProcedure [dbo].[sp_crea_tem_person]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_crea_tem_person
  @t_show_version bit = 0
as
  declare
    @w_return  int,
    @w_sp_name varchar(30),
    @w_msg     varchar(255)

  set ansi_warnings off

  select
    @w_sp_name = 'sp_crea_tem_person'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  /** Borra  tablas temporales ****/
  print 'BORRANDO TABLAS TEMPORALES'
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'pint4')
    drop table tempdb..pint4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'cdev4')
    drop table tempdb..cdev4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'mcta4')
    drop table tempdb..mcta4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'crem4')
    drop table tempdb..crem4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'cret4')
    drop table tempdb..cret4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'cslm4')
    drop table tempdb..cslm4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'inac4')
    drop table tempdb..inac4
  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'eect4')
    drop table tempdb..eect4

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'PINT',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' PINT'
    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'CDEV',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' CDEV'
    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'MCTA',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' MCTA'
    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'CREM',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' CREM'
    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'CRET',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' CRET'
    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'CSLM',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' CSLM'

    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'INAC',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    print @w_msg
  end

  exec @w_return = cob_remesas..sp_crea_temp
    @i_serdisponible = 'EECT',
    @i_batch         = 'S',
    @i_prod_cobis    = 4

  if @w_return <> 0
  begin
    select
      @w_msg = mensaje
    from   cobis..cl_errores
    where  numero = @w_return
    select
      @w_msg = @w_msg + ' EECT'
    print @w_msg
  end

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'auxiliar')
    drop table tempdb..auxiliar

  exec cob_remesas..sp_crea_atrib

  print 'Creacion de indices'

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'pint4')
  begin
    create clustered index pint4_Key
      on tempdb..pint4 (tipo_ente, pro_bancario, filial, sucursal, producto,
    moneda, categoria, servicio_dis, rubro, tipo_atributo, rango_desde,
    rango_hasta)

    create index i_pint4
      on tempdb..pint4 (sucursal, pro_bancario, tipo_ente, categoria,
    rango_desde,
    rango_hasta)
  end

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'mcta4')
  begin
    create clustered index mcta4_Key
      on tempdb..mcta4 (tipo_ente, pro_bancario, filial, sucursal, producto,
    moneda, categoria, servicio_dis, rubro, tipo_atributo, rango_desde,
    rango_hasta)
  end

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'cslm4')
  begin
    create clustered index cslm4_Key
      on tempdb..cslm4 (tipo_ente, pro_bancario, filial, sucursal, producto,
    moneda, categoria, servicio_dis, rubro, tipo_atributo, rango_desde,
    rango_hasta)
  end

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'inac4')
  begin
    create clustered index inac4_Key
      on tempdb..inac4 (tipo_ente, pro_bancario, filial, sucursal, producto,
    moneda, categoria, servicio_dis, rubro, tipo_atributo, rango_desde,
    rango_hasta)
  end

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'ah_cuenta_nombre')
    truncate table tempdb..ah_cuenta_nombre
  else
  begin
    create table tempdb..ah_cuenta_nombre
    (
      cuenta varchar(24) not null,
      nombre varchar(64) not null
    )

    create unique clustered index i_ah_cta_nom
      on tempdb..ah_cuenta_nombre (cuenta)
  end

  insert into tempdb..ah_cuenta_nombre
    select
      ah_cta_banco,ah_nombre
    from   cob_ahorros..ah_cuenta

  if @@error <> 0
    print 'Error insertando tempdb..ah_cuenta_nombre'
  return 0

go

