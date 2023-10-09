/************************************************************************/
/*      Archivo           :  cr_erdia.sqr                               */
/*      Base de datos     :  cob_credito                                */
/*      Producto          :  Credito                                    */
/*      Disenado por      :  Sheela Burbano                             */
/*      Fecha de escritura:  22-Feb-02                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este reporte saca un listado de los errores diarios del         */
/*      consolidador                                                    */
/*                                                                      */
/************************************************************************/
/*                                MODIFICACIONES                        */
/*          FECHA           AUTOR           RAZON                       */
/*          21/Oct/16      j. Calderon     Emision inicial              */
/************************************************************************/
USE cob_credito
GO
if object_id('sp_cr_erdia_ej') is not null
begin
   drop proc sp_cr_erdia_ej
   if object_id('sp_cr_erdia_ej') is not null begin
      print 'FAILED DROPPING PROCEDURE sp_cr_erdia_ej.sp'
   end
end
go

create proc sp_cr_erdia_ej
   @t_show_version bit      = 0,
   @i_param1       datetime = NULL
as
DECLARE @i_fecha DATETIME,
   @i_filial           int,
   @w_s_app            varchar(150),
   @w_date_proceso     varchar(10),
   @w_sp_name          varchar(64),
   @w_retorno          int,
   @w_error            int,
   @w_retorno_ej       int,
   @w_mensaje          varchar(150),
   @w_tot_records      int,
   @w_fecha_proceso    varchar(10),
   @w_mes              char(2),
   @w_dia              char(2),
   @w_anio             char(4),
   @w_comando          varchar(500),
   @w_cmd              varchar(224),
   @w_fecha            varchar(30),
   @w_hora_bcp         varchar(2),
   @w_min_bcp          varchar(2),
   @w_path_pro         varchar(200),
   @w_pr_path          varchar(200),
   @w_fecha_tran       varchar(10),
   @w_nombre           varchar(30),
   @w_titulo           varchar(100),
   @w_nombre_fuente    varchar(30),
   @w_archivo_bcp      varchar(150),
   @w_cabecera         char(250),
   @w_campo0           char(15),
   @w_campo1           char(35),
   @w_campo2           char(20),
   @w_campo3           char(80),
   @w_campo4           char(20),
   @w_campo5           char(15),
   @w_campo6           char(20),
   @w_campo7           char(10),
   @w_campo8           char(30),
   @w_campo9           char(20),
   @w_campo10          char(11),
   @w_oficina          varchar(5),
   @w_nombre_listado   varchar(150),
   @w_pr_path_dest     varchar(100),
   @w_fecha_definitiva varchar(30),
   @w_mes_listado      varchar(30),
   @w_dia_listado      varchar(30),
   @w_ani_listado      varchar(30),
   @w_hor_listado      varchar(2),
   @w_min_listado      varchar(2),
   @w_hor              int,
   @w_min              int,
   @w_campo0_des       varchar(19),
   @w_campo9_des       varchar(19),
   @w_os_producto      tinyint,
   @w_en_subtipo       char(1),
   @w_en_ced_ruc       varchar(30) ,
   @w_os_operacion     varchar(24),
   @w_os_clase         catalogo,
   @w_os_toperacion    varchar(30),
   @w_os_moneda        tinyint,
   @w_os_saldo         money,
   @w_os_estado_contable tinyint,
   @w_espacio          char(80),
   @w_cadena           char(202),
   @w_errores          varchar(124),
   @w_saldo            char(15),
   @w_moneda           char(6),
   @w_path             varchar(100)

select @w_sp_name = 'sp_cr_erdia_ej'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1 begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

truncate table rpt_cr_opcns

/* OBTIENE RUTA DEL KERNEL */
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

if @@rowcount = 0 begin
  select @w_error = 101077,
         @w_mensaje = ' ERROR No existe parametro S_APP'
  goto ERRORFIN
end

select @i_fecha  = @i_param1

select @i_filial = 1
select @w_date_proceso = convert(VARCHAR(30),@i_fecha,103)
select @w_dia  = substring(@w_date_proceso,1,2)
select @w_mes  = substring(@w_date_proceso,4,2)
select @w_anio = substring(@w_date_proceso,7,4)
select @w_fecha_tran =  @w_anio +  @w_mes + @w_dia

select @w_hor = datepart(hour,@i_fecha)
select @w_min = datepart(minute,@i_fecha)

