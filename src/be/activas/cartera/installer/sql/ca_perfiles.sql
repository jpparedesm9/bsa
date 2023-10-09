use cob_conta
go

set nocount on

go
print 'BORRANDO PERFILES ANTERIORES'
go

-- ACTIVOS
delete cb_perfil 
where pe_empresa  = 1 
and   pe_producto = 7
and   pe_perfil in ('BOC_ACT', 'CAS_ACT', 'CAU_ACT', 'EST_ACT', 'DES_ACT', 'IOC_ACT', 'PAG_ACT', 'RPA_ACT', 'TCO_ACT','SUA_ACT')

delete cb_det_perfil 
where dp_empresa  = 1 
and   dp_producto = 7
and   dp_perfil in ('BOC_ACT', 'CAS_ACT', 'CAU_ACT', 'EST_ACT', 'DES_ACT', 'IOC_ACT', 'PAG_ACT', 'RPA_ACT', 'TCO_ACT','SUA_ACT')

-- ADMINISTRADOS

delete cb_perfil 
where pe_empresa  = 1 
and   pe_producto = 7
and   pe_perfil in ('BOC_ADM','CAU_ADM', 'DES_ADM', 'PAG_ADM', 'TCO_ADM','CAS_ADM')

delete cb_det_perfil 
where dp_empresa  = 1 
and   dp_producto = 7
and   dp_perfil in ('BOC_ADM','CAU_ADM', 'DES_ADM', 'PAG_ADM', 'TCO_ADM','CAS_ADM')	

-- PASIVOS

delete cb_perfil 
where pe_empresa  = 1 
and   pe_producto = 7
and   pe_perfil in ('BOC_PAS', 'CAU_PAS', 'DES_PAS', 'PAG_PAS', 'RPA_PAS', 'TCO_PAS')


delete cb_det_perfil 
where dp_empresa  = 1 
and   dp_producto = 7
and   dp_perfil in ('BOC_PAS', 'CAU_PAS', 'DES_PAS', 'PAG_PAS', 'RPA_PAS', 'TCO_PAS')

-- PROVISIONES

delete cb_perfil 
where pe_empresa  = 1 
and   pe_producto = 21
and   pe_perfil in ('BOC_PRV')

delete cb_det_perfil 
where dp_empresa  = 1 
and   dp_producto = 21
and   dp_perfil in ('BOC_PRV')


go
PRINT 'INGRESO DE LAS CABECERAS DE LOS PERFILES CONTABLES'
go

