/************************************************************************/
/*      Archivo:                actgrpal.sp                             */
/*      Stored procedure:       sp_actualiza_grupal                     */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           LCA                                     */
/*      Fecha de escritura:     Feb/2005                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Copia los datos de una operacion grupal de sus operaciones      */
/*      individuales a la temporal grupal                               */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    21/Feb/05             LCA              Emision Inicial            */
/*    11/Abr/17             M.Custode        cambio a las nuevas tablas */
/*                                           de grupales o suma de      */
/*                                           interciclos                */
/*    08/Ago/2019           M.Taco           Caso 113432 optimizacion   */
/************************************************************************/
use cob_cartera
go
if exists (select 1 from sysobjects where name = 'sp_actualiza_grupal')
    drop proc sp_actualiza_grupal
go
create proc sp_actualiza_grupal
        @i_banco             cuenta  = null,       --cuenta grupal padre
        @i_tramite           int     = null,       --cuenta grupal padre
        @i_desde_cca         char(1) = null --Bandera en el cual indica si trabaja en tablas tmp o definitivas
as
declare @w_operacionca       int,
        @w_error             int,
        @w_sp_name           descripcion,
        @w_monto             money,
        @w_sector            varchar(10),
        @w_subsegmento       varchar(10),
        @w_saldo             money,
        @w_cliente           int,
        @w_creditos          smallint,
        @w_estado_grupal     tinyint,
        @w_div               smallint,
        @w_fecha_ven         date,
        @w_dividendo         int

DECLARE
@w_op_monto          money,
@w_op_cuota          money,
@w_op_monto_aprobado money,
@w_op_fecha_ini      datetime,
@w_op_fecha_liq      datetime,
@w_op_fecha_fin      datetime,
@w_op_fecha_ult_proceso datetime,
@w_op_oficina        int


-- Validacion
if @i_banco is null
begin
   select @i_banco = op_banco 
   from cob_cartera..ca_operacion
   where op_tramite = @i_tramite
end
-- LGU: para que procese solo si es una Grupal y tiene al menos una operacion hija activa
if exists (select 1 from cob_credito..cr_tramite_grupal
     where tg_referencia_grupal = @i_banco) 
     --and exists (select 1 from cob_credito..cr_tramite_grupal, ca_operacion
     --where tg_referencia_grupal = @i_banco
     --and tg_operacion = op_operacion
	 --and tg_prestamo <> tg_referencia_grupal
     --and tg_monto > 0
     --and op_estado != 3)
begin
    create table #TMP_dividendo (
        di_operacion   int,
        di_dividendo   int,
        div_padre      int,
        di_estado      int,
        tipo           char(1))

