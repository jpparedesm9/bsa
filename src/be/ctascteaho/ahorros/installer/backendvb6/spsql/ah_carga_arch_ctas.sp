/************************************************************************/
/*      Archivo:                ah_carga_arch_ctas.sp                   */
/*      Stored procedure:       sp_carga_archivo_cuentas                */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               clientes                                */
/*      Disenado por:           Alfredo Zamudio                         */
/*      Fecha de escritura:     03/04/2012                              */
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
/*                              PROPOSITO                               */
/*      Carga Archivo de Cuentas enviado a travéz de la base de Datos  */
/*      de cob_externos.                                                */
/************************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA                 AUTOR                 RAZON               */
/*     05/DIC/2013          Liana Coto   Req 393 DispersiONn de Fondos  */
/*                                       para abonos a cuentas inactivas*/
/*                                       no trasladadas al DTN          */
/*   02/May/2016            J. Calderon  Migración a CEN                */
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
           where  name = 'sp_carga_archivo_cuentas')
  drop proc sp_carga_archivo_cuentas
go

create proc sp_carga_archivo_cuentas
(
  @t_show_version bit = 0,
  @i_param1       varchar(1)
)
as
  declare
    @w_tipo_carga    varchar(1),
    @w_fecha_carga   datetime,
    @w_nom_archivo   varchar(255),
    @w_spname        varchar(15),
    @w_slm           money,
    @w_s_app         varchar(50),
    @w_path          varchar(60),
    @w_cmd           varchar(255),
    @w_destino       varchar(255),
    @w_errores       varchar(255),
    @w_error         int,
    @w_comando       varchar(500),
    @w_mensaje       varchar(255),
    @w_usuario       varchar(24),
    @s_user          login,
    @w_int           int,
    @w_idd           varchar(5),
    @w_cont          int,
    @w_fecha         datetime,
    @w_top           varchar(10),
    @w_mon           money,
    @t_trn           int,
    @w_tmov          char(1),
    @w_parm          varchar(50),
    @w_cuenta        int,
    @w_cur           int,
    @w_empresa       int,
    @w_tcar          char(1),
    @w_whl           int,
    @w_mon_r1        money,
    @w_mon_r2        money,
    @w_cont_r1       int,
    @w_cont_r2       int,
    @w_sec_archivo   int,
    @w_tipo_reg      char(2),
    @w_secuencia     int,
    @w_autnum        int,
    @w_sec_detalle   int,
    @w_max_sec_arch  int,
    @w_nomb_arch     varchar(100),
    @w_empresa_det   int,
    @w_tcar_det      char(1),
    @w_causa         char(3),
    @w_causa_r1      char(3),
    @w_tmov_r1       char(1),
    @w_tipo_oper     char(1),
    @w_tipo_ced_val  char(2),
    @w_ced_ruc_val   varchar(30),
    @w_ca_ente_val   int,
    @w_cta_banco_val char(16),
    @w_valor_val     money,
    @w_tipo_mov_val  char(1),
    @w_estado        char(1),
    @w_estado_arc    char(1),
    @w_cmd_rename    varchar(2500),
    @w_nuevo         varchar(500),
    @w_fech_arch     varchar(30),
    @w_fech_arch2    varchar(30),
    @w_fech_arch3    datetime,
    @w_1             varchar(4),
    @w_2             varchar(2),
    @w_3             varchar(2),
    @w_return        int,
    @w_sp_name       varchar(30)
  /*Instanciación de Variables*/

   /* Captura del nombre del Store Procedure */

  select
    @w_sp_name = 'sp_carga_archivo_cuentas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_spname = 'sp_carga_archivo_cuentas',
    @w_tipo_carga = @i_param1,
    @w_mensaje = 'ERROR ESTRUCTURA:'

 

  select
    @w_fecha_carga = fp_fecha
  from   cobis..ba_fecha_proceso

  delete cob_ahorros..ah_carga_archivo_cuentas_tmp

  /* SI ES CARGA DE ARCHIVO EXTERNO */
  if @w_tipo_carga = 'E'
  begin
    /* OBTIENE RUTA DEL ARCHIVO A CARGAR */
    select
      @w_path = ba_path_destino
    from   cobis..ba_batch with (nolock)
    where  ba_arch_fuente = 'cob_ahorros..sp_carga_archivo_cuentas'

    if @w_path is null
    begin
      select
        @w_error = 101077,
        @w_mensaje =
'ERROR : NO EXISTE RUTA DESTINO DE LISTADOS PARA EL BATCH sp_carga_archivo_cuentas'
  print @w_mensaje
  goto ERRORFIN