-- PERFILES ACTIVOS
insert into cb_perfil values(1, 7, 'BOC_ACT',  'BALANCE OPERATIVO CONTABLE (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'CAS_ACT',  'CASTIGO DE OPERACIONES (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'CAU_ACT',  'CAUSACION DIARIA (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'EST_ACT',  'CAMBIO DE ESTADO A VENCIDO (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'DES_ACT',  'DESEMBOLSO DE OPERACIONES (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'IOC_ACT',  'INGRESO OTROS CARGOS (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'PAG_ACT',  'APLICACION DE UN PAGO (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'RPA_ACT',  'REGISTRO DE UN PAGO (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'TCO_ACT',  'TRASLADO DE CARTERA (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'SUA_ACT',  'SUSPENSO (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'CCA_DSC',  'DESCUENTO DE TASA')


-- PERFILES ADMINISTRADOS
insert into cb_perfil values(1, 7, 'BOC_ADM',  'BALANCE OPERATIVO CONTABLE (PRESTAMOS ADMINISTRADOS)')
insert into cb_perfil values(1, 7, 'CAU_ADM',  'CAUSACION DIARIA (PRESTAMOS ADMINISTRADOS)')
insert into cb_perfil values(1, 7, 'DES_ADM',  'DESEMBOLSO DE OPERACIONES (PRESTAMOS ADMINISTRADOS)')
insert into cb_perfil values(1, 7, 'PAG_ADM',  'APLICACION DE UN PAGO (PRESTAMOS ADMINISTRADOS)')
insert into cb_perfil values(1, 7, 'TCO_ADM',  'TRASLADO DE CARTERA (PRESTAMOS ADMINISTRADOS)')
insert into cb_perfil values(1, 7, 'CAS_ADM',  'CASTIGOS DE CARTERA (PRESTAMOS ADMINISTRADOS)')

--PASIVAS

insert into cb_perfil values(1, 7, 'BOC_PAS',  'BALANCE OPERATIVO CONTABLE (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'CAU_PAS',  'CAUSACION DIARIA (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'DES_PAS',  'DESEMBOLSO DE OPERACIONES (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'PAG_PAS',  'APLICACION DE UN PAGO (PRESTAMOS ACTIVOS)')
insert into cb_perfil values(1, 7, 'RPA_PAS',  'REGISTRO DE UN PAGO (PRESTAMOS ACTIVOS)')


-- PERFILES PROVISIONES

insert into cb_perfil values(1,21, 'BOC_PRV',  'BALANCE OPERATIVO CONTABLE (PROVISIONES)')


go
PRINT 'INGRESO DE LOS DETALLES DE LOS PERFILES CONTABLES (OPERACIONES ACTIVAS)'
go


insert into cb_det_perfil values (1, 7,  'BOC_ACT',   1, 'CAP_VIG_14',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   2, 'CAP_CAS_81',   'CTB_OF',  '2',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   3, 'INT_VIG_16',   'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   4, 'INT_CAS_81',   'CTB_OF',  '2',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   5, 'INT_SUS_64',   'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   6, 'IMO_VIG_16',   'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   7, 'IMO_CAS_81',   'CTB_OF',  '2',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   8, 'IMO_SUS_64',   'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',   9, 'COM_VEN_16',   'CTB_OF',  '2',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  10, 'COM_CAS_81',   'CTB_OF',  '2',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  11, 'COM_SUS_64',   'CTB_OF',  '2',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  12, 'COM_VEN_16',   'CTB_OF',  '2',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  13, 'COM_CAS_81',   'CTB_OF',  '2',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  14, 'COM_SUS_64',   'CTB_OF',  '2',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  15, 'SEG_VEN_16',   'CTB_OF',  '2',  16010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  16, 'SEG_CAS_81',   'CTB_OF',  '2',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  17, 'SEG_SUS_64',   'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  18, 'FNG_VEN_16',   'CTB_OF',  '2',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  19, 'FNG_CAS_81',   'CTB_OF',  '2',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  20, 'FNG_SUS_64',   'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  21, 'FNG_VEN_16',   'CTB_OF',  '2',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  22, 'FNG_CAS_81',   'CTB_OF',  '2',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  23, 'FNG_SUS_64',   'CTB_OF',  '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  24, 'JUD_VEN_16',   'CTB_OF',  '2',  23010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  25, 'JUD_VEN_16',   'CTB_OF',  '2',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ACT',  26, 'JUD_CAS_81',   'CTB_OF',  '2',  23040, 'N', 'D', NULL,  'L')


--CASTIGOS

insert into cb_det_perfil values (1, 7,  'CAS_ACT',   1, 'CAP_VIG_14',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   2, 'CAP_PRO_14',   'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   3, 'CONTRA8305',   'CTB_OF',  '2',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   4, 'CAP_CAS_81',   'CTB_OF',  '1',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   5, 'INT_VIG_16',   'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   6, 'INT_PRO_16',   'CTB_OF',  '1',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   7, 'CONTRA8305',   'CTB_OF',  '2',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   8, 'INT_CAS_81',   'CTB_OF',  '1',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',   9, 'INT_SUS_63',   'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  10, 'INT_SUS_64',   'CTB_OF',  '1',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  11, 'IMO_VIG_16',   'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  12, 'IMO_PRO_16',   'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  13, 'CONTRA8305',   'CTB_OF',  '2',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  14, 'IMO_CAS_81',   'CTB_OF',  '1',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  15, 'IMO_SUS_63',   'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  16, 'IMO_SUS_64',   'CTB_OF',  '1',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  17, 'COM_VEN_16',   'CTB_OF',  '2',  13020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  18, 'COM_PRO_16',   'CTB_OF',  '1',  13020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  19, 'CONTRA8305',   'CTB_OF',  '2',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  20, 'COM_CAS_81',   'CTB_OF',  '1',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  21, 'COM_VEN_16',   'CTB_OF',  '2',  14020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  22, 'COM_PRO_16',   'CTB_OF',  '1',  14020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  23, 'CONTRA8305',   'CTB_OF',  '2',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  24, 'COM_CAS_81',   'CTB_OF',  '1',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  25, 'SEG_VEN_16',   'CTB_OF',  '2',  16020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  26, 'SEG_PRO_16',   'CTB_OF',  '1',  16020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  27, 'CONTRA8305',   'CTB_OF',  '2',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  28, 'SEG_CAS_81',   'CTB_OF',  '1',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  29, 'FNG_VEN_16',   'CTB_OF',  '2',  17020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  30, 'FNG_PRO_16',   'CTB_OF',  '1',  17020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  31, 'CONTRA8305',   'CTB_OF',  '2',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  32, 'FNG_CAS_81',   'CTB_OF',  '1',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  33, 'FNG_VEN_16',   'CTB_OF',  '2',  18020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  34, 'FNG_PRO_16',   'CTB_OF',  '1',  18020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  35, 'CONTRA8305',   'CTB_OF',  '2',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  36, 'FNG_CAS_81',   'CTB_OF',  '1',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  37, 'JUD_VEN_16',   'CTB_OF',  '2',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  38, 'JUD_PRO_16',   'CTB_OF',  '1',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  39, 'CONTRA8305',   'CTB_OF',  '2',  23040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  40, 'JUD_CAS_81',   'CTB_OF',  '1',  23040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  41, 'CONTRA8305',   'CTB_OF',  '2',  21040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ACT',  42, 'HON_CAS_81',   'CTB_OF',  '1',  21040, 'N', 'D', NULL,  'L')


--CASUSACION DE INTERESES


insert into cb_det_perfil values (1, 7,  'CAU_ACT',   1, 'INT_VIG_16',  'CTB_OF',  '1',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   2, 'INT_VIG_41',  'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   3, 'CONTRA8305',  'CTB_OF',  '2',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   4, 'INT_CAS_81',  'CTB_OF',  '1',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   5, 'INT_SUS_64',  'CTB_OF',  '1',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   6, 'INT_SUS_63',  'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   7, 'IMO_VIG_16',  'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   8, 'IMO_VEN_41',  'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',   9, 'IMO_VIG_16',  'CTB_OF',  '1',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  10, 'IMO_VEN_41',  'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  11, 'IMO_CAS_81',  'CTB_OF',  '1',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  12, 'CONTRA8305',  'CTB_OF',  '2',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  13, 'IMO_SUS_64',  'CTB_OF',  '1',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  14, 'IMO_SUS_63',  'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  15, 'COM_VEN_16',  'CTB_OF',  '1',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  16, 'COM_VIG_41',  'CTB_OF',  '2',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  17, 'COM_CAS_81',  'CTB_OF',  '1',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  18, 'CONTRA8305',  'CTB_OF',  '2',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  19, 'COM_SUS_63',  'CTB_OF',  '2',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  20, 'COM_SUS_64',  'CTB_OF',  '1',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  21, 'COM_VEN_16',  'CTB_OF',  '1',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  22, 'IVA_PAG_25',  'CTB_IMP', '2',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  23, 'COM_CAS_81',  'CTB_OF',  '1',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  24, 'CONTRA8305',  'CTB_OF',  '2',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  25, 'COM_SUS_63',  'CTB_OF',  '2',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  26, 'COM_SUS_64',  'CTB_OF',  '1',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  27, 'SEG_VEN_16',  'CTB_OF',  '1',  16010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  28, 'SEG_PAG_25',  'CTB_OF',  '2',  16010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  29, 'SEG_CAS_81',  'CTB_OF',  '1',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  30, 'CONTRA8305',  'CTB_OF',  '2',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  31, 'SEG_SUS_63',  'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  32, 'SEG_SUS_64',  'CTB_OF',  '1',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  33, 'FNG_VEN_16',  'CTB_OF',  '1',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  34, 'FNG_PAG_25',  'CTB_OF',  '2',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  35, 'CONTRA8305',  'CTB_OF',  '2',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  36, 'FNG_CAS_81',  'CTB_OF',  '1',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  37, 'FNG_SUS_63',  'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  38, 'FNG_SUS_64',  'CTB_OF',  '1',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  39, 'FNG_VEN_16',  'CTB_OF',  '1',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  40, 'IVA_PAG_25',  'CTB_IMP', '2',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  41, 'CONTRA8305',  'CTB_OF',  '2',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  42, 'FNG_CAS_81',  'CTB_OF',  '1',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  43, 'FNG_SUS_63',  'CTB_OF',  '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ACT',  44, 'FNG_SUS_64',  'CTB_OF',  '1',  18090, 'N', 'D', NULL,  'L')


--DESEMBOLSOS

insert into cb_det_perfil values (1, 7,  'DES_ACT',   1, '16879500800', 'CTB_OF',  '2',  101,   'N', 'D', NULL,  'L') --CON CAJAS
insert into cb_det_perfil values (1, 7,  'DES_ACT',   2, '16879500900', 'CTB_OF',  '2',  110,   'N', 'D', NULL,  'L') --RENOVACIONES
insert into cb_det_perfil values (1, 7,  'DES_ACT',   3, 'CH_OTR_BAN',  'CTB_OF',  '2',  113,   'N', 'D', NULL,  'L') --DES.CHEQUES
insert into cb_det_perfil values (1, 7,  'DES_ACT',   4, 'CAP_VIG_14',  'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',   5, 'COM_VIG_41',  'CTB_OF',  '2',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',   6, 'IVA_PAG_25',  'CTB_IMP', '2',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',   7, 'SEG_PAG_25',  'CTB_OF',  '2',  15010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',   8, 'FNG_PAG_25',  'CTB_OF',  '2',  17010, 'N', 'D', NULL,  'L')--cambia
insert into cb_det_perfil values (1, 7,  'DES_ACT',   9, 'IVA_PAG_25',  'CTB_IMP', '2',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  10, 'APE_VIG_41',  'CTB_OF',  '2',  19010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  11, 'EST_CRE_41',  'CTB_OF',  '1',  19030, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  12, 'APE_VIG_41',  'CTB_OF',  '2',  19030, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  13, 'IVA_PAG_25',  'CTB_IMP', '2',  20010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  14, 'EXQ_PAG_25',  'CTB_OF',  '2',  25010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  15, 'SEG_PAG_25',  'CTB_OF',  '2',  26010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ACT',  16, '21651500005', 'CTB_OF',  '2',  121,   'N', 'D', NULL,  'L')

--INGRESO OTROS CARGOS

insert into cb_det_perfil values (1, 7,  'IOC_ACT',   1,  'HON_VEN_16',  'CTB_OF',  '1',  21010, 'N', 'D', NULL,  'L')--eliminar
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   2,  'HON_ABO_25',  'CTB_OF',  '2',  21010, 'N', 'D', NULL,  'L')--eliminar
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   3,  'HON_VEN_16',  'CTB_OF',  '1',  22010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   4,  'IVA_PAG_25',  'CTB_IMP', '2',  22010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   5,  'JUD_VEN_16',  'CTB_OF',  '1',  23010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   6, '16879500800',  'CTB_OF',  '2',  23010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   7,  'JUD_VEN_16',  'CTB_OF',  '1',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   8, '16879500800',  'CTB_OF',  '2',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',   9, '27959500998',  'CTB_OF',  '2',  32010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  10, '16879500998',  'CTB_OF',  '1',  32010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  11, '27959500998',  'CTB_OF',  '2',  32020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  12, '16879500998',  'CTB_OF',  '1',  32020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  13, '27959500998',  'CTB_OF',  '2',  32030, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  14, '16879500998',  'CTB_OF',  '1',  32030, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  15, '27959500998',  'CTB_OF',  '2',  32040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  16, '16879500998',  'CTB_OF',  '1',  32040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  17, '27959500998',  'CTB_OF',  '2',  32090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  18, '16879500998',  'CTB_OF',  '1',  32090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  19, '27959500998',  'CTB_OF',  '2',  32990, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'IOC_ACT',  20, '16879500998',  'CTB_OF',  '1',  32990, 'N', 'D', NULL,  'L')


--PAGOS

insert into cb_det_perfil values (1, 7,  'PAG_ACT',   1, '16879500700',  'CTB_OF',  '1',  100,   'N', 'D', NULL,  'L') 
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   2, '25959500800',  'CTB_OF',  '2',  112,   'N', 'D', NULL,  'L') 
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   3, 'CAP_VIG_14',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   4, 'CAP_VIG_14',   'CTB_OF',  '2',  10090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   5, '52951500005',  'CTB_OF',  '1',  10017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   6, 'CAP_VIG_14',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   7, '52951500005',  'CTB_OF',  '1',  10027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   8, 'CAP_REC_42',   'CTB_OF',  '2',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',   9, 'CONTRA8305',   'CTB_OF',  '1',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  10, 'CAP_CAS_81',   'CTB_OF',  '2',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  11, 'CAP_REC_42',   'CTB_OF',  '1',  10047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  12, 'INT_VIG_16',   'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  13, '52951500005',  'CTB_OF',  '1',  11017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  14, 'INT_VIG_16',   'CTB_OF',  '2',  11020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  15, '52951500005',  'CTB_OF',  '1',  11027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  16, 'INT_CAS_42',   'CTB_OF',  '2',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  17, 'CONTRA8305',   'CTB_OF',  '1',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  18, 'INT_CAS_81',   'CTB_OF',  '2',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  19, 'INT_CAS_42',   'CTB_OF',  '1',  11047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  20, 'INT_VIG_41',   'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  21, 'INT_SUS_63',   'CTB_OF',  '1',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  22, 'INT_SUS_64',   'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  23, 'INT_VIG_41',   'CTB_OF',  '1',  11097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  24, 'IMO_VIG_16',   'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  25, '52951500005',  'CTB_OF',  '1',  12017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  26, 'IMO_VIG_16',   'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  27, '52951500005',  'CTB_OF',  '1',  12027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  28, 'IMO_CAS_42',   'CTB_OF',  '2',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  29, 'CONTRA8305',   'CTB_OF',  '1',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  30, 'IMO_CAS_81',   'CTB_OF',  '2',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  31, 'IMO_CAS_42',   'CTB_OF',  '1',  12047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  32, 'IMO_SUS_63',   'CTB_OF',  '1',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  33, 'IMO_SUS_64',   'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  34, 'IMO_SUS_41',   'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  35, 'IMO_SUS_41',   'CTB_OF',  '1',  12097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  36, 'COM_VEN_16',   'CTB_OF',  '2',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  37, '52951500005',  'CTB_OF',  '1',  13017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  38, 'COM_VEN_16',   'CTB_OF',  '2',  13020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  39, '52951500005',  'CTB_OF',  '1',  13027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  40, 'COM_REC_42',   'CTB_OF',  '2',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  41, 'COM_CAS_81',   'CTB_OF',  '2',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  42, 'CONTRA8305',   'CTB_OF',  '1',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  43, 'COM_REC_42',   'CTB_OF',  '1',  13047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  44, '52951500005',  'CTB_OF',  '1',  13097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  45, 'COM_SUS_63',   'CTB_OF',  '1',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  46, 'COM_SUS_64',   'CTB_OF',  '2',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  47, 'COM_REC_42',   'CTB_OF',  '2',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  48, '52951500005',  'CTB_OF',  '2',  13097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  49, 'COM_VEN_16',   'CTB_OF',  '2',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  50, 'COM_VEN_16',   'CTB_OF',  '1',  14017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  51, 'COM_VEN_16',   'CTB_OF',  '2',  14020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  52, '52951500005',  'CTB_OF',  '1',  14027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  53, 'COM_REC_42',   'CTB_OF',  '2',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  54, 'COM_CAS_81',   'CTB_OF',  '2',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  55, 'CONTRA8305',   'CTB_OF',  '1',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  56, 'COM_REC_42',   'CTB_OF',  '1',  14047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  57, 'IVA_PAG_25',   'CTB_IMP', '2',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  58, 'COM_SUS_63',   'CTB_OF',  '1',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  59, 'COM_SUS_64',   'CTB_OF',  '2',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  60, '52951500005',  'CTB_OF',  '1',  14097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  61, 'SEG_PAG_25',   'CTB_OF',  '2',  16010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  62, '52951500005',  'CTB_OF',  '1',  16017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  63, 'SEG_VEN_16',   'CTB_OF',  '2',  16020, 'N', 'D', NULL,  'L')--cambiar
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  64, '52951500005',  'CTB_OF',  '1',  16027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  65, 'SEG_REC_42',   'CTB_OF',  '2',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  66, 'SEG_CAS_81',   'CTB_OF',  '2',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  67, 'CONTRA8305',   'CTB_OF',  '1',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  68, 'SEG_REC_42',   'CTB_OF',  '1',  16047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  69, 'SEG_SUS_63',   'CTB_OF',  '1',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  70, 'SEG_SUS_64',   'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  71, 'SEG_REC_42',   'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  72, '52951500005',  'CTB_OF',  '1',  16097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  73, 'FNG_PAG_25',   'CTB_OF',  '2',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  74, '52951500005',  'CTB_OF',  '1',  17017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  75, 'FNG_VEN_16',   'CTB_OF',  '2',  17020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  76, '52951500005',  'CTB_OF',  '1',  17027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  77, 'FNG_REC_42',   'CTB_OF',  '2',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  78, 'CONTRA8305',   'CTB_OF',  '1',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  79, 'FNG_CAS_81',   'CTB_OF',  '2',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  80, 'FNG_REC_42',   'CTB_OF',  '1',  17047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  81, 'FNG_SUS_63',   'CTB_OF',  '1',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  82, 'FNG_SUS_64',   'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  83, 'FNG_REC_42',   'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  84, '52951500005',  'CTB_OF',  '1',  17097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  85, 'IVA_PAG_25',   'CTB_IMP', '2',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  86, '52951500005',  'CTB_OF',  '1',  18017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  87, 'FNG_VEN_16',   'CTB_OF',  '2',  18020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  88, '52951500005',  'CTB_OF',  '1',  18027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  89, 'FNG_REC_42',   'CTB_OF',  '2',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  90, 'CONTRA8305',   'CTB_OF',  '1',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  91, 'FNG_CAS_81',   'CTB_OF',  '2',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  92, 'FNG_REC_42',   'CTB_OF',  '1',  18047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  93, 'FNG_SUS_63',   'CTB_OF',  '1',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  94, 'FNG_SUS_64',   'CTB_OF',  '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  95, 'FNG_REC_42',   'CTB_OF',  '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  96, '52951500005',  'CTB_OF',  '1',  18097, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  97, 'HON_ABO_25',   'CTB_OF',  '2',  21010, 'N', 'D', NULL,  'L')--CAMBIO BH
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  98, '52951500005',  'CTB_OF',  '1',  21017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT',  99, 'HON_ABO_25',   'CTB_OF',  '2',  21020, 'N', 'D', NULL,  'L')--CAMBIA BH
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 100, '52951500005',  'CTB_OF',  '1',  21027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 101, 'HON_REC_42',   'CTB_OF',  '2',  21040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 102, 'CONTRA8305',   'CTB_OF',  '1',  21040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 103, 'HON_CAS_81',   'CTB_OF',  '2',  21040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 104, 'HON_REC_42',   'CTB_OF',  '1',  21047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 105, 'HON_ABO_25',   'CTB_OF',  '2',  22010, 'N', 'D', NULL,  'L')--CAMBIA BH
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 106, '52951500005',  'CTB_OF',  '1',  22017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 107, 'HON_ABO_25',   'CTB_OF',  '2',  22020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 108, '52951500005',  'CTB_OF',  '1',  22027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 109, 'HON_REC_42',   'CTB_OF',  '2',  22040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 110, 'CONTRA8305',   'CTB_OF',  '1',  22040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 111, 'HON_CAS_81',   'CTB_OF',  '2',  22040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 112, 'HON_REC_42',   'CTB_OF',  '1',  22047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 113, 'JUD_VEN_16',   'CTB_OF',  '2',  23010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 114, '52951500005',  'CTB_OF',  '1',  23017, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 115, 'JUD_VEN_16',   'CTB_OF',  '2',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 116, '52951500005',  'CTB_OF',  '1',  23027, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 117, 'JUD_REC_42',   'CTB_OF',  '2',  23040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 118, 'CONTRA8305',   'CTB_OF',  '1',  23040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 119, 'JUD_CAS_81',   'CTB_OF',  '2',  23040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 120, 'JUD_REC_42',   'CTB_OF',  '1',  23047, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 121, 'COM_CANAL' ,   'CTB_OF',  '2',  29010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 122, 'GASTO_COM' ,   'CTB_OF',  '1',  29010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 123, 'IVA_PAG_25',   'CTB_IMP', '2',  30010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 124, 'COM_BANCO' ,   'CTB_OF',  '2',  31010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ACT', 125, '16879500998',   'CTB_OF',  '2',  32010, 'N', 'D', NULL,  'L')



 
--REGISTRO DE PAGOS

insert into cb_det_perfil values (1, 7,  'RPA_ACT',   1, '16879500700',  'CTB_OF',  '2',  100,   'N', 'D', NULL,  'L')--VAC0
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   2, '11050500005',  'CTB_OF',  '1',  101,   'N', 'D', NULL,  'L')--CAJAS EFEC
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   3, '11051000005',  'CTB_OF',  '1',  102,   'N', 'D', NULL,  'L')--CAJAS CHPR.
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   4, '11051000005',  'CTB_OF',  '1',  103,   'N', 'D', NULL,  'L')--CAJAS CHLO
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   5, '11051000005',  'CTB_OF',  '1',  104,   'N', 'D', NULL,  'L')--CAJAS CHOTR
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   6, '52959500005',  'CTB_OF',  '1',  105,   'N', 'D', NULL,  'L')--PAGOS MINIMOS
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   7, '16879500774',  'CTB_OF',  '1',  106,   'N', 'D', NULL,  'L')--EDATEL
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   8, '16879500773',  'CTB_OF',  '1',  107,   'N', 'O', NULL,  'L')--BALOTO
insert into cb_det_perfil values (1, 7,  'RPA_ACT',   9, 'CH_OTR_BAN' ,  'CTB_OF',  '1',  108,   'N', 'D', NULL,  'L')--CONSIGNACIONES
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  10, '16872000005',  'CTB_OF',  '1',  109,   'N', 'O', NULL,  'L')--SINESTROS (SEGUROS)
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  11, '16879500900',  'CTB_OF',  '1',  110,   'N', 'O', NULL,  'L')--RENOVACIONES
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  12, '16879500775',  'CTB_OF',  '1',  111,   'N', 'D', NULL,  'L')--FNG
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  13, '25959500800',  'CTB_OF',  '1',  112,   'N', 'D', NULL,  'L')--SOBRANTES
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  14, '16879500999',  'CTB_OF',  '1',  115,   'N', 'D', NULL,  'L')--SIC.FUERA_LINEA
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  15, '11050500005',  'CTB_OF',  '1',  116,   'N', 'O', NULL,  'L')--SIC.EFECTIVO
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  16, '11051000005',  'CTB_OF',  '1',  117,   'N', 'D', NULL,  'L')--SIC.CHEQUE
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  17, '16879500999',  'CTB_OF',  '1',  118,   'N', 'D', NULL,  'L')--SIC.DOC
insert into cb_det_perfil values (1, 7,  'RPA_ACT',  18, '27959500998',  'CTB_OF',  '1',  119,   'N', 'D', NULL,  'L')--CXC berry

