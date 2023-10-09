/************************************************************************/
/*      Archivo           :  cb_saprd.sqr                               */
/*      Base de datos     :  cob_conta                                  */
/*      Producto          :  Contabilidad                               */
/*      Disenado por      :  José Rafael Molano Zorro                   */
/*      Fecha de escritura:  06/05/2005                                 */
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
/*      Emite listados de promedios diarios para un mes determinado     */
/*      tomando las fechas ingresadas por parametro.                    */
/*                                                                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*						                        */
/*      FECHA                AUTOR                 RAZON                */
/*   06/05/2005              J.Molano             Emision Inicial       */
/************************************************************************/
use cob_conta
go 

if exists (select * from sysobjects where name = 'tmp_cb_hist_saldo')
   drop table tmp_cb_hist_saldo
go

create table tmp_cb_hist_saldo
(
   th_empresa      tinyint	null,
   th_cuenta       cuenta 	null,
   th_oficina      smallint     null,
   th_nombre       varchar(80)	null,
   th_prom_act     money        null,
   th_prom_ant     money     	null,
   th_var_abs      money     	null,
   th_var_rel      money        null
)
--lock datarows
go

create nonclustered index tmp_cb_hist_saldo on tmp_cb_hist_saldo(th_empresa, th_cuenta, th_oficina)
go

if exists (select * from sysobjects where name = 'tmp_cb_hist_saldo2')
   drop table tmp_cb_hist_saldo2
go

create table tmp_cb_hist_saldo2
(
   ta_empresa      tinyint	null,
   ta_cuenta       cuenta 	null,
   ta_oficina      smallint     null,
   ta_prom_ant     money     	null,
)
--lock datarows
go

create nonclustered index tmp_cb_hist_saldo2 on tmp_cb_hist_saldo2(ta_empresa, ta_cuenta, ta_oficina)
go

if exists (select * from sysobjects where name = 'cb_oficina_tmp')
   drop table cb_oficina_tmp
go

create table cb_oficina_tmp
(
   of_oficina      smallint	null
)
--lock datarows
go


if exists(select * from cob_conta..sysobjects where name = 'sp_promedios_diarios')
   drop proc sp_promedios_diarios
go

create proc sp_promedios_diarios(
   @s_ssn		  int = null,
   @s_date		  datetime = null,
   @s_term		  descripcion = null,
   @s_corr		  char(1) = null,
   @s_ssn_corr	          int = null,
   @s_ofi		  smallint = null,
   @t_rty		  char(1) = null,
   @t_trn		  smallint = null,
   @t_debug 	          char(1) = 'N',
   @t_file		  varchar(14) = null,
   @t_from		  varchar(30) = null,
   @i_fecha	          datetime,
   @i_empresa	          tinyint,
   @i_nivel_of      	  int,
   @i_oficina_i	          smallint,
   @i_oficina_f	          smallint,
   @i_cuenta_i            cuenta,
   @i_cuenta_f            cuenta
)
as

declare
   @w_empresa             tinyint,
   @w_nivel_of            int,
   @w_oficina_i           smallint,
   @w_oficina_f           smallint,
   @w_fecha_i             datetime,
   @w_fecha_f             datetime,
   @w_sp_name             varchar,
   @w_corte_m             smallint,
   @w_corte_f             smallint,
   @w_corte_i             smallint,
   @w_periodo_i           smallint,
   @w_fecha               datetime,
   @w_meses               int,
   @w_contador            int,
   @w_anio_i              char(4),
   @w_mes_i	          char(2),
   @w_oficina             smallint,
   @w_saldo               money,
   @w_nombre              descripcion

select @w_sp_name = 'sp_promedios_diarios'

select @w_fecha =  @i_fecha

select  @w_corte_i = min(co_corte),
        @w_periodo_i = co_periodo
from    cob_conta..cb_corte,cob_conta..cb_periodo
where   co_empresa = convert(tinyint,@i_empresa)
and     pe_empresa = convert(tinyint,@i_empresa)
and     @w_fecha between pe_fecha_inicio and pe_fecha_fin
and     co_periodo = pe_periodo
and     datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha)
group   by co_periodo


-- CALCULO CORTE FINAL DEL MES
select @w_corte_m = max(co_corte)
from   cob_conta..cb_corte,cob_conta..cb_periodo
where  co_empresa = convert(tinyint,@i_empresa)
and    pe_empresa = convert(tinyint,@i_empresa)
and    @w_fecha between pe_fecha_inicio and pe_fecha_fin
and    co_periodo = pe_periodo
and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha)
group  by co_periodo