end

  /* OBTIENE LISTADO DE ARCHIVOS POR CARGAR A COB_EXTERNOS */
  set @w_parm = 'PLANO_CARGA_CTAS*' + '.txt'
  set @w_cmd = 'DIR "' + @w_path + case when right(@w_path, 1) = '\' then ''
               else '\' end +
               @w_parm + '" /B'

  create table #tmpBuscaFiles
  (
    id   int identity,
    line varchar(255) null
  )
  insert into #tmpBuscaFiles
  exec @w_return = master..xp_cmdshell
    @w_cmd

  if @w_return <> 0
  begin
    print 'NO EXISTEN ARCHIVOS A CARGAR, FAVOR VALIDAR'
    return 0
  end

  select
    @w_cuenta = count(1)
  from   #tmpBuscaFiles

  if @w_cuenta is null
  begin
    select
      @w_error = 1000001,
      @w_mensaje = 'NO HAY ARCHIVOS DE NOMINA COINCIDENTES'
    goto ERRORFIN
  end

  set @w_cur = 1
  set @w_cuenta = @w_cuenta - 1

  /* OBTIENE RUTA DEL KERNEL */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@error <> 0
  begin
    print 'nombre: ' + @w_nom_archivo + ' ' + convert(varchar, @w_cur)
    select
      @w_error = 101077,
      @w_mensaje = ' ERROR No existe parametro'
    goto ERRORFIN
  end

  /* REALIZA CARGA AL SISTEMA DE LOS ARCHIVOS A PROCESAR */
  while(@w_cur <= @w_cuenta)
  begin
    /* OBTIENE NOMBRE DEL ARCHIVO A PROCESAR */
    select top 1
      @w_nom_archivo = line
    from   #tmpBuscaFiles
    where  id = @w_cur

    if @@rowcount = 0
      break

    select
      @w_estado_arc = 'V'

    --Validacion de estructura de nombre archivo
    if isdate(substring(@w_nom_archivo,
                        charindex('.txt',
                                  @w_nom_archivo) - 8,
                        8)) = 0
    begin
      print 'nombre: ' + @w_nom_archivo + ' '
      select
        @w_error = 101077,
        @w_mensaje = ' ARCHIVO ' + @w_nom_archivo +
                     ' con estructura de nombre errado'
      goto ERROR_ARCH_E
    end

    --VALIDANDO FECHA DE ARCHIVO A CARGAR REQ464
    select
      @w_fech_arch = right(@w_nom_archivo,
                           12),
      @w_fech_arch = substring(@w_fech_arch,
                               1,
                               8),
      @w_1 = substring(@w_fech_arch,
                       1,
                       4),
      @w_2 = substring(@w_fech_arch,
                       5,
                       6),
      @w_3 = substring(@w_fech_arch,
                       7,
                       8),
      @w_fech_arch2 = @w_1 + '-' + @w_2 + '-' + @w_3,
      @w_fech_arch3 = convert(datetime, @w_fech_arch2, 101)

    if @w_fech_arch3 > @w_fecha_carga
    begin
      print 'NO SE PUEDE REALIZAR LA CARGA DEL ARCHIVO : ' + @w_nom_archivo
            + ' , FECHA MAYOR A LA FECHA DE PROCESO'
      select
        @w_error = 1000086,
        @w_mensaje =
'NO SE PUEDE REALIZAR LA CARGA DEL ARCHIVO, FECHA MAYOR A LA FECHA DE PROCESO'

  delete from #tmpBuscaFiles
  where  line = @w_nom_archivo
     and id   = @w_cur

  select
    @w_estado_arc = 'E'

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha_carga,
    @i_error       = @w_error,
    @i_usuario     = 'admuser',
    @i_tran        = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_spname

  select
    @w_path = case right(@w_path,
                         1)
                when '\' then @w_path
                else @w_path + '\'
              end
  select
    @w_nuevo = @w_nom_archivo + '.procesado.' + convert(varchar(8),
               @w_fecha_carga
               ,
                                        112) + '_'
               + @w_estado_arc
  select
    @w_cmd_rename = 'ren ' + @w_path + @w_nom_archivo + ' ' + @w_nuevo

  exec master..xp_cmdshell
    @w_cmd_rename

  select
    @w_error = 0

  goto ERR_FECHPROC

end --fin @w_fech_arch3 > @w_fecha_carga 

select
  @w_cmd =
  @w_s_app +
  's_app bcp -auto -login cob_externos..ex_carga_archivo_cuentas in '
select
  @w_destino = @w_path + @w_nom_archivo,
  @w_errores = @w_path + @w_nom_archivo + '_' + '.err'

select
  @w_comando =
                                                                  @w_cmd +
  @w_destino + ' -b1000  -c -e ' + @w_errores + ' -t"|" ' +
                                                                  '-config ' +
                                                                  @w_s_app
               + 's_app.ini'

exec @w_error = xp_cmdshell
  @w_comando

/*VALIDACIONES ESTRUCTURA SOBRE ARCHIVO PLANO*/
if @w_error <> 0
begin
  print 'cmd ' + @w_cmd
  print 'destino ' + @w_destino
  print 'comando ' + @w_comando
  print 'Error Cargando Archivo <' + @w_nom_archivo + '> ' + ' Mensaje '
        + isnull(convert(varchar, error_number()), '')
  select
    @w_error = isnull(convert(varchar, error_number()),
                      1),
    @w_mensaje = 'ERROR CARGANDO EL ARCHIVO PLANO'
  goto ERROR_ARCH_E
end

ERR_FECHPROC:
set @w_cur = @w_cur + 1

