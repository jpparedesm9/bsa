/************************************************************************/
/*   Archivo:               balcc.sp                                    */
/*   Stored procedure:      sp_balcc                                    */
/*   Base de datos:         cob_conta                                   */
/*   Producto:              CONTABILIDAD                                */
/*   Disenado por:          Jose Orlando Forero.                        */
/*   Fecha de escritura:    26/Feb/2004                                 */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de             */
/*   "MACOSA".                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                        PROPOSITO                                     */
/*   Generar el reporte balace de prueba por oficina                    */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*   FECHA         AUTOR          RAZON                                 */
/*   8-Mar-04	D.    Ayala          Tuning                               */
/*   10-Jun-05      J. Quintero    Ajuste Parametros Rango de Ofici     */
/*                                       cinas, Cuentas y Fechas.       */
/*   14-Ago-06     Mauricio Rincon Impresion saldos con exponencial     */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_balcc')
	drop proc sp_balcc
go

create proc sp_balcc (
   @i_empresa     tinyint  = null,
   @i_fecha_ini   datetime = null,
   @i_fecha_fin   datetime = null,
   @i_nivelof     tinyint  = null,
   @i_oficina_ini smallint = null,
   @i_oficina_fin smallint = null,
   @i_cuenta_ini  cuenta   = null,
   @i_cuenta_fin  cuenta   = null,
   @i_cifras_dec  float    = 1000
)
as
declare @w_estado		char(1),
	@w_corte_inicial	int,
	@w_periodo_inicial	int,
	@w_corte_final		int,
	@w_cortefp		int,
	@w_periodo_final	int


/* LIMPIA LA TABLA TEMPORAL */
truncate table cb_balcc_tmp
truncate table cb_hist_saldo_tmp

/* ELIMINA EL INDICE DE LA TABLA TEMPORAL */
if exists (select name from sysindexes
where name = 'i_empresa_cuenta1_tmp')
begin
--	print 'dropea indice'
	drop index cb_hist_saldo_tmp.i_empresa_cuenta1_tmp
end

/* CALCULA EL PERIODO Y CORTE DE LA FECHA FINAL DEL REPORTE */
set transaction isolation level READ UNCOMMITTED
select	@w_corte_final   = co_corte,
	@w_periodo_final = co_periodo
from  cb_corte
where co_empresa = @i_empresa
and   co_periodo >= 0
and   co_corte >= 0
and   co_fecha_ini >= @i_fecha_fin
and   co_fecha_fin <= @i_fecha_fin

if @@rowcount = 0
begin
   print 'ERROR (1): Corte de la Fecha Final de reporte no encontrado'
   return 1
end

--A LA FECHA INICIAL LE QUITAMOS UN DIA

select  @i_fecha_ini = dateadd(dd,-1, @i_fecha_ini )

set transaction isolation level READ UNCOMMITTED
select	@w_corte_inicial   = co_corte,
	@w_periodo_inicial = co_periodo
from  cb_corte
where co_empresa = @i_empresa
and   co_periodo >= 0
and   co_corte >= 0
and   co_fecha_ini >= @i_fecha_ini
and   co_fecha_fin <= @i_fecha_ini

if @@rowcount = 0
begin
   print 'ERROR (2): Corte correspondiente a la Fecha Inicial del reporte no encontrado'
   return 1
end

/* DETERMINA SI EL CORTE CORRESPONDE A UN FIN DE PERIODO */
set transaction isolation level READ UNCOMMITTED
select @w_cortefp = max(co_corte)
from  cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_periodo = @w_periodo_inicial
and   co_corte   > 0

if @@rowcount = 0
begin
   print 'ERROR (3): Máximo corte para el período anterior no encontrado'
   return 1
end

--print '1'

/* DETERMINA EL CORTE ACTUAL DE CONTABILIDAD */
set transaction isolation level READ UNCOMMITTED
select @w_estado = co_estado
from  cb_corte
where co_empresa = @i_empresa
and   co_periodo = @w_periodo_final
and   co_corte   = @w_corte_final

