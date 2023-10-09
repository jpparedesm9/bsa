/************************************************************************/
/*   Archivo:             ah_gen_arch_cta.sp                            */
/*   Stored procedure:    sp_genera_archivo_cuentas                     */
/*   Base de datos:       cob_ahorros                                   */
/*   Producto:            Ahorros                                       */
/*   Disenado por:        Edwin Jimenez Diaz                            */
/*   Fecha de escritura:  Abril/2012                                    */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno  de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales de propiedad inte-         */
/*   lectual. Su uso no  autorizado dara  derecho a COBISCorp para      */
/*   obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                           PROPOSITO                                  */
/*   Archivo plano de periodicidad EVENTUAL,                            */
/*   que muestra las transacciones de Credito/Debito en cuentas         */
/*   de ahorro, con la informacion contenida en las estructuras         */
/*   correspondientes de cob_externos.                                  */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*   FECHA           AUTOR           RAZON                              */
/*   20/Oct/2011     E.Jimenez       Emision Inicial                    */
/*   04/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO       */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_genera_archivo_cuentas')
  drop proc sp_genera_archivo_cuentas
go

/****** Object:  StoredProcedure [dbo].[sp_genera_archivo_cuentas]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_genera_archivo_cuentas
(
  @t_show_version bit = 0,
  @i_param1       varchar (255),
  @i_param2       varchar(100)
)
as
  declare
    @w_return      int,
    @w_fecha       varchar(12),
    @w_error       varchar(255),
    @w_sp_name     varchar(30),
    --variables para bcp 
    @w_archivo     varchar(255),
    @w_nom_archivo varchar(100),
    @w_hora_arch   varchar(100),
    @w_cmd         varchar(255),
    @w_comando     varchar(500),
    @w_path_s_app  varchar(100),
    @w_msg         varchar(50),
    @w_path        varchar(250),
    @w_anio        int,
    @w_mes         int,
    @w_dia         int,
    @w_mensaje     varchar(1000),
    @w_fecha_proc  datetime,
    @w_arch_proc   varchar(100),
    @w_arch_bcp    varchar(100)

  --Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_genera_archivo_cuentas',
    @w_fecha_proc = cast(@i_param1 as datetime),
    @w_hora_arch = substring(convert(varchar, getdate(), 108), 1, 2)
                   + substring(convert(varchar, getdate(), 108), 4, 2),
    @w_arch_proc = isnull(@i_param2,
                          '')

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  if @w_arch_proc <> ''
  begin
    truncate table cob_ahorros..ah_carga_archivo_cuentas_tmp320

    insert into cob_ahorros..ah_carga_archivo_cuentas_tmp320
      select
        ca_tipo_carga,cast((select
                count(0)
              from   cob_ahorros..ah_carga_archivo_cuentas
              where  ca_tipo_reg   = 'R2'
                 and ca_fecha_proc = @w_fecha_proc
                 and ca_nomb_arch  = @w_arch_proc) as varchar),cast((select
                count(ca_error)
              from   cob_ahorros..ah_carga_archivo_cuentas
              where  ca_error like 'OK%'
                 and ca_tipo_reg   = 'R2'
                 and ca_fecha_proc = @w_fecha_proc
                 and ca_nomb_arch  = @w_arch_proc)as varchar),(select
           count(ca_error)
         from   cob_ahorros..ah_carga_archivo_cuentas
         where  ca_error like '%DAT%'
            and ca_fecha_proc = @w_fecha_proc
            and ca_nomb_arch  = @w_arch_proc),(select
           count(ca_error)
         from   cob_ahorros..ah_carga_archivo_cuentas
         where  ca_error like '%ESTRUCTURA%'
            and ca_fecha_proc = @w_fecha_proc
            and ca_nomb_arch  = @w_arch_proc),
        cast((select
                isnull(ah_nombre,
                       '')
              from   cob_ahorros..ah_cuenta
              where  ah_cta_banco = ca_cta_banco
                 and ca_nomb_arch = @w_arch_proc) as varchar),cast(
        ca_tipo_ced as varchar),cast(ca_ced_ruc as varchar),cast(
        ca_valor as varchar
        ),
        cast((select
                isnull(ah_producto,
                       '')
              from   cob_ahorros..ah_cuenta
              where  ah_cta_banco = ca_cta_banco
                 and ca_nomb_arch = @w_arch_proc) as varchar),
        --• Tipo de producto: ( 4- ahorros / 3 - corriente)
        cast(ca_cta_banco as varchar),
        --• Número de cuenta: (Número de cuenta corriente o de ahorros)
        ca_estado,--• Estado: (Procesado, Rechazado )
        ca_error,--• Mensaje-ERROR: 
        ca_nomb_arch -- Nombre del archivo
      from   cob_ahorros..ah_carga_archivo_cuentas
      where  ca_fecha_proc = @w_fecha_proc
          or ca_fecha_reg  = @w_fecha_proc
             and ca_nomb_arch  = @w_arch_proc
  end

  if exists(select
              1
            from   sysobjects
            where  name = 'ah_carga_archivo_cuentas_tmp320_arch')
    drop table ah_carga_archivo_cuentas_tmp320_arch

  create table cob_ahorros..ah_carga_archivo_cuentas_tmp320_arch
  (
    ca_tipo_carga   varchar(10) null,
    ca_total_reg    varchar(30) null,
    ca_reg_ok       varchar(30) null,
    ca_error_data   varchar(60) null,
    ca_error_estruc varchar(25) null,
    ca_nombre_clie  varchar(255) null,
    ca_tipo_identi  varchar(30) null,
    ca_iden_clie    varchar(30) null,
    ca_valor        varchar(30) null,
    ca_tipo_produc  varchar(30) null,
    ca_cta_banco    varchar(30) null,
    ca_estado       varchar(30) null,
    ca_error        varchar(255) null,
    ca_nomb_arch    varchar(60) null
  )

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
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 4

  if @@rowcount = 0
  begin
    select
      @w_msg = 'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_repnc_com',
      @w_error = 400001
    print @w_msg
    goto ERROR
  end

  select distinct
    archivo=ca_nomb_arch,
    estado='I'
  into   #archivos
  from   cob_ahorros..ah_carga_archivo_cuentas_tmp320
  where  ca_tipo_carga in ('I', 'E')
  order  by ca_nomb_arch

  while 1 = 1
  begin
    select top 1
      @w_arch_bcp = archivo
    from   #archivos
    where  estado = 'I'

    if @@rowcount = 0
      break

    truncate table cob_ahorros..ah_carga_archivo_cuentas_tmp320_arch

    insert into cob_ahorros..ah_carga_archivo_cuentas_tmp320_arch
    values      ('Tipo Carga','Total Reg.','Reg. OK','Reg. ERROR Data',
                 'Reg. ERROR Estruc.',
                 'Nombre Cliente','Tip. Identif','Id. Cliente','Valor C/D',
                 'Tipo Producto',
                 'No de cuenta','Estado','Mensaje-Error','Nombre Archivo' )

    insert into cob_ahorros..ah_carga_archivo_cuentas_tmp320_arch
      select
        *
      from   cob_ahorros..ah_carga_archivo_cuentas_tmp320
      where  ca_nomb_arch = @w_arch_bcp

    --GENERA BCP
    select
      @w_nom_archivo = replace(@w_arch_bcp,
                               '/',
                               '')
    select
      @w_nom_archivo = replace(@w_nom_archivo, ' ', '') + '_' + convert(varchar(
                       8
                       )
                       ,
                                                               @w_fecha_proc,
                                                               112 )
                       + convert(varchar(4), @w_hora_arch) + '_REP.txt'
    select
      @w_archivo = @w_path + @w_nom_archivo
    select
      @w_cmd = @w_path_s_app
               +
's_app bcp -auto -login cob_ahorros..ah_carga_archivo_cuentas_tmp320_arch out '
  select
    @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e' + @w_archivo + '.err' +
                 ' -t"|" -config '
                 + @w_path_s_app
                 + 's_app.ini'

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

  update #archivos
  set    estado = 'P'
  where  archivo = @w_arch_bcp
     and estado  = 'I'
end

  return 0

  ERROR:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_tran        = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_sp_name

  return @w_error

go

