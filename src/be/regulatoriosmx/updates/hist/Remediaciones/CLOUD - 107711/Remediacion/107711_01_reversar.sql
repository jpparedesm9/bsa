USE cob_cartera
GO

DECLARE
@s_date  DATETIME,
@w_banco varchar(32),
@w_sec int,
@w_secuencial_pago int

create table #pagos (sec int, banco varchar(32), secuencial_pago int)
create table #pagos_fecha_valor (banco varchar(32))

--sobrante grupo 560
--update ca_det_trn set dtr_monto = dtr_monto  -0.72, dtr_monto_mn = dtr_monto_mn - 0.72 where dtr_operacion = 26029 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.34, dtr_monto_mn = dtr_monto_mn - 0.34 where dtr_operacion = 26032 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.70, dtr_monto_mn = dtr_monto_mn - 0.70 where dtr_operacion = 26035 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.58, dtr_monto_mn = dtr_monto_mn - 0.58 where dtr_operacion = 26038 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.46, dtr_monto_mn = dtr_monto_mn - 0.46 where dtr_operacion = 26041 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.46, dtr_monto_mn = dtr_monto_mn - 0.46 where dtr_operacion = 26044 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.65, dtr_monto_mn = dtr_monto_mn - 0.65 where dtr_operacion = 26047 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -0.70, dtr_monto_mn = dtr_monto_mn - 0.70 where dtr_operacion = 26050 and dtr_secuencial = 103 and dtr_concepto in ('VAC0')
--
--delete from ca_det_trn  where dtr_operacion = 26029 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26032 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26035 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26038 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26041 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26044 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26047 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26050 and dtr_secuencial = 103 and dtr_concepto = 'SOBRANTE'

--sobrante grupo 681
--update ca_det_trn set dtr_monto = dtr_monto  -5.23, dtr_monto_mn = dtr_monto_mn - 5.23 where dtr_operacion = 32294 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -6.67, dtr_monto_mn = dtr_monto_mn - 6.67 where dtr_operacion = 32297 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -6.67, dtr_monto_mn = dtr_monto_mn - 6.67 where dtr_operacion = 32300 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -5.25, dtr_monto_mn = dtr_monto_mn - 5.25 where dtr_operacion = 32303 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -5.25, dtr_monto_mn = dtr_monto_mn - 5.25 where dtr_operacion = 32306 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -6.67, dtr_monto_mn = dtr_monto_mn - 6.67 where dtr_operacion = 32309 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -5.25, dtr_monto_mn = dtr_monto_mn - 5.25 where dtr_operacion = 32312 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
--update ca_det_trn set dtr_monto = dtr_monto  -5.25, dtr_monto_mn = dtr_monto_mn - 5.25 where dtr_operacion = 26050 and dtr_secuencial = 121 and dtr_concepto in ('VAC0')
----
--delete from ca_det_trn  where dtr_operacion = 32294 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 32297 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 32300 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 32303 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 32306 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 32309 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 32312 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'
--delete from ca_det_trn  where dtr_operacion = 26050 and dtr_secuencial = 121 and dtr_concepto = 'SOBRANTE'


--grupo 560
--insert into #pagos values (1, '233460000034',	95)
--insert into #pagos values (2, '233460000042',	95)
--insert into #pagos values (3, '233460000059',	95)
--insert into #pagos values (4, '233460000067',	95)
--insert into #pagos values (5, '233460000075',	95)
--insert into #pagos values (6, '233460000083',	95)
--insert into #pagos values (7, '233460000090',	95)
--insert into #pagos values (8, '233460000109',	95)
--
----grupo 681
--insert into #pagos values (9 , '233510011015',	103)
--insert into #pagos values (10, '233510011023',	103)
--insert into #pagos values (11, '233510011031',	103)
--insert into #pagos values (12, '233510011049',	103)
--insert into #pagos values (13, '233510011056',	103)
--insert into #pagos values (14, '233510011064',	103)
--insert into #pagos values (15, '233510011072',	103)
--insert into #pagos values (16, '233510011080',	103)
--insert into #pagos values (17, '233510011015',	107)
--insert into #pagos values (18, '233510011023',	107)
--insert into #pagos values (19, '233510011031',	107)
--insert into #pagos values (20, '233510011049',	107)
--insert into #pagos values (21, '233510011056',	107)
--insert into #pagos values (22, '233510011064',	107)
--insert into #pagos values (23, '233510011072',	107)
--insert into #pagos values (24, '233510011080',	107)

--grupo 1078
insert into #pagos values (25, '214790003087',	53)
insert into #pagos values (26, '214790003094',	53)
insert into #pagos values (27, '214790003103',	53)
insert into #pagos values (28, '214790003111',	53)
insert into #pagos values (29, '214790003129',	53)
insert into #pagos values (30, '214790003137',	53)
insert into #pagos values (31, '214790003145',	53)
insert into #pagos values (32, '214790003152',	53)
insert into #pagos values (33, '214790003160',	53)

