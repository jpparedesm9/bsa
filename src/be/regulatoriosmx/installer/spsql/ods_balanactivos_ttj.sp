/*************************************************************************/
/*   Archivo:              ods_balanactivos_ttj.sp                       */
/*   Stored procedure:     sp_ods_balance_activos_ttj                    */
/*   Base de datos:        cob_conta_super                               */
/*   Producto:             Regulatorios                                  */
/*   Disenado por:         Raúl Altamirano Mendez                        */
/*   Fecha de escritura:   Diciembre 2017                                */
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
/*   Extraccion de datos para la generacion de archivo de interface ODS 2*/
/*   Balance Activos  TTI                                                */
/*                              CAMBIOS                                  */
/* Mar-05-2020      AOR         MEJORA 129414                            */
/* Ago-17-2020    	ACHP        Caso #143664 - cambio de nombre          */
/* Ene-19-2020    	SRS         Caso #152525 - Ajuste saldos intereses   */
/* Ene-12-2022    	KVI         R.#173512-Archivo tome ultimo dia natural*/
/* Feb-21-2022      DCU         R. #179359                               */
/*************************************************************************/
use cob_conta_super
go

if exists(select 1 from sysobjects where name = 'sp_ods_balance_activos_ttj')
    drop proc sp_ods_balance_activos_ttj
go

create proc sp_ods_balance_activos_ttj
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
    @w_fecha_corte      datetime,
    @w_est_vigente      tinyint,
    @w_est_vencido      tinyint,
    @w_formato_fecha    int,
    @w_batch            int,
    @w_query            varchar(500),
    @w_columna          varchar(50),
    @w_col_id           int,
    @w_cabecera         varchar(8000),
    @w_nom_cabecera     varchar(8000), 
    @w_nom_columnas     varchar(8000),
    @w_cont_columnas    int,
    @w_sql              varchar(5000),
	@w_es_fin_mes       char(1),
	@w_fecha_fin_mes_hab datetime,
	--Caso #173512 Ini
	@w_fecha_fin_mes     datetime, 
	@w_dia_m             varchar(2),
    @w_mes_m             varchar(2),
    @w_anio_m            varchar(4),
	--Caso #173512 Fin
    @w_est_etapa2       tinyint --179359

select @w_sp_name = 'sp_ods_balance_activos_ttj'

select @w_formato_fecha = 112, @w_batch = 75222 ----
select @w_es_fin_mes = 'N'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '1.0.0.0'
  return 0
end

if @i_param1 is null 
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
else 
   select @w_fecha_proceso = @i_param1

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


select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

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


--CONSULTAR ESTADO VENCIDO/VIGENTE PARA CARTERA
exec @w_error  = cob_externos..sp_estados
@i_producto      = 7,
@o_est_vencido   = @w_est_vencido   out,
@o_est_vigente   = @w_est_vigente   out,
@o_est_etapa2    = @w_est_etapa2    out 

if @w_error > 0 or @w_est_vencido is null or @w_est_vigente is null
begin
   select
   @w_error   = 2108029,
   @w_mensaje = 'No Encontro Estado Vigente/Vencido para Cartera'
   goto ERROR_PROCESO
end

--HASTA ENCONTRAR EL HABIL ANTERIOR
select @w_fecha_corte = dateadd(dd, -1, @w_fecha_proceso)

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_corte)
begin
   if datepart(dd, @w_fecha_corte) != 1 select @w_fecha_corte = dateadd(dd, -1, @w_fecha_corte) else break
end

select @w_dia = right('00' + convert(varchar(2), datepart(dd, @w_fecha_corte)), 2)
select @w_mes = right('00' + convert(varchar(2), datepart(mm, @w_fecha_corte)), 2)
select @w_anio = right(convert(varchar(4), datepart(yyyy, @w_fecha_corte)),4)

-------------------------------------------Caso #143664 Ini
SELECT @w_fecha_fin_mes_hab = dateadd(d, -1, dateadd(m, DATEDIFF(m, 0, @w_fecha_corte) + 1, 0))

while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional and df_fecha = @w_fecha_fin_mes_hab) 
begin
   if datepart(dd, @w_fecha_fin_mes_hab) != 1 select @w_fecha_fin_mes_hab = dateadd(dd, -1, @w_fecha_fin_mes_hab) else break
end

if(convert(VARCHAR(10),@w_fecha_fin_mes_hab, @w_formato_fecha) = convert(VARCHAR(10),@w_fecha_corte, @w_formato_fecha))
    select @w_es_fin_mes = 'S'
-------------------------------------------Caso #143664 Fin

if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_balance' and type = 'U')
   drop table sb_tmp_cabecera_balance

create table sb_tmp_cabecera_balance
(
    cabecera01  varchar(50),
    cabecera02  varchar(50),
    cabecera03  varchar(50),
    cabecera04  varchar(50),
    cabecera05  varchar(50),
    cabecera06  varchar(50),
    cabecera07  varchar(50),
    cabecera08  varchar(50),
    cabecera09  varchar(50)
)

--Consultar informacion inicial para generacion del archivo
select 
'banco'        = do_banco,
'cuenta'       = bod_cuenta,
'fecha'        = bod_fecha,
'oficina'      = do_oficina, --bod_oficina,
'rubro'        = bod_concepto,
'saldo_cta'    = bod_val_opera
into #datos_ctas_prestamos
from cob_conta_super..sb_dato_operacion,
     cob_conta..cb_boc_det     
