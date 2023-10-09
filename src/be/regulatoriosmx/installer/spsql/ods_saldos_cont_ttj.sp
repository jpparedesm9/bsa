/************************************************************************/
/*  Archivo               : ods_saldos_cont_ttj.sp                      */
/*  Stored procedure      : sp_ods_saldos_cont                          */
/*  Base de datos         : cob_conta_super                             */
/*  Producto              : Contabilidad                                */
/*  Disenado por          : Andy  Gonzalez                              */
/*  Fecha de documentacion: 19 de Septiembre de 2017                    */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Generacion de saldos contables  diarios y mensules para Interfaz ODS*/
/*  04/03/2020    AORTIZ 	Agregar encabezado y ajustes				*/
/************************************************************************/
/*                              CAMBIOS                                 */
/*   24/09/2020 ACH             Caso: 146729                            */
/* Ene-19-2021    	SRS         Caso #152525 - Ajuste saldos intereses  */
/*   12/11/2021     DCU         Caso #172460                            */
/*   08/02/2023     DCU         Caso: 202336-Control doble signo (-)    */
/************************************************************************/
use cob_conta_super
go

if exists (select 1 from sysobjects where  name = 'sp_ods_saldos_cont_ttj')
   drop proc sp_ods_saldos_cont_ttj
go

create proc sp_ods_saldos_cont_ttj
(
 @i_param1       char(1)      = null, ----Mensual (M) Diario(D)
 @i_param2       datetime     = null 
)
as
declare
@w_empresa              int,
@w_sp_name              varchar(30),
@w_error                int,
@w_fecha_ini            datetime,
@w_fecha_fin            datetime,
@w_corte_ini            int,
@w_periodo_ini          int,
@w_corte_fin            int,
@w_periodo_fin          int,
@w_donde_ini            char(1),
@w_donde_fin            char(1),
@w_fecha_fma            datetime,
@w_corte_fma            int,   --fin mes anterior
@w_periodo_fma          int,
@w_treporte             char(1),
@w_fecha_proceso        datetime,
@w_nom_arch             varchar(255),
@w_cont                 int,
@w_ciudad_nacional      int,
@w_fecha_piv            datetime,
@w_query                varchar(500),
@w_path                 varchar(255),
@w_report_nombre        varchar(100),
@w_destino              varchar(400),
@w_nom_log              varchar(255),
@w_errores              varchar(400),
@w_comando              varchar(8000),
@w_s_app                varchar(400),
@w_msg                  varchar(400),
@w_batch                int,
@w_num_dec              int,
@w_fecha_corte          varchar(10),
@w_fecha_reporte        datetime,
@w_fecha_ini_mes        datetime,
@w_columna          	varchar(50),
@w_col_id           	int,
@w_cabecera         	varchar(8000),
@w_nom_cabecera     	varchar(8000), 
@w_nom_columnas     	varchar(8000),
@w_cont_columnas    	int,
@w_sql              	varchar(5000),
@w_mensaje          	varchar(150)
 
select @w_treporte = @i_param1
select @w_sp_name = 'sp_ods_saldos_cont_ttj'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
declare @resultadobcp table (linea varchar(max))

if  @i_param2  is not null select @w_fecha_proceso = @i_param2
---NUMERO DE DECIMALES
exec @w_error = cob_cartera..sp_decimales
@i_moneda    = 0,
@o_decimales = @w_num_dec out

if @w_error <> 0 begin
   select 
   @w_msg   = 'ERROR AL OBTENER NUMERO DE DECIMALES',
   @w_error = 710001
   goto ERROR_PROCESO
end 

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


select @w_empresa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 70135
   goto ERROR_PROCESO
end


select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1
begin
   select @w_error = 70135
   goto ERROR_PROCESO
end


create table #saldos (
sa_cuenta   cuenta,
sa_oficina  int,
sa_area     int,
sa_periodo  int,
sa_corte    int,
sa_saldo    money,
sa_tsaldo   char(1)
)


select @w_batch = case @w_treporte when 'D' then 7527 else 7538 end

select @w_path = ba_path_destino,
       @w_report_nombre = ba_arch_resultado
from cobis..ba_batch
where ba_batch = @w_batch

if @@error != 0 or @@rowcount != 1 or
   isnull(@w_path, '') = '' or 
   isnull(@w_report_nombre, '') = ''
begin
   select
    @w_error = 70134,
    @w_msg   = 'ERROR NO SE ENCUENTRA PATH DESTINO'
   goto ERROR_PROCESO
end


