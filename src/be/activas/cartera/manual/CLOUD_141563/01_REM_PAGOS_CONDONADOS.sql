
USE cob_cartera
go

declare
@w_fecha_proceso       datetime,
@w_operacion           INT ,
@w_banco               cuenta,
@w_fecha_valor         datetime,
@w_error               INT,
@w_msg                 VARCHAR(100),
@w_secuencial          INT,
@w_id                  int


SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

create table #operaciones (
banco            cuenta)

insert into #operaciones values ('210320041358')
insert into #operaciones values ('210320041366')
insert into #operaciones values ('210320041374')
insert into #operaciones values ('210320041382')
insert into #operaciones values ('210320041399')
insert into #operaciones values ('210320041408')
insert into #operaciones values ('210320041416')
insert into #operaciones values ('210320041424')
insert into #operaciones values ('210320041432')
insert into #operaciones values ('210530048334')
insert into #operaciones values ('210530048342')
insert into #operaciones values ('210530049471')
insert into #operaciones values ('210530049489')
insert into #operaciones values ('210530049496')
insert into #operaciones values ('210530049505')
insert into #operaciones values ('210530049513')
insert into #operaciones values ('210530049521')
insert into #operaciones values ('210530049539')
insert into #operaciones values ('210530049547')
insert into #operaciones values ('210530048359')
insert into #operaciones values ('210530048367')
insert into #operaciones values ('210530048375')
insert into #operaciones values ('210530048383')
insert into #operaciones values ('210530048390')
insert into #operaciones values ('210530048409')
insert into #operaciones values ('210530051148')
insert into #operaciones values ('210530051155')
insert into #operaciones values ('210530051163')
insert into #operaciones values ('210530051171')
insert into #operaciones values ('210530051189')
insert into #operaciones values ('210530051196')
insert into #operaciones values ('210530051205')
insert into #operaciones values ('210530051213')
insert into #operaciones values ('211240022486')
insert into #operaciones values ('211240022493')
insert into #operaciones values ('211240022502')
insert into #operaciones values ('211240022437')
insert into #operaciones values ('211240022445')
insert into #operaciones values ('211240022452')
insert into #operaciones values ('211240022460')
insert into #operaciones values ('211240022478')
insert into #operaciones values ('211430023194')
insert into #operaciones values ('211430023203')
insert into #operaciones values ('211430023211')
insert into #operaciones values ('211430023229')
insert into #operaciones values ('211430023120')
insert into #operaciones values ('211430023138')
insert into #operaciones values ('211430023146')
insert into #operaciones values ('211430023153')
insert into #operaciones values ('211430023161')
insert into #operaciones values ('211430023179')
insert into #operaciones values ('211430023187')
insert into #operaciones values ('211430029530')
insert into #operaciones values ('211430029548')
insert into #operaciones values ('211430029555')
insert into #operaciones values ('211430029563')
insert into #operaciones values ('211430029571')
insert into #operaciones values ('211430029589')
insert into #operaciones values ('211430029596')
insert into #operaciones values ('211430029605')
insert into #operaciones values ('211450024998')
insert into #operaciones values ('211450025005')
insert into #operaciones values ('211450025013')
insert into #operaciones values ('211450025021')
insert into #operaciones values ('211450025039')
insert into #operaciones values ('211450025047')
insert into #operaciones values ('211450025054')
insert into #operaciones values ('211450025062')
insert into #operaciones values ('213020016950')
insert into #operaciones values ('213020016968')
insert into #operaciones values ('213020016976')
insert into #operaciones values ('213020016984')
insert into #operaciones values ('213020016991')
insert into #operaciones values ('213020017017')
insert into #operaciones values ('213020017025')
insert into #operaciones values ('213100007888')
insert into #operaciones values ('213100007895')
insert into #operaciones values ('213100007903')
insert into #operaciones values ('213100007911')
insert into #operaciones values ('213100007929')
insert into #operaciones values ('213100007937')
insert into #operaciones values ('213190002541')
insert into #operaciones values ('213190002574')
insert into #operaciones values ('213180001264')
insert into #operaciones values ('213180001272')
insert into #operaciones values ('213180001280')
insert into #operaciones values ('213180001297')
insert into #operaciones values ('213180001306')
insert into #operaciones values ('213180001314')
insert into #operaciones values ('213180001322')
insert into #operaciones values ('213180001330')
insert into #operaciones values ('213260008899')
insert into #operaciones values ('213260008907')
insert into #operaciones values ('213260008915')
insert into #operaciones values ('213260008923')
insert into #operaciones values ('213260008931')
insert into #operaciones values ('213260008949')
insert into #operaciones values ('213260008956')
insert into #operaciones values ('213260008964')
insert into #operaciones values ('213260008972')
insert into #operaciones values ('213260008980')
insert into #operaciones values ('213260008997')
insert into #operaciones values ('213310005573')
insert into #operaciones values ('213310005581')
insert into #operaciones values ('213310005598')
insert into #operaciones values ('213310005607')
insert into #operaciones values ('213310005615')
insert into #operaciones values ('213310005623')
insert into #operaciones values ('213310003016')
insert into #operaciones values ('213310003024')
insert into #operaciones values ('213310003032')
insert into #operaciones values ('213310003040')
insert into #operaciones values ('213310003057')
insert into #operaciones values ('213310003065')
insert into #operaciones values ('213310003073')
insert into #operaciones values ('213310003081')
insert into #operaciones values ('213440002300')
insert into #operaciones values ('213460001934')
insert into #operaciones values ('213460001942')
insert into #operaciones values ('213460001959')
insert into #operaciones values ('213440002219')
insert into #operaciones values ('213440002227')
insert into #operaciones values ('213440002235')
insert into #operaciones values ('213440002243')
insert into #operaciones values ('213440002250')
insert into #operaciones values ('213440002268')
insert into #operaciones values ('213440002276')
insert into #operaciones values ('213440002284')
insert into #operaciones values ('213440002291')
insert into #operaciones values ('213460001885')
insert into #operaciones values ('213460001892')
insert into #operaciones values ('213460001900')
insert into #operaciones values ('213460001918')
insert into #operaciones values ('213460001926')
insert into #operaciones values ('213440003407')
insert into #operaciones values ('213440003415')
insert into #operaciones values ('213440003423')
insert into #operaciones values ('213440003431')
insert into #operaciones values ('213440003449')
insert into #operaciones values ('213440003456')
insert into #operaciones values ('213440003464')
insert into #operaciones values ('213460002494')
insert into #operaciones values ('213460002503')
insert into #operaciones values ('213460002511')
insert into #operaciones values ('213460002529')
insert into #operaciones values ('213460002537')
insert into #operaciones values ('213460002545')
insert into #operaciones values ('213460002552')
insert into #operaciones values ('213460002560')
insert into #operaciones values ('213460002651')
insert into #operaciones values ('213460002669')
insert into #operaciones values ('213460002677')
insert into #operaciones values ('213460002685')
insert into #operaciones values ('213460002692')
insert into #operaciones values ('213460002701')
insert into #operaciones values ('213490004239')
insert into #operaciones values ('213490004254')
insert into #operaciones values ('213490004262')
insert into #operaciones values ('213490004270')
insert into #operaciones values ('213490004288')
insert into #operaciones values ('213490004295')
insert into #operaciones values ('213490004619')
insert into #operaciones values ('213490004627')
insert into #operaciones values ('213490004635')
insert into #operaciones values ('213490004643')
insert into #operaciones values ('213490004650')
insert into #operaciones values ('213490004668')
insert into #operaciones values ('214810031092')
insert into #operaciones values ('223810099479')
insert into #operaciones values ('223810099404')
insert into #operaciones values ('223810099412')
insert into #operaciones values ('223810099420')
insert into #operaciones values ('223810099438')
insert into #operaciones values ('223810099446')
insert into #operaciones values ('223810099453')
insert into #operaciones values ('223810099461')
insert into #operaciones values ('223810104669')
insert into #operaciones values ('223810104677')
insert into #operaciones values ('223810104685')
insert into #operaciones values ('223810104692')
insert into #operaciones values ('223810104701')
insert into #operaciones values ('223810104719')
insert into #operaciones values ('223810104727')
insert into #operaciones values ('223810104735')
insert into #operaciones values ('224030101360')
insert into #operaciones values ('224030101378')
insert into #operaciones values ('224030101386')
insert into #operaciones values ('224030101393')
insert into #operaciones values ('224030101402')
insert into #operaciones values ('224030101410')
insert into #operaciones values ('224030101428')
insert into #operaciones values ('224030101436')
insert into #operaciones values ('224030103788')
insert into #operaciones values ('224030103795')
insert into #operaciones values ('224030103804')
insert into #operaciones values ('224030103812')
insert into #operaciones values ('224030103820')
insert into #operaciones values ('224030103838')
insert into #operaciones values ('224030103846')
insert into #operaciones values ('224030103853')
insert into #operaciones values ('224030105619')
insert into #operaciones values ('224030105627')
insert into #operaciones values ('224030105643')
insert into #operaciones values ('224030105650')
insert into #operaciones values ('233450084287')
insert into #operaciones values ('233450084294')
insert into #operaciones values ('233450084303')
insert into #operaciones values ('233450084311')
insert into #operaciones values ('233450084329')
insert into #operaciones values ('233450084337')
insert into #operaciones values ('233450084345')
insert into #operaciones values ('233450084352')
insert into #operaciones values ('233450086241')
insert into #operaciones values ('233450086258')
insert into #operaciones values ('233450086266')
insert into #operaciones values ('233450086274')
insert into #operaciones values ('233450086282')
insert into #operaciones values ('233450086308')
insert into #operaciones values ('233450086316')
insert into #operaciones values ('233450086324')
insert into #operaciones values ('233450086332')
insert into #operaciones values ('233450086340')
insert into #operaciones values ('233450086357')
insert into #operaciones values ('233450088097')
insert into #operaciones values ('233450088106')
insert into #operaciones values ('233450088114')
insert into #operaciones values ('233450088122')
insert into #operaciones values ('233450088130')
insert into #operaciones values ('233450088148')
insert into #operaciones values ('233450088155')
insert into #operaciones values ('233450088163')
insert into #operaciones values ('233480110375')
insert into #operaciones values ('233480110383')
insert into #operaciones values ('233480110390')
insert into #operaciones values ('233480110409')
insert into #operaciones values ('233480110417')
insert into #operaciones values ('233480110425')
insert into #operaciones values ('233480110433')
insert into #operaciones values ('233480110441')
insert into #operaciones values ('233480111976')
insert into #operaciones values ('233480111984')
insert into #operaciones values ('233480111991')
insert into #operaciones values ('233480112009')
insert into #operaciones values ('233480112017')
insert into #operaciones values ('233480112025')
insert into #operaciones values ('233480112033')
insert into #operaciones values ('233480112041')
insert into #operaciones values ('233510110931')
insert into #operaciones values ('233510110949')
insert into #operaciones values ('233510110956')
insert into #operaciones values ('233510110964')
insert into #operaciones values ('233510110972')
insert into #operaciones values ('233510110980')
insert into #operaciones values ('233510110997')
insert into #operaciones values ('233510111005')
insert into #operaciones values ('233510111013')
insert into #operaciones values ('233510114637')
insert into #operaciones values ('233510114645')
insert into #operaciones values ('233510114652')
insert into #operaciones values ('233510114660')
insert into #operaciones values ('233510114678')
insert into #operaciones values ('233510114686')
insert into #operaciones values ('233510114693')
insert into #operaciones values ('233510114702')
insert into #operaciones values ('213360018310')
insert into #operaciones values ('213360018328')
insert into #operaciones values ('213360018336')
insert into #operaciones values ('213360018344')
insert into #operaciones values ('213360018351')
insert into #operaciones values ('213360018369')
insert into #operaciones values ('213360018377')
insert into #operaciones values ('213360018385')
--2do Bloque operaciones
insert into #operaciones values ('210810031687')
insert into #operaciones values ('210810031694')
insert into #operaciones values ('210810031703')
insert into #operaciones values ('210810031711')
insert into #operaciones values ('210810031729')
insert into #operaciones values ('210810031737')
insert into #operaciones values ('210810035837')
insert into #operaciones values ('210810035845')
insert into #operaciones values ('210810035852')
insert into #operaciones values ('210810035860')
insert into #operaciones values ('210810035878')
insert into #operaciones values ('210810035886')
insert into #operaciones values ('210810035893')
insert into #operaciones values ('210810035901')
insert into #operaciones values ('210810037783')
insert into #operaciones values ('210810037790')
insert into #operaciones values ('210810037809')
insert into #operaciones values ('210810037817')
insert into #operaciones values ('210810037825')
insert into #operaciones values ('210810037833')
insert into #operaciones values ('210810037841')
insert into #operaciones values ('210810037858')
insert into #operaciones values ('213130002719')
insert into #operaciones values ('213130002727')
insert into #operaciones values ('213130002735')
insert into #operaciones values ('213130002743')
insert into #operaciones values ('213130002750')
insert into #operaciones values ('213130002768')
insert into #operaciones values ('213130002776')
insert into #operaciones values ('213130002784')
insert into #operaciones values ('213260009490')
insert into #operaciones values ('213260009509')
insert into #operaciones values ('213260009517')
insert into #operaciones values ('213260009525')
insert into #operaciones values ('213260009533')
insert into #operaciones values ('213260009541')
insert into #operaciones values ('213260009228')
insert into #operaciones values ('213260009236')
insert into #operaciones values ('213260009244')
insert into #operaciones values ('213260009251')
insert into #operaciones values ('213260009269')
insert into #operaciones values ('213260009277')
insert into #operaciones values ('213260009285')
insert into #operaciones values ('213260009292')
insert into #operaciones values ('213260009475')
insert into #operaciones values ('213260009483')
insert into #operaciones values ('213270012270')
insert into #operaciones values ('213270012288')
insert into #operaciones values ('213270012295')
insert into #operaciones values ('213270012304')
insert into #operaciones values ('213270012312')
insert into #operaciones values ('213270012320')
insert into #operaciones values ('213270012338')
insert into #operaciones values ('213270012346')
insert into #operaciones values ('213270012353')
insert into #operaciones values ('213290008588')
insert into #operaciones values ('213290008595')
insert into #operaciones values ('213290008604')
insert into #operaciones values ('213290008612')
insert into #operaciones values ('213290008620')
insert into #operaciones values ('213290008638')
insert into #operaciones values ('213290008646')
insert into #operaciones values ('213290008653')
insert into #operaciones values ('213310005573')
insert into #operaciones values ('213310005581')
insert into #operaciones values ('213310005598')
insert into #operaciones values ('213310005607')
insert into #operaciones values ('213310005615')
insert into #operaciones values ('213310005623')
insert into #operaciones values ('213310003016')
insert into #operaciones values ('213310003024')
insert into #operaciones values ('213310003032')
insert into #operaciones values ('213310003040')
insert into #operaciones values ('213310003057')
insert into #operaciones values ('213310003065')
insert into #operaciones values ('213310003073')
insert into #operaciones values ('213310003081')
insert into #operaciones values ('213340002490')
insert into #operaciones values ('213340002509')
insert into #operaciones values ('213340002517')
insert into #operaciones values ('213340002525')
insert into #operaciones values ('213340002533')
insert into #operaciones values ('213340002541')
insert into #operaciones values ('213340002558')
insert into #operaciones values ('213340002566')
insert into #operaciones values ('224030102863')
insert into #operaciones values ('224030102871')
insert into #operaciones values ('224030102889')
insert into #operaciones values ('224030102896')
insert into #operaciones values ('224030102904')
insert into #operaciones values ('224030102912')
insert into #operaciones values ('224030102920')
insert into #operaciones values ('224030102938')
insert into #operaciones values ('233450088221')
insert into #operaciones values ('233450088239')
insert into #operaciones values ('233450088247')
insert into #operaciones values ('233450088254')
insert into #operaciones values ('233450088262')
insert into #operaciones values ('233450088189')
insert into #operaciones values ('233450088196')
insert into #operaciones values ('233450088205')
insert into #operaciones values ('233450088213')

