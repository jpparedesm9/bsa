use cob_cartera
go

select * 
into cob_credito..borrar_cr_tramite_104138
from cob_credito..cr_tramite

select * 
into cob_cartera..borrar_ca_operacion_104138
from cob_cartera..ca_operacion

--///////////////////////////////////////////////////////////////////////////////////////////////////////
--  1119        PARRES 
--///////////////////////////////////////////////////////////////////////////////////////////////////////
update cob_credito..cr_tramite set tr_oficina = 1479
where tr_tramite in (
 11649 ,
 11722 ,
 11723 ,
 11724 ,
 11725 ,
 11726 ,
 11727 ,
 11728 
 )
 
 
update cob_cartera..ca_operacion set op_oficina = 1479
where op_operacion in (55765,56199,56202,56205,56208,56211,56214,56217,56220 )

update cob_cartera..ca_operacion_his set oph_oficina = 1479
where oph_operacion in (55765,56199,56202,56205,56208,56211,56214,56217,56220 )
 
update cob_cartera_his..ca_operacion set op_oficina = 1479
where op_operacion in (55765,56199,56202,56205,56208,56211,56214,56217,56220 )
 
update cob_cartera_his..ca_operacion_his set oph_oficina = 1479
where oph_operacion in (55765,56199,56202,56205,56208,56211,56214,56217,56220 )
 
 update cob_conta_super..sb_dato_operacion set do_oficina = 1479
 where do_banco in (
 '214790003277', 
 '224030008383', 
 '224030008390', 
 '224030008409', 
 '224030008417', 
 '224030008425', 
 '224030008433', 
 '224030008441', 
 '224030008458'
 )
 
--///////////////////////////////////////////////////////////////////////////////////////////////////////
-- 1109        ESMERALDA IGUALA
--///////////////////////////////////////////////////////////////////////////////////////////////////////
update cob_credito..cr_tramite set tr_oficina =  1480
where tr_tramite in (
 11485 ,
 11696 ,
 11697 ,
 11698 ,
 11699 ,
 11700 ,
 11701 ,
 11702 ,
 11703 
 )

update cob_cartera..ca_operacion set op_oficina = 1480
where op_operacion in ( 55137   ,56078   ,56081   ,56084   ,56087   ,56090   ,56093   ,56096   ,56099   )
 
update cob_cartera..ca_operacion_his set oph_oficina = 1480
where oph_operacion in ( 55137   ,56078   ,56081   ,56084   ,56087   ,56090   ,56093   ,56096   ,56099   )
 
update cob_cartera_his..ca_operacion set op_oficina = 1480
where op_operacion in ( 55137   ,56078   ,56081   ,56084   ,56087   ,56090   ,56093   ,56096   ,56099   )
 
update cob_cartera_his..ca_operacion_his set oph_oficina = 1480
where oph_operacion in ( 55137   ,56078   ,56081   ,56084   ,56087   ,56090   ,56093   ,56096   ,56099   )
 
 update cob_conta_super..sb_dato_operacion set do_oficina = 1480
 where do_banco in (
 '224030008144',
 '224030008151',
 '224030008169',
 '224030008177',
 '224030008185',
 '224030008192',
 '224030008201',
 '224030008219'
 )
 
--///////////////////////////////////////////////////////////////////////////////////////////////////////
-- 1124        ALCATRAZ ZAPATA
--///////////////////////////////////////////////////////////////////////////////////////////////////////
update cob_credito..cr_tramite set tr_oficina = 2381
where tr_tramite in (
11648 ,
11713 ,
11714 ,
11715 ,
11716 ,
11717 ,
11718 ,
11719 ,
11720
 )

update cob_cartera..ca_operacion set op_oficina = 2381
where op_operacion in (55764 ,56175 ,56178 ,56181 ,56184 ,56187 ,56190 ,56193 ,56196  )

update cob_cartera..ca_operacion_his set oph_oficina = 2381
where oph_operacion in (55764 ,56175 ,56178 ,56181 ,56184 ,56187 ,56190 ,56193 ,56196  )

