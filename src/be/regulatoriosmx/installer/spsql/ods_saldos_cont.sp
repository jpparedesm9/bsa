/************************************************************************/
/*  Archivo               : ods_saldos_cont.sp                          */
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
/************************************************************************/
/*                              CAMBIOS                                 */
/*   24/09/2020 ACH             Caso: 146729                            */
/*   02/02/2023 DCU             Caso: 202093                            */
/*   08/02/2023 DCU             Caso: 202336-Control generacion 3er dia */
/************************************************************************/

use cob_conta_super
go

if exists (select 1 from sysobjects where  name = 'sp_ods_saldos_cont')
   drop proc sp_ods_saldos_cont
go

create proc sp_ods_saldos_cont
(
 @i_param1       char(1)      = null, ----Mensual (M) Diario(D)
 @i_fecha        datetime     = null,
 @i_valida_dia   char(1)      = 'S' 
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
@w_comando              varchar(400),
@w_s_app                varchar(400),
@w_msg                  varchar(400),
@w_batch                int,
@w_num_dec              int,
@w_fecha_corte          varchar(10),
@w_fecha_reporte        datetime,
@w_fecha_ini_mes        datetime,
@w_dia_tercero          datetime,
@w_dia_quinto           datetime,
@w_cambio_periodo       char(1),
@w_periodo_ant          int,
@w_ult_corte_per_ant    int,
@w_proceso_cierre       int,
@w_numero_dias          int,
@w_periodo_anterior     int,
@w_corte_max_ant        int,
@w_fecha_ini_ing_fp     datetime,
@w_fecha_fin_inf_fp     datetime,
@w_comprobante_fp       char(1),
@w_fecha                datetime,
@w_fecha_tercer_dia     char(1)
 
select @w_treporte = @i_param1
select @w_sp_name = 'sp_ods_saldos_cont'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_proceso_cierre  = 6079
select @w_fecha_tercer_dia = 'N'

if  @i_fecha  is not null select @w_fecha_proceso = @i_fecha
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

create table #saldos_restar (
sa_cuenta_res   cuenta,
sa_oficina_res  int,
sa_area_res     int,
sa_periodo_res  int,
sa_corte_res    int,
sa_saldo_res    money,
sa_tsaldo_res   char(1)
)

create table #saldos (
sa_cuenta   cuenta,
sa_oficina  int,
sa_area     int,
sa_periodo  int,
sa_corte    int,
sa_saldo    money,
sa_tsaldo   char(1)
)


select @w_batch = case @w_treporte when 'D' then 7527 else 7528 end

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
   @w_nom_log      =  @w_report_nombre+'_'+'D'+right(convert(varchar(4), datepart(yyyy,@w_fecha_reporte  )),4)+right('00' + convert(varchar,datepart(mm, @w_fecha_reporte  )),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_reporte )),2), -- caso#146729
   @w_batch        =  7527

   select @w_fecha_reporte  =convert(varchar(8), @w_fecha_reporte, 112)
