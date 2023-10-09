
USE cob_cartera
go

declare
@w_fecha_proceso       datetime,
@w_operacion           INT ,
@w_banco               cuenta,
@w_fecha_valor         datetime,
@w_error               INT,
@w_msg                 VARCHAR(100),
@w_secuencial          INT

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

CREATE table #operaciones (
banco            cuenta,
operacion        INT null)

insert into #operaciones values ('210320041358',null)
insert into #operaciones values ('210320041366',null)
insert into #operaciones values ('210320041374',null)
insert into #operaciones values ('210320041382',null)
insert into #operaciones values ('210320041399',null)
insert into #operaciones values ('210320041408',null)
insert into #operaciones values ('210320041416',null)
insert into #operaciones values ('210320041424',null)
insert into #operaciones values ('210320041432',null)
insert into #operaciones values ('210530048334',null)
insert into #operaciones values ('210530048342',null)
insert into #operaciones values ('210530049471',null)
insert into #operaciones values ('210530049489',null)
insert into #operaciones values ('210530049496',null)
insert into #operaciones values ('210530049505',null)
insert into #operaciones values ('210530049513',null)
insert into #operaciones values ('210530049521',null)
insert into #operaciones values ('210530049539',null)
insert into #operaciones values ('210530049547',null)
insert into #operaciones values ('210530048359',null)
insert into #operaciones values ('210530048367',null)
insert into #operaciones values ('210530048375',null)
insert into #operaciones values ('210530048383',null)
insert into #operaciones values ('210530048390',null)
insert into #operaciones values ('210530048409',null)
insert into #operaciones values ('210530051148',null)
insert into #operaciones values ('210530051155',null)
insert into #operaciones values ('210530051163',null)
insert into #operaciones values ('210530051171',null)
insert into #operaciones values ('210530051189',null)
insert into #operaciones values ('210530051196',null)
insert into #operaciones values ('210530051205',null)
insert into #operaciones values ('210530051213',null)
insert into #operaciones values ('211240022486',null)
insert into #operaciones values ('211240022493',null)
insert into #operaciones values ('211240022502',null)
insert into #operaciones values ('211240022437',null)
insert into #operaciones values ('211240022445',null)
insert into #operaciones values ('211240022452',null)
insert into #operaciones values ('211240022460',null)
insert into #operaciones values ('211240022478',null)
insert into #operaciones values ('211430023194',null)
insert into #operaciones values ('211430023203',null)
insert into #operaciones values ('211430023211',null)
insert into #operaciones values ('211430023229',null)
insert into #operaciones values ('211430023120',null)
insert into #operaciones values ('211430023138',null)
insert into #operaciones values ('211430023146',null)
insert into #operaciones values ('211430023153',null)
insert into #operaciones values ('211430023161',null)
insert into #operaciones values ('211430023179',null)
insert into #operaciones values ('211430023187',null)
insert into #operaciones values ('211430029530',null)
insert into #operaciones values ('211430029548',null)
insert into #operaciones values ('211430029555',null)
insert into #operaciones values ('211430029563',null)
insert into #operaciones values ('211430029571',null)
insert into #operaciones values ('211430029589',null)
insert into #operaciones values ('211430029596',null)
insert into #operaciones values ('211430029605',null)
insert into #operaciones values ('211450024998',null)
insert into #operaciones values ('211450025005',null)
insert into #operaciones values ('211450025013',null)
insert into #operaciones values ('211450025021',null)
insert into #operaciones values ('211450025039',null)
insert into #operaciones values ('211450025047',null)
insert into #operaciones values ('211450025054',null)
insert into #operaciones values ('211450025062',null)
insert into #operaciones values ('213020016950',null)
insert into #operaciones values ('213020016968',null)
insert into #operaciones values ('213020016976',null)
insert into #operaciones values ('213020016984',null)
insert into #operaciones values ('213020016991',null)
insert into #operaciones values ('213020017017',null)
insert into #operaciones values ('213020017025',null)
insert into #operaciones values ('213100007888',null)
insert into #operaciones values ('213100007895',null)
insert into #operaciones values ('213100007903',null)
insert into #operaciones values ('213100007911',null)
insert into #operaciones values ('213100007929',null)
insert into #operaciones values ('213100007937',null)
insert into #operaciones values ('213190002541',null)
insert into #operaciones values ('213190002574',null)
insert into #operaciones values ('213180001264',null)
insert into #operaciones values ('213180001272',null)
insert into #operaciones values ('213180001280',null)
insert into #operaciones values ('213180001297',null)
insert into #operaciones values ('213180001306',null)
insert into #operaciones values ('213180001314',null)
insert into #operaciones values ('213180001322',null)
insert into #operaciones values ('213180001330',null)
insert into #operaciones values ('213260008899',null)
insert into #operaciones values ('213260008907',null)
insert into #operaciones values ('213260008915',null)
insert into #operaciones values ('213260008923',null)
insert into #operaciones values ('213260008931',null)
insert into #operaciones values ('213260008949',null)
insert into #operaciones values ('213260008956',null)
insert into #operaciones values ('213260008964',null)
insert into #operaciones values ('213260008972',null)
insert into #operaciones values ('213260008980',null)
insert into #operaciones values ('213260008997',null)
insert into #operaciones values ('213310005573',null)
insert into #operaciones values ('213310005581',null)
insert into #operaciones values ('213310005598',null)
insert into #operaciones values ('213310005607',null)
insert into #operaciones values ('213310005615',null)
insert into #operaciones values ('213310005623',null)
insert into #operaciones values ('213310003016',null)
insert into #operaciones values ('213310003024',null)
insert into #operaciones values ('213310003032',null)
insert into #operaciones values ('213310003040',null)
insert into #operaciones values ('213310003057',null)
insert into #operaciones values ('213310003065',null)
insert into #operaciones values ('213310003073',null)
insert into #operaciones values ('213310003081',null)
insert into #operaciones values ('213440002300',null)
insert into #operaciones values ('213460001934',null)
insert into #operaciones values ('213460001942',null)
insert into #operaciones values ('213460001959',null)
insert into #operaciones values ('213440002219',null)
insert into #operaciones values ('213440002227',null)
insert into #operaciones values ('213440002235',null)
insert into #operaciones values ('213440002243',null)
insert into #operaciones values ('213440002250',null)
insert into #operaciones values ('213440002268',null)
insert into #operaciones values ('213440002276',null)
insert into #operaciones values ('213440002284',null)
insert into #operaciones values ('213440002291',null)
insert into #operaciones values ('213460001885',null)
insert into #operaciones values ('213460001892',null)
insert into #operaciones values ('213460001900',null)
insert into #operaciones values ('213460001918',null)
insert into #operaciones values ('213460001926',null)
insert into #operaciones values ('213440003407',null)
insert into #operaciones values ('213440003415',null)
insert into #operaciones values ('213440003423',null)
insert into #operaciones values ('213440003431',null)
insert into #operaciones values ('213440003449',null)
insert into #operaciones values ('213440003456',null)
insert into #operaciones values ('213440003464',null)
insert into #operaciones values ('213460002494',null)
insert into #operaciones values ('213460002503',null)
insert into #operaciones values ('213460002511',null)
insert into #operaciones values ('213460002529',null)
insert into #operaciones values ('213460002537',null)
insert into #operaciones values ('213460002545',null)
insert into #operaciones values ('213460002552',null)
insert into #operaciones values ('213460002560',null)
insert into #operaciones values ('213460002651',null)
insert into #operaciones values ('213460002669',null)
insert into #operaciones values ('213460002677',null)
insert into #operaciones values ('213460002685',null)
insert into #operaciones values ('213460002692',null)
insert into #operaciones values ('213460002701',null)
insert into #operaciones values ('213490004239',null)
insert into #operaciones values ('213490004254',null)
insert into #operaciones values ('213490004262',null)
insert into #operaciones values ('213490004270',null)
insert into #operaciones values ('213490004288',null)
insert into #operaciones values ('213490004295',null)
insert into #operaciones values ('213490004619',null)
insert into #operaciones values ('213490004627',null)
insert into #operaciones values ('213490004635',null)
insert into #operaciones values ('213490004643',null)
insert into #operaciones values ('213490004650',null)
insert into #operaciones values ('213490004668',null)
insert into #operaciones values ('214810031092',null)
insert into #operaciones values ('223810099479',null)
insert into #operaciones values ('223810099404',null)
insert into #operaciones values ('223810099412',null)
insert into #operaciones values ('223810099420',null)
insert into #operaciones values ('223810099438',null)
insert into #operaciones values ('223810099446',null)
insert into #operaciones values ('223810099453',null)
insert into #operaciones values ('223810099461',null)
insert into #operaciones values ('223810104669',null)
insert into #operaciones values ('223810104677',null)
insert into #operaciones values ('223810104685',null)
insert into #operaciones values ('223810104692',null)
insert into #operaciones values ('223810104701',null)
insert into #operaciones values ('223810104719',null)
insert into #operaciones values ('223810104727',null)
insert into #operaciones values ('223810104735',null)
insert into #operaciones values ('224030101360',null)
insert into #operaciones values ('224030101378',null)
insert into #operaciones values ('224030101386',null)
insert into #operaciones values ('224030101393',null)
insert into #operaciones values ('224030101402',null)
insert into #operaciones values ('224030101410',null)
insert into #operaciones values ('224030101428',null)
insert into #operaciones values ('224030101436',null)
insert into #operaciones values ('224030103788',null)
insert into #operaciones values ('224030103795',null)
insert into #operaciones values ('224030103804',null)
insert into #operaciones values ('224030103812',null)
insert into #operaciones values ('224030103820',null)
insert into #operaciones values ('224030103838',null)
insert into #operaciones values ('224030103846',null)
insert into #operaciones values ('224030103853',null)
insert into #operaciones values ('224030105619',null)
insert into #operaciones values ('224030105627',null)
insert into #operaciones values ('224030105643',null)
insert into #operaciones values ('224030105650',null)
insert into #operaciones values ('233450084287',null)
insert into #operaciones values ('233450084294',null)
insert into #operaciones values ('233450084303',null)
insert into #operaciones values ('233450084311',null)
insert into #operaciones values ('233450084329',null)
insert into #operaciones values ('233450084337',null)
insert into #operaciones values ('233450084345',null)
insert into #operaciones values ('233450084352',null)
insert into #operaciones values ('233450086241',null)
insert into #operaciones values ('233450086258',null)
insert into #operaciones values ('233450086266',null)
insert into #operaciones values ('233450086274',null)
insert into #operaciones values ('233450086282',null)
insert into #operaciones values ('233450086308',null)
insert into #operaciones values ('233450086316',null)
insert into #operaciones values ('233450086324',null)
insert into #operaciones values ('233450086332',null)
insert into #operaciones values ('233450086340',null)
insert into #operaciones values ('233450086357',null)
insert into #operaciones values ('233450088097',null)
insert into #operaciones values ('233450088106',null)
insert into #operaciones values ('233450088114',null)
insert into #operaciones values ('233450088122',null)
insert into #operaciones values ('233450088130',null)
insert into #operaciones values ('233450088148',null)
insert into #operaciones values ('233450088155',null)
insert into #operaciones values ('233450088163',null)
insert into #operaciones values ('233480110375',null)
insert into #operaciones values ('233480110383',null)
insert into #operaciones values ('233480110390',null)
insert into #operaciones values ('233480110409',null)
insert into #operaciones values ('233480110417',null)
insert into #operaciones values ('233480110425',null)
insert into #operaciones values ('233480110433',null)
insert into #operaciones values ('233480110441',null)
insert into #operaciones values ('233480111976',null)
insert into #operaciones values ('233480111984',null)
insert into #operaciones values ('233480111991',null)
insert into #operaciones values ('233480112009',null)
insert into #operaciones values ('233480112017',null)
insert into #operaciones values ('233480112025',null)
insert into #operaciones values ('233480112033',null)
insert into #operaciones values ('233480112041',null)
insert into #operaciones values ('233510110931',null)
insert into #operaciones values ('233510110949',null)
insert into #operaciones values ('233510110956',null)
insert into #operaciones values ('233510110964',null)
insert into #operaciones values ('233510110972',null)
insert into #operaciones values ('233510110980',null)
insert into #operaciones values ('233510110997',null)
insert into #operaciones values ('233510111005',null)
insert into #operaciones values ('233510111013',null)
insert into #operaciones values ('233510114637',null)
insert into #operaciones values ('233510114645',null)
insert into #operaciones values ('233510114652',null)
insert into #operaciones values ('233510114660',null)
insert into #operaciones values ('233510114678',null)
insert into #operaciones values ('233510114686',null)
insert into #operaciones values ('233510114693',null)
insert into #operaciones values ('233510114702',null)
insert into #operaciones values ('213360018310',null)
insert into #operaciones values ('213360018328',null)
insert into #operaciones values ('213360018336',null)
insert into #operaciones values ('213360018344',null)
insert into #operaciones values ('213360018351',null)
insert into #operaciones values ('213360018369',null)
insert into #operaciones values ('213360018377',null)
insert into #operaciones values ('213360018385',null)
--2do Bloque operaciones                       ,null
insert into #operaciones values ('210810031687',null)
insert into #operaciones values ('210810031694',null)
insert into #operaciones values ('210810031703',null)
insert into #operaciones values ('210810031711',null)
insert into #operaciones values ('210810031729',null)
insert into #operaciones values ('210810031737',null)
insert into #operaciones values ('210810035837',null)
insert into #operaciones values ('210810035845',null)
insert into #operaciones values ('210810035852',null)
insert into #operaciones values ('210810035860',null)
insert into #operaciones values ('210810035878',null)
insert into #operaciones values ('210810035886',null)
insert into #operaciones values ('210810035893',null)
insert into #operaciones values ('210810035901',null)
insert into #operaciones values ('210810037783',null)
insert into #operaciones values ('210810037790',null)
insert into #operaciones values ('210810037809',null)
insert into #operaciones values ('210810037817',null)
insert into #operaciones values ('210810037825',null)
insert into #operaciones values ('210810037833',null)
insert into #operaciones values ('210810037841',null)
insert into #operaciones values ('210810037858',null)
insert into #operaciones values ('213130002719',null)
insert into #operaciones values ('213130002727',null)
insert into #operaciones values ('213130002735',null)
insert into #operaciones values ('213130002743',null)
insert into #operaciones values ('213130002750',null)
insert into #operaciones values ('213130002768',null)
insert into #operaciones values ('213130002776',null)
insert into #operaciones values ('213130002784',null)
insert into #operaciones values ('213260009490',null)
insert into #operaciones values ('213260009509',null)
insert into #operaciones values ('213260009517',null)
insert into #operaciones values ('213260009525',null)
insert into #operaciones values ('213260009533',null)
insert into #operaciones values ('213260009541',null)
insert into #operaciones values ('213260009228',null)
insert into #operaciones values ('213260009236',null)
insert into #operaciones values ('213260009244',null)
insert into #operaciones values ('213260009251',null)
insert into #operaciones values ('213260009269',null)
insert into #operaciones values ('213260009277',null)
insert into #operaciones values ('213260009285',null)
insert into #operaciones values ('213260009292',null)
insert into #operaciones values ('213260009475',null)
insert into #operaciones values ('213260009483',null)
insert into #operaciones values ('213270012270',null)
insert into #operaciones values ('213270012288',null)
insert into #operaciones values ('213270012295',null)
insert into #operaciones values ('213270012304',null)
insert into #operaciones values ('213270012312',null)
insert into #operaciones values ('213270012320',null)
insert into #operaciones values ('213270012338',null)
insert into #operaciones values ('213270012346',null)
insert into #operaciones values ('213270012353',null)
insert into #operaciones values ('213290008588',null)
insert into #operaciones values ('213290008595',null)
insert into #operaciones values ('213290008604',null)
insert into #operaciones values ('213290008612',null)
insert into #operaciones values ('213290008620',null)
insert into #operaciones values ('213290008638',null)
insert into #operaciones values ('213290008646',null)
insert into #operaciones values ('213290008653',null)
insert into #operaciones values ('213310005573',null)
insert into #operaciones values ('213310005581',null)
insert into #operaciones values ('213310005598',null)
insert into #operaciones values ('213310005607',null)
insert into #operaciones values ('213310005615',null)
insert into #operaciones values ('213310005623',null)
insert into #operaciones values ('213310003016',null)
insert into #operaciones values ('213310003024',null)
insert into #operaciones values ('213310003032',null)
insert into #operaciones values ('213310003040',null)
insert into #operaciones values ('213310003057',null)
insert into #operaciones values ('213310003065',null)
insert into #operaciones values ('213310003073',null)
insert into #operaciones values ('213310003081',null)
insert into #operaciones values ('213340002490',null)
insert into #operaciones values ('213340002509',null)
insert into #operaciones values ('213340002517',null)
insert into #operaciones values ('213340002525',null)
insert into #operaciones values ('213340002533',null)
insert into #operaciones values ('213340002541',null)
insert into #operaciones values ('213340002558',null)
insert into #operaciones values ('213340002566',null)
insert into #operaciones values ('224030102863',null)
insert into #operaciones values ('224030102871',null)
insert into #operaciones values ('224030102889',null)
insert into #operaciones values ('224030102896',null)
insert into #operaciones values ('224030102904',null)
insert into #operaciones values ('224030102912',null)
insert into #operaciones values ('224030102920',null)
insert into #operaciones values ('224030102938',null)
insert into #operaciones values ('233450088221',null)
insert into #operaciones values ('233450088239',null)
insert into #operaciones values ('233450088247',null)
insert into #operaciones values ('233450088254',null)
insert into #operaciones values ('233450088262',null)
insert into #operaciones values ('233450088189',null)
insert into #operaciones values ('233450088196',null)
insert into #operaciones values ('233450088205',null)
insert into #operaciones values ('233450088213',null)

