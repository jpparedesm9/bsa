/************************************************************************/
/*      Archivo:             ahdebauto.sp                               */
/*      Stored procedure:    sp_deb_aut                                 */
/*      Base de datos:       cob_ahorros                                */
/*      Producto:            Ahorros                                    */
/*      Disenado por:        Edwin Jimenez Diaz                         */
/*      Fecha de escritura:  Oct/2011                                   */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*      Este programa generacion de Archivo Plano,                      */
/*      que permita la revision diaria de los movimientos debitos       */
/*      AUTOMATICOS POR PAGO DE OBLIGACIONES                            */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      20/Oct/2011     E.Jimenez       Emision Inicial                 */
/*      03/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_deb_aut')
  drop proc sp_deb_aut
go

/****** Object:  StoredProcedure [dbo].[sp_deb_aut]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_deb_aut
(
  @t_show_version bit = 0,
  @i_param1       varchar (255)
)
as
  declare
    @w_return        int,
    @w_fecha_proceso varchar(12),
    @w_fecha_fin     datetime,
    @w_fecha_varchar varchar(10),
    @w_error         varchar(255),
    @w_sp_name       varchar(30),
    --variables para bcp 
    @w_archivo       varchar(255),
    @w_nom_archivo   varchar(100),
    @w_cmd           varchar(500),
    @w_comando       varchar(1000),
    @w_path_s_app    varchar(100),
    @w_msg           varchar(50),
    @w_path          varchar(250),
    @w_anio          char(4),
    @w_mes           char(2),
    @w_dia           char(2),
    @w_mensaje       varchar(1000),
    @w_fecha_max     datetime

  --Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_deb_aut'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_fin = convert(datetime, @i_param1),
    @w_fecha_varchar = convert(varchar, fp_fecha, 103)
  from   cobis..ba_fecha_proceso

  select
    @w_fecha_max = max(convert(datetime, f_debito, 103))
  from   cob_ahorros..ah_debito_auto
  where  f_debito not like 'F%'

  if @w_fecha_max is null
      or @w_fecha_max = ''
    select
      @w_fecha_max = @w_fecha_fin

  -- Depurar tabla al incio de mes
  if datepart(mm,
              @w_fecha_fin) <> datepart(mm,
                                        @w_fecha_max)
  begin
    delete cob_ahorros..ah_debito_auto
    where  territorial <> 'Territorial'
  end

  -- LIMPIAR TABLA PARA REPROCESO
  delete cob_ahorros..ah_debito_auto
  where  f_debito = convert(varchar, @w_fecha_fin, 103)

  --CONSULTA DE DATOS
  select
    'num_operacion' = convert(varchar, nca_operacion),-- NUM OPERACION
    'num_banco' = convert(varchar, nca_banco),-- NUMERO PRESTAMO
    'oficina_op' = convert(varchar, (select
                                       of_nombre
                                     from   cobis..cl_oficina
                                     where  of_oficina = nca_oficina_op)),
    -- OFICINA PRESTAMO
    'monto_deb' = convert(varchar, '0'),-- VALOR DEBITADO
    'fecha_pago' = convert(varchar, nca_fecha_pago, 103),-- FECHA PAGO
    'cuota' = convert(varchar, nca_monto_pago),-- CUOTA DEL CREDITO
    'monto_desem' = convert(varchar, op_monto),-- VALOR DESEMBOLSO
    'cuenta_ah' = convert(varchar, op_cuenta),-- CUENTA PARA DEB.AUT.
    'fecha_marca' = convert(varchar(60), ' '),-- FECHA DE MARCACION
    'usuario_marca' = convert(varchar(60), ' '),
    -- USUARIO QUE REALIZO LA MARCACION
    'regional' = convert(varchar(60), ' '),-- REGIONAL DE LA CUENTA AHO
    'zona' = convert(varchar(60), ' '),-- ZONA DE LA CUENTA AHO
    'oficina_cta' = convert(varchar(60), ' '),-- OFICINA DE LA CUENTA AHO
    'producto' = convert(varchar(60), ' '),-- PRODUCTO DE CUENTA AHO
    'categoria' = convert(varchar(60), ' '),-- CATEGORIA DE CUENTA AHO
    'estado' = convert(varchar(60), ' '),-- ESTADO DE LA CUENTA AHO
    'fecha_aper' = convert(varchar(60), ' '),-- FECHA APERTURA CUENTA AHO
    'cliente' = convert(varchar, op_cliente),-- CODIGO CLIENTE
    'ced_ruc' = convert(varchar(60), ' '),-- No. DOCUMENTO DEL CLIENTE
    'nombre' = convert(varchar(60), ' '),-- NOMBRE CLIENTE
    'subtipo' = convert(varchar(60), ' '),-- SUBTIPO CLIENTE
    'ciudad' = convert(varchar(60), ' '),-- CIUDAD
    'clase_clte' = convert(varchar(60), ' '),-- CLASE CLIENTE
    'sal_cuent_antdeb' = convert(varchar, nca_dispo_ant_deb),
    -- SALDO CUENTA ANTES DEL DEBITO
    'valor_cuota_pend' = convert(varchar, '0'),-- VALOR DE CUOTA PENDIENTE
    'causa_rechazo' = convert(varchar(60), ' '),-- DESCRIPCION CAUSA DEL RECHAZO
    'num_deb_pago' = convert(varchar, isnull(nca_intentos_pag,
                                             0)),-- NUMERO DE DEBITOS PARA PAGO
    'titular_ah' = 'N',-- ES TITULAR DE LA CUENTA AHO
    'fecha_deb' = convert(varchar, nca_fecha_pago, 103) -- FECHA DE DEBITO
  into   #trabajo
  from   cob_cartera..ca_ahndc_automatica,
         cob_cartera..ca_operacion
  where  nca_operacion        = op_operacion
     and nca_fecha_pago       = @w_fecha_fin
     and isnull(op_cuenta,
                '') <> ''
  order  by nca_fecha_pago

  if @@error <> 0
  begin
    select
      @w_error = 400001,
      @w_msg = ' ERROR EN LA INSERCION DE LA TABLA #trabajo'
    goto ERROR
  end

  --ACTUALIZACION DATOS DEL CLIENTE Y LA CUENTA DE AHORROS
  update #trabajo
  set    regional = convert(varchar, of_regional),--Territorial
         zona = convert(varchar, of_zona),--Zona
         oficina_cta = convert(varchar, (select
                                           of_nombre
                                         from   cobis..cl_oficina
                                         where  of_oficina = ah_oficina)),
         --Oficina
         producto = convert(varchar, ah_producto),--Producto 
         categoria = convert(varchar, ah_categoria),--Categor›a
         estado = convert(varchar, ah_estado),--estado
         fecha_aper = convert(varchar, ah_fecha_aper, 103),
         --Fecha de Apertura Cuenta 
         ced_ruc = convert(varchar, en_ced_ruc),--Doc Identificaciæn 
         nombre = substring(en_nomlar,
                            1,
                            60),--Nombre Titular de la Cuenta 	
         subtipo = convert(varchar, en_subtipo),
         --Tipo Persona (Jur›dica o Natural) cl_ente.en_subtipo
         ciudad = convert(varchar, (select
                                      ci_descripcion
                                    from   cobis..cl_ciudad
                                    where  of_ciudad = ci_ciudad)),--Ciudad
         clase_clte = convert(varchar, ah_clase_clte) --Clase cliente
  from   #trabajo,
         cob_ahorros..ah_cuenta_tmp,
         cobis..cl_ente,
         cobis..cl_oficina
  where  cuenta_ah  = ah_cta_banco
     and cliente    = en_ente
     and ah_oficina = of_oficina

  if @@error <> 0
  begin
    select
      @w_error = 400002,
      @w_msg = ' ERROR EN LA ACTUALIZACION DE LA TABLA #trabajo'
    goto ERROR
  end

  --ACTUALIZAR CAUSA DE RECHAZO
  update #trabajo
  set    causa_rechazo = abd_beneficiario
  from   #trabajo,
         cob_cartera..ca_abono,
         cob_cartera..ca_abono_det
  where  num_operacion     = ab_operacion
     and num_operacion     = abd_operacion
     and ab_operacion      = abd_operacion
     and ab_secuencial_ing = abd_secuencial_ing
     and ab_fecha_ing      = @w_fecha_fin
  if @@error <> 0
  begin
    select
      @w_error = 400003,
      @w_msg = ' ERROR EN LA ACTUALIZACION DE LA TABLA #trabajo'
    goto ERROR
  end

  -- ACTUALIZAR SI ES TITULAR DE LA CUENTA
  update #trabajo
  set    titular_ah = 'S'
  from   #trabajo,
         cobis..cl_det_producto,
         cobis..cl_cliente
  where  dp_det_producto = cl_det_producto
     and cuenta_ah       = dp_cuenta
     and cliente         = cl_cliente
     and cl_rol          = 'T'

  if @@error <> 0
  begin
    select
      @w_error = 400004,
      @w_msg = ' ERROR EN LA ACTUALIZACION DE LA TABLA #trabajo'
    goto ERROR
  end

  --ACTUALIZACION FECHA DEBITO, VALOR DEBITADO Y VALOR PENDIENTE DE LA CUOTA
  update #trabajo
  set    fecha_deb = convert(varchar, hm_fecha, 103),
         monto_deb = isnull(hm_valor,
                            0)
  from   #trabajo,
         cob_ahorros_his..ah_his_movimiento
  where  num_operacion = hm_cod_alterno
     and hm_tipo_tran  = 264
     and hm_causa      = '26'
     and hm_fecha      = @w_fecha_fin

  if @@error <> 0
  begin
    select
      @w_error = 400005,
      @w_msg = ' ERROR EN LA ACTUALIZACION DE LA TABLA #trabajo'
    goto ERROR
  end

  update #trabajo
  set    valor_cuota_pend = convert(varchar, (convert(money, cuota) -
                                                     convert(money, monto_deb)))
  if @@error <> 0
  begin
    select
      @w_error = 400005,
      @w_msg = 'ERROR EN LA ACTUALIZACION DE LA TABLA #trabajo'
    goto ERROR
  end

  select
    ops_fecha_marca = min(ops_fecha_proceso_ts),
    ops_usuario_ts,
    'operacion' = num_operacion
  into   #marcas
  from   #trabajo,
         cob_cartera..ca_operacion_ts with (nolock)
  where  num_operacion         = ops_operacion
     and isnull(ops_cuenta,
                '') <> ''
  group  by num_operacion,
            ops_usuario_ts,
            ops_fecha_proceso_ts
  order  by ops_fecha_proceso_ts desc

  update #trabajo
  set    fecha_marca = convert(varchar, ops_fecha_marca, 103),
         usuario_marca = ops_usuario_ts
  from   #trabajo,
         #marcas
  where  num_operacion = operacion

  if @@error <> 0
  begin
    select
      @w_error = 400006,
      @w_msg = ' ERROR EN LA ACTUALIZACION DE LA TABLA #trabajo'
    goto ERROR
  end

  insert into cob_ahorros..ah_debito_auto
    select
      regional,zona,oficina_cta,producto,categoria,
      cuenta_ah,estado,fecha_aper,cliente,ced_ruc,
      nombre,subtipo,ciudad,clase_clte,fecha_marca,
      usuario_marca,sal_cuent_antdeb,num_banco,oficina_op,monto_desem,
      fecha_pago,--FECHA PAGO CREDITO
      convert(varchar, cuota),convert(varchar, monto_deb),
      convert(varchar, valor_cuota_pend),fecha_deb,--FECHA DEBITO
      causa_rechazo,num_deb_pago,titular_ah
    from   #trabajo

  if @@error <> 0
  begin
    select
      @w_error = 400007,
      @w_msg = ' ERROR EN LA INSERCION DE LA TABLA cob_ahorros..ah_debito_auto'
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
      @w_error = 400008,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERROR
  end

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 4260

  if @@rowcount = 0
  begin
    select
      @w_msg =
'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_nc_remesa_automatica'
print @w_msg
return 1
end

  select
    @w_anio = convert(varchar(4), datepart(yyyy,
                                           @w_fecha_fin)),
    @w_mes = replicate ('0', 2 - datalength(convert(varchar(2), '00'+datepart(mm
             ,
             @w_fecha_fin))))
             + convert(varchar(2), '00'+datepart(mm, @w_fecha_fin)),
    @w_dia = replicate ('0', 2 - datalength(convert(varchar(2), '00'+datepart(dd
             ,
             @w_fecha_fin))))
             + convert(varchar(2), '00'+datepart(dd, @w_fecha_fin))

  --GENERA BCP

  select
    @w_nom_archivo = 'sp_deb_aut_' + convert(varchar(4), @w_anio) + convert(
                     varchar
                            ( 2), @w_mes)
                     + convert(varchar(4), @w_dia) + '.txt'
  select
    @w_archivo = @w_path + @w_nom_archivo
  print '@w_archivo: ' + @w_archivo
  --select @w_cmd   = @w_path_s_app + 's_app bcp -auto -login cob_ahorros..ah_debito_auto out ' 
  select
    @w_cmd =
'bcp "select territorial,zona,oficina,producto,categoria,Nro_Cuenta,estado,f_aper_cta,cod_cl,doc_id,nom_tit_cta,tip_pers,ciudad,cl_cliente,fech_marc_cuent_deb,'
         +
'usuar_proc_marc, sal_cta,no_prest,of_prest,vlr_desemb,f_pag_cred,vlr_cuot_cred,vlr_debitado,vlr_pend_cuot,f_debito,caus_rechaz_deb_auto,nro_deb_pag,titul_cuent'
         +
' from cob_ahorros..ah_debito_auto order by territorial desc" queryout '
  select
       @w_comando = @w_cmd + @w_archivo + ' -t"|" -b5000 -c -T -S' +
                    @@servername
                    +
                    ' -e' +
                    @w_archivo
    + '.err' --+ ' -config '+ @w_path_s_app + 's_app.ini'

  print '@w_comando: ' + @w_comando
  print '@w_archivo' + @w_archivo
  print '@w_nom_archivo' + @w_nom_archivo

  exec @w_error = xp_cmdshell
    @w_comando

  if @@error <> 0
  begin
    print 'ERROR GENERANDO BCP ' + @w_comando
    select
      @w_mensaje = 'NO EXISTE RUTA DE S_APP',
      @w_error = 400010
    goto ERROR
  end
  return 0

  ERROR:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha_fin,
    @i_error       = @w_error,
    @i_usuario     = 'admuser',
    @i_tran        = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_sp_name

  return @w_error

go

