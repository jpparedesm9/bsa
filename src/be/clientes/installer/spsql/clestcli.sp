/************************************************************************/
/*  Archivo:            cl_estcli.sp                                    */
/*  Stored procedure:   sp_genera_est_clte                              */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Alexandra Correa R                              */
/*  Fecha de escritura: 09-Abr-2008                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  la generación de estadística de acuerdo a parametrización           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  09-Abr-08   ACO           Emision Inicial                           */
/*  03-Mar-09   ELA           Desarrollo 021                            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_genera_est_clte')
  drop proc sp_genera_est_clte
go

create table #tmp_clte_cca_act
(
  cl_cliente int null
)
go

create proc sp_genera_est_clte
(
  @t_show_version bit = 0,
  @i_criterio     varchar(10),
  @i_cartera      char(1) = 'N',
  @i_rol          char(1) = 'D'
)
as
  declare
    @w_campo        varchar(50),
    @w_comando      varchar(500),
    @w_comando1     varchar(500),
    @w_comando2     varchar(1000),
    @w_fecha        varchar(10),
    @w_columnas     varchar(200),
    @w_group        varchar(200),
    @w_condicion    varchar(200),
    @w_especial     char(1),
    @w_ref_amigo    varchar(4),
    @w_ref_familiar varchar(4),
    @w_ref_empleado varchar(4),
    @w_return       int,
    @w_sp_name      varchar(30)

    select 
          @w_sp_name = 'sp_genera_est_clte'
          
  --Version /*  03-Mar-09   ELA           Desarrollo 021                            */
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  print "entra a generar  sp_genera_est_clte "

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

  select
    @w_campo = pe_campo
  from   cobis..cl_param_est_clte
  where  pe_tcriterio = @i_criterio

  select
    @w_comando = 'delete cobis..cl_estad_clte where ec_fecha_corte = ''' +
                 @w_fecha
                                                            + ''' and'
  select
       @w_comando = @w_comando + ' ec_tcriterio = ''' + @i_criterio +
                    ''' and ec_cartera = '''
  select
    @w_comando = @w_comando + @i_cartera + ''''
  exec (@w_comando)

  select
    @w_comando = ''
  select
    @w_columnas = 'isnull(en_oficina_prod, 0), ''' + @w_fecha + ''', ''' +
                                             @i_criterio + ''', '
  select
    @w_columnas = @w_columnas + @w_campo + ', ''' + @i_cartera + ''''

  select
    @w_group = 'en_oficina_prod, ' + @w_campo

  if @i_cartera = 'N'
  begin
    if @i_criterio = 'M'
    begin
      insert into cobis..cl_estad_clte
        select
          isnull(en_oficina_prod,
                 0),@w_fecha,@i_criterio,mo_mercado_objetivo,@i_cartera,
          count(1),0
        from   cobis..cl_ente,
               cobis..cl_mercado_objetivo_cliente
        where  en_ente = mo_ente
        group  by en_oficina_prod,
                  mo_mercado_objetivo
    end
    else
    begin
      select
        @w_comando = 'insert into cobis..cl_estad_clte '
      select
        @w_comando = @w_comando + 'select ' + @w_columnas + ', ' + 'count(1)' +
                     ','
                     +
                     '0'
      select
        @w_comando = @w_comando + ' from cobis..cl_ente where ' + @w_campo
      select
        @w_comando = @w_comando + ' is not null group by ' + @w_group

      select
        @w_comando2 = @w_comando
    end
  end
  else
  begin
    create table #tmp_clte_cca_act
    (
      cl_cliente int null
    )

    if @i_rol = 'D'
      insert into #tmp_clte_cca_act
        select distinct
          cl_cliente
        from   cob_cartera..ca_operacion,
               cob_cartera..ca_estado,
               cobis..cl_det_producto,
               cobis..cl_cliente
        where  op_estado       = es_codigo
           and dp_cuenta       = op_banco
           and dp_det_producto = cl_det_producto
           and es_procesa      = 'S'
           and dp_producto     = 7
           and cl_rol          = @i_rol
    else
      insert into #tmp_clte_cca_act
        select distinct
          cl_cliente
        from   cob_cartera..ca_operacion,
               cob_cartera..ca_estado,
               cobis..cl_det_producto,
               cobis..cl_cliente
        where  op_estado       = es_codigo
           and dp_cuenta       = op_banco
           and dp_det_producto = cl_det_producto
           and es_procesa      = 'S'
           and dp_producto     = 7

    if @i_criterio = 'M'
    begin
      insert into cobis..cl_estad_clte
        select
          isnull(en_oficina_prod,
                 0),@w_fecha,@i_criterio,mo_mercado_objetivo,@i_cartera,
          count(1),0
        from   cobis..cl_ente,
               cobis..cl_mercado_objetivo_cliente,
               #tmp_clte_cca_act
        where  en_ente = mo_ente
           and en_ente = cl_cliente
        group  by en_oficina_prod,
                  mo_mercado_objetivo
    end
    else
    begin
      select
        @w_comando = 'insert into cobis..cl_estad_clte '
      select
        @w_comando = @w_comando + 'select ' + @w_columnas + ', ' + 'count(1)' +
                     ', '
                     +
                     'sum(am_cuota - am_pagado)'
      select
        @w_comando = @w_comando
                     +
' from cobis..cl_ente, #tmp_clte_cca_act,cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op,cob_cartera..ca_operacion'
  select
    @w_comando = @w_comando +
    ' where op_operacion = am_operacion and ro_operacion  = am_operacion'
  select
    @w_comando1 = ' and ro_concepto = am_concepto and op_cliente  = en_ente'
  select
    @w_comando1 = @w_comando1 + ' and en_ente = cl_cliente and ' + @w_campo
  select
    @w_comando1 = @w_comando1 + ' is not null group by '
  select
    @w_comando1 = @w_comando1 + @w_group
  select
    @w_comando2 = @w_comando + @w_comando1

end
end

  if ltrim(rtrim(@w_comando2)) <> ''
    exec (@w_comando2)

  if @i_criterio = 'P'
     and @i_cartera = 'N'
  begin
    exec @w_return = sp_gerera_sum
    /*    exec sp_errorlog
           @i_fecha         = @w_fecha,
           @i_error         = @w_return,
           @i_usuario       = 'misbatch',
           @i_tran          = 0,
           @i_tran_name     = "sp_genera_est_clte ",
           @i_cuenta        = "CRITERIO P CARTERA N",
           @i_descripcion   = 'sp_gerera_sum',
           @i_rollback      = 'S' */

    delete from cl_estad_clte
    where  ec_tcriterio = "P"
       and ec_criterio in(@w_ref_amigo, @w_ref_familiar, @w_ref_empleado)
       and ec_cartera   = "N"
    /* if @@error <> 0
     begin
        exec sp_errorlog
           @i_fecha         = @w_fecha,
           @i_error         = @w_return,
           @i_usuario       = 'misbatch',
           @i_tran          = 0,
           @i_tran_name     = "sp_genera_est_clte ",
           @i_cuenta        = "sp_gerera_sum",
           @i_descripcion   = 'ERROR AL ELIMINAR CARTERA N PROCEDENCIA',
           @i_rollback      = 'S'
     end*/

    insert into cl_estad_clte
                (ec_oficina,ec_fecha_corte,ec_tcriterio,ec_criterio,ec_cartera,
                 ec_cantidad,ec_valor)
      select
        ec_oficina,ec_fecha_corte,ec_tcriterio,ec_criterio,ec_cartera,
        ec_cantidad,ec_valor
      from   cl_estad_clte2
    /* if @@error <> 0
     begin
        exec sp_errorlog
           @i_fecha         = @w_fecha,
           @i_error         = @w_return,
           @i_usuario       = 'misbatch',
           @i_tran          = 0,
           @i_tran_name     = "sp_genera_est_clte ",
           @i_cuenta        = "sp_gerera_sum",
           @i_descripcion   = 'ERROR AL INSERTAR cl_estad_clte2 N PROCEDENCIA',
           @i_rollback      = 'S'
     end*/

    delete from cl_estad_clte2
  /* if @@error <> 0
   begin
      exec sp_errorlog
         @i_fecha         = @w_fecha,
         @i_error         = @w_return,
         @i_usuario       = 'misbatch',
         @i_tran          = 0,
         @i_tran_name     = "sp_genera_est_clte ",
         @i_cuenta        = "sp_gerera_sum",
         @i_descripcion   = 'ERROR AL ELIMINAR cl_estad_clte2 N PROCEDENCIA',
         @i_rollback      = 'S'
    end*/
  end
  return 0

go

