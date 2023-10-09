use cob_cartera
go

/* operaciones inconvenentes garantias
   '233460004910'
*/
select tg_grupo, tg_referencia_grupal, participantes = count(1)
into #operacion_grupales
from cob_cartera..ca_operacion,
     cob_credito..cr_tramite_grupal
where op_operacion       = tg_operacion     
and   tg_participa_ciclo = 'S'
and   tg_monto           > 0
and   tg_referencia_grupal in ('233460004910') --grupo 1751
group by tg_grupo, tg_referencia_grupal
order by tg_grupo, tg_referencia_grupal

select grupo = tg_grupo, operacion_grupal = max(tg_referencia_grupal)
into #ultimas_operaciones_grupales 
from #operacion_grupales
group by tg_grupo

select grupo           , 
       operacion_grupal, 
       participantes   ,
       cancelado = convert(varchar,'N')
into #operaciones_vigentes       
from #operacion_grupales,
     #ultimas_operaciones_grupales
where tg_referencia_grupal= operacion_grupal    
order by tg_grupo


select operacion_grupal_can= tg_referencia_grupal, integrantes_can =   count(1)
into #operacion_canceladas       
from #operaciones_vigentes,
     cob_credito..cr_tramite_grupal,
     cob_cartera..ca_operacion
where operacion_grupal = tg_referencia_grupal
and   tg_operacion     = op_operacion
and   op_estado        = 3
and   tg_participa_ciclo = 'S'
and   tg_monto           > 0
group by  tg_referencia_grupal


update #operaciones_vigentes
set cancelado = 'S'
from  #operacion_canceladas
where operacion_grupal_can= operacion_grupal
and   integrantes_can     = participantes

delete from #operaciones_vigentes
where cancelado = 'S'

select tg_referencia_grupal, participantes, di_dividendo, di_estado, di_fecha_can= isnull(di_fecha_can, '01/01/1900'), numero_part_dividendo = count(1)
into #operaciones_dividendos
from #operaciones_vigentes,
     cob_credito..cr_tramite_grupal,
     cob_cartera..ca_dividendo
where cancelado        = 'N'
and   operacion_grupal = tg_referencia_grupal
and   tg_operacion     = di_operacion
and   di_estado > 0
and   tg_participa_ciclo = 'S'
and   tg_monto           > 0
group by tg_referencia_grupal, participantes, di_dividendo, di_estado, isnull(di_fecha_can, '01/01/1900')
order by tg_referencia_grupal, participantes, di_dividendo, isnull(di_fecha_can, '01/01/1900')


create table #grupo_inconveniente
( secuencial            int         identity,
  tg_referencia_grupal  varchar(20) null,
  participantes         int         null,
  dividendo             int         null,
  estado                int         null,
  fecha_cancelacion     datetime    null,
  numero_int_dividendo  int         null
)


create table #operacion_secuencial
(operacion_grupal  varchar(20) null,
 operacion         int         null,
 operacion_hija    int         null,   
 secuencial_pago   int         null
)


insert into #grupo_inconveniente(
       tg_referencia_grupal, participantes, dividendo, estado, fecha_cancelacion , numero_int_dividendo)     
select tg_referencia_grupal, participantes, di_dividendo, di_estado, di_fecha_can, numero_part_dividendo
from #operaciones_dividendos
where participantes <> numero_part_dividendo
order by tg_referencia_grupal desc, di_dividendo desc, di_fecha_can desc

declare @w_secuencial       int,
        @w_operacion_grupal varchar(20),
        @w_participantes    int,
        @w_dividendo        int,
        @w_estado           int,
        @w_fecha_cancela    datetime,
        @w_numero_integ_div int,
        @w_secuencial_pago  int,
        @w_operacion        int

select @w_secuencial = 0

