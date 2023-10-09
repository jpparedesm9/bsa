/************************************************************************/
/*   Archivo:             rep_cfin_LLS_81538.sp                         */
/*   Stored procedure:    sp_rep_cifin                                  */
/*   Base de datos:       cobis                                         */
/*   Producto:            cartera                                       */
/*   Disenado por:        Luis Carlos Moreno C.                         */
/*   Fecha de escritura:  Febrero/2012                                  */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Generar un reporte mensual con marcaciones y desmarcaciones de GMF  */
/*  del dia 31 de Agosto de 2012                                        */
/*  con la siguiente estructura:                                        */
/*  - Zona: Descripción Zona                                            */
/*  - Código de oficina: Codigo Oficina                                 */
/*  - Oficina: Descripción Oficina                                      */
/*  - Nro. Identificación: Identificacion Cliente                       */
/*  - Nombre del cliente: Nombre del Cliente                            */
/*  - Nro. Cuenta: Número de Cuenta                                     */
/*  - Tipo de Novedad: (Marcacion o Desmarcacion)                       */
/*  - Fecha Marcación: Fecha cuando se realizo la marcacion             */
/*  - Fecha Desmarcación: Fecha cuando se realizo la desmarcacion       */
/*  - Usuario Marcación: Usuario que realizo la marcacion               */
/*  - Usuario Desmarcación: Usuario que realizo la desmarcacion         */
/*  - Tipo de cuenta: CONFIRMAR A QUE SE REFIERE TIPO CUENTA            */
/*  - Estado de la cuenta: (ACTIVA, CANCELADA)                          */
/*  - Causal Rechazo: Causal cuando no se pueda realizar la marcacion   */
/*    en CIFIN.                                                         */
/*  - Banco: Entidad donde tenga marcada otra cuenta reportada en CIFIN.*/
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA     AUTOR             RAZON                                   */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/

use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_rep_cifin')
           drop proc sp_rep_cifin
go