if @@rowcount = 0
begin
   print 'ERROR (4): Estado del corte actual no encontrado'
   return 1
end

if @w_estado = 'A'
begin

        -- SALDOS FECHA INICIAL
	insert into cb_hist_saldo_tmp
	select A.* 

	from	cob_conta_his..cb_hist_saldo A,
		cb_cuenta, 
		cb_oficina, 
		cb_jerarquia

	where cu_empresa = @i_empresa
	and cu_cuenta > ''
	and je_empresa = @i_empresa  -- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
	and je_oficina > 0
	and je_oficina_padre > 0
	and je_nivel > 0
        and of_empresa = @i_empresa
	and of_oficina > 1
	and of_organizacion = @i_nivelof
	and cu_empresa = @i_empresa
	and hi_empresa = @i_empresa
	and hi_periodo = @w_periodo_inicial
	and hi_corte   = @w_corte_inicial
	and hi_oficina = je_oficina
	and hi_area > 0
	and hi_cuenta = cu_cuenta
	and of_oficina = je_oficina_padre
	and hi_empresa = je_empresa
	and hi_empresa = cu_empresa
	and hi_empresa = of_empresa
	and je_empresa = cu_empresa
	and je_empresa = of_empresa
	and of_empresa = cu_empresa
        and of_oficina >= @i_oficina_ini
        and of_oficina <= @i_oficina_fin
        and hi_cuenta  >= @i_cuenta_ini
        and hi_cuenta  <= @i_cuenta_fin

	if @@error <> 0
	begin
	   print 'ERROR (6): Error en insercion de saldos de periodo actual en tabla de trabajo temporal'
	   return 1
	end

end
else	--@w_estado = 'V', 'C'
begin

        -- SALDOS FECHA INICIAL
	insert into cb_hist_saldo_tmp
	select A.* 
	from	cob_conta_his..cb_hist_saldo A,
		cb_cuenta, 
		cb_oficina, 
		cb_jerarquia

	where cu_empresa = @i_empresa
	and cu_cuenta > ''
	and je_empresa = @i_empresa  -- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
	and je_oficina > 0
	and je_oficina_padre > 0
	and je_nivel > 0
        and of_empresa = @i_empresa
	and of_oficina > 1
	and of_organizacion = @i_nivelof
	and cu_empresa = @i_empresa
	and hi_empresa = @i_empresa
	and hi_periodo = @w_periodo_inicial
	and hi_corte   = @w_corte_inicial
	and hi_oficina = je_oficina
	and hi_area > 0
	and hi_cuenta = cu_cuenta
	and of_oficina = je_oficina_padre
	and hi_empresa = je_empresa
	and hi_empresa = cu_empresa
	and hi_empresa = of_empresa
	and je_empresa = cu_empresa
	and je_empresa = of_empresa
	and of_empresa = cu_empresa
        and of_oficina >= @i_oficina_ini
        and of_oficina <= @i_oficina_fin
        and hi_cuenta  >= @i_cuenta_ini
        and hi_cuenta  <= @i_cuenta_fin
        
	if @@error <> 0
	begin
	   print 'ERROR (7): Error en insercion de saldos del periodo anterior en tabla de trabajo temporal'
	   return 1
	end

        -- SALDOS FECHA FINAL

	insert into cb_hist_saldo_tmp
	select A.* 
	from	cob_conta_his..cb_hist_saldo A,
		cb_cuenta, 
		cb_oficina, 
		cb_jerarquia

	where cu_empresa = @i_empresa
	and cu_cuenta > ''
	and je_empresa = @i_empresa  -- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
	and je_oficina > 0
	and je_oficina_padre > 0
	and je_nivel > 0
        and of_empresa = @i_empresa
	and of_oficina > 1
	and of_organizacion = @i_nivelof
	and cu_empresa = @i_empresa
	and hi_empresa = @i_empresa
	and hi_periodo = @w_periodo_final
	and hi_corte   = @w_corte_final 
	and hi_oficina = je_oficina
	and hi_area > 0
	and hi_cuenta = cu_cuenta
	and of_oficina = je_oficina_padre
	and hi_empresa = je_empresa
	and hi_empresa = cu_empresa
	and hi_empresa = of_empresa
	and je_empresa = cu_empresa
	and je_empresa = of_empresa
	and of_empresa = cu_empresa
        and of_oficina >= @i_oficina_ini
        and of_oficina <= @i_oficina_fin
        and hi_cuenta  >= @i_cuenta_ini
        and hi_cuenta  <= @i_cuenta_fin 

	if @@error <> 0
	begin
	   print 'ERROR (8): Error en insercion de saldos del periodo actual en tabla de trabajo temporal. (Hist)'
	   return 1
	end