if @w_hor < 10 select @w_hor_listado = '0' + convert(CHAR(1),@w_hor)
else           select @w_hor_listado = convert(CHAR(2),@w_hor)

if @w_min < 10 select  @w_min_listado = '0' + convert(CHAR(1),@w_min)
else           select  @w_min_listado = convert(CHAR(2),@w_min)

select @w_pr_path_dest = ltrim(rtrim(ba_path_destino))
from   cobis..ba_batch
where  ba_batch = 21056

if @@rowcount = 0 begin
    select @w_error = 101077,
           @w_mensaje = ' ERROR No existe ba_path_destino'
    goto ERRORFIN
end

select @w_nombre_fuente = ba_arch_fuente
from   cobis..ba_batch
where  ba_batch = convert(int,21040)

if @@rowcount = 0 begin
   select @w_error = 101077,
          @w_mensaje = ' ERROR No existe nombre del fuente'
   goto ERRORFIN
end

select @w_nombre_fuente = 'cr_erdia.sp'

select @w_nombre = fi_nombre
from   cobis..cl_filial
where  fi_filial = 1

if @@rowcount = 0 begin
   select @w_error = 101077,
          @w_mensaje = ' ERROR No existe nombre del la filial'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_espacio = '                                                                '
select @w_cadena = @w_espacio + '                          ' + @w_nombre

INSERT INTO rpt_cr_opcns (cadena) VALUES    (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro en la tabla cob_credito..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_espacio = '                                                                '
select @w_titulo = 'ERRORES - PROCESO DIARIO'
select @w_cadena = @w_espacio + @w_titulo + @w_espacio

INSERT INTO rpt_cr_opcns (cadena) VALUES    (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro la tabla cob_credito..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cabecera = ''
select @w_nombre_fuente = 'cr_erdia.sp'
select @w_date_proceso
select @w_campo0 = 'PROGRAMA'
select @w_campo1 = 'NO.OPERACION'
select @w_campo2 = 'NUMERO ERROR'
select @w_campo3 = 'DESCRIPCION'
select @w_cabecera = @w_campo0 + @w_campo1 + @w_campo2 + @w_campo3

INSERT INTO rpt_cr_opcns (cadena) VALUES (@w_cabecera)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

INSERT INTO rpt_cr_opcns
select convert(char(15), er_tran)  + isnull(convert(char(35),er_cuenta),' ') + convert(char(20),er_error)  +  convert(char(80),er_descripcion)
FROM  cr_errorlog
WHERE er_fecha_proc  = @i_fecha
ORDER BY er_tran

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro de detalle en la tabla cob_credito..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_fecha_definitiva = @w_fecha_tran + '_' + @w_hor_listado + @w_min_listado

if @i_filial > 0 begin
   select @i_filial = 100000 + @i_filial
   select @w_oficina = substring(convert(CHAR,@i_filial), 2,5)
   select @w_nombre_listado = @w_pr_path_dest + @w_nombre_fuente + '_' + @w_fecha_definitiva + '_of' + @w_oficina + '.lis'
end
ELSE begin
   select @w_nombre_listado = @w_pr_path_dest + @w_nombre_fuente + '_' + @w_fecha_definitiva + '_of00000.lis'
end

select @w_path = 'C:\Cobis\vbatch\credito\listados\'

select @w_nombre_listado = @w_path + @w_nombre_fuente + '_' + @w_fecha_definitiva + '_of' + @w_oficina + '.lis'
select @w_errores  = @w_nombre_fuente + '_'  + @w_fecha_definitiva  + '_of'+ '.err'

select  @w_archivo_bcp = @w_nombre_listado,
        @w_cmd         = @w_s_app + 's_app' + ' bcp -auto -login cob_credito..rpt_cr_opcns out '
select  @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e' + @w_errores +
                   ' -t"|" -config '
                   + @w_s_app + 's_app.ini'

select @w_comando
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   PRINT 'error xp_cmdshell------'
   select @w_mensaje = 'ERROR AL GENERAR ARCHIVO ' + @w_nombre_fuente + ' ' + convert(varchar, @w_error)
   goto ERRORFIN
end

RETURN 0
ERRORFIN:
   exec sp_errorlog
   @i_fecha       = @i_fecha,
   @i_error       = @w_error,
   @i_usuario     = 'admuser',
   @i_tran_name   = @w_mensaje,
   @i_rollback    = 'N',
   @i_tran        = null,
   @i_descripcion = @w_mensaje
   return @w_error

go

