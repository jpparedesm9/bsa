/************************************************************************/
/*   Archivo:              ahrollout.sp                                 */
/*   Stored procedure:     sp_aut_prod_ofi                              */
/*   Base de datos:        cob_ahorros                                  */
/*   Producto:             Ahorros                                      */
/*   Disenado por:         Jaime Loyo HOlguin                           */
/*   Fecha de escritura:   Feb/2012                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                               PROPOSITO                              */
/*   Este proceso hace el llamado al sp que permite autorizar un        */
/*   producto para una oficina                                          */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*       FECHA          AUTOR           RAZON                           */
/*  24/Feb/2012     Jaime Loyo       Emision Inicial                    */
/*  02/May/2016     J. Calderon      Migración a CEN                    */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_aut_prod_ofi')
  drop proc sp_aut_prod_ofi
go

create procedure sp_aut_prod_ofi
(
  @t_show_version bit = 0,
  @i_param1       varchar(255),--Producto
  @i_param2       varchar(255),--Fecha
  @i_param3       varchar(255) --oficina
)
as
  declare
    @w_producto smallint,
    @w_fecha    datetime,
    @w_oficina  smallint,
    @w_msg      varchar(100),
    @w_error    int,
    @w_sp_name  varchar(30)

  select
    @w_sp_name = 'sp_aut_prod_ofi'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* INICIO DE VARIABLES DE TRABAJO */
  select
    @w_producto = convert(tinyint, @i_param1)
  select
    @w_fecha = convert(datetime, @i_param2)
  select
    @w_oficina = convert(int, @i_param3)

  if not exists (select
                   1
                 from   cobis..cl_oficina
                 where  of_oficina = @w_oficina)
  begin
    select
      @w_error = 101016,
      @w_msg = 'No existe oficina :' + cast(@w_oficina as varchar)
    print @w_msg
    goto ERRORFIN
  end

  if (select
        count(1)
      from   cob_remesas..pe_pro_bancario
      where  pb_pro_bancario = @w_producto) = 0
  begin
    print 'No existe el producto en Cuentas de Ahorros :' + cast(@w_producto as
          varchar)
    select
      @w_error = 101111,
      @w_msg = 'No existe el producto en Cuentas de Ahorros'
    print @w_msg
    goto ERRORFIN
  end

  if @w_fecha is null
  begin
    select
      @w_fecha = fp_fecha
    from   cobis..ba_fecha_proceso
  end

  exec @w_error = cob_remesas..sp_par_rollout
    @i_criterio     = 'O',-- T->Todo, 'R'->Territorial, 'Z'->Zona, 'O'->Oficina
    @i_producto     = 4,
    @i_prod_banc    = @w_producto,
    @i_oficina      = @w_oficina,
    --Depende de la informaci¾n suministrada por el banco
    @i_fecha_inicio = @w_fecha,
    @i_estado       = 'V'

  if @w_error <> 0
      or @@error <> 0
  begin
    select
      @w_msg = 'LLamada de cob_remesas.. sp_par_rollout genera error ',
      @w_error = @w_error
    print @w_msg
    goto ERRORFIN
  end

  return 0

  ERRORFIN:

  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_aut_prod_ofi'

  return @w_error

go