end
else begin 

   select 
   @w_fecha_fin   = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso),
   @w_fecha_ini_mes = convert(datetime, right('00' + convert(varchar, datepart(MM, @w_fecha_proceso)), 2) + '/01/' + convert(varchar, datepart(yyyy, @w_fecha_proceso))),
   @w_dia_tercero = null,
   @w_dia_quinto  = null
   
   select
   @w_fecha_ini  = dateadd(dd,1-datepart(dd,@w_fecha_fin),@w_fecha_fin),
   @w_fecha_fma  = dateadd(dd,0-datepart(dd,@w_fecha_fin),@w_fecha_fin),
   @w_nom_arch   = @w_report_nombre+'_'+'M'+right(convert(varchar(4), datepart(yyyy, @w_fecha_fin)),4)+right('00' +convert(varchar,datepart(mm, @w_fecha_fin)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_fin)),2),
   @w_nom_log    = @w_report_nombre+'_'+'M'+right(convert(varchar(4), datepart(yyyy, @w_fecha_fin)),4)+right('00' +convert(varchar,datepart(mm, @w_fecha_fin)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_fin)),2), 
   @w_batch      =  7528
   
   
   --CONTROL PARA NO EJECUTAR SI NO ES EL 4 DIA HABIL DEL MES
   /*  SE reescribe condicion REQ#157518
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
   */
   print 'EJECUCION MENSUAL'
   select 
   @w_cont      = 0, 
   @w_fecha_piv = @w_fecha_ini_mes
   
   while @w_cont < 5
   begin
      if not exists (select 1 from cobis..cl_dias_feriados where df_ciudad = 1  and df_fecha = @w_fecha_piv)
	  begin
	     select @w_cont = @w_cont + 1
	  end
	  if @w_cont = 3 and @w_fecha_tercer_dia = 'N'
	  begin
         select 
		 @w_dia_tercero = @w_fecha_piv,
		 @w_fecha_tercer_dia = 'S'
      end
      else if @w_cont = 5
      begin
         select @w_dia_quinto  = @w_fecha_piv
      end
      select @w_fecha_piv = dateadd(dd,1,@w_fecha_piv)
   end 

   if (@w_fecha_proceso != @w_dia_tercero and @w_fecha_proceso != @w_dia_quinto and @i_valida_dia = 'S')
   begin
      print' SALE porque solo debe ejecutarse el tercer y quinto DIA HABIL.'
      return 0
   end
   
   if exists (select 1 from sb_ods_ult_ejec where ou_archivo = @w_report_nombre + '_D' + convert(varchar(2),datepart(dd,@w_fecha_proceso)) and ou_fecha = @w_fecha_fin) 
   BEGIN
   	PRINT ' ya existen datos'
   return 0 --Si ya esta generado el archivo ,no se genera
   end
   
   select     @w_fecha_reporte = convert(varchar(8), @w_fecha_fin, 112)
end   
        
select @w_fecha_corte = convert(varchar(8), @w_fecha_fin, 112)


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

--SI EXISTE CAMBIO DE PERIODO NO SE DEBE CONSIDERAR ULTIMO DIA PARA REPORTAR ENERO 
select @w_cambio_periodo = 'N'
if @w_periodo_fma <> @w_periodo_ini select @w_cambio_periodo = 'S'

select @w_periodo_anterior = @w_periodo_ini - 1
select @w_corte_max_ant = max(co_corte) from cob_conta..cb_corte where co_periodo = @w_periodo_anterior

select @w_fecha_ini_ing_fp = convert(datetime,'01/01/' + convert(varchar(4),@w_periodo_fin))
select @w_fecha_fin_inf_fp = convert(datetime,'01/31/' + convert(varchar(4),@w_periodo_fin))

if exists(select top 1 *
          from cob_conta..cb_comprobante
          where co_fecha_tran >= @w_fecha_ini_ing_fp
          and   co_fecha_tran <= @w_fecha_fin_inf_fp
          and   co_descripcion like '%Cierre de Periodo%')
   select @w_comprobante_fp = 'S'

select '@w_comprobante_fp' = @w_comprobante_fp

--Cuentas que se enceran en el fin de periodo
SELECT
'cuenta'     = ca_cuenta,
'moneda'     = ca_condicion,
'ctr_cuenta' = ca_cta_asoc,
'ctr_oficina'= ca_oficina_destino
INTO #cta_contra
FROM cob_conta..cb_cuenta_asociada
WHERE ca_proceso = @w_proceso_cierre

select distinct
cu_cuenta      = cu_cuenta,
cu_moneda      = cu_moneda,
cu_tercero     = convert(char(1),'N'), --al inicio asumimos que ninguna cuenta es de terceros
cu_ctr_cuenta  = ctr_cuenta,
cu_ctr_oficina = ctr_oficina
into #cuentas_finpe
from cob_conta..cb_cuenta, #cta_contra
where substring(cu_cuenta,1,1) = cuenta
AND   cu_moneda                = moneda
and   cu_movimiento            = 'S'

