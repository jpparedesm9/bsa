/********************************************************************/
/*  Archivo:                Ctas_Can_Exentas_GMF.sp                 */
/*  Stored procedure:       sp_ctascan_extgmf                       */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Ahorros                                 */
/*  Disenado por:           Andres Munoz                            */
/*  Fecha de escritura:     21-Junio-2012                           */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                          PROPOSITO                               */
/*  Extraer datos diarios de saldos de cuentas de ahorro por        */
/*  oficina   del '12/06/2010' al  '04/30/2012'                     */
/*                          MODIFICACIONES                          */
/********************************************************************/
/*  FECHA          AUTOR               RAZON                        */
/*  21/06/2012     A. Munoz            Emision inicial              */
/*  03/May/2016    J. Salazar          Migracion COBIS CLOUD MEXICO */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ctascan_extgmf')
  drop proc sp_ctascan_extgmf
go

/****** Object:  StoredProcedure [dbo].[sp_ctascan_extgmf]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ctascan_extgmf
  @t_show_version bit = 0
as
  declare
    @w_s_app        varchar(255),
    @w_path         varchar(255),
    @w_nombre       varchar(255),
    @w_nombre_cab   varchar(255),
    @w_destino      varchar(2500),
    @w_errores      varchar(1500),
    @w_error        int,
    @w_comando      varchar(3500),
    @w_nombre_plano varchar(2500),
    @w_msg          varchar(255),
    @w_col_id       int,
    @w_columna      varchar(100),
    @w_cabecera     varchar(2500),
    @w_nom_tabla    varchar(100),
    @w_sp_name      varchar(20),
    @w_cont         int

  select
    @w_sp_name = 'sp_ctascan_extgmf'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if exists (select
               1
             from   cob_ahorros..sysobjects
             where  name = 'cuentas_gmf')
    drop table cob_ahorros..cuentas_gmf

  select
    'Oficina' = isnull((select
                          of_nombre
                        from   cobis..cl_oficina
                        where  of_oficina = ah_oficina),
                       ''),
    'Producto' = isnull((select
                           pb_descripcion
                         from   cob_remesas..pe_pro_bancario
                         where  pb_pro_bancario = ah_prod_banc),
                        ''),
    'Nro Cuenta' = isnull((ltrim(ah_cta_banco)),
                          ''),
    'Estado' = isnull((select
                         b.valor
                       from   cobis..cl_tabla a,
                              cobis..cl_catalogo b
                       where  a.tabla  = 'ah_estado_cta'
                          and a.codigo = b.tabla
                          and b.codigo = ah_estado),
                      ''),
    'Apertura' = isnull((convert(varchar(10), ah_fecha_aper, 101)),
                        ''),
    'Oficial' = isnull((select
                          fu_nombre
                        from   cobis..cc_oficial,
                               cobis..cl_funcionario
                        where  fu_funcionario = oc_funcionario
                           and oc_oficial     = ah_oficial),
                       ''),
    'Cedula' = isnull((select
                         en_ced_ruc
                       from   cobis..cl_ente
                       where  en_ente = ah_cliente),
                      ''),
    'Nombre' = isnull((ltrim(ah_nombre)),
                      ''),
    'Categoria' = isnull((select
                            b.valor
                          from   cobis..cl_tabla a,
                                 cobis..cl_catalogo b
                          where  a.tabla  = 'pe_categoria'
                             and a.codigo = b.tabla
                             and b.codigo = ah_categoria),
                         ''),
    'Condiciones' = isnull((cast(ah_condiciones as varchar(10))),
                           ''),
    'Sal. Disponible' = isnull((cast(ah_disponible as varchar(20))),
                               ''),
    'Descripcion EC' = isnull((cast(ah_descripcion_ec as varchar(60))),
                              ''),
    'Cta Personalizada' = isnull((cast(ah_personalizada as varchar(5))),
                                 ''),
    'Nro. Transacciones' = isnull((cast(ah_contador_trx as varchar(5))),
                                  ''),
    'Telefono' = isnull((select top 1
                           (convert(varchar, isnull(ltrim(rtrim(te_prefijo)),
                            '0')
                            )
                            + '-' +
                            te_valor)
                         from   cobis..cl_direccion,
                                cobis..cl_telefono
                         where  di_principal  = 'S'
                            and di_direccion  = te_direccion
                            and te_ente       = di_ente
                            and te_secuencial = di_telefono
                            and di_ente       = ah_cliente),
                        ''),
    'Cobrado GMF' = isnull((cast(ah_monto_imp as varchar(20))),
                           ''),
    'Exonerado GMF' = isnull(eg_marca,
                             ''),
    'Titularidad' = isnull((select
                              b.valor
                            from   cobis..cl_tabla a,
                                   cobis..cl_catalogo b
                            where  a.tabla  = 're_titularidad'
                               and a.codigo = b.tabla
                               and b.codigo = ah_ctitularidad),
                           ''),
    'Tipo Sociedad' = isnull((select
                                b.valor
                              from   cobis..cl_tabla a,
                                     cobis..cl_catalogo b
                              where  a.tabla  = 'ah_cla_cliente'
                                 and a.codigo = b.tabla
                                 and b.codigo = ah_tipocta_super),
                             ''),
    'Direccion DVC' = isnull((ltrim(ah_descripcion_dv)),
                             ''),
    'Ciudad DVC' = isnull((case
                             when ah_parroquia_dv <> 0 then
                             (select
                                ci_descripcion
                              from   cobis..cl_ciudad
                              where
                             ci_ciudad = ah_parroquia_dv)
                             else (select
                                     ci_descripcion
                                   from   cobis..cl_oficina,
                                          cobis..cl_ciudad
                                   where  of_oficina = ah_agen_dv
                                      and of_ciudad  = ci_ciudad)
                           end),
                          ''),
    'Permite saldo 0' = isnull((cast(ah_permite_sldcero as varchar(5))),
                               ''),
    'Zona Oficina' = isnull((select
                               (select
                                  ltrim(b.of_nombre)
                                from   cobis..cl_oficina b
                                where  a.of_zona = b.of_oficina)
                             from   cobis..cl_oficina a
                             where  a.of_subtipo = 'O'
                                and a.of_oficina = ah_oficina),
                            ''),
    'Cta. Trasl. DNT' = isnull((case
                                  when (select
                                          1
                                        from   cob_remesas..re_tesoro_nacional
                                        where  tn_estado = 'P'
                                           and tn_cuenta = ah_cta_banco) = 1
                                then
                                  'S'
                                  else 'N'
                                end),
                               ''),
    'Cod. Tutor' = isnull((select
                             cast(b.cl_cliente as varchar(10))
                           from   cobis..cl_ente a,
                                  cobis..cl_cliente b
                           where  a.en_ente         = b.cl_cliente
                              and b.cl_rol          = 'U'
                              and b.cl_det_producto = (select
                                                         c.cl_det_producto
                                                       from
                                  cobis..cl_cliente c,
                                  cobis..cl_det_producto d
                                                       where
                                  c.cl_cliente      = ah_cliente
                                                          and
                                  d.dp_cuenta       = ah_cta_banco
                                                          and
                                  c.cl_det_producto = dp_det_producto))
                   ,
                          ''),
    'Ced. Tutor' = isnull((select
                             b.cl_ced_ruc
                           from   cobis..cl_ente a,
                                  cobis..cl_cliente b
                           where  a.en_ente         = b.cl_cliente
                              and b.cl_rol          = 'U'
                              and b.cl_det_producto = (select
                                                         c.cl_det_producto
                                                       from
                                  cobis..cl_cliente c,
                                  cobis..cl_det_producto d
                                                       where
                                  c.cl_cliente      = ah_cliente
                                                          and
                                  d.dp_cuenta       = ah_cta_banco
                                                          and
                                  c.cl_det_producto = dp_det_producto))
                   ,
                          ''),
    'Nom. Tutor' = isnull((select
                             a.en_nomlar
                           from   cobis..cl_ente a,
                                  cobis..cl_cliente b
                           where  a.en_ente         = b.cl_cliente
                              and b.cl_rol          = 'U'
                              and b.cl_det_producto = (select
                                                         c.cl_det_producto
                                                       from
                                  cobis..cl_cliente c,
                                  cobis..cl_det_producto d
                                                       where
                                  c.cl_cliente      = ah_cliente
                                                          and
                                  d.dp_cuenta       = ah_cta_banco
                                                          and
                                  c.cl_det_producto = dp_det_producto))
                   ,
                          ''),
    'Genero' = (select
                  a.valor
                from   cobis..cl_catalogo a,
                       cobis..cl_tabla b
                where  a.tabla  = b.codigo
                   and b.tabla  = 'cl_sexo'
                   and a.codigo = (select
                                     p_sexo
                                   from   cobis..cl_ente
                                   where  en_ente = ah_cliente))
  into   cob_ahorros..cuentas_gmf
  from   cob_ahorros..ah_cuenta_tmp,
         cob_ahorros..ah_exenta_gmf
  where  eg_marca     = 'S'
     and eg_cta_banco = ah_cta_banco
     and ah_estado    = 'C'
  order  by 1

  /*** GENERAR BCP ***/

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 4011

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_nombre = 'CTAS_CAN',
    @w_nom_tabla = 'cuentas_gmf',
    --@w_cont         = 0,
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), ''),
    @w_nombre_cab = @w_nombre + '_EXGMF'

  select
    @w_nombre_plano =
       @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart(
       dd, getdate())) +
       '_'
                      + convert(varchar(2), datepart(mm, getdate())) + '_'
                      + convert(varchar(4), datepart(yyyy, getdate())) + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cob_ahorros..sysobjects o,
           cob_ahorros..syscolumns c
    where  o.id    = c.id
       and o.name  = @w_nom_tabla
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

  select
    @w_cabecera = left(@w_cabecera,
                       datalength(@w_cabecera) - 2)

  --Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  --Ejecucion para Generar Archivo Datos
  select
    @w_comando =
    @w_s_app + 's_app bcp -auto -login cob_ahorros..cuentas_gmf out '

  select
    @w_destino = @w_path + 'ctas_can_con_gmf.txt',
    @w_errores = @w_path + 'ctas_can_con_gmf.err'

  select
       @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                    ' -t"|" '
                    + '-config '
                    + @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'Error Generando Archivo ctas_can_con_gmf'
  end

  ----------------------------------------
  --Union de archivos (cab) y (dat)
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                        'ctas_can_con_gmf.txt' + ' ' +
                        @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  return 0

  ERRORFIN:
  print @w_msg

go