if  @w_treporte = 'D' begin --diario 
	
	--HASTA ENCONTRAR EL HABIL ANTERIOR
   select @w_fecha_reporte = dateadd(dd, -1, @w_fecha_proceso)
   
   while exists( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_reporte ) 
         if datepart(dd, @w_fecha_reporte) != 1 select @w_fecha_reporte= dateadd(dd, -1, @w_fecha_reporte) else break

   select
   @w_fecha_ini    =  dateadd(dd,1-datepart(dd,@w_fecha_reporte),@w_fecha_reporte),
   @w_fecha_fin    =  @w_fecha_reporte,
   @w_fecha_fma    =  dateadd(dd,0-datepart(dd,@w_fecha_reporte),@w_fecha_reporte),
   @w_nom_arch     =  @w_report_nombre+'_'+'D'+right(convert(varchar(4), datepart(yyyy,@w_fecha_reporte  )),4)+right('00' + convert(varchar,datepart(mm, @w_fecha_reporte )),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_reporte  )),2),
   @w_nom_log      =  @w_report_nombre+'_'+'D'+right(convert(varchar(4), datepart(yyyy,@w_fecha_reporte  )),4)+right('00' + convert(varchar,datepart(mm, @w_fecha_reporte  )),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_reporte )),2)-- caso#146729
   
   select @w_fecha_reporte  =convert(varchar(8), @w_fecha_reporte, 112)
end
else begin 

   select 
   @w_fecha_fin   = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso),
   @w_fecha_ini_mes = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fecha_proceso)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fecha_proceso)))
   
   select
   @w_fecha_ini  = dateadd(dd,1-datepart(dd,@w_fecha_fin),@w_fecha_fin),
   @w_fecha_fma  = dateadd(dd,0-datepart(dd,@w_fecha_fin),@w_fecha_fin),
   @w_nom_arch   = @w_report_nombre+'_'+right(convert(varchar(4), datepart(yyyy, @w_fecha_fin)),4)+right('00' +convert(varchar,datepart(mm, @w_fecha_fin)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_fin)),2),
   @w_nom_log    = @w_report_nombre+'_'+right(convert(varchar(4), datepart(yyyy, @w_fecha_fin)),4)+right('00' +convert(varchar,datepart(mm, @w_fecha_fin)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_fin)),2)
   
   --CONTROL PARA NO EJECUTAR SI NO ES EL 4 DIA HABIL DEL MES
   select 
   @w_cont      = 0, 
   @w_fecha_piv = @w_fecha_proceso
   
   while @w_fecha_piv >= @w_fecha_ini_mes  
   begin
      if not exists ( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_piv)
         select @w_cont = @w_cont +1
   
   select @w_fecha_piv = dateadd (dd,-1 ,@w_fecha_piv)
   end
   
   if @w_cont < 5 
   BEGIN
   	 print' SALE porque no debe ejecutarse antes del dia 4  DIA = ' + convert(VARCHAR, @w_cont )
       return 0
   END 
   
   if exists (select 1 from sb_ods_ult_ejec where ou_archivo = @w_report_nombre and ou_fecha = @w_fecha_fin) 
   BEGIN
   	PRINT ' ya existen datos'
   return 0 --Si ya esta generado el archivo ,no se genera
   end
   
--   insert into sb_ods_ult_ejec values (@w_report_nombre, @w_fecha_fin) --Tabla que lleva el registro de la ejecucion fin mes
   
   select     @w_fecha_reporte = convert(varchar(8), @w_fecha_fin, 112)
end   
        
select @w_fecha_corte = convert(varchar(8), @w_fecha_fin, 112)

if exists(select 1 from sysobjects where name = 'sb_tmp_cabecera_saldos' and type = 'U')
   drop table sb_tmp_cabecera_saldos

create table sb_tmp_cabecera_saldos
(
    cabecera01  varchar(50),
    cabecera02  varchar(50),
    cabecera03  varchar(50),
    cabecera04  varchar(50),
    cabecera05  varchar(50),
    cabecera06  varchar(50),
    cabecera07  varchar(50),
    cabecera08  varchar(50),
    cabecera09  varchar(50),
    cabecera10  varchar(50),
    cabecera11  varchar(50),
    cabecera12  varchar(50),
    cabecera13  varchar(50),
    cabecera14  varchar(50)
)

select 
@w_donde_ini   = 'H',
@w_donde_fin   = 'H',
@w_corte_ini   = ( select co_corte    from cob_conta..cb_corte where co_fecha_ini = @w_fecha_ini ),
@w_periodo_ini = ( select co_periodo  from cob_conta..cb_corte where co_fecha_ini = @w_fecha_ini ),
@w_corte_fma   = ( select co_corte    from cob_conta..cb_corte where co_fecha_ini = @w_fecha_fma ),
@w_periodo_fma = ( select co_periodo  from cob_conta..cb_corte where co_fecha_fin = @w_fecha_fma ),
@w_corte_fin   = ( select co_corte    from cob_conta..cb_corte where co_fecha_fin = @w_fecha_fin ),
@w_periodo_fin = ( select co_periodo  from cob_conta..cb_corte where co_fecha_fin = @w_fecha_fin )