--grupo 769
insert into #pagos values (34, '214810000493',	77)
insert into #pagos values (35, '214810000502',	77)
insert into #pagos values (36, '214810000510',	77)
insert into #pagos values (37, '214810000528',	77)
insert into #pagos values (38, '214810000536',	77)
insert into #pagos values (39, '214810000544',	77)
insert into #pagos values (40, '214810000551',	77)
insert into #pagos values (41, '214810000569',	77)
insert into #pagos values (42, '214810000577',	77)

--grupo 827
insert into #pagos values (43, '214800001049',	71)
insert into #pagos values (44, '214800001056',	71)
insert into #pagos values (45, '214800001064',	71)
insert into #pagos values (46, '214800001072',	71)
insert into #pagos values (47, '214800001080',	71)
insert into #pagos values (48, '214800001097',	71)
insert into #pagos values (49, '214800001106',	71)
insert into #pagos values (50, '214800001114',	71)
insert into #pagos values (51, '214800001122',	71)

--grupo 1059
insert into #pagos values (52, '223770004610',	55)
insert into #pagos values (53, '223770004628',	55)
insert into #pagos values (54, '223770004636',	55)
insert into #pagos values (55, '223770004644',	55)
insert into #pagos values (56, '223770004651',	55)
insert into #pagos values (57, '223770004669',	55)
insert into #pagos values (58, '223770004677',	55)
insert into #pagos values (59, '223770004685',	55)

--grupo 1138
insert into #pagos values (60, '233460002089',	43)
insert into #pagos values (61, '233460002096',	43)
insert into #pagos values (62, '233460002105',	43)
insert into #pagos values (63, '233460002113',	43)
insert into #pagos values (64, '233460002121',	43)
insert into #pagos values (65, '233460002139',	43)
insert into #pagos values (66, '233460002147',	43)
insert into #pagos values (67, '233460002154',	43)

--grupo 1447
insert into #pagos values (68, '224040011609',	19)
insert into #pagos values (69, '224040011617',	19)
insert into #pagos values (70, '224040011625',	19)
insert into #pagos values (71, '224040011633',	19)
insert into #pagos values (72, '224040011641',	19)
insert into #pagos values (73, '224040011658',	19)
insert into #pagos values (74, '224040011666',	19)
insert into #pagos values (75, '224040011674',	19)

--grupo 1526
insert into #pagos values (76, '223790009027',	19)
insert into #pagos values (77, '223790009035',	19)
insert into #pagos values (78, '223790009043',	19)
insert into #pagos values (79, '223790009050',	19)
insert into #pagos values (80, '223790009068',	19)
insert into #pagos values (81, '223790009076',	19)
insert into #pagos values (82, '223790009084',	19)
insert into #pagos values (83, '223790009091',	19)

--grupo 45

insert into #pagos values (84, '233450017808',7)
insert into #pagos values (85, '233450017816',7)
insert into #pagos values (86, '233450017824',7)
insert into #pagos values (87, '233450017832',7)
insert into #pagos values (88, '233450017840',7)
insert into #pagos values (89, '233450017857',7)
insert into #pagos values (90, '233450017865',7)
insert into #pagos values (91, '233450017873',7)



SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

select @w_sec = 0

---Reversar pagos
while (1=1)
begin
    
    select top 1 
    @w_banco = banco, 
    @w_secuencial_pago = secuencial_pago, 
    @w_sec = sec
    from #pagos 
    where sec > @w_sec 
    order by sec
    
    if @@rowcount = 0 begin 
       break
    end 
    
    exec  sp_fecha_valor 
    @s_date        = @s_date,
    @s_user        = 'OPERADOR',
    @s_term        = 'CONSOLA',
    @t_trn         = 7049,
    @i_banco       = @w_banco,  
    @i_secuencial  = @w_secuencial_pago,  
    @i_observacion = 'OAB: pago duplicado caso 107711',
    @i_operacion   = 'R'

end --Reversar pagos   

--Fecha valor
insert into #pagos_fecha_valor
select distinct banco from #pagos

select @w_banco = ' '
while (1=1)
begin

   select top 1 
   @w_banco = banco 
   from #pagos_fecha_valor
   where banco > @w_banco
   order by banco
   
   if @@rowcount = 0 begin 
       break
   end 

    exec  sp_fecha_valor 
    @s_date        = @s_date,
    @s_user        = 'OPERADOR',
    @s_term        = 'CONSOLA',
    @t_trn         = 7049,
    @i_banco       = @w_banco,  
    @i_fecha_mov   = @s_date,
    @i_fecha_valor = @s_date,
    @i_secuencial  = 1,
    @i_operacion   = 'F'

end

--Marcar como Anulado las ordenes de pago grupal reversadas
--update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23280
--update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23273  --pendiente de revisar con Israel
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23274
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23681
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23678
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23664
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 25258
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23667
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 23662
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 25264
update ca_corresponsal_trn set co_estado = 'A'  where co_secuencial = 21612   --grupo 45


drop table #pagos_fecha_valor
drop table #pagos 

go