update cob_cartera_his..ca_operacion set op_oficina = 2381
where op_operacion in (55764 ,56175 ,56178 ,56181 ,56184 ,56187 ,56190 ,56193 ,56196  )

update cob_cartera_his..ca_operacion_his set oph_oficina = 2381
where oph_operacion in (55764 ,56175 ,56178 ,56181 ,56184 ,56187 ,56190 ,56193 ,56196  )
 
 update cob_conta_super..sb_dato_operacion set do_oficina = 2381
 where do_banco in (
'224030008300',
'224030008318',
'224030008326',
'224030008334',
'224030008342',
'224030008359',
'224030008367',
'224030008375'
 )
 
--///////////////////////////////////////////////////////////////////////////////////////////////////////
-- 1103        GRUPO AZUL  
--///////////////////////////////////////////////////////////////////////////////////////////////////////
update cob_credito..cr_tramite set tr_oficina = 1479
where tr_tramite in (
11397  ,   
11705  ,   
11706  ,   
11707  ,   
11708  ,   
11709  ,   
11710  ,   
11711  ,   
11712     
)

update cob_cartera..ca_operacion set op_oficina = 1479
where op_operacion in ( 54742  , 56151  , 56154  , 56157  , 56160  , 56163  , 56166  , 56169  , 56172   )
 
update cob_cartera..ca_operacion_his set oph_oficina = 1479
where oph_operacion in ( 54742  , 56151  , 56154  , 56157  , 56160  , 56163  , 56166  , 56169  , 56172   )
 
update cob_cartera_his..ca_operacion set op_oficina = 1479
where op_operacion in ( 54742  , 56151  , 56154  , 56157  , 56160  , 56163  , 56166  , 56169  , 56172   )
 
update cob_cartera_his..ca_operacion_his set oph_oficina = 1479
where oph_operacion in ( 54742  , 56151  , 56154  , 56157  , 56160  , 56163  , 56166  , 56169  , 56172   )

 
 update cob_conta_super..sb_dato_operacion set do_oficina = 1479
 where do_banco in (
 '214790003178', 
'224030008227', 
'224030008235', 
'224030008243', 
'224030008250', 
'224030008268', 
'224030008276', 
'224030008284', 
'224030008291'
 )
 
--///////////////////////////////////////////////////////////////////////////////////////////////////////
-- 289         RISUENAS   
--///////////////////////////////////////////////////////////////////////////////////////////////////////
update cob_credito..cr_tramite set tr_oficina = 3345, tr_oficial = 69
where tr_tramite in (
10618 ,
11668 ,
11669 ,
11670 ,
11671 ,
11672 ,
11673 ,
11674 ,
11675 ,
11676 )

update cob_cartera..ca_operacion set   op_oficina = 3345, op_oficial = 69
where op_operacion in (51091 , 55876 , 55879 , 55882 , 55885 , 55888 , 55891 , 55894 , 55897 , 55900   )
 
update cob_cartera..ca_operacion_his set   oph_oficina = 3345, oph_oficial = 69
where oph_operacion in (51091 , 55876 , 55879 , 55882 , 55885 , 55888 , 55891 , 55894 , 55897 , 55900   )
 
update cob_cartera_his..ca_operacion set   op_oficina = 3345, op_oficial = 69
where op_operacion in (51091 , 55876 , 55879 , 55882 , 55885 , 55888 , 55891 , 55894 , 55897 , 55900   )
 
update cob_cartera_his..ca_operacion_his set   oph_oficina = 3345, oph_oficial = 69
where oph_operacion in (51091 , 55876 , 55879 , 55882 , 55885 , 55888 , 55891 , 55894 , 55897 , 55900   )

 
 update cob_conta_super..sb_dato_operacion set do_oficina = 3345
 where do_banco in (
 '233450014192', 
'224030008052', 
'224030008060', 
'224030008078', 
'224030008086', 
'224030008093', 
'224030008102', 
'224030008110', 
'224030008128', 
'224030008136'
 )

 update cobis..cl_cliente_grupo set cg_oficial = 69
 where cg_grupo = 289
 
 
 go
 
 
 
 