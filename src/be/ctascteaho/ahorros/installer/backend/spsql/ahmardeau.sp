/*********************************************************************/
/*   Archivo:             ahmardeau.sp                               */
/*   Stored procedure:    sp_marca_debito_aut                        */
/*   Base de datos:       cob_ahorros                                */
/*   Producto:            Ahorros                                    */
/*   Disenado por:        Edwin Jiménez Diaz                         */
/*   Fecha de escritura:  Oct/2011                                   */
/*********************************************************************/
/*                          IMPORTANTE                               */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*   de COBISCorp.                                                   */
/*   Su uso no autorizado queda expresamente prohibido asi como      */
/*   cualquier alteracion o agregado hecho por alguno  de sus        */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*   Este programa esta protegido por la ley de derechos de autor    */
/*   y por las convenciones  internacionales de propiedad inte-      */
/*   lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*   penalmente a los autores de cualquier infraccion.               */
/*********************************************************************/
/*                           PROPOSITO                               */
/*   Este programa procesa Realiza un                                */
/*   Archivo Plano que permite discriminar y detallar                */
/*   las cuentas de ahorros que tienen el servicio                   */
/*   de débito automático.                                           */
/*********************************************************************/
/*                           MODIFICACIONES                          */
/*   FECHA          AUTOR           RAZON                            */
/*   20/Oct/2011    E.Jimenez       Emision Inicial                  */
/*   04/May/2016    J. Salazar      Migracion COBIS CLOUD MEXICO     */
/*********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_marca_debito_aut')
  drop proc sp_marca_debito_aut
go

/****** Object:  StoredProcedure [dbo].[sp_marca_debito_aut]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_marca_debito_aut
  @t_show_version bit = 0
as
  declare
    @w_return      int,
    @w_fecha       varchar(12),
    @w_error       varchar(255),
    @w_sp_name     varchar(30),
    --variables para bcp 
    @w_archivo     varchar(255),
    @w_nom_archivo varchar(100),
    @w_cmd         varchar(255),
    @w_comando     varchar(500),
    @w_path_s_app  varchar(100),
    @w_msg         varchar(50),
    @w_path        varchar(250),
    @w_anio        int,
    @w_mes         int,
    @w_dia         int

  --Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_marca_debito_aut'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_anio = convert(varchar(4), datepart(yy,
                                           @w_fecha))
  select
    @w_mes = convert(char(2), datepart(mm,
                                       @w_fecha))
  select
    @w_dia = convert(char(2), datepart(dd,
                                       @w_fecha))
  select
       @w_fecha = convert(varchar, @w_anio) + right((replicate('0', 2) + convert
                  (
                  varchar, @w_mes
                  )), 2)
               + right((replicate('0', 2) + convert(varchar, @w_dia)), 2)

  --Limpia Tablas
  truncate table cob_ahorros..ah_marca_debit_aut

  --INCLUIR CABECERA DEL ARCHIVO 
  insert into cob_ahorros..ah_marca_debit_aut
  values      ('Territorial','Oficina','No Cuenta','Id Cliente','Nom_Cliente',
               'No Prestamo','Oficina Prestamo','Valor Desembolso')

  if @@error <> 0
  begin
    select
      @w_error = 999999,
      @w_msg =
    ' ERROR DE INSERCION EN LA CABECERA cob_ahorros..ah_marca_debit_aut'
    goto ERROR
  end

  --crea la tabla temporar #temp0308
  select
    op_oficina,
    op_banco,
    op_cliente,
    op_cuenta,
    op_forma_pago,
    op_monto_aprobado
  into   #temp0308
  from   cob_cartera..ca_operacion,
         cob_cartera..ca_producto
  where  op_forma_pago        = cp_producto
     and cp_pago_aut          = 'S'
     and isnull(op_cuenta,
                '') <> ''

  --crea el index de la tabla temporal
  create nonclustered index idx1
    on #temp0308 (op_oficina, op_cuenta )
  --inserta en la tabla ah_marca_debit_aut
  insert into cob_ahorros..ah_marca_debit_aut
    select
      of_regional,ah_oficina,ah_cta_banco,ah_ced_ruc,ah_nombre,
      op_banco,op_oficina,op_monto_aprobado
    from   #temp0308,
           cobis..cl_oficina,
           cob_ahorros..ah_cuenta_tmp
    where  ah_oficina   = of_oficina
       and ah_cta_banco = op_cuenta

  if @@error <> 0
  begin
    select
      @w_error = 999999,
      @w_msg =
    ' ERROR EN LA INSERCION DE LA TABLA cob_ahorros..ah_marca_debit_aut'
    goto ERROR
  end

  --********************************************--
  ---> GENERAR BCP 
  --********************************************--

  select
    @w_path_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @w_path_s_app is null
  begin
    select
      @w_error = 999999,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
  end

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 4259

  if @@rowcount = 0
  begin
    select
      @w_msg =
    'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH ah_marca_debit_aut',
      @w_error = 400001
    print @w_msg
    goto ERROR
  end

  --GENERA BCP

  select
    @w_nom_archivo = 'ah_marca_debit_aut_' + @w_fecha + '.txt'
  select
    @w_archivo = @w_path + @w_nom_archivo

  select
    @w_cmd = @w_path_s_app +
    's_app bcp -auto -login cob_ahorros..ah_marca_debit_aut out '

  select
       @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e' + @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_path_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + @w_error + ' ERROR GENERANDO BCP ' + @w_comando,
      @w_error = 400002
    print @w_msg
    goto ERROR
  end
  return 0

  ERROR:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'admuser',
    @i_tran        = null,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error

go

