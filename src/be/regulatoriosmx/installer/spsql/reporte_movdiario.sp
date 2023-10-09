/*************************************************************************/
/*   Archivo:              reporte_movdiario.sp                          */
/*   Stored procedure:     sp_reporte_movdiario                          */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Dario Cumbal                                  */
/*   Fecha de escritura:   24/07/2020                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Reporte de movimientos contables desde inicio de mes a la fecha     */
/*   actual                                                              */
/*                              CAMBIOS                                  */
/* 24/07/2020                 DCU             Caso: 143223               */
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_reporte_movdiario')
    drop proc sp_reporte_movdiario
go

create proc sp_reporte_movdiario
(
    @i_param1           datetime = null,   --FECHA  
    @t_show_version     bit      =   0
             
)
as
declare
    @w_sp_name          varchar(20),
    @w_s_app            varchar(50),
    @w_path             varchar(255),
    @w_path_obj         varchar(255),
    @w_destino          varchar(2500),
    @w_msg              varchar(200),
    @w_error            int,
    @w_errores          varchar(1500),
    @w_comando          varchar(8000),
    @w_cadena           varchar (1000),
    @w_report_nombre    varchar(100),
    @w_reporte          varchar(10),
    @w_return           int,
    @w_dia              varchar(2),
    @w_mes              varchar(2),
    @w_anio             varchar(4),
    @w_nom_arch         varchar(255),
    @w_nom_log          varchar(255),
    @w_fecha_proceso    datetime,
    @w_mensaje          varchar(150),
    @w_empresa          int,
    @w_ciudad_nacional  int,
    @w_formato_fecha    int,
    @w_batch            int,
    @w_query            varchar(500),
    @w_columna          varchar(50),
    @w_col_id           int,
    @w_cabecera         varchar(8000),
    @w_nom_cabecera     varchar(8000), 
    @w_nom_columnas     varchar(8000),
    @w_cont_columnas    int,
    @w_sql              varchar(8000),
    @w_sql2             varchar(8000),
    @w_fecha_inicial    datetime,
    @w_fecha_hasta      datetime,
    @w_periodo          int


select @w_sp_name = 'sp_reporte_movdiario'

select @w_formato_fecha = 112, @w_batch = 36436 ----

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


if @i_param1 is null 
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else 
   select @w_fecha_proceso = @i_param1
   
select @w_fecha_hasta = dateadd(dd, -1, @w_fecha_proceso)
   
while exists(select 1 
             from cobis..cl_dias_feriados 
             where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_hasta ) 
   select @w_fecha_hasta= dateadd(dd, -1, @w_fecha_hasta) 
   
   
select @w_fecha_inicial = dateadd(dd, 1-datepart(dd, @w_fecha_hasta), @w_fecha_hasta) 
select @w_periodo = year(@w_fecha_hasta)

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end

select @w_empresa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 101254
   goto ERROR_PROCESO
end



select @w_path = ba_path_destino,
       @w_report_nombre = ba_arch_resultado
from  cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or
   isnull(@w_path, '') = '' or 
   isnull(@w_report_nombre, '') = ''
begin
   select @w_error = 807048
   goto ERROR_PROCESO
end

   
select @w_dia = right('00' + convert(varchar(2), datepart(dd, @w_fecha_proceso)), 2)
select @w_mes = right('00' + convert(varchar(2), datepart(mm, @w_fecha_proceso)), 2)
select @w_anio = 'D'+right(convert(varchar(4), datepart(yyyy, @w_fecha_proceso)),2)

select @w_nom_arch = @w_report_nombre + '_' + @w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_' + @w_anio + @w_mes + @w_dia + '.err'

if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_movdia' and type = 'U')
   drop table sb_tmp_cabecera_movdia

create table sb_tmp_cabecera_movdia
(
    cabecera01  varchar(50), -- COMPANIA
    cabecera02  varchar(50), -- NUMERO_POLIZA
    cabecera03  varchar(50), -- DESCRIPCION_POLIZA 
    cabecera04  varchar(50), -- FECHA_CAPTURA
    cabecera05  varchar(50), -- FECHA_EFECTIVA
    cabecera06  varchar(50), -- HORA_EFECTIVA
    cabecera07  varchar(50), -- CUENTA
    cabecera08  varchar(50), -- TIPO_CUENTA
    cabecera09  varchar(50), -- TIPO_TRANSACCION
    cabecera10  varchar(50), -- DESCRIPCION_CUENTA
    cabecera11  varchar(50), -- IMPORTE
    cabecera12  varchar(50), -- TIPO MONEDA
    cabecera13  varchar(50), -- TIPO_CAMBIO
    cabecera14  varchar(50), -- IMPORTE MN 
    cabecera15  varchar(50), -- USUARIO NOMBRE DIG
    cabecera16  varchar(50), -- USUARIO ID AUT
    cabecera17  varchar(50), -- USUARIO ID DIG
    cabecera18  varchar(50), -- PERIODO AFECTADO
    cabecera19  varchar(50), -- OFICINA ORIGEN
    cabecera20  varchar(50), -- MAYORIZADO
    cabecera21  varchar(50), -- REFERENCIA
    cabecera22  varchar(50), -- CONCEPTO
    cabecera23  varchar(50)
)

