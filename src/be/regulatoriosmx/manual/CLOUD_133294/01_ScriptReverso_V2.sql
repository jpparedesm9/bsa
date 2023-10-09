use cob_conta
go

declare @w_comprobante     int,
        @w_comprobante_new int,
        @w_error           int,
        @w_fecha_ing_comp  datetime,
        @w_reg_comprobante int
        

select *
into #asientos_reversar
from cob_conta..cb_comprobante
where co_empresa = 1
and co_fecha_tran = '01/01/2020'
and co_reversado  ='N'
and co_descripcion like 'Asiento%'

select *
into #comprobantes
from cob_conta..cb_comprobante
where co_empresa = 1
and co_fecha_tran = '01/01/2020'
and co_reversado  = 'N'
and co_descripcion like 'Asiento%'

select *
into #asientos
from cob_conta..cb_asiento
where as_empresa = 1
and as_fecha_tran = '01/01/2020'
and as_concepto like '%Asiento%'
and as_comprobante in (select co_comprobante from #comprobantes)


select *
into #retenciones
from cob_conta..cb_retencion 
where re_empresa = 1
and  re_fecha = '01/01/2020'
and  re_comprobante in (select co_comprobante from #comprobantes)


select @w_comprobante = 0,
       @w_reg_comprobante=0


while 1 = 1
begin
     select top 1 
     @w_comprobante    = co_comprobante,
     @w_fecha_ing_comp = co_fecha_tran 
     from #asientos_reversar 
     where co_comprobante > @w_comprobante
     order by co_comprobante asc
     
     if @@rowcount = 0 
        break
        
     select @w_reg_comprobante = @w_reg_comprobante+ 1
     
     exec @w_error = cob_conta..sp_cseqcomp
     @i_empresa = 1,
     @i_fecha   = @w_fecha_ing_comp,
     @i_tabla   = 'cb_tcomprobante',
     @i_modulo  = 6,
     @i_modo    = 1,
     @o_siguiente = @w_comprobante_new out
     
     print convert(varchar,@w_reg_comprobante) + ' comprobante ant:' + convert(varchar, @w_comprobante) + ' comprobante new:' + convert(varchar, @w_comprobante_new)
     
     update #comprobantes set
     co_comprobante = @w_comprobante_new,
     co_tot_debito  = co_tot_credito,
     co_tot_credito = co_tot_debito,
     co_mayorizado  = 'N',
     co_traslado    = 'N',
     co_descripcion = substring('REV:' + co_descripcion,1,160)
     where co_comprobante = @w_comprobante
     
     update #asientos set
     as_comprobante = @w_comprobante_new,
     as_mayorizado  = 'N',
     as_credito     = as_debito,
     as_debito      = as_credito,
     as_concepto    = substring('REV:'+ as_concepto,1,160)
     where as_comprobante = @w_comprobante
     
     update #retenciones set
     re_comprobante = @w_comprobante_new
     where re_comprobante = @w_comprobante
     
     
     select co_tot_debito, co_tot_credito, *
     from cb_comprobante
     where co_comprobante = @w_comprobante
     
     select co_tot_debito, co_tot_credito, *
     from #comprobantes
     where co_comprobante = @w_comprobante_new
     
     select as_comprobante, as_mayorizado, sum(as_credito), sum(as_debito)
     from cb_asiento
     where as_comprobante = @w_comprobante
     group by as_comprobante, as_mayorizado
     
     select as_comprobante, as_mayorizado, sum(as_credito), sum(as_debito)
     from #asientos
     where as_comprobante = @w_comprobante_new
     group by as_comprobante, as_mayorizado
     
     insert into cob_conta..cb_comprobante
     select *
     from #comprobantes
     where co_comprobante = @w_comprobante_new
     
     insert into cob_conta..cb_asiento
     select *
     from #asientos
     where as_comprobante = @w_comprobante_new
     
     insert into cob_conta..cb_retencion
     select *
     from #retenciones
     where re_comprobante = @w_comprobante_new
     
end

drop table #comprobantes
drop table #asientos
drop table #retenciones