--tramites grupales normales
     insert into #TMP_dividendo
     (di_operacion,     di_dividendo,  div_padre,                   di_estado,  tipo)
      select
      di_operacion,      di_dividendo,  'div_padre' = di_dividendo,  di_estado,  tg_grupal
      from cob_cartera..ca_dividendo, cob_credito..cr_tramite_grupal
      where tg_referencia_grupal = @i_banco     --papa
      and di_operacion = tg_operacion
      and tg_grupal = 'S'
      and convert(varchar, tg_operacion) <> tg_prestamo
	  and tg_monto > 0
	  and tg_participa_ciclo = 'S'
      order by di_operacion, di_dividendo

     --tramites grupales emergentes o interciclos
     select H.op_operacion, di_dividendo, 'desplazar' = di_dividendo -1, tg_grupal
     into #tmp1
     from cob_cartera..ca_dividendo, cob_credito..cr_tramite_grupal, cob_cartera..ca_operacion H, cob_cartera..ca_operacion P
     where tg_referencia_grupal = @i_banco     --papa
	 and convert(int, tg_prestamo ) <> tg_operacion
	 and tg_monto > 0
	 and tg_participa_ciclo = 'S'
     and tg_referencia_grupal  = P.op_banco
     and di_operacion = P.op_operacion
     and tg_operacion = H.op_operacion
     and tg_grupal = 'N'
     and H.op_fecha_ini between di_fecha_ini and di_fecha_ven


     --duplicacion de fechas
     select top 1 @w_operacionca= op_operacion from #tmp1 where desplazar > 0 order by 1 asc
     while 1=1
     begin
       select @w_dividendo = max(di_dividendo) from #tmp1 where desplazar > 0 and op_operacion = @w_operacionca
       delete #tmp1 where desplazar > 0 and op_operacion = @w_operacionca and di_dividendo > 0 and di_dividendo < @w_dividendo

       select top 1 @w_operacionca = op_operacion from #tmp1 where desplazar > 0 and op_operacion > @w_operacionca
       if @@rowcount = 0
          break
     end

     select top 1 @w_operacionca = op_operacion from #tmp1
     group by op_operacion
     having count(op_operacion) > 1
     while 1=1
     begin
       select  @w_dividendo = max(di_dividendo) from #tmp1 where op_operacion = @w_operacionca
       delete #tmp1 where op_operacion = @w_operacionca and di_dividendo < @w_dividendo

       select top 1 @w_operacionca = op_operacion from #tmp1
       where op_operacion > @w_operacionca
       group by op_operacion
       having count(op_operacion) > 1
       if @@rowcount = 0
          break
     end

     insert into #TMP_dividendo
     (di_operacion,     di_dividendo,    div_padre,                                 di_estado,  tipo)
     select
      di_operacion,     d.di_dividendo, 'div_padre' = d.di_dividendo + desplazar,   di_estado,  'tipo' = 'N'
     from cob_cartera..ca_dividendo d, #tmp1 t
     where di_operacion = op_operacion
     order by di_operacion, di_dividendo

     drop table #tmp1

   if @i_desde_cca <> 'N'
   begin    --inicio @i_desde_cca <> 'N'
      if exists (select 1 from cob_credito..cr_tramite_grupal where tg_referencia_grupal = @i_banco)
      begin
      select @w_operacionca       = opt_operacion,
             @w_monto             = opt_monto,
             @w_sector            = opt_sector,
             @w_cliente           = opt_cliente
        from ca_operacion_tmp
       where opt_banco = @i_banco
      end else begin
         select @w_error = 710159
         goto ERROR
      end

      select @w_creditos = (select count(1) from ca_operacion, cob_credito..cr_tramite_grupal
                            where tg_operacion = op_operacion
                            and tg_referencia_grupal = @i_banco)

      update ca_operacion_tmp
         set opt_monto = (select sum(isnull(op_monto,0))
                            from ca_operacion, cob_credito..cr_tramite_grupal
                            where tg_operacion = op_operacion
                            and tg_referencia_grupal = @i_banco),
             opt_cuota = (select sum(isnull(op_cuota,0))
                            from ca_operacion , cob_credito..cr_tramite_grupal
                            where tg_operacion = op_operacion
                              and tg_referencia_grupal = @i_banco),
             opt_monto_aprobado = (select sum(isnull(op_monto_aprobado,0))
                            from ca_operacion , cob_credito..cr_tramite_grupal
                            where tg_operacion = op_operacion
                              and tg_referencia_grupal = @i_banco)
       where opt_operacion = @w_operacionca

      if @@error <> 0 begin
         select @w_error = 710002
         goto ERROR
      end

      select @w_monto = isnull(opt_monto,@w_monto)
        from ca_operacion_tmp
       where opt_operacion =  @w_operacionca


      select @w_div = 0
      while 1=1 begin
         set rowcount 1
         select @w_div = dit_dividendo
           from ca_dividendo_tmp
          where dit_operacion = @w_operacionca
            and dit_dividendo > @w_div
         order by dit_dividendo

         if @@rowcount = 0 begin
            set rowcount 0
            break
         end
         set rowcount 0

         if (select count(1) from #TMP_dividendo, cob_credito..cr_tramite_grupal
                     where di_operacion = tg_operacion
                       and div_padre = @w_div
                       and tg_referencia_grupal = @i_banco) = @w_creditos

         if (select count(1) from #TMP_dividendo, cob_credito..cr_tramite_grupal
                     where di_operacion = tg_operacion
                       and div_padre = @w_div
                       and di_estado    = 3    ----estado CANCELADO
                       and tg_referencia_grupal = @i_banco) = @w_creditos
            select @w_estado_grupal = 3
         else
            if exists (select 1 from #TMP_dividendo, cob_credito..cr_tramite_grupal
                        where di_operacion = tg_operacion
                          and div_padre = @w_div
                          and di_estado    = 2 ----estado VENCIDO
                          and tg_referencia_grupal = @i_banco)
               select @w_estado_grupal = 2
            else
               if exists (select 1 from #TMP_dividendo, cob_credito..cr_tramite_grupal
                           where di_operacion = tg_operacion
                             and div_padre = @w_div
                             and di_estado    = 1  ----estado VIGENTE
                             and tg_referencia_grupal = @i_banco) and
                  not exists (select 1 from #TMP_dividendo
                           where di_operacion = @w_operacionca
                             and div_padre < @w_div
                             and di_estado    = 1)
                  select @w_estado_grupal = 1
               else select @w_estado_grupal = 0

         update ca_dividendo_tmp
         set    dit_estado = @w_estado_grupal
         where  dit_operacion = @w_operacionca
           and  dit_dividendo = @w_div
      end



      update ca_amortizacion_tmp
         set amt_acumulado   = --isnull((select sum(isnull(A.am_acumulado)),0
                                 isnull((select sum(isnull(am_acumulado,0))
                                  from ca_amortizacion_tmp A, cob_credito..cr_tramite_grupal, #TMP_dividendo T
                                 where tg_referencia_grupal = @i_banco
                                   and A.amt_operacion > @w_operacionca
                                   and A.amt_operacion = tg_operacion
                                   and A.amt_operacion = T.di_operacion
                                   and A.amt_dividendo = T.di_dividendo
                                   and ca_amortizacion_tmp.amt_dividendo = T.div_padre
                                   and ca_amortizacion_tmp.amt_concepto  = A.amt_concepto
                                   and ca_amortizacion_tmp.amt_secuencia = A.amt_secuencia),0),
             amt_pagado      = isnull((select sum(isnull(am_pagado,0))
                                  from ca_amortizacion_tmp A, cob_credito..cr_tramite_grupal, #TMP_dividendo T
                                 where tg_referencia_grupal = @i_banco
                                   and A.amt_operacion > @w_operacionca
                                   and A.amt_operacion = tg_operacion
                                   and A.amt_operacion = T.di_operacion
                                   and A.amt_dividendo = T.di_dividendo
                                   and ca_amortizacion_tmp.amt_dividendo = T.div_padre
                                   and ca_amortizacion_tmp.amt_concepto  = A.amt_concepto
                                   and ca_amortizacion_tmp.amt_secuencia = A.amt_secuencia),0),
             amt_cuota       = isnull((select sum(isnull(am_cuota,0))
                                  from ca_amortizacion_tmp A, cob_credito..cr_tramite_grupal, #TMP_dividendo T
                                 where tg_referencia_grupal = @i_banco
                                   and A.amt_operacion > @w_operacionca
                                   and A.amt_operacion = tg_operacion
                                   and A.amt_operacion = T.di_operacion
                                   and A.amt_dividendo = T.di_dividendo
                                   and ca_amortizacion_tmp.amt_dividendo = T.div_padre
                                   and ca_amortizacion_tmp.amt_concepto  = A.amt_concepto
                                   and ca_amortizacion_tmp.amt_secuencia = A.amt_secuencia),0),
             /*amt_exponencial = isnull((select sum(isnull(am_exponencial,0))
                                  from ca_amortizacion_tmp A, cob_credito..cr_tramite_grupal, #TMP_dividendo T
                                 where tg_referencia_grupal = @i_banco
                                   and A.am_operacion  = tg_operacion
                                   and A.am_operacion = T.di_operacion
                                   and A.am_dividendo = T.di_dividendo
                                   and ca_amortizacion_tmp.am_dividendo = T.div_padre
                                   and ca_amortizacion_tmp.am_concepto  = A.am_concepto
                                   and ca_amortizacion_tmp.am_secuencia = A.am_secuencia),0),*/
             amt_gracia      = isnull((select sum(isnull(am_gracia,0))
                                  from ca_amortizacion_tmp A, cob_credito..cr_tramite_grupal, #TMP_dividendo T
                                 where tg_referencia_grupal = @i_banco
                                   and A.amt_operacion > @w_operacionca
                                   and A.amt_operacion = tg_operacion
                                   and A.amt_operacion = T.di_operacion
                                   and A.amt_dividendo = T.di_dividendo
                                   and ca_amortizacion_tmp.am_dividendo = T.div_padre
                                   and ca_amortizacion_tmp.am_concepto  = A.am_concepto
                                   and ca_amortizacion_tmp.am_secuencia = A.am_secuencia),0)
       where amt_operacion = @w_operacionca


      if @@error != 0 begin
         select @w_error = 710002
         goto ERROR
      end

      update ca_rubro_op_tmp
         set rot_valor = isnull((select sum(isnull(ro_valor,0))
                            from ca_rubro_op, cob_credito..cr_tramite_grupal
                           where tg_referencia_grupal = @i_banco
                             and ro_operacion  = tg_operacion
                             and ca_rubro_op_tmp.rot_concepto  = ro_concepto),0)
       where rot_operacion = @w_operacionca

      if @@error <> 0 begin
         select @w_error = 710002
         goto ERROR
      end
   end --fin @i_desde_cca <> 'N'
   ---///////////////////////////////////////////////////////////////////////////////////////////
   else
   begin
        PRINT 'Procesando operacion : ' + @i_banco
        
        select 
            @w_operacionca       = op_operacion,
            @w_monto             = op_monto,
            @w_sector            = op_sector,
            @w_cliente           = op_cliente
        from ca_operacion
        where op_banco = @i_banco
        
        IF @@ROWCOUNT = 0
        BEGIN 
            PRINT 'Esta operacion no existe ' + @i_banco
            RETURN 0
        END

		select  
	        @w_op_monto = sum(op_monto),
	        @w_op_cuota = sum(op_cuota),
	        @w_op_monto_aprobado = sum(op_monto_aprobado),
	        @w_op_fecha_ini = min(op_fecha_ini),
	        @w_op_fecha_liq = min(op_fecha_liq),
	        @w_op_fecha_fin = max(op_fecha_fin),
	        @w_op_fecha_ult_proceso = min(op_fecha_ult_proceso),
	        @w_op_oficina   = max(op_oficina)
 		from ca_operacion A ,cob_credito..cr_tramite_grupal
      where tg_referencia_grupal = @i_banco
	  and convert(varchar, tg_operacion) <> tg_prestamo
	  and tg_monto > 0
	  and tg_participa_ciclo = 'S'
      and op_operacion = tg_operacion
      and op_operacion <> @w_operacionca
                             
      update ca_operacion
         set op_monto             = isnull(@w_op_monto,            op_monto            ),
             op_cuota             = isnull(@w_op_cuota,            op_cuota            ),
             op_monto_aprobado    = isnull(@w_op_monto_aprobado,   op_monto_aprobado   ),
             op_fecha_ini         = isnull(@w_op_fecha_ini,        op_fecha_ini        ),
             op_fecha_liq         = isnull(@w_op_fecha_liq,        op_fecha_liq        ),
             op_fecha_fin         = isnull(@w_op_fecha_fin,        op_fecha_fin        ),
             op_fecha_ult_proceso = isnull(@w_op_fecha_ult_proceso,op_fecha_ult_proceso),
             op_oficina           = isnull(@w_op_oficina,op_oficina)
       where op_operacion = @w_operacionca

      if @@error != 0
      begin
         select @w_error = 710002
         goto ERROR
      end

		DELETE ca_dividendo WHERE di_operacion = @w_operacionca
		
		INSERT INTO ca_dividendo 
		select operacion  = @w_operacionca ,
		       dividendo  = di_dividendo,
		       fecha_ini  = min(di_fecha_ini),
		       fecha_ven  = max(di_fecha_ven),
				 de_capital = max(di_de_capital),
				 de_interes = max(di_de_interes),
				 gracia     = min(di_gracia),
				 gracia_dis = min(di_gracia_disp),
		       estado     = min(di_estado),
		       dias_cuota = max(di_dias_cuota),
		       intento    = max(di_intento),
		       prorroga   = max(di_prorroga),
		       fecha_can  = max(di_fecha_can)
		from ca_dividendo,cob_credito..cr_tramite_grupal
      where tg_referencia_grupal = @i_banco
	  and convert(varchar, tg_operacion) <> tg_prestamo
	  and tg_monto > 0
	  and tg_participa_ciclo = 'S'
      and di_operacion = tg_operacion
      and di_operacion <> @w_operacionca
	  group by di_dividendo

                             		
       if @@error <> 0 begin
         select @w_error = 710003
         goto ERROR
       end
          
		DELETE ca_amortizacion WHERE am_operacion = @w_operacionca

      /* INSERTO VALORES NO GENERADOS EN LA CREACION DE LA OPERACION */
      insert into ca_amortizacion
      (am_operacion,   am_dividendo,   am_concepto,    am_estado,          am_periodo,
       am_cuota,       am_gracia,      am_pagado,      am_acumulado,       am_secuencia)
      select 
       @w_operacionca,   am_dividendo,   am_concepto,     max(am_estado),     max(am_periodo),
       sum(am_cuota),  sum(am_gracia), sum(am_pagado),  sum(am_acumulado),  am_secuencia
        from ca_amortizacion, cob_credito..cr_tramite_grupal
      where tg_referencia_grupal = @i_banco
	  and convert(varchar, tg_operacion) <> tg_prestamo
	  and tg_monto > 0
	  and tg_participa_ciclo = 'S'
      and am_operacion = tg_operacion
      and am_operacion <> @w_operacionca
  	  GROUP BY am_dividendo, am_concepto, am_secuencia

       if @@error <> 0 begin
         select @w_error = 710004
         goto ERROR
       end

      insert into ca_rubro_op(
      ro_operacion,             ro_concepto,           ro_tipo_rubro,              ro_fpago,
      ro_prioridad,             ro_paga_mora,          ro_provisiona,              ro_signo,
      ro_factor,                ro_referencial,        ro_signo_reajuste,          ro_factor_reajuste,
      ro_referencial_reajuste,  ro_valor,              ro_porcentaje,              ro_gracia,
      ro_concepto_asociado,     ro_base_calculo,       ro_porcentaje_aux,          ro_principal,
      ro_garantia)
      select distinct
      @w_operacionca,           D.ro_concepto,         D.ro_tipo_rubro,            D.ro_fpago,
      D.ro_prioridad,           D.ro_paga_mora,        D.ro_provisiona,            D.ro_signo,
      D.ro_factor,              D.ro_referencial,      D.ro_signo_reajuste,        D.ro_factor_reajuste,
      D.ro_referencial_reajuste,0,                     D.ro_porcentaje,            D.ro_gracia,
      D.ro_concepto_asociado,   D.ro_base_calculo,     D.ro_porcentaje_aux,        D.ro_principal,
      D.ro_garantia
       from ca_rubro_op D, cob_credito..cr_tramite_grupal
       where tg_referencia_grupal = @i_banco
	   and convert(varchar, tg_operacion) <> tg_prestamo
	   and tg_monto > 0
	   and tg_participa_ciclo = 'S'
       and D.ro_operacion = tg_operacion
       and not exists (select 1 from ca_rubro_op A
                          where A.ro_operacion = @w_operacionca
                            and A.ro_concepto  = D.ro_concepto)
       and D.ro_fpago     in ('P','A','M')
       if @@error <> 0 begin
         select @w_error = 710005
         goto ERROR
       end


       select 'concepto' = ro_concepto, 'valor' = sum(ro_valor)
       into #tmpoperacion
       from ca_rubro_op A, cob_credito..cr_tramite_grupal
       where tg_referencia_grupal = @i_banco
	   and convert(varchar, tg_operacion) <> tg_prestamo
	   and tg_monto > 0
	   and tg_participa_ciclo = 'S'
       and ro_operacion  = tg_operacion
       and tg_monto  > 0
       group by ro_concepto

      update ca_rubro_op
         set ro_valor = valor
      from #tmpoperacion
       where ro_operacion = @w_operacionca
       and ro_concepto = concepto

      if @@error <> 0 begin
         select @w_error = 710006
         goto ERROR
      end
   end

end

return 0
ERROR:
return @w_error
go