create proc sp_rep_cifin
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name          varchar(32),
    @w_sp_name_batch    varchar(50),
    @w_fecha_proceso    datetime,
    @w_fecha_ini        datetime,
    @w_fecha_fin        datetime,
    @w_s_app            varchar(30),
    @w_path             varchar(255),
    @w_error            int,
    @w_col_id           int,
    @w_columna          varchar(50),
    @w_cabecera         varchar(1000),
    @w_comando          varchar(1000),
    @w_cmd              varchar(300),
    @w_msg              varchar(30),
    @w_cont_reg         int,
    @w_nombre_plano     varchar(200),
    @w_plano_errores    varchar(200),
    @w_nombre_plano_det varchar(200),
    @w_fecha_arch       varchar(8),
    @w_hora_arch        varchar(4)

  select
    @w_sp_name = 'sp_rep_cifin'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set nocount on

  /* CREA TABLA TEMPORAL */
  if not object_id('rep_mov_gmf_tmp') is null
    drop table rep_mov_gmf_tmp

  create table rep_mov_gmf_tmp
  (
    rm_zona        varchar(100) null,
    rm_cod_ofi     int null,
    rm_nom_ofi     varchar(100) null,
    rm_ident       varchar(30) null,
    rm_nombre      varchar(254) null,
    rm_cuenta      varchar(100) null,
    rm_novedad     varchar(15) null,
    rm_fec_marc    varchar(10) null,
    rm_fec_desmac  varchar(10) null,
    rm_hora_trans  varchar(10) null,
    rm_usu_marc    varchar(20) null,
    rm_usu_desmarc varchar(20) null,
    rm_tip_cta     varchar(64) null,
    rm_categoria   varchar(64) null,
    rm_est_cta     varchar(64) null,
    rm_causal      varchar(254) null,
    rm_banco       varchar(100) null
  )

  /* CALCULA FECHA DE PROCESO */
  select
    @w_fecha_proceso = fc_fecha_cierre
  from   cobis..ba_fecha_cierre
  where  fc_producto = 4
  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL OBTENER FECHA DE PROCESO.'
    goto ERROR_INF
  end

  -- OBTIENE FECHA INICIAL DE PROCESO
  select
    @w_cont_reg = 0
  select
    @w_fecha_ini = '08/31/2012'
  select
    @w_fecha_fin = '09/01/2012'

  select
    @w_msg = ''

  -- CARGA TABLA TEMPORAL DE TIPOS DE PRODUCTOS
  select
    pf_pro_final,
    me_tipo_ente,
    me_pro_bancario,
    pf_filial,
    pf_sucursal,
    pf_producto,
    pf_moneda,
    pf_tipo,
    pf_descripcion
  into   #tmp_profinal
  from   cob_remesas..pe_pro_final with (nolock),
         cob_remesas..pe_mercado with (nolock)
  where  pf_mercado = me_mercado

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR LEYENDO PRODUCTOS.'
    goto ERROR_INF
  end

  -- INSERTA DATOS EN EL REPORTE
  insert into rep_mov_gmf_tmp
              (rm_ident,rm_fec_marc,rm_hora_trans,rm_usu_marc,rm_novedad)
    select
      oc_ced_ruc,convert(varchar(10), oc_fecha_real_ing, 103),
      convert(varchar(10), oc_fecha_real_ing, 108),oc_usuario,'NO PROCESADA'
    from   cobis..cl_orden_consulta_ext with (nolock)
    where  oc_tconsulta = '08'
       and oc_fecha_real_ing between @w_fecha_ini and @w_fecha_fin
       and oc_estado    = 'PRO'
    order  by oc_fecha_real_ing

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL GENERAR DATOS REPORTE DE MARCACIONES CIFIN.'
    goto ERROR_INF
  end

  /* ACTUALIZA INFORMACION DE LA CUENTA Y DE LA OFICINA DE PROCESO */
  update rep_mov_gmf_tmp
  set    rm_zona = z.of_nombre,
         rm_cod_ofi = hs_oficina,
         rm_nom_ofi = o.of_nombre,
         rm_nombre = en_nomlar,
         rm_cuenta = ah_cta_banco,
         rm_novedad = case hs_observacion
                        when 'EXENTO GMF' then 'MARCACION'
                        when 'NO EXENTO GMF' then 'DESMARCACION'
                        else 'ERROR'
                      end,
         rm_fec_marc = case hs_observacion
                         when 'EXENTO GMF' then rm_fec_marc
                         else ''
                       end,
         rm_fec_desmac = case hs_observacion
                           when 'NO EXENTO GMF' then rm_fec_marc
                           else ''
                         end,
         rm_usu_marc = case hs_observacion
                         when 'EXENTO GMF' then rm_usu_marc
                         else ''
                       end,
         rm_usu_desmarc = case hs_observacion
                            when 'NO EXENTO GMF' then rm_usu_marc
                            else ''
                          end
  from   cob_ahorros_his..ah_his_servicio with (nolock),
         cob_ahorros..ah_cuenta with (nolock),
         cobis..cl_oficina o with (nolock),
         cobis..cl_oficina z with (nolock),
         cobis..cl_ente with (nolock)
  where  hs_tipo_transaccion in (4106, 4148)
     and en_ced_ruc   = rm_ident
     and hs_tsfecha between @w_fecha_ini and @w_fecha_fin
     and ah_cta_banco = hs_cta_banco
     and o.of_oficina = hs_oficina
     and en_ente      = ah_cliente
     and z.of_oficina = o.of_zona

  /* ACTUALIZA NOMBRE DEL CLIENTE */
  update rep_mov_gmf_tmp
  set    rm_nombre = en_nomlar
  from   cobis..cl_ente with (nolock)
  where  en_ced_ruc = rm_ident

  /* OBTIENE LA ULTIMA RESPUESTA QUE EXISTE DE CIFIN PARA LAS CUENTAS SELECCIONADAS */
  select
    rm_ident     ident,
    max(mcg_cod) codigo
  into   #codigos
  from   rep_mov_gmf_tmp,
         cobis..cl_marc_cifin_gen with (nolock)
  where  mcg_num_ide = rm_ident
  group  by rm_ident

  /* ACTUALIZA INFORMACION DE CAUSAL Y NOMBRE DEL CLIENTE */
  update rep_mov_gmf_tmp
  set    rm_causal = mcg_desc_msg,
         rm_nombre = isnull(rm_nombre,
                            mcg_nom_cli)
  from   cobis..cl_marc_cifin_gen with (nolock),
         #codigos
  where  mcg_num_ide = ident
     and rm_ident    = mcg_num_ide
     and mcg_cod     = codigo

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ACTUALIZAR INFORMACION DE CAUSAL Y NOMBRE DEL CLIENTE.'
    goto ERROR_INF
  end

  /* ACTUALIZA INFORMACION DE CAUSAL Y BANCO A PARTIR DE LA TRAMA DE CIFIN */
  update rep_mov_gmf_tmp
  set    rm_banco = mcc_nom_ent
  from   cobis..cl_marc_cifin_gen with (nolock),
         cobis..cl_marc_cifin_ctas with (nolock),
         #codigos
  where  mcg_num_ide = ident
     and rm_ident    = mcg_num_ide
     and mcg_cod     = codigo
     and mcg_cod     = mcc_cod

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ACTUALIZAR INFORMACION DE BANCO.'
    goto ERROR_INF
  end

  /* ACTUALIZA INFORMACION DE TIPO DE CUENTA */
  update rep_mov_gmf_tmp
  set    rm_tip_cta = pf_descripcion
  from   #tmp_profinal,
         cob_ahorros..ah_cuenta with (nolock),
         cobis..cl_oficina with (nolock)
  where  ah_cta_banco    = rm_cuenta
     and me_tipo_ente    = ah_tipocta
     and me_pro_bancario = ah_prod_banc
     and pf_filial       = ah_filial
     and pf_sucursal     = isnull(of_regional,
                                  of_oficina)
     and pf_producto     = ah_producto
     and pf_moneda       = ah_moneda
     and pf_tipo         = ah_tipo
     and of_oficina      = ah_oficina

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ACTUALIZAR INFORMACION DE TIPO DE CUENTA.'
    goto ERROR_INF
  end

  /* ACTUALIZA INFORMACION DE CATEGORIA DE LA CUENTA */
  update rep_mov_gmf_tmp
  set    rm_categoria = valor
  from   cobis..cl_tabla t with (nolock),
         cobis..cl_catalogo c with (nolock),
         cob_ahorros..ah_cuenta with (nolock)
  where  ah_cta_banco = rm_cuenta
     and t.tabla      = 'pe_categoria'
     and c.tabla      = t.codigo
     and c.codigo     = ah_categoria

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ACTUALIZAR INFORMACION DE CATEGORIA DE LA CUENTA.'
    goto ERROR_INF
  end

  /* ACTUALIZA ESTADO DE LA CUENTA */
  update rep_mov_gmf_tmp
  set    rm_est_cta = valor
  from   cobis..cl_tabla t with (nolock),
         cobis..cl_catalogo c with (nolock),
         cob_ahorros..ah_cuenta with (nolock)
  where  ah_cta_banco = rm_cuenta
     and t.tabla      = 'ah_estado_cta'
     and c.tabla      = t.codigo
     and c.codigo     = ah_estado

  if @@error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ACTUALIZAR ESTADO DE LA CUENTA.'
    goto ERROR_INF
  end

