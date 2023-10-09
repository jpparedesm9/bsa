/************************************************************************/
/*   Archivo:             cl_sinergy.sp                                 */
/*   Stored procedure:    sp_interface_sinergy                          */
/*   Base de datos:       cobis                                         */
/*   Producto:            Clientes                                      */
/*   Fecha de escritura:  Mayo 27/2010                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Extraccion de datos de Clientes para repositorio Sinergy           */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR               RAZON                           */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_interface_sinergy')
  drop proc sp_interface_sinergy
go

create proc sp_interface_sinergy
(
  @t_show_version bit = 0,
  @i_param1       datetime --fecha de proceso

)
as
  declare
    @w_error         int,
    @w_sp_name       varchar(64),
    @w_fecha_proceso datetime,
    @w_msg           varchar(64)

  create table #clientes_sinergy
  (
    ente int null
  )

  /* CARGADO DE VARIABLES DE TRABAJO */
  select
    @w_sp_name = 'sp_interface_sinergy'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR CLIENTES EN COB_EXTERNOS */

  truncate table cob_externos..ex_ente_sg
  truncate table cob_externos..ex_direccion_sg
  truncate table cob_externos..ex_telefono_sg

  /* SELECCIONAR TABLAS MODIFICADAS */

  insert into #clientes_sinergy
    select
      en_ente
    from   cobis..cl_ente
    where  en_fecha_crea >= @i_param1
        or en_fecha_mod  >= @i_param1

  /* CARGA DE OPERACIONES ACTIVAS */

  select
    sg_ente = en_ente,
    sg_p_apellido = p_p_apellido,
    sg_s_apellido = p_s_apellido,
    sg_nombre = en_nombre,
    sg_tipo_ced = en_tipo_ced,
    sg_ced_ruc = en_ced_ruc,
    sg_pais = en_pais,
    sg_sexo = p_sexo,
    sg_profesion = p_profesion,
    sg_concordato = en_concordato,
    sg_nivel_estudio = p_nivel_estudio,
    sg_actividad = en_actividad,
    sg_tipo_persona = p_tipo_persona,
    sg_tipo_vivienda = p_tipo_vivienda,
    sg_fecha_ingreso = convert(varchar(10), en_fecha_crea, 111),
    sg_fecha_mod = convert(varchar(10), en_fecha_mod, 111),
    sg_subtipo = en_subtipo,
    sg_nomlar = en_nomlar,
    sg_oficina = en_oficina,
    sg_des_oficina = of_nombre,
    sg_zona = of_zona
  into   #ente_sinergy
  from   cobis..cl_ente,
         cobis..cl_oficina,
         #clientes_sinergy
  where  en_ente    = ente
     and en_oficina = of_oficina

  /* CLIENTES */

  insert into cob_externos..ex_ente_sg
    select
      *
    from   #ente_sinergy
  if @@error <> 0
  begin
    select
      @w_error = 103001,
      @w_msg = 'Error en al Grabar en table cob_externos..#ente_sinergy'
    goto ERROR
  end

  /* DIRECCIONES */

  select
    dd_fecha = convert(varchar(10), @i_param1, 111),
    dd_ente = di_ente,
    dd_direccion = di_direccion,
    dd_descripcion = di_descripcion,
    dd_ciudad = di_ciudad,
    dd_tipo = di_tipo,
    dd_fecha_ingreso = convert(varchar(10), di_fecha_registro, 111),
    dd_fecha_modificacion = convert(varchar(10), di_fecha_modificacion, 111),
    dd_principal = di_principal,
    dd_rural_urb = di_rural_urb,
    dd_provincia = di_provincia,
    dd_parroquia = di_parroquia
  into   #direcciones
  from   cobis..cl_direccion
  where  di_ente in
         (select
            ente
          from   #clientes_sinergy)

  insert into cob_externos..ex_direccion_sg
    select
      *
    from   #direcciones
  if @@error <> 0
  begin
    select
      @w_error = 103007,
      @w_msg = 'Error en al Grabar en table cob_externos..ex_direccion_sg'
    goto ERROR
  end

  /* TELEFONOS */

  select
    dt_fecha = convert(varchar(10), @i_param1, 111),
    dt_ente = te_ente,
    dt_direccion = te_direccion,
    dt_secuencial = te_secuencial,
    dt_valor = te_valor,
    dt_tipo_telefono = te_tipo_telefono,
    dt_prefijo = te_prefijo,
    dt_fecha_ingreso = convert(varchar(10), te_fecha_registro, 111),
    dt_fecha_mod = convert(varchar(10), te_fecha_mod, 111)
  into   #telefonos
  from   cobis..cl_telefono,
         #clientes_sinergy
  where  te_ente = ente

  insert into cob_externos..ex_telefono_sg
    select
      *
    from   #telefonos
  if @@error <> 0
  begin
    select
      @w_error = 103038,
      @w_msg = 'Error en al Actualizar table cob_externos..ex_telefono_sg'
    goto ERROR
  end

  return 0

  ERROR:

  return @w_error

go

