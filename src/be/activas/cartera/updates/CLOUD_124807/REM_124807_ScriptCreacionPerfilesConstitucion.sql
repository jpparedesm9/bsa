use cob_conta
go

select *
from cob_conta..cb_det_perfil
where dp_perfil = 'CCA_SEG'


delete cob_conta..cb_det_perfil
where dp_perfil = 'CCA_SEG'


--'BANCO SANTANDER'-> 131
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 1         , '11020205', 'CTB_OF', '1'       , 131      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 2         , '240123' , 'CTB_OF', '2'       , 131      , 'N'         , 'O'           , NULL        , 'L')
go

--'OPEN PAY', 'CORRESP', 0, 137
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 3         , '11020202', 'CTB_OF', '1'       , 137      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 4         , '240123' , 'CTB_OF', '2'       , 137      , 'N'         , 'O'           , NULL        , 'L')
go

--'CORRESPONSAL OXXO',  139
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta   , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 5         , '14019101', 'CTB_OF', '1'       , 139      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 6         , '240123' , 'CTB_OF', '2'       , 139      , 'N'         , 'O'           , NULL        , 'L')
go

--'ELAVON',   141
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta   , dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 7         , '14019102', 'CTB_OF', '1'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go

insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
                   values (1         , 7          , 'CCA_SEG', 8         , '240123' , 'CTB_OF', '2'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go



select *
from cob_conta..cb_det_perfil
where dp_perfil = 'CCA_SEG'