SELECT count(1) FROM  #operaciones
delete #operaciones WHERE banco IN (
SELECT op_banco FROM ca_operacion  where op_estado = 3)

SELECT count(1) FROM  #operaciones

create table #operaciones_a_procesar (
   id                  int identity,
   operacion           int,
   secuencial          int,
   banco               cuenta)
   
insert into #operaciones_a_procesar
select ab_operacion, ab_secuencial_pag, op_banco
from cob_cartera..ca_operacion,
     cob_cartera..ca_abono,
     cob_cartera..ca_abono_det
where op_banco          in (select banco from #operaciones)
and   ab_operacion      = op_operacion
and   ab_operacion      = abd_operacion
and   ab_secuencial_ing = abd_secuencial_ing
and   ab_estado         in ('A', 'NA', 'ING')
and   abd_tipo          = 'CON'
and   abd_concepto      in ('INT_ESPERA', 'IVA_ESPERA')

select * from #operaciones_a_procesar

select  @w_id = 0

while 1 = 1 begin

   select top 1
   @w_id         = id,
   @w_secuencial = secuencial,
   @w_banco      = banco,
   @w_operacion  = operacion
   from #operaciones_a_procesar
   where id > @w_id
   order by id asc
   
   if @@rowcount = 0 break
   
   begin TRY
      exec @w_error = cob_cartera..sp_fecha_valor 
      @s_date        = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
      @s_user        = 'usrbatch',
      @s_term        = 'consola',
      @t_trn         = 7049,	
      @i_fecha_mov   = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
      --@i_fecha_valor = @w_fecha_pro,
      @i_banco       = @w_banco, --'210800041050',
      @i_secuencial  = @w_secuencial, 
      @i_operacion   = 'R'
	  
	  if @w_error <> 0 begin
	     select 'ERROR'=@w_error, 'OPERACION'=@w_operacion
		 goto SIGUIENTE
	  end
   
    END TRY
    BEGIN CATCH 	    
    	select 'FALLA  REVERSA Operacion:' = convert(VARCHAR,@w_operacion), 
           '@w_banco:' = @w_banco
    END  CATCH 
	
    SIGUIENTE:
end


select ab_operacion, ab_secuencial_pag, op_banco
from cob_cartera..ca_operacion,
     cob_cartera..ca_abono,
     cob_cartera..ca_abono_det
where op_banco          in (select banco from #operaciones)
and   ab_operacion      = op_operacion
and   ab_operacion      = abd_operacion
and   ab_secuencial_ing = abd_secuencial_ing
and   ab_estado         in ('A', 'NA', 'ING')
and   abd_tipo          = 'CON'
and   abd_concepto      in ('INT_ESPERA', 'IVA_ESPERA')

drop table #operaciones
drop table #operaciones_a_procesar
go