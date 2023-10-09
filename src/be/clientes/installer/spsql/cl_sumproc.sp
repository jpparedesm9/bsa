/*************************************************************************/
/*   Archivo             :    cl_sumproc.sp                              */
/*   Stored procedure    :    sp_gerera_sum                              */
/*   Base de datos       :    cobis                                      */
/*   Producto            :    Clientes                                   */
/*   Fecha de escritura  :    09-Mar-2009                                */
/*************************************************************************/
/*                       IMPORTANTE                                      */
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
/*                       PROPOSITO                                       */
/*        Generacion de estados del cliente.                             */
/*************************************************************************/
/*                        MODIFICACIONES                                 */
/*        FECHA          AUTOR          RAZON                            */
/*    02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/*************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_gerera_sum')
  drop proc sp_gerera_sum
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_gerera_sum
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name        varchar(30),
    @w_persona        int,
    @w_ec_oficina     smallint,
    @w_ec_fecha_corte datetime,
    @w_ec_tcriterio   varchar(10),
    @w_ec_criterio    varchar(10),
    @w_ec_cartera     char(1),
    @w_ec_cantidad    int,
    @w_ec_valor       money,
    @w_ref_amigo      varchar(4),
    @w_ref_familiar   varchar(4),
    @w_ref_empleado   varchar(4),
    @w_fecha          varchar(10),
    @w_return         int

  --Version 05/25/2009

  select
    @w_sp_name = 'sp_tbalance'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  print "entra a generar  sp_gerera_sum "

  select
    @w_fecha = convert(varchar(10), fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  select
    @w_ref_amigo = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'REFA'
     and pa_producto = 'MIS'

  select
    @w_ref_familiar = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'REFF'
     and pa_producto = 'MIS'

  select
    @w_ref_empleado = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'REFE'
     and pa_producto = 'MIS'

  declare gen_sum cursor for
    select distinct
      (ec_oficina)
    from   cl_estad_clte
    where  ec_tcriterio = 'P'
       and ec_cartera   = 'N'
       and ec_criterio in(@w_ref_amigo, @w_ref_familiar, @w_ref_empleado)
    order  by ec_oficina

  open gen_sum

  fetch gen_sum into @w_ec_oficina

  while @@fetch_status <> -1
  begin
    if @@fetch_status = -2
    begin
      print 'Error en apertura del cursor gen_sum'
      return 1
    end

    if @w_ec_oficina >= 0
    begin
      select
        @w_ec_cantidad = sum(ec_cantidad),
        @w_ec_valor = sum(ec_valor)
      from   cl_estad_clte
      where  ec_oficina   = @w_ec_oficina
         and ec_tcriterio = 'P'
         and ec_cartera   = 'N'
         and ec_criterio in(@w_ref_amigo, @w_ref_familiar, @w_ref_empleado)
      group  by ec_oficina

      select
        @w_ec_fecha_corte = ec_fecha_corte,
        @w_ec_tcriterio = ec_tcriterio,
        @w_ec_cartera = ec_cartera,
        @w_ec_criterio = "RE"
      from   cl_estad_clte
      where  ec_oficina   = @w_ec_oficina
         and ec_tcriterio = 'P'
         and ec_cartera   = 'N'
         and ec_criterio in(@w_ref_amigo, @w_ref_familiar, @w_ref_empleado)

      insert into cl_estad_clte2
                  (ec_oficina,ec_fecha_corte,ec_tcriterio,ec_criterio,ec_cartera
                   ,
                   ec_cantidad,ec_valor)
      values      ( @w_ec_oficina,@w_ec_fecha_corte,@w_ec_tcriterio,"RE",
                    @w_ec_cartera,
                    @w_ec_cantidad,@w_ec_valor )

      print @w_ec_oficina

      goto SIGUIENTE

      delete from cl_estad_clte
      where  ec_oficina   = @w_ec_oficina
         and ec_tcriterio = "P"
         and ec_criterio  <> 'RE'
         and ec_cartera   = 'N'

    end

    SIGUIENTE:
    fetch gen_sum into @w_ec_oficina
  end

go