end --FIN WHILE

  /* CARGA TABLA TEMPORAL CON LOS NOMBRES DE LOS ARCHIVOS A PROCESAR */
  select distinct
    ca_nomb_arch
  into   #archivos
  from   cob_externos..ex_carga_archivo_cuentas
  where  ca_tipo_carga = 'E'
  order  by ca_nomb_arch

  select
    @w_nomb_arch = ''

  /* PROCESAR CADA UNO DE LOS ARCHIVOS */
  while 1 = 1
  begin
    select
      @w_estado_arc = 'V'

    /* OBTIENE NOMBRE DE CADA UNO DE LOS ARCHIVOS A PROCESAR */
    select top 1
      @w_nomb_arch = ca_nomb_arch
    from   #archivos
    where  ca_nomb_arch > @w_nomb_arch
    order  by ca_nomb_arch

    if @@rowcount = 0
      break

    delete #archivos
    where  ca_nomb_arch = @w_nomb_arch

    /* OBTIENE CANTIDAD DE REGISTROS DEL ARCHIVO */
    select
      @w_cont = count(1)
    from   cob_externos..ex_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch

    if @w_cont = 1
    begin
      select
        @w_mensaje = 'NO CARGO DATOS EN EL BCP. REVISAR EL ARCHIVO PLANO: ' +
                            @w_nomb_arch,
        @w_error = 2903084
      goto ERROR_ARCH_E
    end

  /* VALIDA EXISTENCIA DE LA TAPA DEL LOTE */
    -- VALIDA CANTIDAD DE REGISTRO TIPO 1
    select
      @w_cont_r1 = count(1)
    from   cob_externos..ex_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch
       and ca_tipo_reg  = 'R1'

    if @w_cont_r1 = 0
    begin
      select
        @w_error = 1000086,
        @w_mensaje = 'NO SE EXISTE REGISTRO TIPO 1. LOTE:' + @w_nomb_arch
      goto ERROR_ARCH_E --Req 393
    end

    if @w_cont_r1 > 1
    begin
      select
        @w_error = 1000086,
        @w_mensaje = 'EXISTEN MAS DE UNA CABECERA PARA EL LOTE:' + @w_nomb_arch
      goto ERROR_ARCH_E --Req 393
    end

    -- OBTIENE VALOR DE TRANSACCIONES REGISTRO TIPO 1
    select
      @w_mon_r1 = cast(ca_valor as money),
      @w_cont_r1 = cast(ca_cant_reg as int)
    from   cob_externos..ex_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch
       and ca_tipo_reg  = 'R1'

    if @w_mon_r1 = 0
        or @w_mon_r1 is null
    begin
      select
        @w_error = 1000086,
        @w_mensaje = 'NO SE EXISTE MONTO TOTAL REGISTRO TIPO 1. LOTE:' +
                     @w_nomb_arch
      goto ERROR_ARCH_E --Req 393
    end

    -- OBTIENE VALOR DE TRANSACCIONES REGISTRO TIPO 2
    select
      @w_mon_r2 = sum(cast(ca_valor as money)),
      @w_cont_r2 = count(1)
    from   cob_externos..ex_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch
       and ca_tipo_reg  = 'R2'

    if @w_cont_r2 = 0
    begin
      select
        @w_error = 1000086,
        @w_mensaje = 'NO SE EXISTE CANTIDAD DETALLE REGISTRO TIPO 2. LOTE:' +
                     @w_nomb_arch
      goto ERROR_ARCH_E --Req 393
    end

    /* VALIDA CANTIDADES VS VALORES REGISTROS 1 VS REGISTROS 2 */
    if @w_mon_r1 <> @w_mon_r2
        or @w_cont_r1 <> @w_cont_r2
    begin
      update cob_externos..ex_carga_archivo_cuentas
      set    ca_estado = 'X',
             ca_error = 'DATOS DE CABECERA NO COINCIDEN CON EL LOTE. ARCHIVO: '
                        +
                        @w_nomb_arch
      where  ca_nomb_arch = @w_nomb_arch

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = 'ERROR AL ACTUALIZAR LOTE CON ERROR: ' + @w_nomb_arch
        goto ERROR_ARCH_E --Req 393            
      end

      select
        @w_error = 400002,
        @w_mensaje = 'DATOS DE CABECERA NO COINCIDEN CON EL LOTE. ARCHIVO: ' +
                     @w_nomb_arch
      goto ERROR_ARCH_E --Req 393
    end

    /* OBTIENE CAMPOS DEL REGISTRO */
    select
      @w_tcar = ca_tipo_carga,
      @w_empresa = ca_ente,
      @w_fecha = ca_fecha_reg,
      @w_top = ca_tipo_oper,
      @w_tmov = ca_tipo_mov
    from   cob_externos..ex_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch
       and ca_tipo_reg  = 'R1'

    select
      @w_tipo_oper = '' --Req 393

    /* LEE SI YA EXISTE UNA CARGA PARA EL ARCHIVO */
    select
      @w_tipo_oper = ca_tipo_oper
    from   cob_ahorros..ah_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch

    if @@rowcount = 0
       and @w_top = 'N'
    begin
      select
        @w_mensaje = 'NO SE PUEDE REPORTAR NOVEDAD, NO HAY REPORTE INICIAL'
      select
        @w_error = 1000029
      goto ERROR_ARCH_E --Req 393
    end

    /* SI EL TIPO DE OPERACION ES EL ARCHIVO YA ESTA PROCESADO */
    if @w_tipo_oper = @w_top
       and @w_top = 'I'
    begin
      select
        @w_mensaje = 'EL REPORTE ' + isnull(@w_nomb_arch, 'XXX') +
                            ' YA HA SIDO GENERADO'
      select
        @w_error = 1000026

      delete #archivos
      where  ca_nomb_arch = @w_nomb_arch

      goto ERROR_ARCH_E
    end

    set @w_whl = 1
    /* RECHAZA REGISTROS CON SECUENCIAL NULO */
    update cob_externos..ex_carga_archivo_cuentas
    set    ca_estado = 'X',
           ca_error = 'TIPO DE DATO NULO EN EL CAMPO SECUENCIA DE DETALLE'
    where  ca_nomb_arch = @w_nomb_arch
       and ca_tipo_reg  = 'R2'
       and ca_secuencia is null

    if @@error <> 0
    begin
      select
        @w_error = 400002,
        @w_mensaje =