begin tran
-- INSERCION DE PROMEDIOS MENSUALES
   insert into tmp_cb_hist_saldo(th_cuenta, th_oficina,  th_prom_act,   th_empresa,
                                 th_nombre, th_prom_ant, th_var_abs,    th_var_rel) 
   select hi_cuenta, je_oficina_padre,  isnull(avg(hi_saldo),0), @i_empresa,
                                    null,      null,        null,          null
   from    cob_conta_his..cb_hist_saldo, cob_conta..cb_oficina, cob_conta..cb_jerarquia
   where   of_empresa = @i_empresa
   and     of_oficina >= @i_oficina_i
   and     of_oficina <= @i_oficina_f
   and     of_organizacion = @i_nivel_of
   and     je_empresa = of_empresa
   and     je_oficina_padre = of_oficina  
   and     hi_corte >= @w_corte_i
   and     hi_corte <=  @w_corte_m
   and     hi_periodo = @w_periodo_i
   and     hi_oficina  = je_oficina
   and     hi_area >= 0
   and     hi_cuenta  >= @i_cuenta_i
   and     hi_cuenta  < @i_cuenta_f
   group   by je_oficina_padre,hi_empresa,hi_cuenta

   select  @w_fecha = dateadd(mm,-1, @i_fecha) 

   select  @w_corte_i = min(co_corte),
           @w_periodo_i = co_periodo
   from    cob_conta..cb_corte,cob_conta..cb_periodo
   where   co_empresa = convert(tinyint,@i_empresa)
   and     pe_empresa = convert(tinyint,@i_empresa)
   and     @w_fecha between pe_fecha_inicio and pe_fecha_fin
   and     co_periodo = pe_periodo
   and     datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha)
   group   by co_periodo

 -- CALCULO CORTE FINAL DEL MES
   select @w_corte_m = max(co_corte)
   from   cob_conta..cb_corte,cob_conta..cb_periodo
   where  co_empresa = convert(tinyint,@i_empresa)
   and    pe_empresa = convert(tinyint,@i_empresa)
   and    @w_fecha between pe_fecha_inicio and pe_fecha_fin
   and    co_periodo = pe_periodo
   and    datepart(mm,co_fecha_fin) = datepart(mm,@w_fecha)
   group  by co_periodo
   
-- INSERCION DE PROMEDIOS MES ANTERIOR
   insert into tmp_cb_hist_saldo2(ta_cuenta, ta_oficina, ta_prom_ant,   ta_empresa)
   select hi_cuenta, je_oficina_padre, isnull(avg(hi_saldo),0), @i_empresa
   from    cob_conta_his..cb_hist_saldo, cob_conta..cb_oficina, cob_conta..cb_jerarquia
   where   of_empresa = @i_empresa
   and     of_oficina >= @i_oficina_i
   and     of_oficina <= @i_oficina_f
   and     of_organizacion = @i_nivel_of
   and     je_empresa = of_empresa
   and     je_oficina_padre = of_oficina  
   and     hi_corte >= @w_corte_i
   and     hi_corte <=  @w_corte_m
   and     hi_periodo = @w_periodo_i
   and     hi_oficina  = je_oficina
   and     hi_area >=  0
   and     hi_cuenta  >= @i_cuenta_i
   and     hi_cuenta  < @i_cuenta_f
   group   by je_oficina_padre,hi_empresa,hi_cuenta

   update cob_conta..tmp_cb_hist_saldo
   set   th_nombre = cu_nombre
   from  cob_conta..cb_cuenta
   where cu_empresa = th_empresa
   and   cu_cuenta  = th_cuenta
   and   th_oficina > 0

   update cob_conta..tmp_cb_hist_saldo
   set   th_prom_ant = isnull(ta_prom_ant,0)
   from  cob_conta..tmp_cb_hist_saldo2
   where th_empresa = ta_empresa
   and   th_cuenta  = ta_cuenta
   and   th_oficina = ta_oficina
   and   th_oficina > 0

   update cob_conta..tmp_cb_hist_saldo
   set   th_var_abs = th_prom_act - th_prom_ant
   where th_oficina > 0
   and   th_empresa = @i_empresa
   and   th_cuenta  > ' ' 

   update cob_conta..tmp_cb_hist_saldo
   set   th_var_rel = (th_var_abs * 100) / th_prom_ant
   where th_oficina > 0
   and   th_empresa = @i_empresa
   and   th_cuenta > ' '
   and   th_prom_ant <> 0
commit tran
go