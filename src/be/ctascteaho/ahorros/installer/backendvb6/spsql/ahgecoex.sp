/************************************************************************/
/*  Archivo:                         ahgecoex.sp                        */
/*  Stored procedure:                sp_genera_contador_extracto        */
/*  Base de datos:                   cob_ahorros                        */
/*  Producto:                        AHORROS                            */
/*  Fecha de escritura:              28-Mar-2011                        */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP".                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de COBISCORP o su representante.              */
/************************************************************************/
/*              PROPOSITO                                               */
/* Genera contador primer extracto                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  28/03/2011      SMolano         Genera primer contador Extracto     */
/*  03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO        */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_genera_contador_extracto')
  drop proc sp_genera_contador_extracto
go

/****** Object:  StoredProcedure [dbo].[sp_genera_contador_extracto]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create procedure sp_genera_contador_extracto
(
  @t_show_version bit = 0,
  @i_param1       varchar(255) -- Fecha Proceso
)
as
  declare
    @i_fecha         varchar(12),
    @w_sp_name       varchar(60),
    @w_error         varchar(255),
    @w_anio          int,
    @w_mes           int,
    @w_dia           int,
    @w_producto      tinyint,
    @w_msg           varchar(50),
    @w_fecha_reporte varchar(10)

  select
    @w_sp_name = 'sp_genera_contador_extracto',
    @i_fecha = convert(datetime, @i_param1)

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  exec cobis..sp_datepart
    @i_fecha = @i_fecha,
    @o_dia   = @w_dia out,
    @o_mes   = @w_mes out,
    @o_anio  = @w_anio out

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR 3: ERROR EN EL SP_DATEPART'
    print @w_msg
    return 1
  end

  select
    @w_producto = pd_producto
  from   cobis..cl_producto
  where  pd_abreviatura = 'AHO'

  if @@rowcount <> 1
  begin
    -- Producto no existe o definicion de producto no corresponde 
    select
      @w_msg = 'ERROR: PRODUCTO NO EXISTE : sp_genera_contador_extracto '
    print @w_msg
    return 1
  end

  --Selecciona datos de abono cob_ahorros..ah_tran_monet y pagos de remesas en efectivo cob_cuentas..cc_tsot_ingegre
  insert into cob_remesas..re_his_extracto
    select
      @w_producto,ec_cta_banco,@w_mes,@w_anio,1,
      @i_fecha
    from   cob_ahorros..ah_estado_cta
    where  ec_fecha_prx_corte = @i_fecha

  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR: ERROR GENERANDO CONTADOR : sp_genera_contador_extracto '
    print @w_msg
    return 1
  end

  return 0

go