SELECT count(1) FROM  #operaciones
delete #operaciones WHERE banco IN (
SELECT op_banco FROM ca_operacion  where op_estado = 3)

UPDATE #operaciones SET operacion = op_operacion
FROM ca_operacion
WHERE op_banco = banco

DELETE #operaciones WHERE operacion IN (
989857,
989860,
989863,
989866,
989869,
989872,
989875,
989878,
989881,
989884,
989887,
1035410,
1058653)

SELECT count(1) FROM  #operaciones

select operacion = am_operacion , cuota = sum(am_cuota) into #verificaciones from ca_amortizacion 
where am_operacion in (select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA')
group by am_operacion , am_concepto


select operacion, cuota, de_int_dsp from 
#verificaciones , ca_desplazamiento 
where de_operacion = operacion
and de_estado = 'A'

update ca_desplazamiento set 
de_dividendo_vig = 8
where de_banco in (
'213270012270',
'213270012288',
'213270012295',
'213270012304',
'213270012312',
'213270012320',
'213270012338',
'213270012346',
'213270012353')

select @w_operacion = 0

while 1 = 1 begin

   select top 1
   @w_operacion = operacion,
   @w_banco     = banco
   from #operaciones
   where operacion > @w_operacion
   order by operacion asc
   
   
   if @@rowcount = 0 break
   
   
   SELECT @w_fecha_valor = max(de_fecha_fin)
   FROM cob_cartera..ca_desplazamiento 
   WHERE de_banco = @w_banco
   AND   de_estado   = 'A'
   GROUP BY de_operacion
   

   if @w_fecha_valor is null begin 
      select 'Error al obtener fecha valor en operacion '+ convert(varchar,@w_operacion)
      goto SIGUIENTE
   end
   
   exec  @w_error = cob_cartera..sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = 1037,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_valor,
   @i_banco       = @w_banco,
   @i_operacion   = 'F' 
   
   if @w_error <> 0 begin
      select 'cob_cartera..sp_fecha_valor F ANTES', 'ERROR:'=@w_error ,'OPERACION'=@w_operacion
	  goto SIGUIENTE
   end

   exec  @w_error = cob_cartera..sp_reestructuracion_covid19
   @i_banco              = @w_banco,
   @i_cuotas_adicionales = 0,
   @o_error              = @w_error out,
   @o_msg                = @w_msg out
   
   if @w_error <> 0 begin
      select 'cob_cartera..sp_reestructuracion_covid19','ERROR:'=@w_error ,'OPERACION'=@w_operacion
	  goto SIGUIENTE
   end
   
   exec  @w_error = cob_cartera..sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = 1037,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_proceso,
   @i_banco       = @w_banco,
   @i_operacion   = 'F' 
   
   if @w_error <> 0 begin
      select 'cob_cartera..sp_fecha_valor F AHORA','ERROR:'=@w_error ,'OPERACION'=@w_operacion
	  goto SIGUIENTE
   end
   
   SIGUIENTE:

end

insert into #verificaciones
select operacion = am_operacion , cuota = sum(am_cuota) 
from ca_amortizacion 
where am_operacion in (select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA')
group by am_operacion , am_concepto


select operacion, de_banco, cuota, de_int_dsp from 
#verificaciones , ca_desplazamiento 
where de_operacion = operacion
and de_estado = 'A'

SELECT di_operacion,di_dividendo, di_dias_cuota 
INTO #dividendos
FROM cob_cartera..ca_dividendo, cob_cartera..ca_operacion
WHERE di_operacion =op_operacion
AND di_dias_cuota >= 30
AND op_banco IN (select banco from #operaciones)

SELECT * FROM #dividendos WHERE di_operacion IN (
SELECT di_operacion FROM #dividendos
GROUP BY di_operacion
HAVING count(di_dividendo) > 1)

drop table #operaciones
drop table #verificaciones
drop table #dividendos
   
go