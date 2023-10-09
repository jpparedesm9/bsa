/************************************************************************/
/*  Archivo:            ahconscue.sp                                    */
/*  Stored procedure:   sp_consulta_cuenta_cli                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Branch                                          */
/*  Disenado por:       Raul Altamirano                                 */
/*  Fecha de escritura: 02-Mar-2010                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/********************************************************************  **/
/*              PROPOSITO                                               */
/*  Este programa implementa la busqueda de cuentas de ahorros para un  */
/*  cliente para la trasaccion 701 de caja                              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  02/Mar/10    Raul Altamirano Emision Inicial                        */
/*  02/May/16   Javier Calderon Migración a CEN                         */
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
           where  name = 'sp_consulta_cuenta_cli')
  drop proc sp_consulta_cuenta_cli
go

create proc sp_consulta_cuenta_cli
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_cliente      int = null,
  @i_corresponsal char(1) = 'N' --Req. 381 CB Red Posicionada
)
as
  declare
    @w_sp_name       varchar(32),
    @w_cuenta        varchar(24),
    @w_rol           varchar(10),
    @w_prod_banco    smallint,
    @w_sprod_banco   varchar(10),
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  select
    @w_sp_name = 'sp_consulta_cuenta_cli'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  declare cuentas cursor for
    select
      dp_cuenta,
      cl_rol
    from   cobis..cl_det_producto,
           cobis..cl_cliente
    where  dp_det_producto = cl_det_producto
       and dp_producto     = 4
       and dp_estado_ser   <> 'C'
       and cl_cliente      = @i_cliente

  /* Abrir el cursor para productos del cliente */
  open cuentas

  /*Ubicar el primer registro para el cursor*/
  fetch cuentas into @w_cuenta, @w_rol

  if @@fetch_status = -2
  begin
    /* Error en lectura del cursor */
    exec cobis..sp_cerror
      @i_num = 351037,
      @i_sev = 1

    /* Cerrar y liberar cursor */
    close cuentas
    deallocate cuentas
    return 351037
  end

  /*Barrer los registros para las operaciones del cliente */
  while @@fetch_status = 0
  begin
    select
      @w_sprod_banco = null

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_prod_banco = ah_prod_banc
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_cuenta
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

      if @@rowcount > 0
      begin
        select
          @w_sprod_banco = convert(varchar, @w_prod_banco)

        insert into #cuenta
                    (cu_banco,cu_rol,cu_producto)
        values      (@w_cuenta,@w_rol,@w_sprod_banco)

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @i_num = 351037,
            @i_sev = 1

          /* Cerrar y liberar cursor */
          close cuentas
          deallocate cuentas
          return 351037
        end
      end

      --Lee siguiente registro
      fetch cuentas into @w_cuenta, @w_rol
    end
    else
    begin
      select
        @w_prod_banco = ah_prod_banc
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_cuenta

      if @@rowcount > 0
      begin
        select
          @w_sprod_banco = convert(varchar, @w_prod_banco)

        insert into #cuenta
                    (cu_banco,cu_rol,cu_producto)
        values      (@w_cuenta,@w_rol,@w_sprod_banco)

        if @@error <> 0
        begin
          exec cobis..sp_cerror
            @i_num = 351037,
            @i_sev = 1

          /* Cerrar y liberar cursor */
          close cuentas
          deallocate cuentas
          return 351037
        end
      end

      --Lee siguiente registro
      fetch cuentas into @w_cuenta, @w_rol
    end
  end

  /* Cerrar y liberar cursor */
  close cuentas
  deallocate cuentas

  return 0

go

