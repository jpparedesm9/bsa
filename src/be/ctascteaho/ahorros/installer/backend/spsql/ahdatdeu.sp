/**************************************************************************/
/*  Archivo:            ahdatdeu.sp                                       */
/*  Stored procedure:   sp_datos_deudores_rec                             */
/*  Base de datos:      cob_ahorros                                       */
/*  Producto:           Ahorros                                           */
/*  Fecha de escritura:                                                   */
/**************************************************************************/
/*                             IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*  de COBISCorp.                                                         */
/*  Su uso no autorizado queda expresamente prohibido asi como            */
/*  cualquier alteracion o agregado hecho por alguno  de sus              */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de derechos de autor          */
/*  y por las convenciones  internacionales de propiedad inte-            */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para         */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*  penalmente a los autores de cualquier infraccion.                     */
/**************************************************************************/
/*                             PROPOSITO                                  */
/*  Ingresar informacion dee los deudores o clientes a las tablas de REC. */
/**************************************************************************/
/*                          MODIFICACIONES                                */
/*  FECHA         AUTOR           RAZON                                   */
/*  03/May/2016   J. Salazar      Migracion COBIS CLOUD MEXICO            */
/**************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datos_deudores_rec')
  drop proc sp_datos_deudores_rec
go

/****** Object:  StoredProcedure [dbo].[sp_datos_deudores_rec]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datos_deudores_rec
(
  @t_show_version bit = 0,
  @i_corresponsal char(1) = 'N',--Req. 381 CB Red Posicionada        
  @i_param1       char(1) = null
)
as
  declare
    @w_error         int,
    @w_msg           descripcion,
    @w_fecha_proc    datetime,
    @w_tabla         int,
    @w_sp_name       varchar(30),
    @w_prod_bancario varchar(50) --Req. 381 CB Red Posicionada

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_datos_deudores_rec'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end
  
  if @i_param1 is not null
      select @i_corresponsal = @i_param1
  
  /* TRAER LA FECHA DE PROCESO DEL SISTEMA PARA EL MODULO */
  select
    @w_fecha_proc = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = 4

  /* ENTRAR BORRANDO TODA LA INFORMACION GENERADA POR AHORROS EN COB_EXTERNOS */
  delete cob_externos..ex_dato_deudores
  where  de_aplicativo = 4

  if @@error <> 0
  begin
    select
      @w_error = 147000,
      @w_msg = 'Error al eliminar registros cob_externos..ex_dato_deudores'
    goto ERROR
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
  if @i_corresponsal = 'N'
  begin
    select
      dd_fecha = @w_fecha_proc,
      dd_banco = dp_cuenta,
      dd_toperacion = convert(varchar(10), ah_prod_banc),
      dd_aplicativo = convert(tinyint, 4),
      dd_cliente = convert(int, cl_cliente),
      dd_rol = (select
                  eq_val_interfaz
                from   cob_remesas..re_equivalencias
                where  eq_modulo  = 4
                   and eq_mod_int = 36
                   and eq_tabla   = 'ROLDEUDOR'
                   and cl_rol     = eq_val_cfijo)
    into   #deudores_cb
    from   cobis..cl_det_producto,
           cobis..cl_cliente,
           cob_ahorros..ah_cuenta_tmp
    where  dp_cuenta        = ah_cta_banco
       and ((ah_estado in ('A', 'I'))
             or (ah_estado        = 'C'
                 and ah_fecha_ult_mov = @w_fecha_proc))
       and dp_det_producto  = cl_det_producto
       and ah_prod_banc     <> @w_prod_bancario -- Req. 381 CB Red Posicionada
    order  by dp_det_producto

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en #deudores'
      goto ERROR
    end

    print ' Ex_dato_deudores....'

    insert into cob_externos..ex_dato_deudores
                (de_fecha,de_banco,de_toperacion,de_aplicativo,de_cliente,
                 de_rol)
      select
        dd_fecha,dd_banco,dd_toperacion,dd_aplicativo,dd_cliente,
        dd_rol
      from   #deudores_cb

    if @@error <> 0
    begin
      print 'Error: '
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en cob_externos..ex_dato_deudores'
      select
        *
      from   #deudores_cb
      goto ERROR
    end
  end
  else
  begin
    select
      dd_fecha = @w_fecha_proc,
      dd_banco = dp_cuenta,
      dd_toperacion = convert(varchar(10), ah_prod_banc),
      dd_aplicativo = convert(tinyint, 4),
      dd_cliente = convert(int, cl_cliente),
      dd_rol = (select
                  eq_val_interfaz
                from   cob_remesas..re_equivalencias
                where  eq_modulo  = 4
                   and eq_mod_int = 36
                   and eq_tabla   = 'ROLDEUDOR'
                   and cl_rol     = eq_val_cfijo)
    into   #deudores
    from   cobis..cl_det_producto,
           cobis..cl_cliente,
           cob_ahorros..ah_cuenta_tmp
    where  dp_cuenta        = ah_cta_banco
       and ((ah_estado in ('A', 'I'))
             or (ah_estado        = 'C'
                 and ah_fecha_ult_mov = @w_fecha_proc))
       and dp_det_producto  = cl_det_producto
    order  by dp_det_producto

    if @@error <> 0
    begin
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en #deudores'
      goto ERROR
    end

    print ' Ex_dato_deudores....'

    insert into cob_externos..ex_dato_deudores
                (de_fecha,de_banco,de_toperacion,de_aplicativo,de_cliente,
                 de_rol)
      select
        dd_fecha,dd_banco,dd_toperacion,dd_aplicativo,dd_cliente,
        dd_rol
      from   #deudores

    if @@error <> 0
    begin
      print 'Error: '
      select
        @w_error = 499999,
        @w_msg = 'Error al grabar en cob_externos..ex_dato_deudores'
      select
        *
      from   #deudores
      goto ERROR
    end
  end

  return 0

  ERROR:
  exec sp_errorlog
    @i_fecha       = @w_fecha_proc,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 0,
    @i_descripcion = @w_msg,
    @i_programa    = 'sp_datos_deudores_rec'

  return @w_error

go