' ERROR EN LA ACTUALIZACION TIPO DE DATO CAMPO SECUENCIA DE DETALLE, ARCHIVO:'
+ @w_nomb_arch

  goto ERROR_ARCH_E --Req 393
end

/* RECHAZA REGISTROS CON SECUENCIAL NO VALIDO */
update cob_externos..ex_carga_archivo_cuentas
set    ca_estado = 'X',
       ca_error = 'TIPO DE DATO NO VALIDO EN EL CAMPO SECUENCIA DE DETALLE'
where  ca_nomb_arch            = @w_nomb_arch
   and ca_tipo_reg             = 'R2'
   and isnumeric(ca_secuencia) = 0

if @@error <> 0
begin
  select
    @w_error = 400002,
    @w_mensaje =
' ERROR EN LA ACTUALIZACION TIPO DE DATO CAMPO SECUENCIA TIPO DE DATO, ARCHIVO:'
+ @w_nomb_arch

goto ERROR_ARCH_E --Req 393
end
/******************************************************************************************************************************/
/*                                    VALIDACION DE CADA UNO DE LOS PAGOS                                                     */
/******************************************************************************************************************************/
while(@w_whl <= @w_cont_r2)
begin
  begin tran
  -- VALIDACION TIPO DE DOCUMENTO
  select
    @w_tipo_ced_val = ca_tipo_ced,
    @w_ced_ruc_val = ca_ced_ruc,
    @w_ca_ente_val = ca_ente,
    @w_cta_banco_val = ca_cta_banco,
    @w_valor_val = ca_valor,
    @w_tipo_mov_val = ca_tipo_mov,
    @w_estado = ca_estado
  from   cob_externos..ex_carga_archivo_cuentas
  where  ca_nomb_arch               = @w_nomb_arch
     and ca_tipo_reg                = 'R2'
     and cast(ca_secuencia as int) = @w_whl

/* VALIDACIONES DE LOS DATOS DEL REGISTRO */
  -- VALIDACION TIPO DE DOCUMENTO
  if @w_tipo_ced_val is null
      or @w_tipo_ced_val not in(select
                                  c.codigo
                                from   cobis..cl_tabla t,
                                       cobis..cl_catalogo c
                                where  c.tabla = t.codigo
                                   and t.tabla = 'cl_tipo_documento')
  begin
    rollback
    update cob_externos..ex_carga_archivo_cuentas
    set    ca_estado = 'X',
           ca_error =
           'TIPO DE DATO NULO O NO VALIDO EN EL CAMPO TIPO DE DOCUMENTO'
    where  ca_nomb_arch = @w_nomb_arch
       and ca_secuencia = @w_whl

    goto SIGUIENTE
  end

  -- VALIDA NUMERO DE IDENTIFICACION
  if @w_ced_ruc_val is null
  begin
    rollback
    update cob_externos..ex_carga_archivo_cuentas
    set    ca_estado = 'X',
           ca_error =
           'TIPO DE DATO NULO O NO VALIDO EN EL CAMPO NUMERO DE DOCUMENTO'
    where  ca_nomb_arch = @w_nomb_arch
       and ca_secuencia = @w_whl

    if @@error <> 0
    begin
      select
        @w_error = 400002,
        @w_mensaje =
' ERROR EN LA ACTUALIZACION -NO VALIDO EN EL CAMPO NUMERO DE DOCUMENTO-'

goto ERROR_ARCH_E
end
goto SIGUIENTE
end

-- VALIDACION ENTE         
if @w_ca_ente_val is null
or isnumeric(@w_ca_ente_val) = 0
begin
rollback
update cob_externos..ex_carga_archivo_cuentas
set    ca_estado = 'X',
 ca_error =
 'TIPO DE DATO NULO O NO VALIDO EN EL CAMPO NUMERO DE CLIENTE'