--Se toma en cuenta el asiento de fin de periodo
--Para restar al monto de los saldos
if @w_comprobante_fp = 'S' and @w_cambio_periodo = 'S' and @i_param1 = 'M'
begin
   insert into #saldos_restar
   select 
   sa_cuenta  =  hi_cuenta,
   sa_oficina =  hi_oficina,
   sa_area    =  hi_area,
   sa_periodo =  hi_periodo,
   sa_corte   =  hi_corte,
   sa_saldo   =  sum(hi_saldo) * (-1),
   sa_tsaldo  =  'F'          ---Tres Tipo de Saldo (I) inicial  (D) diario (F) final
   from cob_conta_his..cb_hist_saldo, cob_conta..cb_cuenta
   where cu_cuenta  = hi_cuenta
   and   cu_empresa = hi_empresa
   and   cu_empresa = @w_empresa
   and   cu_movimiento = 'S'
   and   hi_periodo    =  @w_periodo_anterior
   and   hi_corte      =  @w_corte_max_ant
   and   cu_cuenta    in (select cu_cuenta from #cuentas_finpe)
   group by  hi_cuenta,hi_oficina,hi_area,hi_periodo,hi_corte
end



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

if exists(select 1 from #saldos_restar) 
begin
   update #saldos set
   sa_saldo = sa_saldo + sa_saldo_res
   from #saldos_restar
   where sa_cuenta  = sa_cuenta_res
   and   sa_oficina = sa_oficina_res
   and   sa_area    = sa_area_res
   and   sa_tsaldo  =  'I' 
end

truncate table sb_ods_saldos_cont

insert into sb_ods_saldos_cont
select 
os_cod_cta_cont       =   ltrim(rtrim(sa_cuenta)),
os_cod_centro_cont    =   sa_oficina,
os_cod_divisa         =   'MXP',
os_cod_entidad        =   '0078',
os_tip_divisa         =   1,
os_sdo_mo             =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end),
os_sdo_ml             =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end),
os_sdo_med_mo         =   round(sum(case when sa_tsaldo in ('F','D')   then sa_saldo else 0 end)/(@w_corte_fin-@w_corte_ini+1),@w_num_dec),
os_sdo_med_ml         =   round(sum(case when sa_tsaldo in ('F','D')   then sa_saldo else 0 end)/(@w_corte_fin-@w_corte_ini+1),@w_num_dec),
os_sdo_mes_mo         =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end) -sum(case when sa_tsaldo = 'I' then sa_saldo else 0 end),
os_sdo_mes_ml         =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end) -sum(case when sa_tsaldo = 'I' then sa_saldo else 0 end),
os_fecha_corte        =   convert(varchar(8), @w_fecha_reporte, 112),
os_cod_area_cont      =   sa_area,
os_des_area_cont      =   convert(varchar,null)
from #saldos
group by sa_cuenta,sa_oficina,sa_area

if @@error <> 0 begin
   select 
   @w_error = 70144,
   @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT'
   goto ERROR_PROCESO
end

update sb_ods_saldos_cont
set os_des_area_cont = isnull(ar_descripcion, '')
from cob_conta..cb_area
where os_cod_area_cont = ar_area

if @@error <> 0 begin
   select 
   @w_error = 70144,
   @w_msg   = 'ERROR AL ACTUALIZAR SALDOS CONT'
   goto ERROR_PROCESO
end

--Geneacion del BCP para creacion del archivo 
select @w_query   = 'select * from cob_conta_super..sb_ods_saldos_cont order by os_cod_cta_cont'

select @w_destino = @w_path + @w_nom_arch+'.txt', -- COB_ODS_07_<aaaa_mm_dd>.txt
       @w_errores = @w_path + @w_nom_log +'.err'  -- COB_ODS_07_<aaaa_mm_dd>.err

select @w_comando = 'bcp "' + @w_query + '" queryout "'
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
  insert into sb_ods_ult_ejec values (@w_report_nombre + '_D' + convert(varchar(2),datepart(dd,@w_fecha_proceso)), @w_fecha_fin) --Tabla que lleva el registro de la ejecucion fin mes
END


return 0

ERROR_PROCESO:


exec @w_error      = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha_proceso,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg


return @w_error

go