select 
@w_corte_ini   ,
@w_periodo_ini ,
@w_corte_fma   ,
@w_periodo_fma ,
@w_corte_fin   ,
@w_periodo_fin 

if exists ( select 1 from cob_conta..cb_corte where co_fecha_ini = @w_fecha_ini  and co_estado = 'A') select @w_donde_ini = 'P'
if exists ( select 1 from cob_conta..cb_corte where co_fecha_ini = @w_fecha_fin  and co_estado = 'A') select @w_donde_fin = 'P'

--Insertando saldos de Fin de Mes anterior
insert into #saldos
select 
sa_cuenta  =  hi_cuenta,
sa_oficina =  hi_oficina,
sa_area    =  hi_area,
sa_periodo =  hi_periodo,
sa_corte   =  hi_corte,
sa_saldo   =  sum(hi_saldo),
sa_tsaldo  =  'I'          ---Tres Tipo de Saldo (I) inicial  (D) diario (F) final
from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
where cu_cuenta  = hi_cuenta
and   cu_empresa = hi_empresa
and   cu_empresa = @w_empresa
and   cu_movimiento = 'S'
and   hi_periodo    =  @w_periodo_fma
and   hi_corte      =  @w_corte_fma
group by  hi_cuenta,hi_oficina,hi_area,hi_periodo,hi_corte

if @@error <> 0 begin
    select 
    @w_error = 70144,
    @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT INICIAL'
    goto ERROR_PROCESO
end


insert into #saldos
select
sa_cuenta  =  hi_cuenta,
sa_oficina =  hi_oficina,
sa_area    =  hi_area,
sa_periodo =  hi_periodo,
sa_corte   =  hi_corte,
sa_saldo   =  sum(hi_saldo),
sa_tsaldo  =  'D'          ---Tres Tipo de Saldo (I) inicial  (D) diario (F) final
from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
where cu_cuenta  = hi_cuenta 
and   cu_empresa = hi_empresa
and   cu_empresa = @w_empresa
and   cu_movimiento = 'S'
and   hi_periodo    =  @w_periodo_fin
and   hi_corte      between @w_corte_ini and (@w_corte_fin -1)
group by  hi_cuenta,hi_oficina,hi_area,hi_periodo,hi_corte

if @@error <> 0 begin
    select
    @w_error = 70144,
    @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT DIARIOS'
    goto ERROR_PROCESO
end


if (@w_donde_fin = 'H') begin   -- Saldo de Historicos

   insert into #saldos
   select 
   sa_cuenta  =  hi_cuenta,
   sa_oficina =  hi_oficina,
   sa_area    =  hi_area,
   sa_periodo =  hi_periodo,
   sa_corte   =  hi_corte,
   sa_saldo   =  sum(hi_saldo),
   sa_tsaldo  =  'F'          ---Tres Tipo de Saldo (I) inicial  (D) diario (F) final
   from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
   where cu_cuenta  = hi_cuenta 
   and   cu_empresa = hi_empresa
   and   cu_empresa = @w_empresa
   and   cu_movimiento = 'S'
   and   hi_periodo    =  @w_periodo_fin
   and   hi_corte      =  @w_corte_fin
   group by  hi_cuenta,hi_oficina,hi_area,hi_periodo,hi_corte

   if @@error <> 0
   begin
      select
      @w_error = 70144,
      @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT HISTORICOS'
      goto ERROR_PROCESO
   end

end else begin                  --Saldo en Produccion

   insert into #saldos
   select
   sa_cuenta  =  sa_cuenta,
   sa_oficina =  sa_oficina,
   sa_area    =  sa_area,
   sa_periodo =  sa_periodo,
   sa_corte   =  sa_corte,
   sa_saldo   =  sum(sa_saldo),
   sa_tsaldo  =  'F'          ---Tres Tipo de Saldo (I) inicial  (D) diario (F) final
   from cob_conta..cb_saldo, cob_conta..cb_cuenta
   where cu_cuenta  = sa_cuenta 
   and   cu_empresa = sa_empresa
   and   cu_empresa = @w_empresa
   and   cu_movimiento = 'S'
   and   sa_periodo    =  @w_periodo_fin
   and   sa_corte      =  @w_corte_fin
   group by sa_cuenta,sa_oficina,sa_area,sa_periodo,sa_corte

   if @@error <> 0 begin
      select 
      @w_error = 70144,
      @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT PRODUCCION'
      goto ERROR_PROCESO
   end

end

truncate table sb_ods_saldos_cont_ttj