--Consultar informacion inicial para generacion del archivo

--Registro de Informacion del Reporte en Estructura Final
if exists(select 1 from sysobjects where name = 'sb_tmp_reporte_movdia' and type = 'U')
   drop table sb_tmp_reporte_movdia

create table sb_tmp_reporte_movdia(
COMPANIA           varchar(25)   null,
NUMERO_POLIZA      varchar(20)   null,
DESCRIPCION_POLIZA varchar(100)  null,
FECHA_CAPTURA      varchar(10)   null,
FECHA_EFECTIVA     varchar(10)   null,
HORA_EFECTIVA      varchar(10)   null,
CUENTA             varchar(100)  null,
TIPO_CUENTA        varchar(10)   null,
TIPO_TRANSACCION   varchar(10)   null,
DESCRIPCION_CUENTA varchar(100)  null,
IMPORTE            varchar(50)   null,
TIPO_MONEDA        varchar(5)    null,
TIPO_CAMBIO        varchar(2)    null,
IMPORTE_MN         varchar(50)   null,
USUARIO_NOMBRE_DIG varchar(100)  null,
USUARIO_NOMBRE_AUT varchar(100)  null,
USUARIO_ID_DIG     varchar(50)   null,
USUARIO_ID_AUT     varchar(50)   null,
PERIODO_AFECTADO   varchar(4)    null,
OFICINA_ORIGEN     varchar(160)  null,
MAYORIZADO         varchar(2)    null,
REFERENCIA         varchar(20)   null,  
CONCEPTO           varchar(250)  null)  


insert into sb_tmp_reporte_movdia(
COMPANIA           ,
NUMERO_POLIZA      ,
DESCRIPCION_POLIZA ,
FECHA_CAPTURA      ,
FECHA_EFECTIVA     ,
HORA_EFECTIVA      ,
CUENTA             ,
TIPO_CUENTA        ,
TIPO_TRANSACCION   ,
DESCRIPCION_CUENTA ,
IMPORTE            ,
TIPO_MONEDA        ,
TIPO_CAMBIO        ,
IMPORTE_MN         ,
USUARIO_NOMBRE_DIG ,
USUARIO_NOMBRE_AUT ,
USUARIO_ID_DIG     ,
USUARIO_ID_AUT     ,
PERIODO_AFECTADO   ,
OFICINA_ORIGEN     ,
MAYORIZADO         ,
REFERENCIA         ,
CONCEPTO           )
select 'COMPANIA'           = 'INCLUSION FINANCIERA',
       'NUMERO_POLIZA'      = ltrim(rtrim(convert(varchar,co_comprobante))),
       'DESCRIPCION_POLIZA' = ltrim(rtrim(co_descripcion)),
       'FECHA_CAPTURA'      = convert(varchar(10),co_fecha_dig,103),
       'FECHA_EFECTIVA'     = convert(varchar(10),co_fecha_tran,103),
       'HORA_EFECTIVA'      = '00:00',--convert(varchar(2),DATEPART(hh,co_fecha_mod)) + ':' + convert(varchar(2),DATEPART(mi,co_fecha_mod)),
       'CUENTA'             = ltrim(rtrim(as_cuenta)),
       'TIPO_CUENTA'        = case 
                              when (convert(int,substring(as_cuenta,1,1))>= 1 and  convert(int,substring(as_cuenta,1,1)) <= 4) then
                                   'B'
                              when (convert(int,substring(as_cuenta,1,1))>= 5 and  convert(int,substring(as_cuenta,1,1)) <= 6) then
                                   'R'
                              else
                                   'O'
                              end, 
       
       'TIPO_TRANSACCION' = case when as_credito <> 0 and as_debito = 0 then
                                   'C'
                                 when as_credito  = 0 and as_debito <> 0 then
                                   'D'
                            end,
        'DESCRIPCION_CUENTA'= ltrim(rtrim((select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = as_cuenta))),
        'IMPORTE'           = case when as_credito <> 0 and as_debito = 0 then
                                   ltrim(rtrim(convert(varchar(50),as_credito)))
                                 when as_credito  = 0 and as_debito <> 0 then
                                   ltrim(rtrim(convert(varchar(50),as_debito)))
                               end,
        'TIPO_MONEDA'       = 'MX',--??
        'TIPO_CAMBIO'       = '1',
        'IMPORTE_MN '       = case when as_credito <> 0 and as_debito = 0 then
                                   ltrim(rtrim(convert(varchar(50),as_credito)))
                                 when as_credito  = 0 and as_debito <> 0 then
                                   ltrim(rtrim(convert(varchar(50),as_debito)))
                               end,
       'USUARIO_NOMBRE_DIG' = case when co_digitador = 'sa' or co_digitador= 'USR_BATCH'then
                                   'AUTOMATICO'
                              else
                                   (select fu_nombre from cobis..cl_funcionario where fu_login = co_digitador)
                              end,
       'USUARIO_NOMBRE_AUT' = case when co_autorizante = 'sa' or co_autorizante = 'USR_BATCH'then
                                   'AUTOMATICO'
                              else
                                   (select fu_nombre from cobis..cl_funcionario where fu_login = co_digitador)
                              end,
       'USUARIO_ID_DIG'     = case when co_digitador = 'sa' or co_digitador= 'USR_BATCH'then
                                   'AUTOMATICO'
                              else
                                   co_digitador
                              end,
         
       'USUARIO_ID_AUT'     = case when co_digitador = 'sa' or co_digitador= 'USR_BATCH'then
                                   'AUTOMATICO'
                              else
                                   co_autorizante
                              end,
       'PERIODO_AFECTADO'   = convert(varchar,@w_periodo),
       'OFICINA_ORIGEN'     = (select of_descripcion
                               from cob_conta..cb_oficina
                               where of_oficina = as_oficina_orig),       
       'MAYORIZADO'         = co_mayorizado,
       'REFERENCIA'         = isnull(co_referencia,' '),
       'CONCEPTO'           = ltrim(rtrim(as_concepto))            
