/************************************************************************/
/*      Archivo:                error_asiento_ah.sp                     */
/*      Stored procedure:       sp_error_asiento_ah                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Ahorros                                 */
/*      Disenado por:           Geovanna Landazuri                      */
/*      Fecha de documentacion: 04/Feb/2003                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este sp crea los procedimientos para las inserciones            */
/*      de errores generados por ahgencom.sp                            */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR              RAZON                          */
/*      04-Feb-03     GLA                Creacion                       */
/*      04/May/2016   J. Salazar         Migracion COBIS CLOUD MEXICO   */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_error_asiento_ah')
  drop proc sp_error_asiento_ah
go

/****** Object:  StoredProcedure [dbo].[sp_error_asiento_ah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_error_asiento_ah
(
  @t_show_version bit = 0,
  @i_fecha        datetime,
  @i_error        int = 0,
  @i_tran_name    descripcion,
  @i_moneda       tinyint = 0,
  @i_ofi_orig     smallint = 0,
  @i_ofi_dest     smallint = 0,
  @i_perfil       varchar(10) = '0',
  @i_valor        money = 0,
  @i_valor_me     money = 0,
  @i_mensaje      varchar(255),
  @i_to_tipo_tran smallint = null,
  @i_causa        varchar(12) = null
)
as
  declare
    @w_err_msg varchar(255),
    @w_sp_name varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_error_asiento_ah'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_err_msg = null

  select
    @w_err_msg = mensaje
  from   cobis..cl_errores
  where  numero = @i_error

  select
    @i_mensaje = isnull(@i_mensaje,
                        ''),
    @i_tran_name = isnull(@i_tran_name,
                          ''),
    @w_err_msg = isnull(@w_err_msg,
                        '')

  select
    @w_err_msg = @i_mensaje + ' ' + @i_tran_name + ' ' + @w_err_msg

  insert into cob_ahorros..ah_error_conta
              (ec_fecha,ec_moneda,ec_ofi_orig,ec_ofi_dest,ec_perfil,
               ec_valor,ec_valor_me,ec_descripcion,ec_filial,ec_tipo_tran,
               ec_causa)
  values      (@i_fecha,@i_moneda,@i_ofi_orig,@i_ofi_dest,@i_perfil,
               @i_valor,@i_valor_me,@w_err_msg,1,@i_to_tipo_tran,
               @i_causa)

  if @@error <> 0
  begin
    print 'error al insertar'
    /* Error en grabacion de archivo de errores */
    exec cobis..sp_cerror
      @i_num = 203056
  end

  return 0

go