end

--print '2'
CREATE INDEX i_empresa_cuenta1_tmp
ON cb_hist_saldo_tmp(hi_empresa, hi_periodo, hi_corte, hi_cuenta, hi_oficina, hi_area)

if @@error <> 0
begin
   print 'ERROR (9): Error en la creacion del Indice en tabla de trabajo temporal'
   return 1
end

--print '3'

--print '@w_estado .............. %1! ',@w_estado

if @w_estado = 'A'
begin
--print '3.1'
       -- SALDOS FECHA FINAL
	/* SELECCION. CALCULA LOS SALDOS DEL CORTE ACTUAL */
	/* Y LOS INSERTA EN UNA TABLA TEMPORAL */
	insert into cb_balcc_tmp
	(bp_empresa, bp_periodo, bp_corte, bp_oficina,
	bp_cuenta, bp_cuenta_padre, bp_nombre,
	bp_moneda, bp_movimiento, bp_nivel_cuenta, bp_categoria, bp_sum_saldo, bp_sum_debito,
	bp_sum_credito, bp_sum_saldo_me, bp_sum_debito_me, bp_sum_credito_me)
	select @i_empresa, @w_periodo_final, @w_corte_final, of_oficina,
	cu_cuenta, cu_cuenta_padre, cu_nombre,
	cu_moneda, cu_movimiento, cu_nivel_cuenta, cu_categoria, convert(float,(ISNULL(sum(sa_saldo),0))), 
        convert(float,(ISNULL(sum(sa_debito),0))), convert(float,(ISNULL(sum(sa_credito),0))), 
        convert(float,(ISNULL(sum(sa_saldo_me),0))), convert(float,(ISNULL(sum(sa_debito_me),0))), 
        convert(float,(ISNULL(sum(sa_credito_me),0)))
	from	cb_saldo, 
		cb_cuenta, 
		cb_oficina, 
		cb_jerarquia

	where cu_empresa = @i_empresa
	and cu_cuenta > ''
	and je_empresa = @i_empresa	-- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
	and je_oficina > 0
	and je_oficina_padre > 0
	and je_nivel > 0
        and of_empresa = @i_empresa
	and of_oficina > 0
	and of_organizacion = @i_nivelof
	and cu_empresa = @i_empresa
        and sa_empresa = @i_empresa
	and sa_periodo = @w_periodo_final
	and sa_corte = @w_corte_final
	and sa_area >= 0
	and sa_oficina = je_oficina
	and sa_cuenta = cu_cuenta
	and of_oficina = je_oficina_padre
	and sa_empresa = je_empresa
	and sa_empresa = cu_empresa
	and sa_empresa = of_empresa
	and je_empresa = cu_empresa
	and je_empresa = of_empresa
        and of_empresa = cu_empresa
        and of_oficina >= @i_oficina_ini
        and of_oficina <= @i_oficina_fin
        and sa_cuenta  >= @i_cuenta_ini
        and sa_cuenta  <= @i_cuenta_fin
	group by of_oficina,cu_cuenta,cu_nombre,cu_nivel_cuenta,cu_categoria,cu_cuenta_padre,cu_moneda,cu_movimiento
	order by of_oficina,cu_cuenta

	if @@error <> 0
	begin
	   print 'ERROR (10): En insercion de resumen de saldos del periodo actual en tabla temporal para reporte'
	   return 1
	end
