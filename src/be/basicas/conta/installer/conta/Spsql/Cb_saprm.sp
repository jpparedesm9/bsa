/************************************************************************/
/*      Archivo           :  cb_saprm.sqr                               */
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
/*      Emite listados de promedios mensuales para un nùmero de meses   */
/*      realizando antes un promedio diario por cada mes, tomando las   */
/*      fechas ingresadas por parametro,                                */
/*                                                                      */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*						                        */
/*      FECHA                AUTOR                 RAZON                */
/*   06/05/2005     José Rafael Molano Zorro       Emision Inicial      */
/************************************************************************/

use cob_conta
go 

if exists (select * from sysobjects where name = 'tmp_cb_saldo_promm')
   drop table tmp_cb_saldo_promm
go

create table tmp_cb_saldo_promm
( sp_empresa           tinyint        null,
   sp_cuenta           cuenta 	      null,
   sp_oficina          smallint       null,
   sp_nombre           varchar(80)    null,
   sp_corte_ini        int            null,
   sp_corte_fin        int            null,
   sp_saldo_prom       money	      null,
   sp_saldo_prom_me    money	      null
)
--lock datarows
go

create nonclustered index tmp_cb_saldo_promm on tmp_cb_saldo_promm(sp_oficina, sp_cuenta)
go

if exists(select * from cob_conta..sysobjects where name = 'sp_promedios_mensuales')
   drop proc sp_promedios_mensuales
go

create proc sp_promedios_mensuales(

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
   @i_empresa             tinyint,
   @i_nivel_of            int,
   @i_oficina_i           smallint,
   @i_oficina_f           smallint,
   @i_fecha_i             datetime,
   @i_fecha_f             datetime,
   @i_corte_ini           int,
   @i_corte_fin           int,
   @i_cuenta_i            cuenta,
   @i_cuenta_f            cuenta

)

as

declare
   @w_empresa      tinyint,
   @w_nivel_of     int,
   @w_oficina_i    smallint,
   @w_oficina_f    smallint,
   @w_fecha_i      datetime,
   @w_fecha_f      datetime,
   @w_sp_name      varchar,
   @w_corte_m      smallint,
   @w_corte_f      smallint,
   @w_corte_i      smallint,
   @w_periodo_i    smallint,
   @w_fecha        datetime,
   @w_meses        int,
   @w_contador     int,
   @w_anio_i       char(4),
   @w_mes_i	     char(2),
   @w_cuenta       cuenta_contable,
   @w_oficina      smallint,
   @w_saldo        money,
   @w_nombre       descripcion
   
select @w_sp_name = 'sp_promedios_mensuales'   

truncate table cob_conta..tmp_cb_saldo_promm

select @w_fecha = @i_fecha_i
select @w_sp_name = 'sp_promedios_mensuales'

-- VALIDACION FECHA INICIAL NO PUEDE SER MAYOR A FECHA FINAL
if @i_fecha_i > @i_fecha_f
begin
   print 'Fecha inicial mayor a fecha final'
   return 1
end

-- NUMERO DE MESES 
select @w_meses = (datediff(mm,@i_fecha_i,@i_fecha_f)) + 1

-- ASIGNACION DE NUMERO DE MESES AL CONTADOR DEL CICLO
select @w_contador = @w_meses

-- ASIGNACION FECHA INICIAL A FECHA DEL CICLO
select @w_fecha = @i_fecha_i

-- CICLO CALCULO CORTES E INSERCION DE PROMEDIOS MENSUALES
while @w_contador > 0
begin
-- CALCULO CORTE INICIAL DEL MES
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

-- INSERCION DE PROMEDIOS MENSUALES
   insert  into cob_conta..tmp_cb_saldo_promm
   select  hi_empresa,hi_cuenta,je_oficina_padre,'NO NAME',
           @w_corte_i,    @w_corte_m,      avg(hi_saldo),avg(hi_saldo_me)
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


-- SIGUIENTE MES A PROCESAR
   select  @w_fecha = dateadd(mm, +1, @w_fecha)

-- DECREMENTO CONTADOR
   select @w_contador = @w_contador - 1

end  -- FIN WHILE CONTADOR

-- INSERCION SALDO PROMEDIO DE LOS MESES PROCESADOS
insert into cob_conta..tmp_cb_saldo_promm
select sp_empresa, sp_cuenta, sp_oficina, sp_nombre, 999, 999, avg(sp_saldo_prom),avg(sp_saldo_prom_me)
from   cob_conta..tmp_cb_saldo_promm
group  BY sp_empresa, sp_cuenta, sp_oficina, sp_nombre

-- ACTUALIZACION NOMBRE DE LA CUENTA
update cob_conta..tmp_cb_saldo_promm
set sp_nombre = cu_nombre
from cob_conta..cb_cuenta
where cu_empresa = convert(tinyint,@i_empresa)
and   sp_empresa = cu_empresa
and   sp_cuenta  = cu_cuenta
and   sp_cuenta > ' '
and   sp_oficina >= 0
and   sp_corte_ini = 999

delete cob_conta..tmp_cb_saldo_promm
where sp_nombre = 'NO NAME'
return
go