where  ca_nomb_arch = @w_nomb_arch
and ca_secuencia = @w_whl

goto SIGUIENTE
end

-- VALIDACION NUMERO DE CUENTA
if @w_cta_banco_val is null
begin
rollback
update cob_externos..ex_carga_archivo_cuentas
set    ca_estado = 'X',
 ca_error =
 'TIPO DE DATO NULO O NO VALIDO EN EL CAMPO NUMERO DE CUENTA'
where  ca_nomb_arch = @w_nomb_arch
and ca_secuencia = @w_whl

goto SIGUIENTE
end

-- VALIDACION MONTO
begin TRY
select
@w_mon = cast(@w_valor_val as money)
end TRY
begin CATCH
rollback
update cob_externos..ex_carga_archivo_cuentas
set    ca_estado = 'X',
 ca_error = 'TIPO DE DATO NULO O NO VALIDO EN EL CAMPO MONTO'
where  ca_nomb_arch = @w_nomb_arch
and ca_secuencia = @w_whl

goto SIGUIENTE
end CATCH

-- VALIDACION ESTADO
if @w_estado is not null
begin
rollback
update cob_externos..ex_carga_archivo_cuentas
set    ca_estado = 'X',
 ca_error = 'TIPO NO VALIDO EN EL CAMPO ESTADO'
where  ca_nomb_arch = @w_nomb_arch
and ca_secuencia = @w_whl
goto SIGUIENTE
end
commit

SIGUIENTE:
if @@trancount > 0
rollback
set @w_whl = @w_whl + 1
end

/* VALIDA ESTADO DE LOS REGISTROS */
update cob_externos..ex_carga_archivo_cuentas
set    ca_estado = 'R'
where  ca_nomb_arch = @w_nomb_arch
   and ca_tipo_reg  = 'R2'
   and ca_estado is null
    or ca_estado    = ''

if @@error <> 0
begin
  select
    @w_error = 400002,
    @w_mensaje = ' ERROR EN LA ACTUALIZACION ca_tipo R2 PARA ARCHIVO ' +
                 @w_nomb_arch

  goto ERROR_ARCH_E
end

/* ACTUALIZA TIPO DE CARGA PARA EL LOTE QUE SE ESTA PROCESANDO */
update cob_externos..ex_carga_archivo_cuentas
set    ca_tipo_carga = @w_tcar
where  ca_nomb_arch = @w_nomb_arch

if @@error <> 0
begin
  select
    @w_error = 400002,
    @w_mensaje = ' ERROR AL ACTUALIZAR EL TIPO DE CARGA. ARCHIVO ' +
                 @w_nomb_arch

  goto ERROR_ARCH_E
end

/* PASA REGISTROS DEL LOTE DE COB_EXTERNOS A TABLA TEMPORAL DE AHORROS */
insert into cob_ahorros..ah_carga_archivo_cuentas_tmp
            (ca_tipo_reg,ca_secuencia,ca_tipo_carga,ca_tipo_ced,ca_ced_ruc,
             ca_nomb_arch,ca_ente,ca_cta_banco,ca_tipo_prod,ca_fecha_reg,
             ca_cant_reg,ca_valor,ca_tipo_mov,ca_causal,ca_fecha_proc,
             ca_tipo_oper,ca_estado,ca_error,ca_empresa)
  select
    substring(ca_tipo_reg,
              1,
              2),cast(isnull(ca_secuencia,
                0) as int),--(cabecera y detalle)
    isnull(substring(ca_tipo_carga,
                     1,
                     1),
           null),isnull(substring(ca_tipo_ced,
                     1,
                     2),
           null),isnull(ca_ced_ruc,
           ''),
    isnull(ca_nomb_arch,
           null),--> Nombre del cliente
    cast(isnull(ca_ente,
                0) as int),isnull(ca_cta_banco,
           ''),isnull(cast(isnull(ca_tipo_prod,
                       0) as tinyint),
           0),convert(datetime, isnull(ca_fecha_reg,
                             '')),--> Fecha a aplicar la transacciÂ¥n
    cast(isnull(ca_cant_reg,
                0) as int),cast(ca_valor as money),isnull(
    substring(ca_tipo_mov,
                     1,
                     1),
           null),isnull(substring(ca_causal,
                     1,
                     3),
           null),
    --convert(datetime,isnull(ca_fecha_proc,'')),--> Fecha que se aplicÂ¥ la Trn
    convert(datetime, isnull(@w_fecha_carga,
                             '')),--REQ464             
    isnull(substring(ca_tipo_oper,
                     1,
                     1),
           null),isnull(substring(ca_estado,
                     1,
                     1),
           null),isnull(ca_error,
           ''),isnull(@w_empresa,
           '')
  from   cob_externos..ex_carga_archivo_cuentas
  where  ca_nomb_arch = @w_nomb_arch

if @@error <> 0
begin
  select
    @w_error = 1000086,
    @w_mensaje =
    'ERROR INSERTANDO DATOS PROCESO INTERNO TIPO CARGA EXT PARA ARCHIVO'
    + isnull(@w_nomb_arch, 'XX')
  goto ERROR_ARCH_E
