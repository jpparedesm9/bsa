use cob_conta
go

if exists (select 1 from sysobjects where name = 'spsel_rexp')
    drop proc spsel_rexp
go
create proc spsel_rexp
(
   @i_empresa     tinyint,
   @i_moneda_base tinyint,
   @i_monbase1    tinyint,
   @i_fecha       datetime

)
as
declare @w_proceso smallint,
        @w_cuenta  cuenta_contable,
        @w_moneda  tinyint,
        @w_periodo smallint,
        @w_corte   smallint,
        @w_estado  char(1)
        
select @w_proceso = 6031   

set rowcount 0


select @w_periodo = co_periodo,
       @w_corte   = co_corte,
       @w_estado  = co_estado
from cob_conta..cb_corte
where co_empresa = @i_empresa
and   co_fecha_ini = @i_fecha

delete cob_conta..t_reexp

insert into cob_conta..t_reexp
values (@i_empresa, @w_periodo, @w_corte)
       
print 'ingresa a select'
Select 
   cu_cuenta,
   cu_moneda 
into #seleccion_reexp
from  cb_cuenta,cb_cuenta_proceso
where cu_empresa    = convert(tinyint,@i_empresa)
and   cu_cuenta     = cp_cuenta
and   cu_moneda     <> convert(tinyint,@i_moneda_base)
and   cu_estado     = 'V'
and   cu_movimiento = 'S'
and   cp_empresa    = cu_empresa
and   cp_proceso    = convert(smallint,@w_proceso)
and   cp_oficina    >= 0
and   cp_area       >= 0
and   cp_cuenta     = cu_cuenta
order by cu_moneda
print 'sale a select'
while 1 = 1
begin
    set rowcount 1
print 'entra a while'
    select 
        @w_cuenta = cu_cuenta,
        @w_moneda = cu_moneda
    from #seleccion_reexp
    order by cu_moneda, cu_cuenta
    
    if @@rowcount = 0
        break
    print 'pasa break'    
    
    set rowcount 0
print @w_cuenta
print @w_moneda

    delete #seleccion_reexp
    where cu_cuenta = @w_cuenta
    and   cu_moneda = @w_moneda 
    
    
print @i_monbase1 
print @w_cuenta   
print @w_periodo
print @w_corte
print @i_fecha
print @w_estado

   if @w_estado = 'A' 
   begin
       PRINT 'ENTRA ESTADO A'
       execute cob_conta..sp_reexpresion
       @i_monbase1  =  @i_monbase1,
       @i_empresa   =  @i_empresa,
       @i_periodo   =  @w_periodo,
       @i_corte     =  @w_corte,
       @i_cuenta    =  @w_cuenta,
       @i_fecha     =  @i_fecha,
       @i_operacion = 'A',
       @i_username  = 'operador'
       
       if @@error <> 0
           goto ERROR
   end
   
   if @w_estado in ('V', 'C')
   begin
       PRINT 'ENTRA ESTADO v'
       
       execute cob_conta..sp_reexpresion
       @i_monbase1  =  @i_monbase1,
       @i_empresa   =  @i_empresa,
       @i_periodo   =  @w_periodo,
       @i_corte     =  @w_corte,
       @i_cuenta    =  @w_cuenta,
       @i_fecha     =  @i_fecha,
       @i_operacion = 'N',
       @i_username  = 'operador'
       
       if @@error <> 0
           goto ERROR
   end
end

RETURN 0

ERROR:
    insert into cob_conta..cb_erreres_batch
    values('reexp', getdate())         
    return 1

go