end
else	--@w_estado = 'V', 'C'
begin
--print '3.2'
       -- SALDOS FECHA FINAL
	/* SELECCION ANTES. CALCULA LOS SALDOS DEL CORTE ANTERIOR */
	/* Y LOS INSERTA EN UNA TABLA TEMPORAL */
	insert into cb_balcc_tmp
	(bp_empresa, bp_periodo, bp_corte, bp_oficina,
	bp_cuenta, bp_cuenta_padre, bp_nombre,
	bp_moneda, bp_movimiento, bp_nivel_cuenta, bp_categoria, bp_sum_saldo, bp_sum_debito,
	bp_sum_credito, bp_sum_saldo_me, bp_sum_debito_me, bp_sum_credito_me)

	select @i_empresa, @w_periodo_final, @w_corte_final, of_oficina,
	cu_cuenta, cu_cuenta_padre, cu_nombre,
	cu_moneda, cu_movimiento, cu_nivel_cuenta, cu_categoria, convert(float,(ISNULL(sum(hi_saldo),0))),
        convert(float,(ISNULL(sum(hi_debito),0))), convert(float,(ISNULL(sum(hi_credito),0))),
        convert(float,(ISNULL(sum(hi_saldo_me),0))), convert(float,(ISNULL(sum(hi_debito_me),0))), 
        convert(float,(ISNULL(sum(hi_credito_me),0)))

	from  cb_hist_saldo_tmp, cb_cuenta, cb_oficina, cb_jerarquia

	where cu_empresa = @i_empresa
	and cu_cuenta > ''
	and je_empresa = @i_empresa	-- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
	and je_oficina > 0
	and je_oficina_padre > 0
	and je_nivel > 0
        and of_empresa = @i_empresa
	and of_oficina > 0
	and of_organizacion = @i_nivelof
	and cu_empresa = @i_empresa
        and hi_empresa = @i_empresa
	and hi_periodo = @w_periodo_final
	and hi_corte = @w_corte_final
	and hi_area >= 0
	and hi_oficina = je_oficina
	and hi_cuenta = cu_cuenta
	and of_oficina = je_oficina_padre
	and hi_empresa = je_empresa
	and hi_empresa = cu_empresa
	and hi_empresa = of_empresa
	and je_empresa = cu_empresa
	and je_empresa = of_empresa
        and of_empresa = cu_empresa
        and of_oficina >= @i_oficina_ini
        and of_oficina <= @i_oficina_fin
        and hi_cuenta  >= @i_cuenta_ini
        and hi_cuenta  <= @i_cuenta_fin
	group by of_oficina,cu_cuenta,cu_nombre,cu_nivel_cuenta,cu_categoria,cu_cuenta_padre,cu_moneda,cu_movimiento
	order by of_oficina,cu_cuenta

	if @@error <> 0
	begin
	   print 'ERROR (11): En insercion de resumen de saldos del periodo actual en tabla temporal para reporte'
	   return 1
	end
end