while 1 = 1
begin
       select top 1
              @w_secuencial       = secuencial          ,
              @w_operacion_grupal = tg_referencia_grupal,
              @w_participantes    = participantes,
              @w_dividendo        = dividendo,
              @w_estado           = estado,
              @w_fecha_cancela    = fecha_cancelacion,
              @w_numero_integ_div = numero_int_dividendo
       from #grupo_inconveniente
       where secuencial > @w_secuencial
       order by secuencial
       
       if @@rowcount = 0
          break
          
       select @w_operacion = op_operacion
       from ca_operacion
       where op_banco = @w_operacion_grupal
       
       select '@w_secuencial'       = @w_secuencial      ,
              '@w_operacion_grupal' = @w_operacion_grupal,
              '@w_participantes'    = @w_participantes   ,
              '@w_dividendo'        = @w_dividendo       ,
              '@w_estado'           = @w_estado          ,
              '@w_fecha_cancela'    = @w_fecha_cancela   ,
              '@w_numero_integ_div' = @w_numero_integ_div
       
       if @w_estado = 3
       begin              
            insert into #operacion_secuencial(
                   operacion_grupal     , operacion   , operacion_hija, secuencial_pago)
            select  tg_referencia_grupal, @w_operacion, tr_operacion  , min(tr_secuencial)
            from cob_credito..cr_tramite_grupal,
                 cob_cartera..ca_transaccion,
                 cob_cartera..ca_det_trn
            where tg_referencia_grupal = @w_operacion_grupal 
            and   tr_operacion         = tg_operacion
            and   tr_tran              in ('RPA', 'PAG')
            and   tr_operacion         = dtr_operacion
            and   tr_secuencial        = dtr_secuencial
            and   dtr_dividendo        = @w_dividendo
            and   tr_secuencial        > 0
            and   tr_estado            <> 'RV'
            and   tr_fecha_ref         = @w_fecha_cancela
            group by tg_referencia_grupal, tr_operacion
       end
       else
       begin
            insert into #operacion_secuencial(
                   operacion_grupal    , operacion   , operacion_hija, secuencial_pago)
            select tg_referencia_grupal, @w_operacion, tr_operacion  ,  min(tr_secuencial)
            from cob_credito..cr_tramite_grupal,
                 cob_cartera..ca_transaccion,
                 cob_cartera..ca_det_trn
            where tg_referencia_grupal = @w_operacion_grupal 
            and   tr_operacion         = tg_operacion
            and   tr_tran              in ('RPA', 'PAG')
            and   tr_operacion         = dtr_operacion
            and   tr_secuencial        = dtr_secuencial
            and   dtr_dividendo        = @w_dividendo
            and   tr_secuencial        > 0
            and   tr_estado            <> 'RV'
            group by tg_referencia_grupal, tr_operacion            
       end
end   

select operacion_grupal, operacion, operacion_hija, 'secuencial_ing' = min(ab_secuencial_ing)
into #abonos
from #operacion_secuencial, cob_cartera..ca_abono
where  operacion_hija  = ab_operacion
and    secuencial_pago = ab_secuencial_pag
and    ab_estado      <> 'RV'
group by operacion_grupal, operacion, operacion_hija

select operacion, 'secuencial_pago'=min(cd_secuencial)
into #pagos_grupales
from #abonos,
     cob_cartera..ca_corresponsal_det
where operacion_hija = cd_operacion
and secuencial_ing = cd_sec_ing
group by operacion


insert into tmp_114349_dcu(
  codigo_interno     ,
  secuencial_corresp ,
  operacion_hija     ,
  secuencial_pago    ,
  secuencial_ing     ,
  fecha_pago         ,
  estado_pago        ,
  estado_proc_reverso,
  estado_proc_pago   )
select distinct 
  co_codigo_interno, 
  co_secuencial    , 
  cd_operacion     , 
  ab_secuencial_pag,
  ab_secuencial_ing,
  ab_fecha_pag,
  ab_estado,
  'N',
  'N' 
from #pagos_grupales,
     ca_corresponsal_trn,
     ca_corresponsal_det,
     ca_abono
where  operacion     = co_codigo_interno
and    co_secuencial >= secuencial_pago    
and    co_estado     = 'P'
and    co_accion    <> 'R'
and    co_secuencial = cd_secuencial
and    cd_operacion  = ab_operacion
and    cd_sec_ing    = ab_secuencial_ing
and    ab_estado    <> 'RV'
order by co_codigo_interno desc,  ab_fecha_pag desc, ab_secuencial_pag desc,co_secuencial desc, cd_operacion desc

select *
from tmp_114349_dcu