-- CAMBIO DE ESTADO AUTOMATICO A VENCIDO

insert into cb_det_perfil values (1, 7,  'SUA_ACT',   1, 'INT_VIG_16',   'CTB_OF',  '1',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   2, 'INT_VIG_41',   'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   3, 'INT_SUS_64',   'CTB_OF',  '1',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   4, 'INT_SUS_63',   'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   5, 'IMO_VIG_16',   'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   6, 'IMO_VEN_41',   'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   7, 'IMO_SUS_64',   'CTB_OF',  '1',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   8, 'IMO_SUS_63',   'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',   9, 'COM_VEN_16',   'CTB_OF',  '1',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  10, 'COM_VIG_41',   'CTB_OF',  '2',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  11, 'COM_SUS_63',   'CTB_OF',  '2',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  12, 'COM_SUS_64',   'CTB_OF',  '1',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  13, 'COM_VEN_16',   'CTB_OF',  '1',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  14, 'IVA_PAG_25',   'CTB_IMP', '2',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  15, 'COM_SUS_63',   'CTB_OF',  '2',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  16, 'COM_SUS_64',   'CTB_OF',  '1',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  17, 'SEG_VEN_16',   'CTB_OF',  '1',  16010, 'N', 'D', NULL,  'L')--eliminar
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  18, 'SEG_PAG_25',   'CTB_OF',  '2',  16010, 'N', 'D', NULL,  'L')--eliminar
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  19, 'SEG_SUS_63',   'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  20, 'SEG_SUS_64',   'CTB_OF',  '1',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  21, 'SEG_CAU_51',   'CTB_OF',  '1',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  22, 'SEG_PAG_25',   'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  23, 'FNG_VEN_16',   'CTB_OF',  '1',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  24, 'FNG_PAG_25',   'CTB_OF',  '2',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  25, 'FNG_SUS_63',   'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  26, 'FNG_SUS_64',   'CTB_OF',  '1',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  27, 'FNG_CAU_51',   'CTB_OF',  '1',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  28, 'FNG_PAG_25',   'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  29, 'FNG_VEN_16',   'CTB_OF',  '1',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  30, 'IVA_PAG_25',   'CTB_IMP', '2',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  31, 'FNG_SUS_63',   'CTB_OF',  '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  32, 'FNG_SUS_64',   'CTB_OF',  '1',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  33, 'IVA_PAG_25',   'CTB_IMP', '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'SUA_ACT',  34, 'FNG_IVA_51',   'CTB_IMP', '1',  18090, 'N', 'D', NULL,  'L')