from cob_conta..cb_comprobante,
     cob_conta..cb_asiento     
where co_comprobante  = as_comprobante
and   co_empresa      = as_empresa
and   co_fecha_tran   = as_fecha_tran
and   co_oficina_orig = as_oficina_orig
and   co_fecha_tran   >= @w_fecha_inicial
and   co_fecha_tran   <= @w_fecha_hasta 


if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end




print 'Generando Cabeceras'
select @w_col_id   = 0,
       @w_columna  = '',
       @w_cabecera = '',
       @w_nom_cabecera = '', 
       @w_nom_columnas = '',
       @w_cont_columnas = 0
       
while 1 = 1 begin
   set rowcount 1 
   select @w_columna = lower(c.name),--lower(substring(ltrim(rtrim(c.name)), 4, len(ltrim(rtrim(c.name))) - 3)),
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_tmp_reporte_movdia'
   and   c.colid > @w_col_id
   order by c.colid
    
   if @@rowcount = 0 begin
      set rowcount 0
      break
   end
   
   set rowcount 0 
   select @w_cont_columnas = @w_cont_columnas + 1
  
   select @w_nom_cabecera = @w_nom_cabecera + 'cabecera' + right('00' + convert(varchar(2), @w_cont_columnas), 2) + char(44)
   select @w_cabecera = @w_cabecera + char(39) + @w_columna + char(39) + char(44)
   select @w_nom_columnas = @w_nom_columnas +'' + upper(@w_columna) + char(44)   
      
end

select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

--Escribir Cabecera
select    @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_movdia '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_nom_cabecera
select    @w_sql = @w_sql + ')'
select    @w_sql = @w_sql + ' values '
select    @w_sql = @w_sql + '('
select    @w_sql = @w_sql + @w_cabecera
select    @w_sql = @w_sql + ')'

exec (@w_sql)

if @@ERROR <> 0 begin
   print 'Error generando Archivo de Cabeceras'
   print @w_sql
   select
   @w_error = 2108048,
   @w_mensaje = 'Error generando Archivo de Cabeceras'
   goto ERROR_PROCESO
end

select @w_nom_arch

--Geneacion del BCP para creacion del archivo 

select @w_sql = 'select '
select @w_sql = @w_sql +  @w_nom_cabecera 
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_movdia '
select @w_sql2 = ' union all ' 
select @w_sql2 = @w_sql2 + 'select '
select @w_sql2 = @w_sql2 + @w_nom_columnas
select @w_sql2 = @w_sql2 + ' from cob_conta_super..sb_tmp_reporte_movdia '

--exec (@w_sql + @w_sql2)

--Geneacion del BCP para creacion del archivo 
select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_02_TTI<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_02_TTI<aaaa_mm_dd>.err
       
select @w_comando = 'bcp "' + (@w_sql + @w_sql2) + '" queryout "'    
--select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '
select @w_comando = @w_comando + @w_destino + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'

--PRINT 'Comando: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select @w_error = 70146
  goto ERROR_PROCESO
end


SALIDA_PROCESO:
return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go
