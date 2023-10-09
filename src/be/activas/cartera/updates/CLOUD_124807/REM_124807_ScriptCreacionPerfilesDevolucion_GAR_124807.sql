use cob_cartera
go


select * from cob_cartera..ca_tipo_trn where tt_codigo = 'DGL'

if not exists (select 1 from cob_cartera..ca_tipo_trn where tt_codigo = 'DGL')
begin
   insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('DGL', 'DEVOLUCION GARANTIAS LIQUIDAS', 'N', 'S')
end
go
select * from cob_cartera..ca_tipo_trn where tt_codigo = 'DGL'



select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DGL'

if not exists (select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DGL')
begin
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('GRUPAL'    , 'DGL', 'CCA_GARDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INDIVIDUAL', 'DGL', 'CCA_GARDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INTERCICLO', 'DGL', 'CCA_GARDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('REVOLVENTE', 'DGL', 'CCA_GARDEV')
end 
go

select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DGL'


use cob_conta
go


delete cob_conta..cb_perfil where pe_perfil = 'CCA_GARDEV'
insert into cb_perfil (pe_empresa, pe_producto, pe_perfil   , pe_descripcion) values (1, 7, 'CCA_GARDEV', 'DEVOLUCION GARANTIAS')


delete cob_conta..cb_det_perfil where dp_perfil = 'CCA_GARDEV'

--'BANCO SANTANDER'-> 131
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 1         , '240191' , 'CTB_OF', '1'       , 131      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 2         , '11020205', 'CTB_OF', '2'       , 131      , 'N'         , 'O'           , NULL        , 'L')
go



--'OPEN PAY', 'CORRESP', 0, 137
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 3         , '240191' , 'CTB_OF', '1'       , 137      , 'N'         , 'O'           , NULL        , 'L')
go


insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 4         , '11020202', 'CTB_OF', '2'       , 137      , 'N'         , 'O'           , NULL        , 'L')
go


--'CORRESPONSAL OXXO',  139
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 5         , '240191' , 'CTB_OF'  , '1'       , 139      , 'N'         , 'O'           , NULL        , 'L')
go
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta   , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 6         , '11020201', 'CTB_OF', '2'       , 139      , 'N'         , 'O'           , NULL        , 'L')
go

--'ELAVON',   141
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 7         , '240191' , 'CTB_OF', '1'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_GARDEV', 8         , '11020205', 'CTB_OF', '2'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go



select * from cob_conta..cb_perfil where pe_perfil = 'CCA_GARDEV'
select * from cob_conta..cb_det_perfil where dp_perfil = 'CCA_GARDEV'



select *
from cob_conta..cb_det_perfil
where dp_perfil  = 'CCA_GAR'
and   dp_codval  = 141
and   dp_debcred = 1 

update cob_conta..cb_det_perfil set
dp_cuenta = '14019102'
where dp_perfil  = 'CCA_GAR'
and   dp_codval  = 141
and   dp_debcred = 1 


select *
from cob_conta..cb_det_perfil
where dp_perfil  = 'CCA_GAR'
and   dp_codval  = 141
and   dp_debcred = 1 