--TRASLADO DE CARTERA

insert into cb_det_perfil values (1, 7,  'TCO_ACT',   1, 'CAP_VIG_14',   'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   2, 'CAP_VIG_14',   'CTB_OF',  '1',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   3, 'CONTRA8305',   'CTB_OF',  '2',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   4, 'CAP_CAS_81',   'CTB_OF',  '1',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   5, 'INT_VIG_16',   'CTB_OF',  '1',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   6, 'INT_VIG_16',   'CTB_OF',  '1',  11020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   7, 'CONTRA8305',   'CTB_OF',  '2',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   8, 'INT_CAS_81',   'CTB_OF',  '1',  11040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',   9, 'INT_SUS_63',   'CTB_OF',  '2',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  10, 'INT_SUS_64',   'CTB_OF',  '1',  11090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  11, 'IMO_VIG_16',   'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  12, 'IMO_VIG_16',   'CTB_OF',  '1',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  13, 'CONTRA8305',   'CTB_OF',  '2',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  14, 'IMO_CAS_81',   'CTB_OF',  '1',  12040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  15, 'IMO_SUS_63',   'CTB_OF',  '2',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  16, 'IMO_SUS_64',   'CTB_OF',  '1',  12090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  17, 'COM_VEN_16',   'CTB_OF',  '1',  13010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  18, 'COM_VEN_16',   'CTB_OF',  '1',  13020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  19, 'COM_CAS_81',   'CTB_OF',  '1',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  20, 'CONTRA8305',   'CTB_OF',  '2',  13040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  21, 'COM_SUS_63',   'CTB_OF',  '2',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  22, 'COM_SUS_64',   'CTB_OF',  '1',  13090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  23, 'IVA_PAG_25',   'CTB_IMP', '2',  14010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  24, 'COM_VEN_16',   'CTB_OF',  '1',  14020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  25, 'COM_CAS_81',   'CTB_OF',  '1',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  26, 'CONTRA8305',   'CTB_OF',  '2',  14040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  27, 'COM_SUS_63',   'CTB_OF',  '2',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  28, 'COM_SUS_64',   'CTB_OF',  '1',  14090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  29, 'SEG_VEN_16',   'CTB_OF',  '1',  16010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  30, 'SEG_VEN_16',   'CTB_OF',  '1',  16020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  31, 'SEG_CAS_81',   'CTB_OF',  '1',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  32, 'CONTRA8305',   'CTB_OF',  '2',  16040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  33, 'SEG_SUS_63',   'CTB_OF',  '2',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  34, 'SEG_SUS_64',   'CTB_OF',  '1',  16090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  35, 'FNG_PAG_25',   'CTB_OF',  '2',  17010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  36, 'FNG_VEN_16',   'CTB_OF',  '1',  17020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  37, 'CONTRA8305',   'CTB_OF',  '2',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  38, 'FNG_CAS_81',   'CTB_OF',  '1',  17040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  39, 'FNG_SUS_63',   'CTB_OF',  '2',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  40, 'FNG_SUS_64',   'CTB_OF',  '1',  17090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  41, 'IVA_PAG_25',   'CTB_IMP', '2',  18010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  42, 'FNG_VEN_16',   'CTB_OF',  '1',  18020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  43, 'CONTRA8305',   'CTB_OF',  '2',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  44, 'FNG_CAS_81',   'CTB_OF',  '1',  18040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  45, 'FNG_SUS_63',   'CTB_OF',  '2',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  46, 'FNG_SUS_64',   'CTB_OF',  '1',  18090, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  47, 'HON_VEN_16',   'CTB_OF',  '1',  21010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  48, 'HON_VEN_16',   'CTB_OF',  '1',  21020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  49, 'CONTRA8305',   'CTB_OF',  '2',  21040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  50, 'HON_CAS_81',   'CTB_OF',  '1',  21040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  51, 'HON_VEN_16',   'CTB_OF',  '1',  22010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  52, 'HON_VEN_16',   'CTB_OF',  '1',  22020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  53, 'CONTRA8305',   'CTB_OF',  '2',  22040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  54, 'HON_CAS_81',   'CTB_OF',  '1',  22040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  55, 'JUD_VEN_16',   'CTB_OF',  '1',  23010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  56, 'JUD_VEN_16',   'CTB_OF',  '1',  23020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  57, 'CONTRA8305',   'CTB_OF',  '2',  23040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ACT',  58, 'JUD_CAS_81',   'CTB_OF',  '1',  23040, 'N', 'D', NULL,  'L')

--DSC
insert into cb_det_perfil values (1, 7, 'CCA_DSC',   1,  '11020203',     'CTB_OF',  '1',  131,    'N','D', null,  'L')
insert into cb_det_perfil values (1, 7, 'CCA_DSC',   2,  '510511900201', 'CTB_OF',  '2',  11010,  'N','D', null,  'L')
insert into cb_det_perfil values (1, 7, 'CCA_DSC',   3,  '24010702',     'CTB_OF',  '2',  12010,  'N','D', null,  'L')

--SEGAD
delete from cb_det_perfil where dp_producto=7 and dp_perfil='CCA_PAG' and dp_asiento = 117
insert into cb_det_perfil values(1,7,'CCA_PAG',117,'240123','CTB_OF','1',29010,'N','D',null,'L')

go
PRINT 'INGRESO DE LOS DETALLES DE LOS PERFILES CONTABLES (OPERACIONES ADMINISTRADAS)'
go

--CASUSACION DE INTERESES