/*********************************************************************************/
/*        GENERA ARCHIVO PLANO CON EL REPORTE DE GARANTIAS REESTRUCTURADAS       */
/*********************************************************************************/
  /* Asigna variables para el nombre del archivo */
  select
    @w_fecha_arch = substring(convert(varchar(10), @w_fecha_proceso, 103), 1, 2)
                    + substring(convert(varchar(10), @w_fecha_proceso, 103), 4,
                    2)
                    + substring(convert(varchar(10), @w_fecha_proceso, 103), 7,
                    4)
    ,
    @w_hora_arch = substring(convert(varchar, getdate(), 108), 1, 2)
                   + substring(convert(varchar, getdate(), 108), 4, 2),
    @w_sp_name_batch = 'cobis..sp_marcacion_cifin'

  /* Obtiene el path donde se va a generar el informe : VBatch\Clientes\Listados */
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    goto ERROR_INF
  end

  /* Obtiene el parametro de la ubicacion del kernel\bin en el servidor */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR AL OBTENER EL PARAMETRO GENERAL S_APP DE ADM'
    goto ERROR_INF
  end

  /* Obtiene los nombres de los informes */
  select
    @w_nombre_plano = @w_path + 'REPO_MARC_GMF_' + @w_fecha_arch + '_' +
                             @w_hora_arch + '.txt',
    @w_plano_errores = @w_path + 'REPO_MARC_GMF_' + @w_fecha_arch + '_' +
                       @w_hora_arch + '.err',
    @w_nombre_plano_det = @w_path + 'REPO_MARC_GMF_det.txt'