end

/* ELIMINA REGISTROS DEL LOTE DE COB_EXTERNOS */
delete cob_externos..ex_carga_archivo_cuentas
where  ca_nomb_arch = @w_nomb_arch

if @@error <> 0
begin
  select
    @w_error = 1000086,
    @w_mensaje =
    'ERROR AL ELIMINAR DE ex_carga_archivo_cuentas ERRORFIN PARA ARCHIVO'
    + isnull(@w_nomb_arch, 'XX')
  goto ERROR_ARCH_E
end

/* ACTUALIZA EMPRESA EN LA TABLA TEMPORAL PARA EL REGISTRO TIPO 1 */
update cob_ahorros..ah_carga_archivo_cuentas_tmp
set    ca_empresa = null,
       ca_estado = null
where  ca_nomb_arch = @w_nomb_arch
   and ca_tipo_reg  = 'R1'

if @@error <> 0
begin
  select
    @w_error = 400002,
    @w_mensaje = ' ERROR EN LA ACTUALIZACION ca_tipo R1 EN ARCHIVO: ' + isnull
                 (
                 @w_nomb_arch,
                 'XX' )

  goto ERROR_ARCH_E
end

--Cambiar fecha del archivo por fecha de proceso
update cob_ahorros..ah_carga_archivo_cuentas_tmp
set    ca_fecha_reg = @w_fecha_carga
where  ca_nomb_arch = @w_nomb_arch

if @@error <> 0
begin
  select
    @w_error = 400002,
    @w_mensaje = ' ERROR ACTUALIZANDO ca_fecha_reg PARA ARCHIVO: ' + isnull(
                 @w_nomb_arch, 'XX')

  goto ERROR_ARCH_E
end

goto ARCH_SIGUIENTE

ERROR_ARCH_E:
if @@trancount > 0
  rollback

select
  @w_estado_arc = 'E'

exec cob_ahorros..sp_errorlog
  @i_fecha       = @w_fecha_carga,
  @i_error       = @w_error,
  @i_usuario     = 'admuser',
  @i_tran        = null,
  @i_descripcion = @w_mensaje,
  @i_programa    = @w_spname

if @w_nomb_arch is not null
begin
  delete cob_externos..ex_carga_archivo_cuentas
  where  ca_nomb_arch = @w_nomb_arch
  delete cob_ahorros..ah_carga_archivo_cuentas_tmp
  where  ca_nomb_arch = @w_nomb_arch
end

ARCH_SIGUIENTE:

select
  @w_path = case right(@w_path,
                       1)
              when '\' then @w_path
              else @w_path + '\'
            end
select
  @w_nuevo = @w_nomb_arch + '.procesado.' + convert(varchar(8), @w_fecha_carga
             ,
                                      112) + '_' +
                                      @w_estado_arc
select
  @w_cmd_rename = 'ren ' + @w_path + @w_nomb_arch + '.txt ' + @w_nuevo

exec master..xp_cmdshell
  @w_cmd_rename

if @@trancount > 0
  commit tran
end
end -- Fin Tipo Carga E

