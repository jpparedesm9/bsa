use cob_conta_super
go

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
@i_param1       char(1)      = null       --Mensual (M) Diario(D)


SELECT @i_param1  = 'D'

select @w_treporte = @i_param1
select @w_sp_name = 'sp_ods_saldos_cont'


select @w_fecha_proceso =  '05/25/2018'
-------------fp_fecha from cobis..ba_fecha_proceso


---NUMERO DE DECIMALES
SELECT @w_num_dec = 2

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


select @w_empresa = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'EMP' and pa_producto = 'ADM'



select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'



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

                  SELECT @w_error = 0

if  @w_treporte = 'D' begin --diario 

   select
   @w_fecha_ini    =  dateadd(dd,1-datepart(dd,@w_fecha_proceso),@w_fecha_proceso),
   @w_fecha_fin    =  @w_fecha_proceso,
   @w_fecha_fma    =  dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso),
   @w_nom_arch     =  @w_report_nombre+'_'+convert(varchar,datepart(yyyy, @w_fecha_proceso))+right('00' + convert(varchar,datepart(mm, @w_fecha_proceso)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_proceso)),2),
   @w_nom_log      =  @w_report_nombre+'_'+convert(varchar,datepart(yyyy, @w_fecha_proceso))+right('00' + convert(varchar,datepart(mm, @w_fecha_proceso)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_proceso)),2),
   @w_batch        =  7527

end
else begin
   select @w_fecha_fin   = dateadd(dd,0-datepart(dd,@w_fecha_proceso),@w_fecha_proceso)

   select
   @w_fecha_ini  = dateadd(dd,1-datepart(dd,@w_fecha_fin),@w_fecha_fin),
   @w_fecha_fma  = dateadd(dd,0-datepart(dd,@w_fecha_fin),@w_fecha_fin),
   @w_nom_arch   = @w_report_nombre+'_'+convert(varchar,datepart(yyyy, @w_fecha_fin))+right('00' +convert(varchar,datepart(mm, @w_fecha_fin)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_fin)),2),
   @w_nom_log    = @w_report_nombre+'_'+convert(varchar,datepart(yyyy, @w_fecha_fin))+right('00' +convert(varchar,datepart(mm, @w_fecha_fin)),2)+right('00' +convert(varchar,datepart(dd, @w_fecha_fin)),2), 
   @w_batch      =  7528
  --CONTROL PARA NO EJECUTAR SI NO ES EL 4 DIA HABIL DEL MES
  select
  @w_cont      = 0,
  @w_fecha_piv = @w_fecha_fin

  while @w_fecha_piv >= @w_fecha_ini begin
     if not exists ( select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional  and df_fecha = @w_fecha_piv)
        select @w_cont = @w_cont +1

     select @w_fecha_piv = dateadd (dd,-1 ,@w_fecha_piv)
  end

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

truncate table sb_ods_saldos_cont

insert into sb_ods_saldos_cont
select 
os_cod_cta_cont       =   ltrim(rtrim(sa_cuenta)),
os_cod_centro_cont    =   sa_oficina,
os_cod_divisa         =   'MXP',
os_cod_entidad        =   14,
os_tip_divisa         =   1,
os_sdo_mo             =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end),
os_sdo_ml             =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end),
os_sdo_med_mo         =   round(sum(case when sa_tsaldo in ('F','D')   then sa_saldo else 0 end)/(@w_corte_fin-@w_corte_ini+1),@w_num_dec),
os_sdo_med_ml         =   round(sum(case when sa_tsaldo in ('F','D')   then sa_saldo else 0 end)/(@w_corte_fin-@w_corte_ini+1),@w_num_dec),
os_sdo_mes_mo         =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end) -sum(case when sa_tsaldo = 'I' then sa_saldo else 0 end),
os_sdo_mes_ml         =   sum(case when sa_tsaldo = 'F'          then sa_saldo else 0 end) -sum(case when sa_tsaldo = 'I' then sa_saldo else 0 end),
os_fecha_corte        =   @w_fecha_corte,
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

IF @w_error = 0
                PRINT ' TERMINON CON EXITO'

ERROR_PROCESO:
IF @w_error <> 0
                PRINT ' FALLO'

Go
