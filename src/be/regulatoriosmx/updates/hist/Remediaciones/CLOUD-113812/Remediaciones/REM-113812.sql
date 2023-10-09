
declare 
@w_ente int,
@w_monto money,
@w_monto_aprobado money,
@w_tramite  int,
@w_grupo  int

select @w_ente = 0
select @w_grupo = 3427
select @w_tramite = 50642

select tg_cliente,tg_monto,tg_monto_aprobado,* from cob_credito..cr_tramite_grupal
where tg_tramite = @w_tramite
and tg_grupo = @w_grupo

while 1 = 1 begin
   select top 1
   @w_ente = tg_cliente,
   @w_monto = tg_monto,
   @w_monto_aprobado = tg_monto_aprobado
   from cob_credito..cr_tramite_grupal
   where tg_tramite = @w_tramite
   and tg_cliente > @w_ente
   order by tg_cliente
   
   if @@rowcount = 0
      break
    
   update cob_credito..cr_tramite_grupal
   set tg_monto_aprobado = @w_monto
   where tg_tramite = @w_tramite
   and tg_cliente = @w_ente
   
end