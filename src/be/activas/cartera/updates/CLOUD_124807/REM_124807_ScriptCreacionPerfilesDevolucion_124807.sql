use cob_cartera
go


select * from cob_cartera..ca_tipo_trn where tt_codigo = 'DSE'

if not exists (select 1 from cob_cartera..ca_tipo_trn where tt_codigo = 'DSE')
begin
   insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('DSE', 'DEVOLUCION SEGUROS EXTERNOS', 'N', 'S')
end
go
select * from cob_cartera..ca_tipo_trn where tt_codigo = 'DSE'



select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DSE'

if not exists (select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DSE')
begin
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('GRUPAL'    , 'DSE', 'CCA_SEGDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INDIVIDUAL', 'DSE', 'CCA_SEGDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INTERCICLO', 'DSE', 'CCA_SEGDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('REVOLVENTE', 'DSE', 'CCA_SEGDEV')
end 
go

select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DSE'


use cob_conta
go


delete cob_conta..cb_perfil where pe_perfil = 'CCA_SEGDEV'
insert into cb_perfil (pe_empresa, pe_producto, pe_perfil   , pe_descripcion) values (1, 7, 'CCA_SEGDEV', 'DEVOLUCION SEGURO')


delete cob_conta..cb_det_perfil where dp_perfil = 'CCA_SEGDEV'

--'BANCO SANTANDER'-> 131
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 1         , '240123' , 'CTB_OF', '1'       , 131      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 2         , '11020205', 'CTB_OF', '2'       , 131      , 'N'         , 'O'           , NULL        , 'L')
go



--'OPEN PAY', 'CORRESP', 0, 137
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 3         , '240123' , 'CTB_OF', '1'       , 137      , 'N'         , 'O'           , NULL        , 'L')
go


insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 4         , '11020202', 'CTB_OF', '2'       , 137      , 'N'         , 'O'           , NULL        , 'L')
go


--'CORRESPONSAL OXXO',  139
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 5         , '240123' , 'CTB_OF'  , '1'       , 139      , 'N'         , 'O'           , NULL        , 'L')
go
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta   , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 6         , '11020201', 'CTB_OF', '2'       , 139      , 'N'         , 'O'           , NULL        , 'L')
go

--'ELAVON',   141
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 7         , '240123' , 'CTB_OF', '1'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEGDEV', 8         , '11020205', 'CTB_OF', '2'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go



select * from cob_conta..cb_perfil where pe_perfil = 'CCA_SEGDEV'
select * from cob_conta..cb_det_perfil where dp_perfil = 'CCA_SEGDEV'