where do_fecha = @w_fecha_corte
and   do_aplicativo = 7 
and   do_estado_cartera in (@w_est_vigente, @w_est_etapa2, @w_est_vencido)
and   bod_fecha = do_fecha
and   bod_banco = do_banco
and   bod_producto = do_aplicativo
and   (bod_cuenta like '1%' or bod_cuenta like '2%' or bod_cuenta like '3%' or bod_cuenta like '7%')
--and   do_tipo_operacion not in('REVOLVENTE')
order by do_banco, bod_concepto, bod_cuenta

if @@error != 0
begin
   select @w_error = 70139
   goto ERROR_PROCESO
end



--Registro de Informacion del Reporte en Estructura Final
truncate table sb_ods_balanactivos_ttj

insert into sb_ods_balanactivos_ttj 
(
 ob_num_cuenta,
 ob_cod_cta_cont,
 ob_cod_divisa,
 ob_fec_data,
 ob_cod_pais,
 ob_cod_centro_cont,
 ob_cod_entidad,
 ob_imp_sdo_cont_mo,
 ob_imp_sdo_cont_ml
)
select
convert(varchar(50),ltrim(rtrim(banco))),
convert(varchar(50),replicate ('0',(15 - len(ltrim(rtrim(cuenta))))) + convert(varchar,ltrim(rtrim(cuenta)))),
--convert(varchar(50),ltrim(rtrim(cuenta))),
'MXP',
convert(varchar(8), @w_fecha_corte, @w_formato_fecha),
convert(varchar(50),52),
convert(varchar(50),oficina),
convert(varchar(50),'0078'),
dbo.fn_formato_num_txt(saldo_cta, 20, 3),
--convert(varchar(50),saldo_cta),
dbo.fn_formato_num_txt(saldo_cta, 20, 3)
--convert(varchar(50),saldo_cta)
from #datos_ctas_prestamos
where saldo_cta != 0

-- SOP 152525
UPDATE 	sb_ods_balanactivos_ttj 
SET		ob_imp_sdo_cont_mo = '-' + ob_imp_sdo_cont_mo,
		ob_imp_sdo_cont_ml = '-' + ob_imp_sdo_cont_ml
WHERE 	ob_cod_cta_cont = '000007711900101'
-- SOP 152525

if @@error <> 0
begin
   select @w_error = 724662
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
   select @w_columna = lower(substring(ltrim(rtrim(c.name)), 4, len(ltrim(rtrim(c.name))) - 3)),
          @w_col_id  = c.colid
   from sysobjects o, syscolumns c
   where o.id    = c.id
   and   o.name  = 'sb_ods_balanactivos_ttj'
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
   select @w_nom_columnas = @w_nom_columnas +'ob_' + lower(@w_columna) + char(44)   
   
end

select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

--Escribir Cabecera
select    @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_balance '
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

--Geneacion del BCP para creacion del archivo 

select @w_sql = 'select '
select @w_sql = @w_sql + @w_nom_cabecera
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_balance '
select @w_sql = @w_sql + ' union all ' 
select @w_sql = @w_sql + 'select '
select @w_sql = @w_sql + @w_nom_columnas
select @w_sql = @w_sql + ' from cob_conta_super..sb_ods_balanactivos_ttj '

-------------------------------------------Caso #143664 Ini
print 'borrar-w_fecha_corte: ' + convert(varchar(30),@w_fecha_corte)
print 'borrar-w_fecha_fin_mes_hab: ' + convert(varchar(30), @w_fecha_fin_mes_hab)
print 'borrar-w_es_fin_mes:' + @w_es_fin_mes

if(@w_es_fin_mes = 'S')
begin
    print 'borrar-Se van a crear archivos con D y M'
	
	-------------------------------------------Caso #173512 Ini
	select @w_fecha_fin_mes = dateadd(d, -1, dateadd(m, DATEDIFF(m, 0, @w_fecha_corte) + 1, 0))
	print 'borrar-w_fecha_fin_mes: ' + convert(varchar(30), @w_fecha_fin_mes)
	select @w_dia_m = right('00' + convert(varchar(2), datepart(dd, @w_fecha_fin_mes)), 2) 
    select @w_mes_m = right('00' + convert(varchar(2), datepart(mm, @w_fecha_fin_mes)), 2) 
    select @w_anio_m = right(convert(varchar(4), datepart(yyyy, @w_fecha_fin_mes)),4)      
	-------------------------------------------Caso #173512 Fin
	
    select @w_nom_arch = @w_report_nombre + '_M_' +@w_anio_m + @w_mes_m + @w_dia_m +'.' + 'txt'
    select @w_nom_log  = @w_report_nombre + '_M_' +@w_anio_m + @w_mes_m + @w_dia_m + '.err'
    
    select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_02_TTI<aaaa_mm_dd>.txt
           @w_errores = @w_path + @w_nom_log   -- COB_ODS_02_TTI<aaaa_mm_dd>.err
    
    select @w_comando = 'bcp "' + @w_sql + '" queryout "'    
    select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '
    
    exec @w_error = xp_cmdshell @w_comando
    
    if @w_error <> 0 begin
      select @w_error = 70146
      goto ERROR_PROCESO
    end
end

select @w_nom_arch = @w_report_nombre + '_D_' + @w_anio + @w_mes + @w_dia +'.' + 'txt'
select @w_nom_log  = @w_report_nombre + '_D_' + @w_anio + @w_mes + @w_dia + '.err'
-------------------------------------------Caso #143664 Fin

--Geneacion del BCP para creacion del archivo 
select @w_destino = @w_path + @w_nom_arch, -- COB_ODS_02_TTI<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log   -- COB_ODS_02_TTI<aaaa_mm_dd>.err
       
select @w_comando = 'bcp "' + @w_sql + '" queryout "'    
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

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