insert into cb_det_perfil values (1, 7,  'CAU_ADM',   1, 'IMO_FNG_81',  'CTB_OF',  '1',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_ADM',   2, 'IMO_FNG_83',  'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')


--TRASLADO DE CARTERA

insert into cb_det_perfil values (1, 7,  'TCO_ADM',   1, 'CAP_FNG_81',   'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   2, 'CAP_FNG_83',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   3, 'CAP_FNG_81',   'CTB_OF',  '1',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   4, 'CAP_FNG_83',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   5, 'CAP_FNG_81',   'CTB_OF',  '1',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   6, 'CAP_FNG_83',   'CTB_OF',  '2',  10040, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   7, 'IMO_FNG_81',   'CTB_OF',  '1',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   8, 'IMO_FNG_83',   'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'TCO_ADM',   9, 'IMO_FNG_25',   'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')


--CASTIGOS

insert into cb_det_perfil values (1, 7,  'CAS_ADM',   1, 'CAP_FNG_81',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ADM',   2, 'CAP_FNG_83',   'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')

insert into cb_det_perfil values (1, 7,  'CAS_ADM',   3, 'CAP_FNG_81',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAS_ADM',   4, 'CAP_FNG_62',   'CTB_OF',  '1',  10020, 'N', 'D', NULL,  'L')

--BOC

insert into cb_det_perfil values (1, 7,  'BOC_ADM',   1, 'CAP_FNG_81',   'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_ADM',   2, 'IMO_FNG_81',   'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')


--DESEMBOLSOS

insert into cb_det_perfil values (1, 7,  'DES_ADM',   1, 'CAP_FNG_81',  'CTB_OF',  '1',   10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ADM',   2, 'CAP_FNG_83',  'CTB_OF',  '2',   10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_ADM',   3, 'CAP_FNG_61',  'CTB_OF',  '1',   10010, 'N', 'D', NULL,  'L')--
insert into cb_det_perfil values (1, 7,  'DES_ADM',   4, 'CAP_FNG_62',  'CTB_OF',  '2',   10010, 'N', 'D', NULL,  'L')--


--PAGOS


insert into cb_det_perfil values (1, 7,  'PAG_ADM',   1, '16879500700',  'CTB_OF',  '1',  100,   'N', 'D', NULL,  'L') 
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   2, 'CAP_FNG_81',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   3, 'CAP_FNG_83',   'CTB_OF',  '1',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   4, 'CAP_FNG_61',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   5, 'CAP_FNG_62',   'CTB_OF',  '1',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   6, 'IMO_FNG_25',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')--
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   7, 'IMO_FNG_81',   'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   8, 'IMO_FNG_83',   'CTB_OF',  '1',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',   9, 'IMO_FNG_25',   'CTB_OF',  '2',  12020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_ADM',  10, 'IMO_FNG_81',   'CTB_OF',  '2',  12027, 'N', 'D', NULL,  'L')--
insert into cb_det_perfil values (1, 7,  'PAG_ADM',  11, 'IMO_FNG_83',   'CTB_OF',  '1',  12027, 'N', 'D', NULL,  'L')--


go
PRINT 'INGRESO DE LOS DETALLES DE LOS PERFILES CONTABLES (OPERACIONES ADMINISTRADAS)'
go

insert into cb_det_perfil values (1, 7,  'BOC_PAS',   1, 'CAP_PAS_24',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_PAS',   2, 'CAP_PAS_24',   'CTB_OF',  '2',  10020, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_PAS',   3, 'INT_PAS_25',   'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'BOC_PAS',   4, 'INT_PAS_25',   'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')


--CAUSACION DE INTERESES


insert into cb_det_perfil values (1, 7,  'CAU_PAS',   1, 'INT_PAS_25',  'CTB_OF',  '2',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_PAS',   2, 'INT_PAS_51',  'CTB_OF',  '1',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_PAS',   3, 'INT_PAS_25',  'CTB_OF',  '2',  12010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'CAU_PAS',   4, 'INT_PAS_51',  'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')

--DESEMBOLSOS


insert into cb_det_perfil values (1, 7,  'DES_PAS',   1, 'CAP_PAS_24',   'CTB_OF',  '2',  10010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'DES_PAS',   2, '16879500850',  'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L')

--PAGOS

insert into cb_det_perfil values (1, 7,  'PAG_PAS',   1, '16879500700',  'CTB_OF',  '2',  100,   'N', 'D', NULL,  'L') 
insert into cb_det_perfil values (1, 7,  'PAG_PAS',   2, 'CAP_PAS_24',   'CTB_OF',  '1',  10010, 'N', 'D', NULL,  'L') 
insert into cb_det_perfil values (1, 7,  'PAG_PAS',   3, 'CAP_PAS_24',   'CTB_OF',  '1',  10020, 'N', 'D', NULL,  'L') 
insert into cb_det_perfil values (1, 7,  'PAG_PAS',   4, 'INT_PAS_25',   'CTB_OF',  '1',  11010, 'N', 'D', NULL,  'L')
insert into cb_det_perfil values (1, 7,  'PAG_PAS',   5, 'INT_PAS_25',   'CTB_OF',  '1',  12010, 'N', 'D', NULL,  'L')


--REGISTRO DE PAGOS


insert into cb_det_perfil values (1, 7,  'RPA_PAS',   1, '16879500700',  'CTB_OF',  '1',  100,   'N', 'D', NULL,  'L')--VAC0
insert into cb_det_perfil values (1, 7,  'RPA_PAS',   2, 'CH_OTR_BAN' ,  'CTB_OF',  '2',  108,   'N', 'D', NULL,  'L')--CONSIGNACIONES


go
PRINT 'INGRESO DE LOS DETALLES DE LOS PERFILES CONTABLES (PROVISIONES)'
go

--BOC OP.ADMINISTRADAS
insert into cb_det_perfil values (1,21,   'BOC_PRV',  1, 'prv_ind_cr',   'CTB_OF',  '2',  10,    'N', 'D', NULL,  'L')         
insert into cb_det_perfil values (1,21,   'BOC_PRV',  2, 'prv_cic_cr',   'CTB_OF',  '2',  20,    'N', 'D', NULL,  'L')        
insert into cb_det_perfil values (1,21,   'BOC_PRV',  3, 'prv_gen_cr',   'CTB_OF',  '2',  30,    'N', 'D', NULL,  'L')       



go
print 'BORRANDO TABLAS DE CUENTAS'
go

delete cb_relparam
from cb_parametro
where pa_parametro = re_parametro
and   pa_stored like 'sp_ca0%'
and   pa_transaccion = 7

delete cb_parametro 
where pa_stored like 'sp_ca0%'
and   pa_transaccion = 7

go
PRINT 'INGRESANDO TABLAS DE CUENTAS (pa_parametro)'
go

--PARAMETROS OPERACIONES ACTIVAS
insert into cb_parametro values(1, 'APE_VIG_41', 'COMISION APERTURA DE CREDITO',               'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'CAP_CAS_81', 'CAPITAL CASTIGADO CTA.81',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'CAP_CUP_62', 'CAPITAL CONTINGENTE (CUPOS)',                'sp_ca01_pf', 7) 
insert into cb_parametro values(1, 'CAP_PRO_14', 'CAPITAL PROVISIONADO CTA.1499',              'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'CAP_REC_42', 'CAPITAL RECUPARDO PAGO CASTIGO',             'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'CAP_VIG_14', 'CAPITAL VIGENTE CTA.14',                     'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'CH_OTR_BAN', 'DESEMBOLSO CON CHEQUE OTR.BANCOS',           'sp_ca06_pf', 7)
insert into cb_parametro values(1, 'COM_CAS_81', 'COMISION MYPIME CTA.81',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'COM_PRO_16', 'COMISION MYPIME PROVISION CTA.1699',         'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'COM_REC_42', 'COMISION MYPIME PAGO CASTIGO',               'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'COM_VEN_16', 'COMISION MYPIME CxC CTA.16',                 'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'COM_VIG_41', 'COMISION MYPIME INGRESO CTA.41',             'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'CONTRA8305', 'CONTRAPARTIDA ORDEN CTA.8305',               'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'EST_CRE_41', 'INGRESO POR COMISION ESTUDIO CREDITO',       'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'FNG_CAS_81', 'FONDO NACIONAL DE GARANTIAS CTA.81',         'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'FNG_PAG_25', 'FONDO NACIONAL DE GARANTIAS CTA.25',         'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'FNG_PRO_16', 'FONDO NACIONAL DE GARANTIAS CTA.1699',       'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'FNG_REC_42', 'FONDO NACIONAL DE GARANTIAS CTA.42',         'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'FNG_VEN_16', 'FONDO NACIONAL DE GARANTIAS CTA.16',         'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'HON_ABO_25', 'HONORARIO ABOGADOS POR PAGAR CTA.25',        'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'HON_CAS_81', 'HONORARIO ABOGADOS CTA.81',                  'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'HON_PRO_16', 'HONORARIO ABOGADOS PROVISIONES CTA.1699',    'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'JUD_PRO_16', 'HONORARIO ABOGADOS PROVISIONES CTA.1699',    'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'HON_REC_42', 'HONORARIO ABOGADOS RECUPERACION CASTIGO',    'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'HON_VEN_16', 'HONORARIO ABOGADOS CxC CTA.16',              'sp_ca02_pf', 7)
insert into cb_parametro values(1, 'IMO_CAS_42', 'INTERES DE MORA CTA.42',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'IMO_CAS_81', 'INTERES DE MORA CTA.81',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'IMO_PRO_16', 'INTERES DE MORA PROVISIONADA CTA.1699',      'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'IMO_SUS_63', 'INTERES DE MORA CONTINGENTE CTA.63',         'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'IMO_SUS_64', 'INTERES DE MORA CONTINGENTE CTA.64',         'sp_ca02_pf', 7)
insert into cb_parametro values(1, 'IMO_VEN_41', 'INTERES DE MORA CTA.41',                     'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'IMO_VIG_16', 'INTERES DE MORA CTA.16',                     'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'IMO_SUS_41', 'INTERES DE MORA CTA.41',                     'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'INT_CAS_42', 'INTERES CORRIENTE CTA.42',                   'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'INT_CAS_81', 'INTERES CORRIENTE CTA.81',                   'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'INT_PRO_16', 'INTERES CORRIENTE CTA.16',                   'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'INT_SUS_63', 'INTERES CORRIENTE CTA.63',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'INT_SUS_64', 'INTERES CORRIENTE CTA.64',                   'sp_ca02_pf', 7)
insert into cb_parametro values(1, 'INT_VIG_16', 'INTERES CORRIENTE CTA.16',                   'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'INT_VIG_41', 'INTERES CORRIENTE CTA.41',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'INT_SUS_41', 'INTERES CONTINGENTES RECUPERADOS CTA.41',    'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'IVA_PAG_25', 'IVA POR PAGAR',                              'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'JUD_VEN_16', 'GASTOS JUDICIALES CTA.16',                   'sp_ca02_pf', 7)
insert into cb_parametro values(1, 'JUD_CAS_81', 'GASTOS JUDICIALES CTA.81',                   'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'JUD_REC_42', 'GASTOS JUDICIALES CTA.42',                   'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'SEG_CAS_81', 'SEGURO DEUDORES CTA.81',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'SEG_PAG_25', 'SEGURO DEUDORES CTA.25',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'SEG_PRO_16', 'SEGURO DEUDORES CTA.16',                     'sp_ca01_pf', 7)
insert into cb_parametro values(1, 'SEG_REC_42', 'SEGURO DEUDORES CTA.42',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'SEG_VEN_16', 'SEGURO DEUDORES CTA.16',                     'sp_ca02_pf', 7) 
insert into cb_parametro values(1, 'COM_CANAL' , 'COMISION A PAGAR USO DEL CANAL DE RECAUDO',  'sp_ca06_pf', 7)
insert into cb_parametro values(1, 'GASTO_COM' , 'GASTOS COMISIONES RECAUDO BANCOS',           'sp_ca06_pf', 7) 
insert into cb_parametro values(1, 'COM_BANCO' , 'COMISIONES GANADAS USO CANAL DE RECAUDO',    'sp_ca06_pf', 7) 
insert into cb_parametro values(1, 'COM_SUS_63', 'COMISION MYPIME SUSPENSO',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'COM_SUS_64', 'COMISION MYPIME SUSPENSO',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'SEG_SUS_64', 'SEGURO DEUDORES SUSPENSO',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'SEG_SUS_63', 'SEGURO DEUDORES SUSPENSO',                   'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'SEG_CAU_51', 'SEGURO CAUSADO  SUSPENSO',                   'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'FNG_SUS_63', 'FNG   SUSPENSO',                             'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'FNG_SUS_64', 'FNG   SUSPENSO',                             'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'FNG_CAU_51', 'FNG   CAUSADO SUSPENSO',                     'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'FNG_IVA_51', 'FNG   CAUSADO IVA SUSPENSO',                 'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'EXQ_PAG_25', 'SERVICIO EXEQUIAL CTA.25',                   'sp_ca04_pf', 7)

--PARAMETROS OPERACIONES ADMINISTRADAS

insert into cb_parametro values(1, 'CAP_FNG_81', 'CAPITAL FNG CTA.81',                         'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'CAP_FNG_83', 'CAPITAL FNG CTA.83',                         'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'CAP_FNG_61', 'CAPITAL FNG CTA.61',                         'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'CAP_FNG_62', 'CAPITAL FNG CTA.62',                         'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'IMO_FNG_81', 'INTERES DE MORA FNG CTA.82',                 'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'IMO_FNG_83', 'INTERES DE MORA FNG CTA.84',                 'sp_ca03_pf', 7)
insert into cb_parametro values(1, 'IMO_FNG_25', 'INTERES DE MORA FNG CTA.25',                 'sp_ca03_pf', 7)


--PARAMETROS OPERACIONES PASIVAS

insert into cb_parametro values(1, 'CAP_PAS_24', 'CAPITAL REDESCUENTO PASIVA',                    'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'INT_PAS_25', 'INTERES RESDESCUENTO PASIVA',                   'sp_ca04_pf', 7)
insert into cb_parametro values(1, 'INT_PAS_51', 'GASTO INTERESES RESDESCUENTO PASIVA',           'sp_ca04_pf', 7)



go
PRINT 'INGRESANDO TABLA DE CUENTAS (cb_relparam)'
go

insert into cb_relparam values(1, 'CAP_VIG_14', 'A.I.4.0',          '14560500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'B.I.4.0',          '14561000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'C.I.4.0',          '14561500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'D.I.4.0',          '14562000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'E.I.4.0',          '14562500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'A.O.4.0',          '14570500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'B.O.4.0',          '14571000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'C.O.4.0',          '14571500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'D.O.4.0',          '14572000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'E.O.4.0',          '14572500005', 7, null, null)

insert into cb_relparam values(1, 'CAP_VIG_14', 'A.I.1.0',          '14598200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'B.I.1.0',          '14608200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'C.I.1.0',          '14628200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'D.I.1.0',          '14638200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'E.I.1.0',          '14658200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'A.O.1.0',          '14668200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'B.O.1.0',          '14678200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'C.O.1.0',          '14688200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'D.O.1.0',          '14698200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_VIG_14', 'E.O.1.0',          '14708200005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'CAP_CAS_81', '1.0',              '81201000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_CAS_81', '4.0',              '81201000010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'CAP_REC_42', '0',                '42250500020', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_VIG_16', 'A.I.4.0',          '16053200005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'B.I.4.0',          '16053400005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'C.I.4.0',          '16053600005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'D.I.4.0',          '16053800005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'E.I.4.0',          '16054000005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'A.O.4.0',          '16053200005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'B.O.4.0',          '16053400005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'C.O.4.0',          '16053600005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'D.O.4.0',          '16053800005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'E.O.4.0',          '16054000005', 7, null, null)

insert into cb_relparam values(1, 'INT_VIG_16', 'A.I.1.0',          '16054200005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'B.I.1.0',          '16054400005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'C.I.1.0',          '16054600005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'D.I.1.0',          '16054800005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'E.I.1.0',          '16054900005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'A.O.1.0',          '16054200005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'B.O.1.0',          '16054400005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'C.O.1.0',          '16054600005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'D.O.1.0',          '16054800005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_16', 'E.O.1.0',          '16054900005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_VIG_41', '1.0',              '41020200005', 7, null, null)
insert into cb_relparam values(1, 'INT_VIG_41', '4.0',              '41020900005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_SUS_63', '1.0',              '63300500005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_63', '4.0',              '63301900005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_SUS_64', 'A.4.0',            '64304000005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'B.4.0',            '64304200005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'C.4.0',            '64304400005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'D.4.0',            '64304600005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'E.4.0',            '64304800005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'A.1.0',            '64305000005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'B.1.0',            '64305200005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'C.1.0',            '64305400005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'D.1.0',            '64305600005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_64', 'E.1.0',            '64305800005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_SUS_41', '1.0',              '41020200005', 7, null, null)
insert into cb_relparam values(1, 'INT_SUS_41', '4.0',              '41020900005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_CAS_81', '0',                '81201500005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_CAS_42', '0',                '42250500010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'CONTRA8305', '0',                '83050000005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'COM_VEN_16', '0',                '16109500005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'COM_VIG_41', '0',                '41159500005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'COM_CAS_81', '0',                '81201500015', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'SEG_VEN_16', 'A.4.0',            '16380500105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'B.4.0',            '16381000105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'C.4.0',            '16381500105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'D.4.0',            '16382000105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'E.4.0',            '16382500105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'A.1.0',            '16390500105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'B.1.0',            '16391000105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'C.1.0',            '16391500105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'D.1.0',            '16392000105', 7, null, null)
insert into cb_relparam values(1, 'SEG_VEN_16', 'E.1.0',            '16392500105', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'SEG_CAS_81', '0',                '81201500025', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'SEG_REC_42', '0',                '42250500030', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'SEG_PAG_25', '0',                '25957000010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_VIG_16', 'A.I.4.0',          '16053200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'B.I.4.0',          '16053400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'C.I.4.0',          '16053600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'D.I.4.0',          '16053800010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'E.I.4.0',          '16054000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'A.O.4.0',          '16053200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'B.O.4.0',          '16053400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'C.O.4.0',          '16053600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'D.O.4.0',          '16053800010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'E.O.4.0',          '16054000010', 7, null, null)

insert into cb_relparam values(1, 'IMO_VIG_16', 'A.I.1.0',          '16054200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'B.I.1.0',          '16054400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'C.I.1.0',          '16054600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'D.I.1.0',          '16054800010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'E.I.1.0',          '16054900010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'A.O.1.0',          '16054200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'B.O.1.0',          '16054400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'C.O.1.0',          '16054600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'D.O.1.0',          '16054800010', 7, null, null)
insert into cb_relparam values(1, 'IMO_VIG_16', 'E.O.1.0',          '16054900010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_CAS_81', '0',                '81201500010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_VEN_41', '1.0',              '41021000005', 7, null, null)
insert into cb_relparam values(1, 'IMO_VEN_41', '4.0',              '41021000010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IVA_PAG_25', '0',                '25350000005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'FNG_VEN_16', 'A.O.4.0',          '16380500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'B.O.4.0',          '16381000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'C.O.4.0',          '16381500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'D.O.4.0',          '16382000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'E.O.4.0',          '16382500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'A.I.1.0',          '16390500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'B.I.1.0',          '16391000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'C.I.1.0',          '16391500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'D.I.1.0',          '16392000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'E.I.1.0',          '16392500010', 7, null, null)

insert into cb_relparam values(1, 'FNG_VEN_16', 'A.I.4.0',          '16380500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'B.I.4.0',          '16381000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'C.I.4.0',          '16381500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'D.I.4.0',          '16382000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'E.I.4.0',          '16382500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'A.O.1.0',          '16390500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'B.O.1.0',          '16391000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'C.O.1.0',          '16391500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'D.O.1.0',          '16392000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_VEN_16', 'E.O.1.0',          '16392500010', 7, null, null)



                                                                                            
insert into cb_relparam values(1, 'FNG_PAG_25', '0',                '25957000030', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'APE_VIG_41', '0',                '41152500015', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'EST_CRE_41', '0',                '41152500005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'HON_ABO_25', '0',                '25957000025', 7, null, null)
                                                                                            

insert into cb_relparam values(1, 'CH_OTR_BAN', '04305674476',      '11150500050', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '09798552203',      '11150500055', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '07009290730',      '11150500060', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '09144480711',      '11150500065', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '26235451881',      '11150500070', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '35235451828',      '11150500075', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '37131383220',      '11150500080', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '39223904719',      '11150500085', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '64526036103',      '11150500090', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '70625691878',      '11150500100', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '74428487208',      '11150500105', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '10332654658',      '11150500110', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '716007067',        '11150500115', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '059000166',        '11150500120', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '060031903',        '11150500125', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '348086794',        '11150500130', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '596251116',        '11150500135', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '616119566',        '11150500140', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '309005569',        '11150500160', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '21002631546',      '11150500165', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '202033171',        '11150500170', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '13050187020001100','11150500175', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '04846913136',      '11150500180', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '9725971710',       '11150500190', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '525024113',        '11150500200', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '313200000617',     '11150500205', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '21500241120',      '11150500220', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '005602022864',     '11150500225', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '66124397',         '11150500235', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '000829390',        '11150500245', 7, null, null)
insert into cb_relparam values(1, 'CH_OTR_BAN', '449019272',        '11150500250', 7, null, null)

                                                                                            
insert into cb_relparam values(1, 'IMO_SUS_63', '1.0',              '63300500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_63', '4.0',              '63301900010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_SUS_64', 'A.4.0',            '64304000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'B.4.0',            '64304200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'C.4.0',            '64304400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'D.4.0',            '64304600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'E.4.0',            '64304800010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'A.1.0',            '64305000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'B.1.0',            '64305200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'C.1.0',            '64305400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'D.1.0',            '64305600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_64', 'E.1.0',            '64305800010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_SUS_41', '1.0',              '41021000005', 7, null, null)
insert into cb_relparam values(1, 'IMO_SUS_41', '4.0',              '41021000010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'COM_REC_42', '0',                '42250500020', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'FNG_CAS_81', '0',                '81201500020', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'FNG_REC_42', '0',                '42250500020', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'HON_CAS_81', '0',                '81201500030', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'HON_REC_42', '0',                '42250500035', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'HON_VEN_16', 'A.4.0',            '16380500200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'B.4.0',            '16381000200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'C.4.0',            '16381500200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'D.4.0',            '16382000200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'E.4.0',            '16382500200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'A.1.0',            '16390500200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'B.1.0',            '16391000200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'C.1.0',            '16391500200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'D.1.0',            '16392000200', 7, null, null)
insert into cb_relparam values(1, 'HON_VEN_16', 'E.1.0',            '16392500200', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_CAS_42', '0',                '42250500015', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'JUD_VEN_16', 'A.4.0',            '16380500205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'B.4.0',            '16381000205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'C.4.0',            '16381500205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'D.4.0',            '16382000205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'E.4.0',            '16382500205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'A.1.0',            '16390500205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'B.1.0',            '16391000205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'C.1.0',            '16391500205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'D.1.0',            '16392000205', 7, null, null)
insert into cb_relparam values(1, 'JUD_VEN_16', 'E.1.0',            '16392500205', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'JUD_CAS_81', '0',                '81201500035', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'JUD_REC_42', '0',                '42259500010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'CAP_PRO_14', 'A.I.4.0',          '14930500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'B.I.4.0',          '14931000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'C.I.4.0',          '14931500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'D.I.4.0',          '14932000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'E.I.4.0',          '14932500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'A.O.4.0',          '14930700005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'B.O.4.0',          '14931200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'C.O.4.0',          '14931700005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'D.O.4.0',          '14932200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'E.O.4.0',          '14932700005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'A.I.1.0',          '14950500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'B.I.1.0',          '14951000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'C.I.1.0',          '14951500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'D.I.1.0',          '14952000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'E.I.1.0',          '14952500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'A.O.1.0',          '14950700005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'B.O.1.0',          '14951200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'C.O.1.0',          '14951700005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'D.O.1.0',          '14952200005', 7, null, null)
insert into cb_relparam values(1, 'CAP_PRO_14', 'E.O.1.0',          '14952700005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'INT_PRO_16', 'A.I.4.0',          '16920500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'B.I.4.0',          '16921000005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'C.I.4.0',          '16921500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'D.I.4.0',          '16922000005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'E.I.4.0',          '16922500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'A.O.4.0',          '16920500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'B.O.4.0',          '16921000005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'C.O.4.0',          '16921500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'D.O.4.0',          '16922000005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'E.O.4.0',          '16922500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'A.I.1.0',          '16945200005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'B.I.1.0',          '16945300005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'C.I.1.0',          '16945400005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'D.I.1.0',          '16945600005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'E.I.1.0',          '16945700005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'A.O.1.0',          '16945200005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'B.O.1.0',          '16945300005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'C.O.1.0',          '16945400005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'D.O.1.0',          '16945600005', 7, null, null)
insert into cb_relparam values(1, 'INT_PRO_16', 'E.O.1.0',          '16945700005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'COM_PRO_16', 'A.I.4.0',          '16923000005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'B.I.4.0',          '16923500005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'C.I.4.0',          '16924000005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'D.I.4.0',          '16924500005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'E.I.4.0',          '16925000005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'A.O.4.0',          '16923000005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'B.O.4.0',          '16923500005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'C.O.4.0',          '16924000005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'D.O.4.0',          '16924500005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'E.O.4.0',          '16925000005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'A.I.1.0',          '16946200005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'B.I.1.0',          '16946300005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'C.I.1.0',          '16946400005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'D.I.1.0',          '16946600005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'E.I.1.0',          '16946700005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'A.O.1.0',          '16946200005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'B.O.1.0',          '16946300005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'C.O.1.0',          '16946400005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'D.O.1.0',          '16946600005', 7, null, null)
insert into cb_relparam values(1, 'COM_PRO_16', 'E.O.1.0',          '16946700005', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'FNG_PRO_16', 'A.I.4.0',          '16923000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'B.I.4.0',          '16923500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'C.I.4.0',          '16924000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'D.I.4.0',          '16924500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'E.I.4.0',          '16925000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'A.O.4.0',          '16923000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'B.O.4.0',          '16923500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'C.O.4.0',          '16924000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'D.O.4.0',          '16924500010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'E.O.4.0',          '16925000010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'A.I.1.0',          '16946200010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'B.I.1.0',          '16946300010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'C.I.1.0',          '16946400010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'D.I.1.0',          '16946600010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'E.I.1.0',          '16946700010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'A.O.1.0',          '16946200010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'B.O.1.0',          '16946300010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'C.O.1.0',          '16946400010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'D.O.1.0',          '16946600010', 7, null, null)
insert into cb_relparam values(1, 'FNG_PRO_16', 'E.O.1.0',          '16946700010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'HON_PRO_16', 'A.I.4.0',          '16923000900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'B.I.4.0',          '16923500900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'C.I.4.0',          '16924000900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'D.I.4.0',          '16924500900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'E.I.4.0',          '16925000900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'A.O.4.0',          '16923000900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'B.O.4.0',          '16923500900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'C.O.4.0',          '16924000900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'D.O.4.0',          '16924500900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'E.O.4.0',          '16925000900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'A.I.1.0',          '16946200900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'B.I.1.0',          '16946300900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'C.I.1.0',          '16946400900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'D.I.1.0',          '16946600900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'E.I.1.0',          '16946700900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'A.O.1.0',          '16946200900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'B.O.1.0',          '16946300900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'C.O.1.0',          '16946400900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'D.O.1.0',          '16946600900', 7, null, null)
insert into cb_relparam values(1, 'HON_PRO_16', 'E.O.1.0',          '16946700900', 7, null, null)

insert into cb_relparam values(1, 'JUD_PRO_16', 'A.I.4.0',          '16923000200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'B.I.4.0',          '16923500200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'C.I.4.0',          '16924000200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'D.I.4.0',          '16924500200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'E.I.4.0',          '16925000200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'A.O.4.0',          '16923000200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'B.O.4.0',          '16923500200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'C.O.4.0',          '16924000200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'D.O.4.0',          '16924500200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'E.O.4.0',          '16925000200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'A.I.1.0',          '16946200200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'B.I.1.0',          '16946300200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'C.I.1.0',          '16946400200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'D.I.1.0',          '16946600200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'E.I.1.0',          '16946700200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'A.O.1.0',          '16946200200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'B.O.1.0',          '16946300200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'C.O.1.0',          '16946400200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'D.O.1.0',          '16946600200', 7, null, null)
insert into cb_relparam values(1, 'JUD_PRO_16', 'E.O.1.0',          '16946700200', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'SEG_PRO_16', 'A.I.4.0',          '16923000100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'B.I.4.0',          '16923500100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'C.I.4.0',          '16924000100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'D.I.4.0',          '16924500100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'E.I.4.0',          '16925000100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'A.O.4.0',          '16923000100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'B.O.4.0',          '16923500100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'C.O.4.0',          '16924000100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'D.O.4.0',          '16924500100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'E.O.4.0',          '16925000100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'A.I.1.0',          '16946200100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'B.I.1.0',          '16946300100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'C.I.1.0',          '16946400100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'D.I.1.0',          '16946600100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'E.I.1.0',          '16946700100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'A.O.1.0',          '16946200100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'B.O.1.0',          '16946300100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'C.O.1.0',          '16946400100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'D.O.1.0',          '16946600100', 7, null, null)
insert into cb_relparam values(1, 'SEG_PRO_16', 'E.O.1.0',          '16946700100', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'IMO_PRO_16', 'A.I.4.0',          '16920500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'B.I.4.0',          '16921000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'C.I.4.0',          '16921500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'D.I.4.0',          '16922000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'E.I.4.0',          '16922500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'A.O.4.0',          '16920500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'B.O.4.0',          '16921000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'C.O.4.0',          '16921500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'D.O.4.0',          '16922000010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'E.O.4.0',          '16922500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'A.I.1.0',          '16945200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'B.I.1.0',          '16945300010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'C.I.1.0',          '16945400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'D.I.1.0',          '16945600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'E.I.1.0',          '16945700010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'A.O.1.0',          '16945200010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'B.O.1.0',          '16945300010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'C.O.1.0',          '16945400010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'D.O.1.0',          '16945600010', 7, null, null)
insert into cb_relparam values(1, 'IMO_PRO_16', 'E.O.1.0',          '16945700010', 7, null, null)
                                                                                            
insert into cb_relparam values(1, 'COM_CANAL' , 'PAGOBALOTO',       '25959500045', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL' , 'PAGOEDATEL',       '25959500044', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '04305674476',       '11150500050', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '09798552203',       '11150500055', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '07009290730',       '11150500060', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '09144480711',       '11150500065', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '26235451881',       '11150500070', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '35235451828',       '11150500075', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '37131383220',       '11150500080', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '39223904719',       '11150500085', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '64526036103',       '11150500090', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '70625691878',       '11150500100', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '74428487208',       '11150500105', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '10332654658',       '11150500110', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '716007067',         '11150500115', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '059000166',         '11150500120', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '060031903',         '11150500125', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '348086794',         '11150500130', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '596251116',         '11150500135', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '616119566',         '11150500140', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '309005569',         '11150500160', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '21002631546',       '11150500165', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '202033171',         '11150500170', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '13050187020001100', '11150500175', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '04846913136',       '11150500180', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '9725971710',        '11150500190', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '525024113',         '11150500200', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '313200000617',      '11150500205', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '21500241120',       '11150500220', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '005602022864',      '11150500225', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '66124397',          '11150500235', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '000829390',         '11150500245', 7, null, null)
insert into cb_relparam values(1, 'COM_CANAL', '449019272',         '11150500250', 7, null, null)



insert into cb_relparam values(1, 'COM_BANCO' , 'PAGOBALOTO',      '41159500010', 7, null, null)

insert into cb_relparam values(1, 'GASTO_COM', '04305674476',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '09798552203',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '07009290730',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '09144480711',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '26235451881',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '35235451828',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '37131383220',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '39223904719',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '64526036103',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '70625691878',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '74428487208',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '10332654658',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '716007067',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '059000166',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '060031903',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '348086794',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '596251116',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '616119566',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '309005569',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '21002631546',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '202033171',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '13050187020001100','51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '04846913136',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '9725971710',       '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '525024113',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '313200000617',     '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '21500241120',      '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '005602022864',     '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '66124397',         '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '000829390',        '51152000005', 7, null, null)
insert into cb_relparam values(1, 'GASTO_COM', '449019272',        '51152000005', 7, null, null)

insert into cb_relparam values(1, 'COM_SUS_64', '1.0',             '64959500010', 7, null, null)
insert into cb_relparam values(1, 'COM_SUS_64', '4.0',             '64959500010', 7, null, null)
insert into cb_relparam values(1, 'COM_SUS_63', '1.0',             '63050000005', 7, null, null)
insert into cb_relparam values(1, 'COM_SUS_63', '4.0',             '63050000005', 7, null, null)

insert into cb_relparam values(1, 'SEG_SUS_64', '1.0',             '64959500025', 7, null, null)
insert into cb_relparam values(1, 'SEG_SUS_64', '4.0',             '64959500025', 7, null, null)
insert into cb_relparam values(1, 'SEG_SUS_63', '1.0',             '63050000005', 7, null, null)
insert into cb_relparam values(1, 'SEG_SUS_63', '4.0',             '63050000005', 7, null, null)
insert into cb_relparam values(1, 'SEG_CAU_51',   '0',             '51552000005', 7, null, null)

insert into cb_relparam values(1, 'FNG_SUS_64', '1.0',             '64959500020', 7, null, null)
insert into cb_relparam values(1, 'FNG_SUS_64', '4.0',             '64959500020', 7, null, null)
insert into cb_relparam values(1, 'FNG_SUS_63', '1.0',             '63050000005', 7, null, null)
insert into cb_relparam values(1, 'FNG_SUS_63', '4.0',             '63050000005', 7, null, null)
insert into cb_relparam values(1, 'FNG_CAU_51',   '0',             '51158000005', 7, null, null)
insert into cb_relparam values(1, 'FNG_IVA_51',   '0',             '51409500010', 7, null, null)
insert into cb_relparam values(1, 'EXQ_PAG_25',   '0',             '25957000010', 7, null, null)


--PARAMETROS OPERACIONES ADMINISTRADAS

insert into cb_relparam values(1, 'CAP_FNG_81', '1.0',              '81959500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_FNG_81', '4.0',              '81959500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_FNG_83', '1.0',              '83050000005', 7, null, null)
insert into cb_relparam values(1, 'CAP_FNG_83', '4.0',              '83050000005', 7, null, null)                   
insert into cb_relparam values(1, 'CAP_FNG_61', '1.0',              '61959500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_FNG_61', '4.0',              '61959500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_FNG_62', '1.0',              '62959500005', 7, null, null)
insert into cb_relparam values(1, 'CAP_FNG_62', '4.0',              '62959500005', 7, null, null)                   
insert into cb_relparam values(1, 'IMO_FNG_81', '1.0',              '81959500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_FNG_81', '4.0',              '81959500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_FNG_83', '1.0',              '82959500010', 7, null, null)
insert into cb_relparam values(1, 'IMO_FNG_83', '4.0',              '82959500010', 7, null, null)--
insert into cb_relparam values(1, 'IMO_FNG_25', '1.0',              '25957000035', 7, null, null)
insert into cb_relparam values(1, 'IMO_FNG_25', '4.0',              '25957000035', 7, null, null)


--PARAMETROS OPERACIONES ADMINISTRADAS

insert into cb_relparam values(1, 'CAP_PAS_24', '0',                '24101000005', 7, null, null)
insert into cb_relparam values(1, 'INT_PAS_25', '0',                '25051500005', 7, null, null)
insert into cb_relparam values(1, 'INT_PAS_51', '0',                '51030400005', 7, null, null)

go
PRINT 'ASOCIANDO PERFILES CONTABLES A LAS TRANSACCIONES DE CARTERA'
go

delete cob_cartera..ca_trn_oper
from cob_cartera..ca_default_toperacion
where to_toperacion = dt_toperacion

insert into cob_cartera..ca_trn_oper select dt_toperacion, 'PAG','PAG_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'DES','DES_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'IOC','IOC_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'RPA','RPA_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'PRV','CAU_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'EST','EST_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'CAS','CAS_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'TCO','TCO_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'SUA','SUA_ACT' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'A'

insert into cob_cartera..ca_trn_oper select dt_toperacion, 'PAG','PAG_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'DES','DES_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'IOC','IOC_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'RPA','RPA_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'PRV','CAU_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'EST','EST_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'CAS','CAS_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'TCO','TCO_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'SUA','SUA_PAS' from cob_cartera..ca_default_toperacion where dt_naturaleza = 'P'

delete cob_cartera..ca_trn_oper
from cob_cartera..ca_default_toperacion
where to_toperacion = dt_toperacion
and   dt_tipo       = 'G'

insert into cob_cartera..ca_trn_oper select dt_toperacion, 'PAG','PAG_ADM' from cob_cartera..ca_default_toperacion where dt_tipo = 'G'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'DES','DES_ADM' from cob_cartera..ca_default_toperacion where dt_tipo = 'G'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'PRV','CAU_ADM' from cob_cartera..ca_default_toperacion where dt_tipo = 'G'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'TCO','TCO_ADM' from cob_cartera..ca_default_toperacion where dt_tipo = 'G'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'RPA','RPA_ACT' from cob_cartera..ca_default_toperacion where dt_tipo = 'G'
insert into cob_cartera..ca_trn_oper select dt_toperacion, 'DSC','CCA_DSC' from cob_cartera..ca_default_toperacion where dt_tipo = 'G'



PRINT 'ACTUALIZACION CODIGO VALOR EN COB_CONTA '

delete cob_conta..cb_codigo_valor where cv_producto = 7
go 
insert into cob_conta..cb_codigo_valor 
select 1, 7, co_codigo * 1000 + es_codigo * 10,co_descripcion + ' - ' + es_descripcion 
from   cob_cartera..ca_concepto, cob_cartera..ca_estado 
 
insert into cob_conta..cb_codigo_valor 
select 1, 7, cp_codvalor, cp_descripcion 
from   cob_cartera..ca_producto 

go 

delete  cob_conta..cb_codigo_valor where cv_codval in ( 142,143)

INSERT INTO dbo.cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 142, 'OBJETADO')


INSERT INTO dbo.cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 7, 143, 'QUEBRANTO')

go

delete cob_cartera..ca_trn_oper where to_tipo_trn = 'DSE'

insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('GRUPAL'    , 'DSE', 'CCA_SEGDEV')
insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INDIVIDUAL', 'DSE', 'CCA_SEGDEV')
insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INTERCICLO', 'DSE', 'CCA_SEGDEV')
insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('REVOLVENTE', 'DSE', 'CCA_SEGDEV')

delete cob_conta..cb_perfil where pe_perfil = 'CCA_SEGDEV'
delete cob_conta..cb_det_perfil where dp_perfil = 'CCA_SEGDEV'

--'BANCO SANTANDER'-> 131
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 1         , '240123' , 'CTB_OF', '1'       , 131      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 2         , '11020205', 'CTB_OF', '2'      , 131      , 'N'         , 'O'           , NULL        , 'L')

--'OPEN PAY', 'CORRESP', 0, 137
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 3         , '240123' , 'CTB_OF', '1'       , 137      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta , dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 4         , '11020202', 'CTB_OF', '2'      , 137      , 'N'         , 'O'           , NULL        , 'L')

--'CORRESPONSAL OXXO',  139
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 5         , '240123' , 'CTB_OF'  , '1'      , 139      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta, dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 6         , '11020201', 'CTB_OF', '2'       , 139      , 'N'         , 'O'           , NULL        , 'L')

--'ELAVON',   141
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 7         , '240123'  , 'CTB_OF', '1'       , 141      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil   , dp_asiento, dp_cuenta, dp_area , dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEGDEV', 8         , '11020205', 'CTB_OF', '2'       , 141      , 'N'         , 'O'           , NULL        , 'L')

go

delete cob_conta..cb_det_perfil where dp_perfil = 'CCA_SEG'


--'BANCO SANTANDER'-> 131
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta , dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 1         , '11020205'  , 'CTB_OF', '1'       , 131      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 2         , '240123'    , 'CTB_OF', '2'       , 131      , 'N'         , 'O'           , NULL        , 'L')
 
--'OPEN PAY', 'CORRESP', 0, 137
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta , dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 3         , '11020202'  , 'CTB_OF', '1'       , 137      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 4         , '240123'    , 'CTB_OF', '2'       , 137      , 'N'         , 'O'           , NULL        , 'L')

--'CORRESPONSAL OXXO',  139
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 5         , '14019101'  , 'CTB_OF', '1'       , 139      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 6         , '240123'    , 'CTB_OF', '2'       , 139      , 'N'         , 'O'           , NULL        , 'L')
--'ELAVON',   141
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 7         , '14019102'  , 'CTB_OF', '1'       , 141      , 'N'         , 'O'           , NULL        , 'L')
insert into cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta,  dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente) values (1         , 7          , 'CCA_SEG', 8         , '240123'    , 'CTB_OF', '2'       , 141      , 'N'         , 'O'           , NULL        , 'L')
go

use cob_cartera
go

if not exists (select 1 from cob_cartera..ca_tipo_trn where tt_codigo = 'DGL')
begin
   insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable) values ('DGL', 'DEVOLUCION GARANTIAS LIQUIDAS', 'N', 'S')
end
go

if not exists (select * from cob_cartera..ca_trn_oper where to_tipo_trn = 'DGL')
begin
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('GRUPAL'    , 'DGL', 'CCA_GARDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INDIVIDUAL', 'DGL', 'CCA_GARDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('INTERCICLO', 'DGL', 'CCA_GARDEV')
    insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil) values ('REVOLVENTE', 'DGL', 'CCA_GARDEV')
end 
go

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


update cob_conta..cb_det_perfil set
dp_cuenta = '14019102'
where dp_perfil  = 'CCA_GAR'
and   dp_codval  = 141
and   dp_debcred = 1 


go