if @w_cortefp = @w_corte_inicial
begin
-- SALDOS FECHA INICIAL
--Seleccion_antes_fp
   select @w_corte_inicial = @w_corte_inicial + 1
   
   while 1 = 1 begin
      set rowcount 10000
      
      delete cb_saldo_fp
      if @@rowcount = 0 begin
         set rowcount 0
         break
      end
   end
   
   insert into cb_saldo_fp (
   sf_empresa,   sf_cuenta,    sf_oficina,
   sf_area,      sf_corte,     sf_periodo,
   sf_saldo,     sf_saldo_me,  sf_debito,
   sf_credito,   sf_debito_me, sf_credito_me)
   select 
   hi_empresa,   hi_cuenta,    hi_oficina,
   hi_area,      hi_corte,     hi_periodo,
   hi_saldo,     hi_saldo_me,  hi_debito,
   hi_credito,   hi_debito_me, hi_credito_me
   from	cob_conta_his..cb_hist_saldo A,
        cb_cuenta, 
        cb_oficina, 
        cb_jerarquia
   where cu_empresa     = @i_empresa
   and cu_cuenta        > ''
   and je_empresa       = @i_empresa  -- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
   and je_oficina       > 0
   and je_oficina_padre > 0
   and je_nivel         > 0
   and of_empresa       = @i_empresa
   and of_oficina       > 1
   and of_organizacion  = @i_nivelof
   and cu_empresa       = @i_empresa
   and hi_empresa       = @i_empresa
   and hi_periodo       = @w_periodo_inicial
   and hi_corte         = @w_corte_inicial 
   and hi_oficina       = je_oficina
   and hi_area          > 0
   and hi_cuenta        = cu_cuenta
   and of_oficina       = je_oficina_padre
   and hi_empresa       = je_empresa
   and hi_empresa       = cu_empresa
   and hi_empresa       = of_empresa
   and je_empresa       = cu_empresa
   and je_empresa       = of_empresa
   and of_empresa       = cu_empresa
   and of_oficina      >= @i_oficina_ini
   and of_oficina      <= @i_oficina_fin
   and hi_cuenta       >= @i_cuenta_ini
   and hi_cuenta       <= @i_cuenta_fin 
	if @@error <> 0
	begin
	   print 'ERROR (12.0): En carga de tabla cb_saldo_fp para actualizacion de saldos anteriores en tabla temporal para reporte'
	   return 1
	end

   select	
   'tmp_oficina' = of_oficina,
   'tmp_cuenta' = cu_cuenta,
   'tmp_nombre' = cu_nombre,
   'tmp_nivel_cuenta' = cu_nivel_cuenta,
   'tmp_categoria' = cu_categoria,
   'tmp_cuenta_padre' = cu_cuenta_padre,
   'tmp_moneda' = cu_moneda,
   'tmp_movimiento' = cu_movimiento,
   'tmp_saldo' = convert(float,(ISNULL(sum(sf_saldo/@i_cifras_dec),0))),
   'tmp_debito' = convert(float,(ISNULL(sum(sf_debito/@i_cifras_dec),0))),
   'tmp_credito' = convert(float,(ISNULL(sum(sf_credito/@i_cifras_dec),0))),
   'tmp_saldo_me' = convert(float,(ISNULL(sum(sf_saldo_me/@i_cifras_dec),0))),
   'tmp_debito_me' = convert(float,(ISNULL(sum(sf_debito_me/@i_cifras_dec),0))),
   'tmp_credito_me' = convert(float,(ISNULL(sum(sf_credito_me/@i_cifras_dec),0))) into #temp
   from  cb_saldo_fp, cb_cuenta, cb_oficina, cb_jerarquia
   where cu_empresa = @i_empresa
   and cu_cuenta > ''
   and je_empresa = @i_empresa	-- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
   and je_oficina > 0
   and je_oficina_padre > 0
   and je_nivel > 0
   and of_empresa = @i_empresa
   and of_oficina > 0
   and of_organizacion = @i_nivelof
   and cu_empresa = @i_empresa
   and sf_empresa = @i_empresa
   and sf_periodo = @w_periodo_inicial
   and sf_corte   = @w_corte_inicial
   and sf_area >= 0
   and sf_oficina = je_oficina
   and sf_cuenta = cu_cuenta
   and of_oficina = je_oficina_padre
   and sf_empresa = je_empresa
   and sf_empresa = cu_empresa
   and sf_empresa = of_empresa
   and je_empresa = cu_empresa
   and je_empresa = of_empresa
   and of_empresa = cu_empresa
   and of_oficina >= @i_oficina_ini
   and of_oficina <= @i_oficina_fin
   and sf_cuenta  >= @i_cuenta_ini
   and sf_cuenta  <= @i_cuenta_fin
   group by of_oficina,cu_cuenta,cu_nombre,cu_nivel_cuenta,cu_categoria,cu_cuenta_padre,cu_moneda,cu_movimiento
   order by of_oficina,cu_cuenta

   if @@error <> 0
   begin
      print 'ERROR (12): En creacion y carga de tabla #temporal para actualizacion de saldos anteriores en tabla temporal para reporte'
      return 1
   end

   update cb_balcc_tmp   set
   bp_sum_saldo_ant      = convert(float,(ISNULL(tmp_saldo,0))),
   bp_sum_debito_ant     = convert(float,(ISNULL(bp_sum_debito/@i_cifras_dec,0)))     -  convert(float,(ISNULL(tmp_debito,0))),
   bp_sum_credito_ant    = convert(float,(ISNULL(bp_sum_credito/@i_cifras_dec,0)))    -  convert(float,(ISNULL(tmp_credito,0))),
   bp_sum_saldo_me_ant   = convert(float,(ISNULL(tmp_saldo_me,0))),
   bp_sum_debito_me_ant  = convert(float,(ISNULL(bp_sum_debito_me/@i_cifras_dec,0)))  -  convert(float,(ISNULL(tmp_debito_me,0))),
   bp_sum_credito_me_ant = convert(float,(ISNULL(bp_sum_credito_me/@i_cifras_dec,0))) -  convert(float,(ISNULL(tmp_credito_me,0)))
   from cb_balcc_tmp
      left outer join #temp on 
   bp_cuenta           = tmp_cuenta
   and bp_oficina      = tmp_oficina
   and bp_nivel_cuenta = tmp_nivel_cuenta 
   and bp_categoria    = tmp_categoria
   and isnull(bp_cuenta_padre, '') = isnull(tmp_cuenta_padre, '')
   and bp_moneda       = tmp_moneda 
   and bp_movimiento   = tmp_movimiento
   where bp_empresa   = @i_empresa

   if @@error <> 0
   begin
      print 'ERROR (13): En actualizacion de saldos anteriores en tabla temporal para reporte'
      return 1
   end
