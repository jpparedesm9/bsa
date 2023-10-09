use cob_cartera
go

delete ca_matriz
 where ma_matriz in ('ASIG_AUTO','COMFAGANU','COMFAGUNI','COMFGAUNI','COMFNGANU','COMFNGAUT','COMGARCAL','COMGARNSA','COMGARTUM','COMGARUNI','COMUSASEM',
                     'DIASMAXNEG','GEN_CNTRAC','INSAPRMIR','MIPYMES','MIPYMESFX','MONTO_EMP','MONTO_MAX','MSGCONPRES','NUM_NORM','PLAZO_EMP','PLAZO_MAX',
                     'POL_CTROFE','PORMAXCOND','TASAS_MAX','TASAS_MIN','TASA_DEF','TASA_MN_LC','VAL_FNG','VAL_MATRIZ','VAL_NORM')
go

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('TASA_DEF', 'DEFINE EL SPREAD DEL CLIENTE', '2013-04-01', 10, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('INSAPRMIR', 'INSTANCIA DE APROBACION MIR', '2011-11-15', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('MONTO_EMP', 'MONTO EN SALARIOS MINIMOS LEGALES DE LA LINEA DE CREDITO (FU', '2009-08-01', 4, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMFNGAUT', 'COMISION FONDO NACIONAL DE GARANTIAS', '2009-08-01', 1, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMFGAUNI', 'COMISION FGA UNICA ANTICIPADA', '2009-08-01', 4, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMGARCAL', 'COMISION FNG CALI', '2013-08-31', 1, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('PORMAXCOND', 'PORCENTAJES MAXIMOS A CONDONAR', '2013-01-12', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('ASIG_AUTO', 'ASIGNACION AUTOMATICA DE VISITAS', '2013-04-01', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('POL_CTROFE', 'DEFINE LAS POLITICAS PARA CONTRA OFERTAS', '2013-04-01', 6, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('MSGCONPRES', 'MENSAJE EVENTO CONSULTA DATOS DEL PRESTAMO', '2013-04-01', 2, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('TASA_MN_LC', 'VALOR DE LA TASA MINIMA QUE SE PODRA NEGOCIAR SEGUN EL ROL', '2013-04-01', 7, -999)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('PLAZO_MAX', 'PLAZO MAXIMO DE LA LINEA DE CREDITO', '2009-08-01', 2, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMGARNSA', 'COMISION FNG NORTE SANTANDER', '2014-05-29', 1, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('MIPYMES', 'SEGUROS DEUDORES', '2009-08-01', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMGARUNI', 'COMISION FGU UNIVERSAL ANTICIPADA', '2013-08-31', 2, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('NUM_NORM', 'NUMERO MAXIMO NORMALIZACIONES', '2013-08-31', 4, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMFNGANU', 'COMISION FONDO NACIONAL DE GARANTIAS', '2009-08-01', 1, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMFAGUNI', 'COMISION FAG UNICA', '2009-08-01', 5, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('MONTO_MAX', 'MONTO MAXIMO DE TRAMITE', '2010-10-09', 5, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('PLAZO_EMP', 'PLAZO MAXIMO DE LA LINEA DE CREDITO (FUNCIONARIOS)', '2009-08-01', 4, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('DIASMAXNEG', 'PLAZOS MAXIMOS DE NEGOCIACION', '2013-01-12', 2, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMGARTUM', 'COMISION FNG TUMACO', '2013-08-31', 1, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMFAGANU', 'COMISION FAG PERIODICA', '2009-08-01', 5, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('MIPYMESFX', 'COMISION MIPYME PARA TABLAS FLEXIBLES', '2009-08-01', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('VAL_FNG', 'CONDIC. MONTO Y DESTINO ECON', '2009-08-01', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('TASAS_MAX', 'SPREAD MAXIMO DE TASA REFERENCIAL PARAMETRIZADA EN LA PIZARR', '2010-01-01', 10, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('COMUSASEM', 'COMISION USAID PERIODICA', '2009-08-01', 1, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('VAL_MATRIZ', 'MATRICES POR LINEA DE CREDITO', '2010-01-01', 2, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('GEN_CNTRAC', 'DEFINE EL TIPO DE CONTRATOS QUE SE TENDRA QUE IMPRIMIR', '2012-04-05', 4, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('VAL_NORM', 'VALOR TASA CLIENTES ESPECIALES NORMALIZACION', '2015-10-15', 3, 0)

insert into ca_matriz (ma_matriz, ma_descripcion, ma_fecha_vig, ma_ejes, ma_valor_default)
values ('TASAS_MIN', 'SPREAD MINIMO DE TASA REFERENCIAL PARAMETRIZADA EN LA PIZARR', '2010-01-01', 1, 0)
go