insert into sb_ods_saldos_cont_ttj
select 
os_cod_cta_cont       =   ltrim(rtrim(sa_cuenta)),
os_cod_centro_cont    =   sa_oficina,
os_cod_divisa         =   'MXP',
os_cod_entidad        =   '0078',
os_tip_divisa         =   1,
os_sdo_mo             =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0.0000 end),
os_sdo_ml             =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0.0000 end),
os_sdo_med_mo         =   convert(numeric(20,4),sum(case when sa_tsaldo in ('F','D')   then sa_saldo else 0 end)/(@w_corte_fin-@w_corte_ini+1)),
os_sdo_med_ml         =   convert(numeric(20,4),sum(case when sa_tsaldo in ('F','D')   then sa_saldo else 0 end)/(@w_corte_fin-@w_corte_ini+1)),
os_sdo_mes_mo         =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0.0000 end) -sum(case when sa_tsaldo = 'I' then sa_saldo else 0.0000 end),
os_sdo_mes_ml         =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0.0000 end) -sum(case when sa_tsaldo = 'I' then sa_saldo else 0.0000 end),
os_fec_data       	  =   convert(varchar(8), @w_fecha_reporte, 112),
os_cod_area_cont      =   sa_area,
os_des_area_cont      =   convert(varchar,null)
from #saldos
group by sa_cuenta,sa_oficina,sa_area

--SOP 152525
UPDATE sb_ods_saldos_cont_ttj
set 	os_sdo_mo = case when charindex('-',os_sdo_mo)> 0 then os_sdo_mo else '-' + os_sdo_mo end,
		os_sdo_ml = case when charindex('-',os_sdo_ml)> 0 then os_sdo_ml else '-' + os_sdo_ml end,
		os_sdo_med_mo =  case when charindex('-',os_sdo_med_mo)> 0 then os_sdo_med_mo else '-' + os_sdo_med_mo end,
		os_sdo_med_ml =  case when charindex('-',os_sdo_med_ml)> 0 then os_sdo_med_ml else '-' + os_sdo_med_ml end,
		os_sdo_mes_mo =  case when charindex('-',os_sdo_mes_mo)> 0 then os_sdo_mes_mo else '-' + os_sdo_mes_mo end,
		os_sdo_mes_ml =  case when charindex('-',os_sdo_mes_ml)> 0 then os_sdo_mes_ml else '-' + os_sdo_mes_ml end
WHERE	os_cod_cta_cont = '7711900101'
-- SOP 152525

if @@error <> 0 begin
   select 
   @w_error = 70144,
   @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT'
   goto ERROR_PROCESO
end

update sb_ods_saldos_cont_ttj
set os_des_area_cont = ar_descripcion
from cob_conta..cb_area
where os_cod_area_cont = ar_area

if @@error <> 0 begin
   select 
   @w_error = 70144,
   @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT'
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
   and   o.name  = 'sb_ods_saldos_cont_ttj'
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
   select @w_nom_columnas = @w_nom_columnas +'os_' + lower(@w_columna) + char(44)   
   
end

select @w_cabecera = substring(@w_cabecera, 1, len(@w_cabecera) - 1),
       @w_nom_cabecera = substring(@w_nom_cabecera, 1, len(@w_nom_cabecera) - 1),
       @w_nom_columnas = substring(@w_nom_columnas, 1, len(@w_nom_columnas) - 1)

--Escribir Cabecera
select    @w_sql = 'insert into cob_conta_super..sb_tmp_cabecera_saldos '
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
select @w_sql = @w_sql + ' from cob_conta_super..sb_tmp_cabecera_saldos '
select @w_sql = @w_sql + ' union all ' 
select @w_sql = @w_sql + 'select '
select @w_sql = @w_sql + @w_nom_columnas
select @w_sql = @w_sql + ' from cob_conta_super..sb_ods_saldos_cont_ttj '

select @w_destino = @w_path + @w_nom_arch+'.txt', -- COB_ODS_07_<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log +'.err'  -- COB_ODS_07_<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_sql + '" queryout "'
select @w_comando = @w_comando + @w_destino + '" -b5000 -c' + @w_s_app + 's_app.ini -T -e"' + @w_errores + '"'+ ' -t"|" '

-- PRINT 'Comando: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select
  @w_error = 70146,
  @w_msg   = 'ERROR AL EJECUTAR COMANDO BCP'
  goto ERROR_PROCESO
end

-- GRABA AL FINAL LA GENERACION DEL ARCHIVO
if  @w_treporte <> 'D'  --diario 
BEGIN
  insert into sb_ods_ult_ejec values (@w_report_nombre, @w_fecha_fin) --Tabla que lleva el registro de la ejecucion fin mes
END

SALIDA_PROCESO:
	return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje


exec @w_error      = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg


return @w_error

go