end
else
begin
--Seleccion_antes_his
  -- SALDOS FECHA INICIAL
	select	'tmp_oficina' = of_oficina,
		'tmp_cuenta' = cu_cuenta,
		'tmp_nombre' = cu_nombre,
		'tmp_nivel_cuenta' = cu_nivel_cuenta,
		'tmp_categoria' = cu_categoria,
		'tmp_cuenta_padre' = cu_cuenta_padre,
		'tmp_moneda' = cu_moneda,
		'tmp_movimiento' = cu_movimiento,
		'tmp_saldo' = convert(float,(ISNULL(sum(hi_saldo/@i_cifras_dec),0))),
		'tmp_debito' = convert(float,(ISNULL(sum(hi_debito/@i_cifras_dec),0))),
		'tmp_credito' = convert(float,(ISNULL(sum(hi_credito/@i_cifras_dec),0))),
		'tmp_saldo_me' = convert(float,(ISNULL(sum(hi_saldo_me/@i_cifras_dec),0))),
		'tmp_debito_me' = convert(float,(ISNULL(sum(hi_debito_me/@i_cifras_dec),0))),
		'tmp_credito_me' = convert(float,(ISNULL(sum(hi_credito_me/@i_cifras_dec),0))) into #temp1
	from  cb_hist_saldo_tmp, cb_cuenta, cb_oficina, cb_jerarquia

	where cu_empresa = @i_empresa
	and cu_cuenta > ''
	and je_empresa = @i_empresa	-- NO SE CONSIDERAN MAS CONDICIONES PARA ESTA TABLA
	and je_oficina > 0
	and je_oficina_padre > 0
	and je_nivel > 0
        and of_empresa = @i_empresa
	and of_oficina > 0
	and of_organizacion = @i_nivelof
	and cu_empresa = @i_empresa
        and hi_empresa = @i_empresa
	and hi_periodo = @w_periodo_inicial
	and hi_corte = @w_corte_inicial
	and hi_area >= 0
	and hi_oficina = je_oficina
	and hi_cuenta = cu_cuenta
	and of_oficina = je_oficina_padre
	and hi_empresa = je_empresa
	and hi_empresa = cu_empresa
	and hi_empresa = of_empresa
	and je_empresa = cu_empresa
	and je_empresa = of_empresa
        and of_empresa = cu_empresa
        and of_oficina >= @i_oficina_ini
        and of_oficina <= @i_oficina_fin
        and hi_cuenta  >= @i_cuenta_ini
        and hi_cuenta  <= @i_cuenta_fin
	group by of_oficina,cu_cuenta,cu_nombre,cu_nivel_cuenta,cu_categoria,cu_cuenta_padre,cu_moneda,cu_movimiento
	order by of_oficina,cu_cuenta

	if @@error <> 0
	begin
	   print 'ERROR (14): En creacion y carga de tabla #temporal para actualizacion de saldos anteriores en tabla temporal para reporte'
	   return 1
	end
	update cb_balcc_tmp   set
	bp_sum_saldo_ant      = convert(float,(ISNULL(tmp_saldo,0))),
	bp_sum_debito_ant     = convert(float,(ISNULL(bp_sum_debito/@i_cifras_dec,0)))     -  convert(float,(ISNULL(tmp_debito,0))),
	bp_sum_credito_ant    = convert(float,(ISNULL(bp_sum_credito/@i_cifras_dec,0)))    -  convert(float,(ISNULL(tmp_credito,0))),
	bp_sum_saldo_me_ant   = convert(float,(ISNULL(tmp_saldo_me,0))),
	bp_sum_debito_me_ant  = convert(float,(ISNULL(bp_sum_debito_me/@i_cifras_dec,0)))  -  convert(float,(ISNULL(tmp_debito_me,0))),
	bp_sum_credito_me_ant = convert(float,(ISNULL(bp_sum_credito_me/@i_cifras_dec,0))) -  convert(float,(ISNULL(tmp_credito_me,0)))
	from cb_balcc_tmp
	left outer join #temp1 on
	bp_cuenta       = tmp_cuenta
	and bp_oficina      = tmp_oficina
	and bp_nivel_cuenta = tmp_nivel_cuenta 
	and bp_categoria    = tmp_categoria
	and isnull(bp_cuenta_padre, '') = isnull(tmp_cuenta_padre, '')
	and bp_moneda       = tmp_moneda 
	and bp_movimiento   = tmp_movimiento
	where bp_empresa    = @i_empresa

	if @@error <> 0
	begin
	   print 'ERROR (15): En actualizacion de saldos anteriores en tabla temporal para reporte'
	   return 1
	end
end
--print '5'

/* REQ 271 EXCLUIR CUENTAS CANCELADAS COMPLETAMENTE */
update cb_balcc_tmp set
bp_cuenta = '0' 
from  cb_balcc_tmp, cb_cuenta
where bp_cuenta = cu_cuenta
and cu_estado = 'C'
and round(bp_sum_saldo,4) = 0 
and round(bp_sum_saldo,4) = round((bp_sum_saldo_ant*@i_cifras_dec),4)
and (round(bp_sum_debito,4) - round(bp_sum_debito_ant,4)) = 0
and (round(bp_sum_credito,4) - round(bp_sum_credito_ant,4)) = 0
if @@error <> 0
begin
   print 'ERROR (16): Identificando cuentas canceladas a eliminar del reporte'
   return 1
end

delete from cb_balcc_tmp where bp_cuenta = '0'
if @@error <> 0 begin
   print 'ERROR (17): En eliminacion de cuentas canceladas del reporte'
   return 1
end

return 0

go