/*-------------------------------------------------------------------------------------*/
/*             GENERA ENCABEZADO INFORME - ARCHIVO: REPO_CRE_REEST.txt       */
/*-------------------------------------------------------------------------------------*/
  /* Obtiene texto para el encabezado de las columnas */
  select
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = ''
  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   sysobjects o,
           syscolumns c
    where  o.id    = c.id
       and o.name  = 'rep_mov_gmf_tmp'
       and c.colid > @w_col_id
    order  by c.colid
    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end
    select
      @w_cabecera = @w_cabecera + @w_columna + '^|'
  end

  /*Escribir encabezado de las columnas */
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ESCRIBIR ENCABEZADO DEL INFORME.'
    goto ERROR_INF
  end

/*-------------------------------------------------------------------------------------*/
/*             GENERA DETALLE INFORME - ARCHIVO: PLANO_ACT_CLI_det.txt          */
/*-------------------------------------------------------------------------------------*/
  /* Genera detalle del informe en el archivo */
  select
    @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..rep_mov_gmf_tmp out '
  select
       @w_comando = @w_cmd + @w_nombre_plano_det + ' -c -e' + @w_plano_errores +
                    ' -t"|" '
    +
                    '-config '
    + @w_s_app
                 + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVIZAR ARCHIVOS DE LOG GENERADOS.'
    print @w_comando
    goto ERROR_INF
  end
  else
  begin
    select
      @w_comando = 'del ' + @w_plano_errores
    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_error = 808022,
        @w_msg = 'ERROR AL BORRAR EL ARCHIVO DE ERRORES BCP.'
      print @w_comando
      goto ERROR_INF
    end
  end

/*-------------------------------------------------------------------------------------*/
/*           GENERA INFORME FINAL - ARCHIVO: PLANO_ACT_CLI.AAAAMMDD_HHMMSS.txt  */
/*-------------------------------------------------------------------------------------*/
  /* Une los archivos encabezado, detalle y totales */
  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_nombre_plano_det + ' ' +
                        @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA GENERACION DEL INFORME FINAL.'
    goto ERROR_INF
  end

  /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
  select
    @w_comando = 'del ' + @w_nombre_plano_det
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
    print @w_comando
    goto ERROR_INF
  end

  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
    print @w_comando
    goto ERROR_INF
  end

  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
    print @w_comando
    goto ERROR_INF
  end

  ERROR_INF:

  print @w_msg

go

