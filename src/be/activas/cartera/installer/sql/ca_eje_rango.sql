use cob_cartera
go

delete from ca_eje_rango
 where er_matriz in ('ASIG_AUTO','COMFAGANU','COMFAGUNI','COMFGAUNI','COMFNGANU','COMFNGAUT','COMGARCAL','COMGARNSA','COMGARTUM','COMGARUNI','COMUSASEM',
                     'DIASMAXNEG','GEN_CNTRAC','INSAPRMIR','MIPYMES','MIPYMESFX','MONTO_EMP','MONTO_MAX','MSGCONPRES','NUM_NORM','PLAZO_EMP','PLAZO_MAX',
                     'POL_CTROFE','PORMAXCOND','TASAS_MAX','TASAS_MIN','TASA_DEF','TASA_MN_LC','VAL_FNG','VAL_MATRIZ','VAL_NORM')
go

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 1, 1, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 1, 2, '6', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 1, 3, '7', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 1, 4, '8', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 1, 5, '9', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 2, 1, '01', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 2, 2, '02', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 2, 3, '03', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 3, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 3, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('ASIG_AUTO', '2013-04-01', 3, 3, 'U', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 1, '003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 2, '004', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 3, '005', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 4, '006', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 5, '007', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 6, '008', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 7, '009', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 8, '012', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 9, '011', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 1, 10, '013', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 2, 1, '1', '350')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 2, 2, '350', '5000')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 2, 3, '5000', '99999999')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 3, 1, 'AUTOMATICA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 3, 2, 'PREVIA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 4, 1, '1', '50')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 4, 2, '50', '60')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 4, 3, '60', '70')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 4, 4, '70', '75')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 4, 5, '75', '80')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 4, 6, '80', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGANU', '2009-08-01', 5, 1, '12', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 1, '003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 2, '004', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 3, '005', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 4, '006', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 5, '007', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 6, '008', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 7, '009', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 8, '012', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 1, 9, '011', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 2, 1, '1', '350')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 2, 2, '350', '5000')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 2, 3, '5000', '99999999')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 3, 1, 'AUTOMATICA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 3, 2, 'PREVIA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 4, 1, '1', '50')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 4, 2, '50', '60')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 4, 3, '60', '70')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 4, 4, '70', '75')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 4, 5, '75', '80')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 4, 6, '80', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 1, '1', '3')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 2, '3', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 3, '4', '5')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 4, '5', '6')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 5, '6', '7')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 6, '7', '8')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 7, '8', '9')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 8, '9', '10')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 9, '10', '11')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 10, '11', '12')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 11, '12', '18')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 12, '18', '24')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 13, '24', '36')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 14, '36', '48')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 15, '48', '60')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 16, '60', '72')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 17, '72', '84')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 18, '84', '96')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 19, '96', '108')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 20, '108', '120')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 21, '120', '132')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 22, '132', '144')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 23, '144', '156')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 24, '156', '168')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 25, '168', '180')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 26, '180', '192')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 27, '192', '204')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 28, '204', '216')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 29, '216', '228')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFAGUNI', '2009-08-01', 5, 30, '228', '240')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFGAUNI', '2009-08-01', 1, 1, '1', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFGAUNI', '2009-08-01', 1, 2, '4', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFGAUNI', '2009-08-01', 1, 3, '25', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFGAUNI', '2009-08-01', 1, 4, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFNGANU', '2009-08-01', 1, 1, '1', '25.000001')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFNGANU', '2009-08-01', 1, 2, '25.000001', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFNGANU', '2009-08-01', 1, 3, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFNGAUT', '2009-08-01', 1, 1, '1', '25.000001')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFNGAUT', '2009-08-01', 1, 2, '25.000001', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMFNGAUT', '2009-08-01', 1, 3, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARCAL', '2013-08-31', 1, 1, '1', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARCAL', '2013-08-31', 1, 2, '4', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARCAL', '2013-08-31', 1, 3, '25', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARCAL', '2013-08-31', 1, 4, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARNSA', '2014-05-29', 1, 1, '1', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARNSA', '2014-05-29', 1, 2, '4', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARNSA', '2014-05-29', 1, 3, '25', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARNSA', '2014-05-29', 1, 4, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARTUM', '2013-08-31', 1, 1, '1', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARTUM', '2013-08-31', 1, 2, '4', '15')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARTUM', '2013-08-31', 1, 3, '15', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARTUM', '2013-08-31', 1, 4, '25', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARTUM', '2013-08-31', 1, 5, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARUNI', '2013-08-31', 1, 1, '2610', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARUNI', '2013-08-31', 2, 1, '1', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARUNI', '2013-08-31', 2, 2, '4', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARUNI', '2013-08-31', 2, 3, '25', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMGARUNI', '2013-08-31', 2, 4, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('COMUSASEM', '2009-08-01', 1, 1, '1', '9999')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('DIASMAXNEG', '2013-01-12', 1, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('DIASMAXNEG', '2013-01-12', 1, 2, 'P', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('DIASMAXNEG', '2013-01-12', 2, 1, '47', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('DIASMAXNEG', '2013-01-12', 2, 2, '72', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('DIASMAXNEG', '2013-01-12', 2, 3, '87', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('DIASMAXNEG', '2013-01-12', 2, 4, '125', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 1, '0', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 2, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 3, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 4, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 5, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 6, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 7, '6', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 8, '7', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 9, '8', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 10, '9', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 11, '10', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 12, '11', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 13, '12', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 14, '13', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 15, '14', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 16, '15', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 17, '16', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 18, '17', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 19, '18', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 20, '19', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 21, '20', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 22, '21', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 23, '22', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 24, '23', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 25, '24', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 26, '25', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 27, '27', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 28, '28', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 29, '29', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 30, '30', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 31, '31', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 32, '32', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 33, '33', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 34, '34', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 35, '35', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 36, '36', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 37, '37', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 38, '38', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 39, '39', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 40, '40', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 41, '41', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 42, '42', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 43, '43', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 44, '44', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 1, 45, '45', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 1, 'O', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 3, 'E', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 4, 'C', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 5, 'U', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 6, 'T', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 7, 'X', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 2, 8, 'M', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 3, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 3, 2, 'S', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 3, 3, 'X', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 4, 1, 'C', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('GEN_CNTRAC', '2012-04-05', 4, 2, 'P', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 1, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 1, 2, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 1, 3, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 1, 4, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 2, 1, '0', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 2, 2, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 2, 3, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 1, '0', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 2, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 3, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 4, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 5, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 6, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 7, '6', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 8, '7', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 3, 9, '8', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 4, 1, '0', '7')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 4, 2, '7', '15')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 4, 3, '15', '35')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 4, 4, '35', '60')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('INSAPRMIR', '2011-11-15', 4, 5, '60', '120')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 1, '4003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 2, '4005', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 3, '4010', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 4, '4011', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 5, '4014', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 6, '4015', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 7, '4017', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 8, '4018', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 9, '4019', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 10, '4022', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 11, '4024', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 12, '4025', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 13, '4027', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 14, '4030', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 15, '4031', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 16, '4032', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 17, '4033', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 18, '4034', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 19, '4035', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 20, '4036', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 21, '4040', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 22, '4043', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 23, '4044', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 24, '4045', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 25, '4046', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 26, '4047', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 27, '4049', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 28, '4050', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 29, '4051', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 30, '4053', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 31, '4054', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 32, '4056', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 33, '4057', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 34, '4058', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 35, '4059', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 36, '4060', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 37, '4061', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 38, '4064', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 39, '4065', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 40, '4067', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 41, '4070', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 42, '4071', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 43, '4072', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 44, '4073', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 45, '4074', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 46, '4075', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 47, '7001', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 48, '7002', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 49, '7003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 50, '7006', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 51, '7008', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 52, '7010', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 53, '7012', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 54, '7016', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 55, '7017', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 56, '7019', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 57, '7020', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 58, '7021', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 59, '7023', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 60, '7025', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 61, '7027', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 62, '7028', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 63, '7029', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 64, '7030', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 65, '7031', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 66, '7032', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 67, '7033', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 68, '7037', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 69, '7038', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 70, '7039', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 71, '7040', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 72, '7041', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 73, '7044', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 74, '7046', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 75, '7047', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 76, '7051', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 77, '7052', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 78, '7054', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 79, '7056', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 80, '7059', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 81, '7060', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 82, '7064', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 83, '7066', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 84, '7067', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 85, '7068', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 86, '7069', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 87, '7071', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 88, '7072', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 89, '7073', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 90, '7074', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 91, '7075', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 92, '4076', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 93, '4077', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 94, '4078', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 95, '4079', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 96, '4080', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 97, '7076', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 98, '7077', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 99, '7078', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 100, '7079', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 101, '7080', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 102, '7081', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 103, '7082', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 104, '7083', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 105, '7084', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 106, '7085', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 107, '7086', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 108, '4081', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 109, '7088', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 110, '7087', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 111, '4082', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 112, '7061', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 113, '4086', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 114, '7018', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 115, '7065', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 116, '4007', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 117, '4008', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 118, '4009', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 119, '7022', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 120, '7024', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 121, '7004', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 122, '4006', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 123, '7011', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 124, '7013', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 125, '4016', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 126, '7089', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 127, '7014', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 128, '7005', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 129, '7009', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 130, '7533', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 131, '7917', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 132, '7092', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 133, '7103', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 134, '7587', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 135, '4570', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 136, '7976', ' ')
go

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 137, '7979', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 138, '7982', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 139, '7983', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 140, '7978', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 141, '7984', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 142, '7960', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 143, '7961', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 144, '7527', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 145, '7062', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 146, '7962', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 147, '7522', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 148, '7617', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 149, '7090', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 150, '7100', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 151, '7106', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 152, '4571', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 153, '4551', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 154, '7583', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 155, '7112', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 156, '4670', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 157, '7093', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 158, '7114', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 159, '7104', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 160, '7554', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 161, '7111', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 162, '7109', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 163, '7034', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 164, '4087', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 165, '7107', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 166, '7101', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 167, '7108', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 168, '7091', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 169, '7117', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 170, '7560', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 171, '4564', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 172, '7118', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 173, '4089', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 174, '4088', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 175, '7116', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 176, '7119', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 177, '7113', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 178, '7115', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 179, '4102', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 180, '7126', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 181, '7127', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 182, '4104', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 183, '7120', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 184, '7123', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 185, '7633', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 186, '4108', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 187, '4107', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 188, '7687', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 189, '7733', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 190, '7125', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 191, '4112', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 192, '4525', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 193, '4109', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 194, '4115', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 195, '4114', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 196, '7986', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 197, '7985', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 198, '7987', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 199, '7988', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 200, '7989', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 201, '7995', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 202, '7055', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 203, '7035', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 204, '7015', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 205, '7049', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 206, '7048', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 207, '7045', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 208, '7043', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 209, '7053', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 210, '7990', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 1, 211, '7042', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 2, 1, '0', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 2, 2, '4', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 3, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMES', '2009-08-01', 3, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 1, '4003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 2, '4005', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 3, '4010', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 4, '4011', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 5, '4014', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 6, '4015', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 7, '4017', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 8, '4018', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 9, '4019', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 10, '4022', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 11, '4024', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 12, '4025', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 13, '4027', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 14, '4030', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 15, '4031', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 16, '4032', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 17, '4033', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 18, '4034', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 19, '4035', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 20, '4036', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 21, '4040', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 22, '4043', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 23, '4044', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 24, '4045', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 25, '4046', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 26, '4047', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 27, '4049', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 28, '4050', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 29, '4051', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 30, '4053', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 31, '4054', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 32, '4056', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 33, '4057', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 34, '4058', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 35, '4059', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 36, '4060', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 37, '4061', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 38, '4064', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 39, '4065', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 40, '4067', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 41, '4070', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 42, '4071', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 43, '4072', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 44, '4073', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 45, '4074', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 46, '4075', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 47, '7001', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 48, '7002', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 49, '7003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 50, '7006', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 51, '7008', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 52, '7010', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 53, '7012', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 54, '7016', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 55, '7017', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 56, '7019', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 57, '7020', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 58, '7021', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 59, '7023', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 60, '7025', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 61, '7027', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 62, '7028', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 63, '7029', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 64, '7030', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 65, '7031', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 66, '7032', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 67, '7033', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 68, '7037', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 69, '7038', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 70, '7039', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 71, '7040', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 72, '7041', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 73, '7044', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 74, '7046', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 75, '7047', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 76, '7051', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 77, '7052', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 78, '7054', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 79, '7056', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 80, '7059', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 81, '7060', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 82, '7064', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 83, '7066', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 84, '7067', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 85, '7068', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 86, '7069', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 87, '7071', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 88, '7072', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 89, '7073', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 90, '7074', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 91, '7075', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 92, '4076', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 93, '4077', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 94, '4078', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 95, '4079', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 96, '4080', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 97, '7076', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 98, '7077', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 99, '7078', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 100, '7079', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 101, '7080', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 102, '7081', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 103, '7082', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 104, '7083', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 105, '7084', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 106, '7085', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 107, '7086', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 108, '4081', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 109, '7088', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 110, '7087', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 111, '4082', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 112, '7061', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 113, '4086', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 114, '7018', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 115, '7065', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 116, '4007', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 117, '4008', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 118, '4009', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 119, '7022', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 120, '7024', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 121, '7004', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 122, '4006', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 123, '7011', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 124, '7013', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 125, '4016', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 126, '7089', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 127, '7014', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 128, '7005', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 129, '7009', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 130, '7533', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 131, '7917', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 132, '7092', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 133, '7103', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 134, '7587', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 135, '4570', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 136, '7976', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 137, '7979', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 138, '7982', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 139, '7983', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 140, '7978', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 141, '7984', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 142, '7960', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 143, '7961', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 144, '7527', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 145, '7062', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 146, '7962', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 147, '7522', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 148, '7617', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 149, '7090', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 150, '7100', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 151, '7106', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 152, '4571', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 153, '4551', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 154, '7583', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 155, '7112', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 156, '4670', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 157, '7093', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 158, '7114', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 159, '7104', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 160, '7554', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 161, '7111', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 162, '7109', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 163, '7034', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 164, '4087', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 165, '7107', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 166, '7101', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 167, '7108', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 168, '7091', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 169, '7117', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 170, '7560', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 171, '4564', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 172, '7118', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 173, '4089', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 174, '4088', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 175, '7116', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 176, '7119', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 177, '7113', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 178, '7115', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 179, '4102', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 180, '7126', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 181, '7127', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 182, '4104', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 183, '7120', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 184, '7123', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 185, '7633', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 186, '4108', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 187, '4107', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 188, '7687', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 189, '7733', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 190, '7125', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 191, '4112', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 192, '4525', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 193, '4109', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 194, '4115', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 195, '4114', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 196, '7986', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 197, '7985', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 1, 198, '7987', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 2, 1, '0', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 2, 2, '4', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 3, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MIPYMESFX', '2009-08-01', 3, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 1, 'PREGRADO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 2, 'POSGRADO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 3, 'CALAMIDAD', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 4, 'EXCONSUMO1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 5, 'EXCONSUMO2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 6, 'EMSV1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 7, 'EMSV2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 8, 'EMNV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 9, 'EXSV24', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 10, 'EXSV23', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 11, 'EXNV4', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 12, 'EXNV3', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 13, 'EXSV13', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 14, 'EXSV14', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 15, 'SEGPOLVEHI', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 1, 16, 'CRESPFUNC', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 2, 1, '1.0', '5.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 2, 2, '5.0', '13.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_EMP', '2009-08-01', 2, 3, '13.0', '100.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 1, 1, 'NU', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 1, 2, 'RN', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 1, 3, 'RE', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 1, 4, 'CU', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 2, 1, 'SC', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 2, 2, 'CC', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 3, 1, 'DSP', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 3, 2, 'DCP', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 3, 3, 'DGA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 4, 1, 'CD', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 4, 2, 'CA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 4, 3, 'CI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 5, 1, 'CSP', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MONTO_MAX', '2010-10-09', 5, 2, 'CCP', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 1, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 1, 2, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 1, 3, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 1, 4, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 2, 1, 'CON', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 2, 2, 'EXT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 2, 3, 'PAG', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('MSGCONPRES', '2013-04-01', 2, 4, 'CAN', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 1, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 1, 2, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 1, 3, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 2, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 2, 2, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 2, 3, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 3, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 3, 2, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 3, 3, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('NUM_NORM', '2013-08-31', 4, 1, '0', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 1, 'PREGRADO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 2, 'POSGRADO', ' ')
go

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 3, 'CALAMIDAD', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 4, 'EXCONSUMO1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 5, 'EXCONSUMO2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 6, 'EMSV1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 7, 'EMSV2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 8, 'EMNV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 9, 'EXSV24', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 10, 'EXSV23', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 11, 'EXNV4', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 12, 'EXNV3', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 13, 'EXSV13', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 14, 'EXSV14', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 15, 'SEGPOLVEHI', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 1, 16, 'CRESPFUNC', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 1, '0.5', '1.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 2, '1.0', '2.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 3, '2.0', '4.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 4, '4.0', '5.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 5, '5.0', '6.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 6, '6.0', '7.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 7, '7.0', '10.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 8, '10.0', '13.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 9, '13.0', '19.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 10, '19.0', '25.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 11, '25.0', '50.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 12, '50.0', '75.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 13, '75.0', '100.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 14, '100.0', '135.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 15, '135.0', '620.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 2, 16, '620.0', '1600.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 3, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 3, 2, 'S', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 4, 1, '20.00', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 4, 2, '25.00', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 4, 3, '32.00', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_EMP', '2009-08-01', 4, 4, '0.00', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 1, 'SINCO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 2, 'CREDSEMI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 3, 'CAMPO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 4, 'CREDVEHI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 5, 'PRESTGAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 6, 'PARALELO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 7, 'MEJOLOCT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 8, 'CLIENT1A', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 9, 'CREDVTU', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 10, 'LECHEMIA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 11, 'MULTIPROD', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 12, 'BAPROGRACT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 13, 'BAPROGRPAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 14, 'BALIQCACT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 15, 'BALIQCPAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 16, 'RESTOLAINV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 17, 'APEMCAPTRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 18, 'APEMPPROD', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 19, 'ROTARURAL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 20, 'ASORURALP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 21, 'INVERRURAL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 22, 'FINAGROEMA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 23, 'FINAGROEMP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 24, 'ASOFINAGRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 25, 'ASOFINAPAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 26, 'MULTPRORUP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 27, 'DESARURAL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 28, 'RENOVOILEV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 29, 'ROINVLEVE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 30, 'ROINVGRAVE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 31, 'ROINVCATAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 32, 'RINVCATTOT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 33, 'SINCOLAPLA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 34, 'CLIENT1ALP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 35, 'FIEL1CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 36, 'FIEL1INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 37, 'FIEL2CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 38, 'FIEL2INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 39, 'FIEL3CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 40, 'FIEL3INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 41, 'FIEL4CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 42, 'FIEL4INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 43, 'CONTRANOCT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 44, 'CONTRANOIV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 45, 'AGROMIACAT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 46, 'AGROMIAINV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 47, 'RURALCATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 48, 'RURALINVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 49, 'RURAINAGRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 50, 'ROTAAGROPE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 51, 'INVERAGROP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 52, 'CREDICONSO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 53, 'CORRESPB', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 54, 'CREDICONS1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 55, 'CREDICONS2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 56, 'INCENMICRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 57, 'ESPECIALRE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 58, 'ESPECIALPG', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 59, 'ALINSTANTE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 60, 'ALIANZAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 61, 'CREDIRUL25', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 62, 'CREDIRUL8', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 1, 63, 'CREDIRUL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 1, '0', '0.7')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 2, '0.7', '1')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 3, '1', '2')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 4, '2', '2.1')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 5, '2.1', '3')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 6, '3', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 7, '4', '4.6287')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 8, '4.6287', '6')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 9, '6', '10')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 10, '10', '10.0624')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 11, '10.0624', '24')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 12, '24', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 13, '25', '25.1')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 14, '25.1', '37')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 15, '37', '50')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 16, '50', '56')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 17, '56', '75')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 18, '75', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 19, '100', '116')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 20, '116', '120')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 21, '120', '400')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 22, '400', '475')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 23, '475', '600')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 24, '600', '745')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 25, '745', '747')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 26, '747', '800')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PLAZO_MAX', '2009-08-01', 2, 27, '800', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 1, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 1, 2, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 2, 1, '01', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 2, 2, '02', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 2, 3, '03', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 3, 1, 'CON', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 3, 2, 'EXT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 3, 3, 'PAG', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 3, 4, 'CAN', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 3, 5, 'BAT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 4, 1, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 4, 2, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 5, 1, '0.0', '70.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 5, 2, '70.0', '85.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 5, 3, '85.0', '100.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 6, 1, '0.0', '70.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 6, 2, '70.0', '85.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('POL_CTROFE', '2013-04-01', 6, 3, '85.0', '100.0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 1, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 1, 2, 'P', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 2, 1, '47', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 2, 2, '86', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 2, 3, '127', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 3, 1, 'CAP', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 3, 2, 'IMO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 3, 3, 'INT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('PORMAXCOND', '2013-01-12', 3, 4, 'OTROS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 1, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 1, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 1, 'CAMPO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 2, 'CLIENT1A', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 3, 'CREDSEMI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 4, 'CREDVEHI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 5, 'LECHEMIA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 6, 'MEJOLOCT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 7, 'PARALELO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 8, 'PRESTGAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 9, 'SINCO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 10, 'SINCOLAPLA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 11, 'CLIENT1ALP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 12, 'FIEL1CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 13, 'FIEL1INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 14, 'FIEL2CATRA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 15, 'FIEL2INVER', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 16, 'FIEL3CATRA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 17, 'FIEL3INVER', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 18, 'FIEL4CATRA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 19, 'FIEL4INVER', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 20, 'CONTRANOCT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 21, 'CONTRANOIV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 22, 'AGROMIACAT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 23, 'AGROMIAINV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 24, 'RURALCATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 25, 'RURALINVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 26, 'RURAINAGRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 27, 'ESPECIALRE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 28, 'ESPECIALPG', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 29, 'CREDIRUL25', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 30, 'CREDIRUL8', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 2, 31, 'CREDIRUL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 3, 1, 'U', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 3, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 4, 1, '001', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 4, 2, '002', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 4, 3, '003', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 4, 4, '004', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 5, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 5, 2, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 6, 1, '0', '1')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 7, 1, '0.7', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 7, 2, '4', '5')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 7, 3, '5', '9')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 7, 4, '9', '99999999')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 8, 1, '0', '11')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 8, 2, '11', '60')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 9, 1, '0', '3')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 9, 2, '3', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 9, 3, '4', '5')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 10, 1, '0', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MAX', '2010-01-01', 10, 2, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MIN', '2010-01-01', 1, 1, 'N', '0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MIN', '2010-01-01', 1, 2, 'R', '0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MIN', '2010-01-01', 2, 1, 'SINCO', '0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASAS_MIN', '2010-01-01', 2, 2, 'CAMPO', '0')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 1, 'AGROMIACAT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 2, 'AGROMIAINV', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 3, 'CAMPO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 4, 'CREDVEHI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 5, 'MEJOLOCT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 6, 'PARALELO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 7, 'PRESTGAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 8, 'RURAINAGRO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 9, 'RURALCATRA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 10, 'RURALINVER', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 11, 'SINCO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 12, 'ESPECIALRE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 13, 'ESPECIALPG', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 1, 14, 'ALIANZAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 1, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 2, '6', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 3, '7', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 4, '8', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 5, '9', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 6, '10', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 7, '11', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 8, '12', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 9, '13', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 10, '14', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 11, '15', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 12, '16', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 13, '17', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 14, '18', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 15, '19', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 16, '20', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 17, '21', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 18, '22', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 19, '23', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 20, '24', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 21, '25', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 22, '27', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 23, '28', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 24, '29', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 25, '30', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 26, '31', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 27, '32', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 28, '33', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 29, '34', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 30, '35', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 31, '36', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 32, '37', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 33, '38', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 34, '39', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 35, '40', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 36, '41', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 37, '42', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 38, '43', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 39, '44', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 2, 40, '45', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 3, 1, 'INT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 4, 1, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 4, 2, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 5, 1, '01', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 5, 2, '03', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 5, 3, '20', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 6, 1, '0', '0.99')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 6, 2, '0.99', '50')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 7, 1, '0', '4')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 7, 2, '4', '9')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 7, 3, '9', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 7, 4, '25', '37')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 7, 5, '37', '120')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 8, 1, 'N', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 8, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 9, 1, 'O', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_DEF', '2013-04-01', 9, 2, 'R', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 1, 'AGROMIACAT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 2, 'AGROMIAINV', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 3, 'CAMPO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 4, 'CREDVEHI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 5, 'MEJOLOCT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 6, 'PARALELO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 7, 'PRESTGAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 8, 'RURAINAGRO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 9, 'RURALCATRA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 10, 'RURALINVER', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 1, 11, 'SINCO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 2, 1, '5', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 2, 2, '6', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 2, 3, '7', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 2, 4, '8', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 2, 5, '9', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 3, 1, 'INT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 4, 1, '47', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 5, 1, '4', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 5, 2, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 6, 1, '01', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 6, 2, '03', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 6, 3, '20', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 7, 1, '0', '0.99')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('TASA_MN_LC', '2013-04-01', 7, 2, '0.99', '50')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 1, 1, '2205', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 1, 2, '2210', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 1, 3, '2236', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 1, 4, '2263', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 1, 5, '2268', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 1, 6, '2266', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 2, 1, '1', '15')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 2, 2, '15', '25')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 2, 3, '25', '100')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 2, 4, '100', '809')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 3, 1, '01', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 3, 2, '03', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_FNG', '2009-08-01', 3, 3, '20', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 1, 'SINCO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 2, 'CREDSEMI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 3, 'CAMPO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 4, 'CREDVEHI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 5, 'PRESTGAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 6, 'PARALELO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 7, 'MEJOLOCT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 8, 'CLIENT1A', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 9, 'CREDVTU', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 10, 'BANCOLDEX', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 11, 'BANCOLMULT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 12, 'BANCOLPAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 13, 'BANMULTPAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 14, 'LECHEMIA', '')
go

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 15, 'MULTIPROD', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 16, 'BAPROGRACT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 17, 'BAPROGRPAS', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 18, 'APEMCAPTRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 19, 'APEMPPROD', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 20, 'ROTARURAL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 21, 'ASORURALP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 22, 'INVERRURAL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 23, 'FINAGROEMA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 24, 'FINAGROEMP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 25, 'ASOFINAGRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 26, 'ASOFINAPAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 27, 'MULTPRORUP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 28, 'DESARURAL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 29, 'SINCOLAPLA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 30, 'CLIENT1ALP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 31, 'PREGRADO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 32, 'POSGRADO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 33, 'CALAMIDAD', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 34, 'EXCONSUMO1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 35, 'EXCONSUMO2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 36, 'EMSV1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 37, 'EMSV2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 38, 'EMNV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 39, 'EXSV24', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 40, 'EXSV23', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 41, 'EXNV4', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 42, 'EXNV3', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 43, 'EXSV13', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 44, 'EXSV14', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 45, 'FIEL1CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 46, 'FIEL1INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 47, 'FIEL2CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 48, 'FIEL2INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 49, 'FIEL3CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 50, 'FIEL3INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 51, 'FIEL4CATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 52, 'FIEL4INVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 53, 'CONTRANOCT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 54, 'CONTRANOIV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 55, 'BALIQCACT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 56, 'BALIQCPAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 57, 'RENOVOILEV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 58, 'RESTOLAINV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 59, 'RINVCATTOT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 60, 'ROINVCATAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 61, 'ROINVGRAVE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 62, 'ROINVLEVE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 63, 'AGROMIACAT', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 64, 'AGROMIAINV', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 65, 'RURALCATRA', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 66, 'RURALINVER', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 67, 'RURAINAGRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 68, 'ROTAAGROPE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 69, 'INVERAGROP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 70, 'SEGPOLVEHI', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 71, 'CRESPFUNC', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 72, 'CREDICONSO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 73, 'CORRESPB', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 74, 'CREDICONS1', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 75, 'CREDICONS2', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 76, 'INCENMICRO', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 77, 'ESPECIALRE', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 78, 'ESPECIALPG', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 79, 'CREDIRUL25', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 80, 'ALIANZAS', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 81, 'CREDIRUL8', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 1, 82, 'CREDIRUL', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 1, 'COMFNGANU', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 2, 'VAL_MATRIZ', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 3, 'MONTO_MAX', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 4, 'PLAZO_MAX', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 5, 'MIPYMES', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 6, 'TASAS_MAX', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 7, 'COMFAGANU', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 8, 'COMUSASEM', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 9, 'PLAZO_EMP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 10, 'MONTO_EMP', ' ')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 11, 'COMFAGUNI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 12, 'COMFNGAUT', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 13, 'VAL_FNG', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 14, 'COMFGAUNI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 15, 'POL_CTROFE', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 16, 'MSGCONPRES', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 17, 'TASA_DEF', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 18, 'ASIG_AUTO', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 19, 'COMGARCAL', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 20, 'COMGARUNI', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 21, 'COMGARNSA', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 22, 'COMGARTUM', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 23, 'NUM_NORM', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_MATRIZ', '2010-01-01', 2, 24, 'VAL_NORM', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 1, 1, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 1, 2, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 2, 1, '0', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 3, 1, '1', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 3, 2, '2', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 3, 3, '3', '')

insert into ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango, er_rango_desde, er_rango_hasta)
values ('VAL_NORM', '2015-10-15', 3, 4, '4', '')
go

