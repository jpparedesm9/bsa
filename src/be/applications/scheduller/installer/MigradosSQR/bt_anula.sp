/************************************************************************/
/*      Archivo           :  bt_anula.sp                             */
/*      Base de datos     :  cob_pfijo                                  */
/*      Producto          :  P Fijo                                     */
/*      Disenado por      :  Dolores Guerrero/Gabriela Estupinian       */
/*      Fecha de escritura:  26/11/1998                                 */
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
/*      Este sp anula todas las operaciones que quedaron como ING       */
/*                                                                      */
/************************************************************************/
/*                                MODIFICACIONES                        */
/*          FECHA           AUTOR           RAZON                       */
/*          24/Oct/16      j. Baque     Emision inicial                 */
/************************************************************************/

USE cob_pfijo
GO
if object_id('sp_bt_anula') is not null
begin
   drop proc sp_bt_anula
   if object_id('sp_bt_anula') is not null
   begin
      print 'FAILED DROPPING PROCEDURE sp_bt_anula_ej.sp'
   end
end
go
create proc sp_bt_anula
    @t_show_version bit       = 0,
    @i_param1       datetime  = NULL
as

declare
   @i_fecha            datetime,
   @i_filial           int,
   @w_sp_name          varchar(20),
   @w_date_proceso     varchar(10),
   @w_s_app            varchar(150),
   @w_error            int,
   @w_mensaje          varchar(150),
   @w_cabecera         char(250),
   @w_cadena           char(202),
   @w_campo0           char(35),
   @w_campo1           char(60),
   @w_fecha_definitiva varchar(30),
   @w_pr_path_dest     varchar(100),
   @w_nombre_fuente    varchar(30),
   @w_archivo_bcp      varchar(150),
   @w_nombre           varchar(150),
   @w_espacio          char(80),
   @w_titulo           varchar(100),
   @w_descripcion      char(120),
   @w_mes              char(2),
   @w_dia              char(2),
   @w_anio             char(4),
   @w_hor              int,
   @w_min              int,
   @w_fecha_tran       varchar(10),
   @w_hor_listado      varchar(2),
   @w_min_listado      varchar(2),
   @w_oficina          varchar(5),
   @w_nombre_listado   varchar(150),
   @w_errores          varchar(124),
   @w_cmd              varchar(224),
   @w_comando          varchar(500),
   @w_path             varchar(150)

select    @w_sp_name = 'sp_bt_anula_ej'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
   print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
   return 0
end
truncate table rpt_cr_opcns

/* OBTIENE RUTA DEL KERNEL */
select @w_s_app = pa_char
from  cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'S_APP'

if @@rowcount = 0 begin
   select
   @w_error   = 101077,
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

create table #tmp_pf_operacion2(op_operacion int)

select @w_pr_path_dest = ltrim(rtrim(ba_path_destino))
from   cobis..ba_batch
where  ba_batch = 14004

select @w_nombre_fuente = ba_arch_fuente
from   cobis..ba_batch
where  ba_batch = convert(int,14004)

if @@rowcount = 0 begin
   select
   @w_error   = 101077,
   @w_mensaje = ' ERROR No existe nombre del fuente'
   goto ERRORFIN
end

select @w_nombre = fi_nombre
from   cobis..cl_filial
where  fi_filial = 1

if @@rowcount = 0 begin
   select
   @w_error = 101077,
   @w_mensaje = ' ERROR No existe nombre del la filial'
   goto ERRORFIN
end

exec @w_error = sp_anula
@i_fecha = @i_fecha

if @w_error <> 0 begin
   select @w_mensaje = 'bt_anula_ej.sp ERROR EN LA EJECUCION DE cob_pfijo..sp_anula'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_espacio = '                                                                '
select @w_cadena = @w_espacio + '                          ' + @w_nombre

insert into rpt_cr_opcns (cadena) values    (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro en la tabla cob_pfijo..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_espacio = '                                                                '
select @w_titulo = 'DEPOSITOS QUE DEBEN SER ACTIVADOS'
select @w_cadena = @w_espacio + @w_titulo + @w_espacio
insert into rpt_cr_opcns (cadena) values    (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro la tabla cob_pfijo..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cabecera = ''
select @w_nombre_fuente = 'bt_anula.sp'
select @w_date_proceso
select @w_campo0 = 'N°. BANCO'
select @w_campo1 = 'ERROR'

select @w_cabecera = @w_campo0 + @w_campo1
insert into rpt_cr_opcns (cadena) values (@w_cabecera)
if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

select @w_descripcion = 'Operacion debe ser Activada, ya que ha ingresado dinero a Caja'
insert into rpt_cr_opcns
select convert(char(24), st_num_banco)  + convert(char(100),@w_descripcion)
from   pf_secuen_ticket
where  st_estado    = 'C'

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro de detalle en la tabla cob_pfijo..rpt_cr_opcns'
   goto ERRORFIN
end

insert into #tmp_pf_operacion2
select op_operacion
from   pf_operacion
where  (op_estado = 'ACT' OR op_estado = 'ANU')
and    op_fecha_valor = @i_fecha

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro la tabla #tmp_pf_operacion2'
   goto ERRORFIN
end

delete from pf_secuen_ticket
where exists(select 1 from #tmp_pf_operacion2
             where st_operacion   = op_operacion)
and (st_estado  = 'C' or st_estado = 'A' or st_estado = 'N' or st_estado = 'R')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro la tabla pf_secuen_ticket'
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

select @w_path = 'C:\Cobis\vbatch\ahorros\listados\'

select @w_nombre_listado = @w_path + @w_nombre_fuente + '_' + @w_fecha_definitiva + '_of' + @w_oficina + '.lis'
select @w_errores  = @w_nombre_fuente + '_'  + @w_fecha_definitiva  + '_of'+ '.err'
select @w_path, @w_nombre_fuente, @w_fecha_definitiva, @w_oficina

select @w_archivo_bcp = @w_nombre_listado,
       @w_cmd         = @w_s_app + 's_app' + ' bcp -auto -login cob_pfijo..rpt_cr_opcns out '

select @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e ' + @w_errores + '.err' +
         ' -t"|" -config '
         + @w_s_app
         + 's_app.ini'
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