/******************************************************************************************************************************/
/*                                                TIPO DE CARGA INTERNO                                                       */
  /******************************************************************************************************************************/
  if @w_tipo_carga = 'I'
  begin
    /* CARGA TABLA TEMPORAL CON LOS NOMBRES DE LOS ARCHIVOS A PROCESAR */
    select distinct
      ca_nomb_arch
    into   #archivos_int
    from   cob_externos..ex_carga_archivo_cuentas
    where  ca_tipo_carga = 'I'
    order  by ca_nomb_arch

    select
      @w_nomb_arch = ''

    /* PROCESAR CADA UNO DE LOS LOTES */
    while 1 = 1
    begin
      /* OBTIENE NOMBRE DE CADA UNO DE LOS ARCHIVOS A PROCESAR */
      select top 1
        @w_nomb_arch = ca_nomb_arch
      from   #archivos_int
      where  ca_nomb_arch > @w_nomb_arch
      order  by ca_nomb_arch

      if @@rowcount = 0
        break

      /* PASA REGISTROS DEL LOTE DE COB_EXTERNOS A TABLA TEMPORAL DE AHORROS */
      insert into cob_ahorros..ah_carga_archivo_cuentas_tmp
                  (ca_tipo_reg,ca_secuencia,ca_tipo_carga,ca_tipo_ced,ca_ced_ruc
                   ,
                   ca_nomb_arch,ca_ente,ca_cta_banco,
                   ca_tipo_prod,ca_fecha_reg,
                   ca_cant_reg,ca_valor,ca_tipo_mov,ca_causal,ca_fecha_proc,
                   ca_tipo_oper,ca_estado,ca_error,ca_empresa)
        select
          substring(ca_tipo_reg,
                    1,
                    2),cast(isnull(ca_secuencia,
                      0) as int),--(cabecera y detalle)
          isnull(substring(ca_tipo_carga,
                           1,
                           1),
                 null),isnull(substring(ca_tipo_ced,
                           1,
                           2),
                 null),isnull(ca_ced_ruc,
                 ''),
          isnull(ca_nomb_arch,
                 null),--> Nombre del archivo
          cast(isnull(ca_ente,
                      0) as int),isnull(ca_cta_banco,
                 ''),isnull(cast(isnull(ca_tipo_prod,
                             0) as tinyint),
                 0),convert(datetime, isnull(ca_fecha_reg,
                                   '')),--> Fecha a aplicar la transacciÂ¥n
          cast(isnull(ca_cant_reg,
                      0) as int),cast(ca_valor as money),isnull(
          substring(ca_tipo_mov,
                           1,
                           1),
                 null),isnull(substring(ca_causal,
                           1,
                           3),
                 null),convert(datetime, isnull(ca_fecha_proc,
                                   '')),--> Fecha que se aplicÂ¥ la Trn
          isnull(substring(ca_tipo_oper,
                           1,
                           1),
                 null),isnull(substring(ca_estado,
                           1,
                           1),
                 null),isnull(ca_error,
                 ''),isnull(ca_ente,
                 '')
        from   cob_externos..ex_carga_archivo_cuentas
        where  ca_nomb_arch = @w_nomb_arch
        order  by ca_secuencia

      if @@error <> 0
      begin
        select
          @w_error = 1000086,
          @w_mensaje = 'ERROR AL INSERTAR LOS DATOS DE PROCESO INTERNO. LOTE:' +
                       @w_nomb_arch
        goto ERROR_ARCH
      end

      /* ELIMINA REGISTROS DEL LOTE DE COB_EXTERNOS */
      delete cob_externos..ex_carga_archivo_cuentas
      where  ca_nomb_arch = @w_nomb_arch

      if @@error <> 0
      begin
        select
          @w_error = 1000086,
          @w_mensaje = 'ERROR AL ELIMINAR LOS DATOS DE PROCESO EXTERNOS. LOTE:'
                       +
                       @w_nomb_arch
        goto ERROR_ARCH
      end

      -- VALIDA CANTIDAD DE REGISTRO TIPO 1
      select
        @w_cont_r1 = count(1)
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R1'

      if @w_cont_r1 = 0
      begin
        select
          @w_error = 1000086,
          @w_mensaje = 'NO SE EXISTE REGISTRO TIPO 1. LOTE:' + @w_nomb_arch
        goto ERROR_ARCH
      end

      if @w_cont_r1 > 1
      begin
        select
          @w_error = 1000086,
          @w_mensaje = 'EXISTEN MAS DE UNA CABECERA PARA EL LOTE:' +
                       @w_nomb_arch
        goto ERROR_ARCH
      end

      -- OBTIENE VALOR DE TRANSACCIONES REGISTRO TIPO 1
      select
        @w_mon_r1 = cast(ca_valor as money),
        @w_cont_r1 = cast(ca_cant_reg as int)
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R1'

      if @w_mon_r1 = 0
          or @w_mon_r1 is null
      begin
        select
          @w_error = 1000086,
          @w_mensaje = 'NO SE EXISTE MONTO TOTAL REGISTRO TIPO 1. LOTE:' +
                       @w_nomb_arch
        goto ERROR_ARCH
      end

      -- OBTIENE VALOR DE TRANSACCIONES REGISTRO TIPO 2
      select
        @w_mon_r2 = sum(cast(ca_valor as money)),
        @w_cont_r2 = count(1)
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'

      if @w_cont_r2 = 0
      begin
        select
          @w_error = 1000086,
          @w_mensaje = 'NO SE EXISTE CANTIDAD DETALLE REGISTRO TIPO 2. LOTE:' +
                       @w_nomb_arch
        goto ERROR_ARCH
      end

      /* VALIDA CANTIDADES VS VALORES REGISTROS 1 VS REGISTROS 2 */
      if @w_mon_r1 <> @w_mon_r2
          or @w_cont_r1 <> @w_cont_r2
      begin
        update cob_ahorros..ah_carga_archivo_cuentas_tmp
        set    ca_estado = 'X',
               ca_error = 'DATOS DE CABECERA NO COINCIDEN CON EL LOTE: ' +
                          @w_nomb_arch
        where  ca_nomb_arch = @w_nomb_arch

        if @@error <> 0
        begin
          select
            @w_error = 400002,
            @w_mensaje = 'DATOS DE CABECERA NO COINCIDEN CON EL LOTE: ' +
                         @w_nomb_arch

          goto ERROR_ARCH
        end

        goto ERROR_ARCH
      end

      select
        @w_sec_archivo = 0,
        @w_autnum = 0

      /* RECHAZA REGISTROS CON SECUENCIAL NULO */
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'X',
             ca_error = @w_mensaje + 'CAMPO SECUENCIA NULO'
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'
         and ca_secuencia is null

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION CAMPO SECUENCIA NULO'

        goto ERROR_ARCH
      end

      -- VALIDACION TIPO DE DOCUMENTO
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'X',
             ca_error = @w_mensaje + 'CAMPO TIPO DOC NULO'
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'
         and ca_tipo_ced is null

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION CAMPO TIPO DOC NULO'

        goto ERROR_ARCH
      end

      -- VALIDA NUMERO DE IDENTIFICACION
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'X',
             ca_error = @w_mensaje + 'CAMPO NUMERO DE DOCUMENTO NULO'
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'
         and ca_ced_ruc is null

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje =
          ' ERROR EN LA ACTUALIZACION CAMPO NUMERO DE DOCUMENTO NULO'

        goto ERROR_ARCH
      end

      -- VALIDACION NUMERO DE CUENTA
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'X',
             ca_error = @w_mensaje + 'CAMPO CUENTA NULO'
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'
         and ca_cta_banco is null

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION CAMPO CUENTA NULO'

        goto ERROR_ARCH
      end

      -- VALIDACION ENTE
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'X',
             ca_error = @w_mensaje + 'CAMPO SECUENCIA NULO'
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'
         and ca_ente is null

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION CAMPO SECUENCIA NULO'

        goto ERROR_ARCH
      end

      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'X',
             ca_error = @w_mensaje + 'CAMPO FECHA PROC NULO'
      where  ca_tipo_reg = 'R2'
         and ca_fecha_proc is null

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION CAMPO FECHA PROC NULO'

        goto ERROR_ARCH
      end
    /******************************************************************************************************/
    /*                          VALIDACION DE CADA UNO DE LOS PAGOS                                       */
      /******************************************************************************************************/
      while 1 = 1
      begin
        begin tran
        select top 1
          @w_tipo_reg = ca_tipo_reg,
          @w_secuencia = ca_secuencia,
          @w_empresa = ca_ente,
          @w_tcar = ca_tipo_carga,
          @w_autnum = ca_autnum,
          @w_causa = ca_causal,
          @w_tmov = ca_tipo_mov
        from   cob_ahorros..ah_carga_archivo_cuentas_tmp
        where  ca_nomb_arch         = @w_nomb_arch
           and isnull(ca_estado,
                      '') <> 'X'
           and ca_autnum            > @w_autnum
        order  by ca_autnum

        if @@rowcount = 0
          break

        if @w_tipo_reg = 'R1'
          select
            @w_sec_detalle = 0,
            @w_empresa_det = @w_empresa,
            @w_tcar_det = @w_tcar,
            @w_causa_r1 = @w_causa,
            @w_tmov_r1 = @w_tmov

        if @w_tipo_reg = 'R2'
        begin
          if @w_secuencia > @w_sec_detalle
          begin
            update cob_ahorros..ah_carga_archivo_cuentas_tmp
            set    ca_ente = @w_empresa_det,
                   ca_causal = @w_causa_r1,
                   ca_tipo_mov = @w_tmov_r1,
                   ca_tipo_carga = @w_tcar_det,
                   ca_empresa = @w_empresa_det
            where  ca_nomb_arch = @w_nomb_arch
               and ca_autnum    = @w_autnum

            if @@error <> 0
            begin
              rollback
              select
                @w_error = 400002,
                @w_mensaje =
      ' ERROR EN LA ACTUALIZACION TIPO DE DATO CAMPO SECUENCIA DE DETALLE'

              goto ERROR_ARCH
            end

            select
              @w_sec_detalle = @w_secuencia
          end
          else
          begin
            rollback
            update cob_ahorros..ah_carga_archivo_cuentas_tmp
            set    ca_estado = 'X',
                   ca_error =
                   'TIPO DE DATO NULO EN EL CAMPO SECUENCIA DE DETALLE'
            where  ca_nomb_arch = @w_nomb_arch
               and ca_autnum    = @w_autnum

            if @@error <> 0
            begin
              select
                @w_error = 400002,
                @w_mensaje =
      ' ERROR EN LA ACTUALIZACION TIPO DE DATO CAMPO SECUENCIA DE DETALLE'

              goto ERROR_ARCH
            end
          end
        end
        commit
      end

      -- VALIDACION ESTADO
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_estado = 'R'
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R2'
         and ca_estado is null
          or ca_estado    = ''

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION R'

        goto ERROR_ARCH
      end

      /* ACTUALIZA EMPRESA EN LA TABLA TEMPORAL PARA EL REGISTRO TIPO 1 */
      update cob_ahorros..ah_carga_archivo_cuentas_tmp
      set    ca_empresa = null,
             ca_estado = null
      where  ca_nomb_arch = @w_nomb_arch
         and ca_tipo_reg  = 'R1'

      if @@error <> 0
      begin
        select
          @w_error = 400002,
          @w_mensaje = ' ERROR EN LA ACTUALIZACION R1'

        goto ERROR_ARCH
      end

      ERROR_ARCH:
      if @@trancount > 0
        rollback
    end
    return 0
  end

  ERRORFIN:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha_carga,
    @i_error       = @w_error,
    @i_usuario     = 'admuser',
    @i_tran        = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_spname

  if @w_nomb_arch is not null
    delete cob_externos..ex_carga_archivo_cuentas
    where  ca_nomb_arch = @w_nomb_arch

  return @w_error

go

