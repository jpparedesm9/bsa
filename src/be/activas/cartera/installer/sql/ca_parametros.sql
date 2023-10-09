
/* CARGA PARAMETROS CARTERA */

use cob_cartera
go

/* PARAMETROS GENERALES */

delete cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico in ('3XMCCA', 'ACC',    'AGRAVA', 'AJUARE', 'AJUCAM', 'AMOTOT', 'ARC',    'ARCXP',  'ARDEPO', 'ARESOB', 'ASEG',   'ATRAS0', 'ATRASO', 'AUTOFV',
                       'BCOLDE', 'CAGRA',  'CAP',    'CAPF',   'APECR',  'CFAGRE', 'CHEGER', 'CHEPRO', 'CODPCO', 'CODPJU', 'CODPRE', 'CODPVO', 'COL',    'COMCV',
                       'COMFAG', 'COMFNG', 'COMFOG', 'COMMAB', 'COMONG', 'CONIVA', 'CONSOB', 'CONTIM', 'COPICR', 'CTOSOB', 'CXCINT', 'CXPCJD', 'CXPCOL', 'CXPDSE',
                       'DCTRA',  'DDP',    'DESDME', 'DESDML', 'DESSOB', 'DEST',   'DEVDD0', 'DEVDD1', 'DEVINT', 'DEVSEG', 'DFVAL',  'DIMAVE', 'DIMIVE', 'DIPP',
                       'DIR',    'DMASIV', 'DQUIN',  'DR',     'ESTCJP', 'EXEQUI', 'FALTAN', 'FDRFAG', 'FE4767', 'FECUVR', 'FECVAL', 'FINAG',  'FINDET', 'FNG_FP',
                       'FNG_PO', 'FNG_RU', 'FPBSP',  'FPDGIA', 'FPRFAG', 'FPRSVI', 'GARHIP', 'GNACI',  'HONABO', 'IBC',    'IBCEX',  'ICTE',   'IDEDUC', 'IFAGRE',
                       'IMO',    'INT',    'INTANT', 'INTFAC', 'IPC',    'ITEMVC', 'LAJUST', 'LEY550', 'LEY617', 'MDG',    'MICSEG', 'MIPYME', 'MISEG',  'MMDC',
                       'MONTOL', 'MUVR',   'NCAHO',  'NCCC',   'NCFE',   'NDAHIT', 'NDAHO',  'NDAHOI', 'NDCC',   'NDCCIT', 'NDCFE',  'NDE',    'NDEIPC', 'NDEOM',
                       'NDO',    'NID',    'NSMLPP', 'OFISOB', 'OFIVB',  'OFOSOB', 'PAN',    'PAR0',   'PART',   'PCCP',   'PDPOG',  'PIVA',   'PRETR0', 'PRETRY',
                       'PRO0',   'PROC',   'R-CONV', 'RCTMAX', 'RECICR', 'RENOV0', 'RENOV1', 'ROT',    'SECSOB', 'SEDEAN', 'SEDEVE', 'SEGEXT', 'SEGROM', 'SEGTRM',
                       'SEGURO', 'SEGVEH', 'SEGVIV', 'SMC',    'SOBAUT', 'SUVEH',  'TASIVA', 'TASTIM', 'TCOBRA', 'TIMBAC', 'TIMBRE', 'TIMPME', 'TLU',    'TLUEX',
                       'TMM',    'TMMEX',  'TODCAU', 'TRAMO',  'TUVR',   'VIPC',   'VISAMO', 'VISCAU', 'VISCMO', 'VISPAG', 'VISSUA', 'VIV',    'CMFAGP', 'COMUNI',
                       'ICFAGU', 'CMFAGD', 'ICFAGD', 'CMUSAP', 'ICUSAD', 'COFNGD', 'COMFGA', 'IVAFGA', 'IVFNGD', 'GMF',    'COMGAR', 'IVAGAR', 'IVAGRP', 'COMGRP',
                       'HINIFI', 'HFINFI', 'HIFISU', 'HFFISU', 'CHELOC', 'RECFNG', 'RECUSA', 'TFLEXI', 'SALMIN', 'BEMPRE', 'IVAMIP', 'FSAMIN', 'PTENOR', 'PCPRE',
                       'PPAGAD', 'PCCOM',  'RUBCPR', 'CCCOM',  'CCCON',  'CCVIV',  'CSMIC',  'MAXVM',  'PRERE',  'PCAPRE', 'DMOVCU', 'DMOVCN', 'CSMIC',  'RAHOGR',
                       'PICIP',  'PIPP',   'VALAHO', 'PGARGR', 'PGARIN', 'DMINC',  'QUIN',   'NCRAHO', 'FDESRE', 'USLIFI', 'CTAORD', 'NOMORD', 'RFCORD', 'DPDES',
                       'RSEMI',  'NTSER',  'NRID',   'NCDAHO', 'MUL500', 'MUL100', 'ISSUER', 'NAXPC',  'RBATN',  'DVOG',   'RPPAG',  'PORCGP', 'MDWNA',  'MDQNA', 'MDMNA', 'IVAINT', 'CANGAR','LOOPA',  'FFOPA',  'LMOPA',  'TCTAOR', 'ABRORD', 'OFICEN', 'DPAGSO', 'CPAGSO', 'NCMPRE', 'TOPGAR', 'CTAGAR', 'CTASTD', 
'CCMORA', 'DIPRE', 'CTACON', 'GADOPA', 'GADOSE', 'NAREVA', 'SEGPRO', 'NROPOL', 'SEMBK' , 'TESEG',  'CAAPSO', 'CAREVA',  'SENSI', 'IMPSEG',
'DGRFNB', 'LCRCUO','LCRVEN', 'LCRGRA', 'LCRUMB', 'PAVACA', 'CTGARL', 'DNOREN','AB_OBJ',  'COMLCR', 'MINDES', 'MAXINC', 'PAVACA','CTGARL', 'DNOREN','AB_OBJ','DANORE',
'LOREVR', 'CICCJA','VTSPRO', 'VTNPRO')
go
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIEMPO (MIN) ESPERA PARA COBRO SEGURO', 'TESEG', 'T', NULL, 60, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro values('MULTIPLO PARA MONTOS GRUPALES', 'MUL500', 'M', null, null, null, null, 500, null, null,'CCA')
insert into cobis..cl_parametro values('MULTIPLO PARA RENOVACIONES', 'MUL100', 'M', null, null, null, null, 100, null, null,'CCA')

insert into cobis..cl_parametro values('PARAMETRO GENERAL PARA DIAS MINIMOS CUOTA', 'DMINC', 'T', null, 3, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('VALIDACION MAXIMO TRANSACCIONES MONETARIAS CARTERA', 'MAXVM', 'M', NULL, NULL, NULL, NULL, 10000, NULL, NULL, 'CCA')
insert into cobis..cl_parametro values('NO APLICA EN CARTERA', '3XMCCA', 'F', null, null, null, null, null, null, 0.0,'CCA')
insert into cobis..cl_parametro values('RUBRO PARA CONTABILIZACION DE ACCIONISTAS', 'ACC', 'C', 'ACC', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('A�O GRAVABLE', 'AGRAVA', 'I', null, null, null, 2006, null, null, null,'CCA')
insert into cobis..cl_parametro values('AREA DE AJUSTE UVR', 'AJUARE', 'S', null, null, 6810, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('AJUSTE DE CAMBIO EN CORRECCION MONETARIA', 'AJUCAM', 'C', '41101500005', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('AMORTIZACI�N TOTAL DTOS. SIN RESPONSABILIDAD', 'AMOTOT', 'C', 'AMOTOT', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('AREA CONTABLE DEL PRODUCTO CARTERA', 'ARC', 'S', null, null, 1090, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('AREA PARA CxP', 'ARCXP', 'I', null, null, null, 6810, null, null, null,'CCA')
insert into cobis..cl_parametro values('AREA DEPOSITOS EN GARANTIA', 'ARDEPO', 'I', null, null, null, 6810, null, null, null,'CCA')
insert into cobis..cl_parametro values('AREA PARA SOBRANTE AUTOMATICO  POR CANCELACION CON MAYOR VALOR', 'ARESOB', 'I', null, null, null, 6810, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO ASEGURADORA QUE TRABAJA CON EL BAC', 'ASEG', 'C', '3', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TIEMPO PARA ESPERAR PROCESOS PARALELOS', 'ATRAS0', 'T', null, 120, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TIEMPO PARA ESPERAR PROCESOS PARALELOS', 'ATRASO', 'T', null, 120, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('AUTORIZACION FECHA VALOR MAS DE 30 DIAS', 'AUTOFV', 'C', 'N', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR BANCOLDEX', 'BCOLDE', 'C', '221', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR PASIVAS SIN ACTIVA DE LA CAJA AGRARIA', 'CAGRA', 'C', 'CAGRA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('SIGLAS DE CAPITAL', 'CAP', 'C', 'CAP', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CAPITAL FINANCIADO', 'CAPF', 'C', 'CAPF', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COBRO COMISION APERTURA DE CREDITO', 'APECR', 'C', 'APERCRED', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA COMISION FAG EN REESTRUCTURACION', 'CFAGRE', 'C', 'COMISPFAG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR CHEQUE DE GERENCIA', 'CHEGER', 'C', 'CHEGER', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO CON CHEQUE PROPIOS', 'CHEPRO', 'C', 'CHPROPIOS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO PREPAGO CONSOLIDACION PASIVOS', 'CODPCO', 'C', '24', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO PREPAGO JURIDICO PASIVAS', 'CODPJU', 'C', '23', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO PRECANCELACION', 'CODPRE', 'C', '21', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO PREPAGO ABONO VOLUNTARIO DEL CLIENTE', 'CODPVO', 'C', '11', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO PARA ALMACENAR EL PORCENTAJE DE COLCHON EN DD', 'COL', 'C', 'COL', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('COMISION DESCUENTO CONVENIOS', 'COMCV', 'C', 'CDCTO', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION FAG', 'COMFAG', 'C', 'COMISIOFAG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION FNG EN EL DESEMBOLSO', 'COMFNG', 'C', 'COMFNGANU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION FOGACAFE', 'COMFOG', 'C', 'CMFOGACAFE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION ACEPTACIONES BANCARIAS', 'COMMAB', 'C', 'CMAB', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION PARA ONG', 'COMONG', 'C', 'COMISONG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO CONTABLE PARA COBRO DE IVA EN CARTERA', 'CONIVA', 'C', '0200', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO SIDAC SOBRANTE AUTOMATICO EN PAGO', 'CONSOB', 'C', '279595SC01', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO CONTABLE PARA COBRO DE TIMBRE EN CARTERA', 'CONTIM', 'C', '0345', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO PREPAGO ICR', 'COPICR', 'C', '31', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CARTERIZACION DE SOBREGIROS', 'CTOSOB', 'C', 'DESSOB', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TRASLADO DE INTERESES CORRIENTES', 'CXCINT', 'C', 'CXCINTES', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO PARA CxP EN GASTOS Y COSTOS JUDICIALES', 'CXPCJD', 'C', '14CART18', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO PARA CUENTAS POR PAGAR EN  DD', 'CXPCOL', 'C', '14CART18', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CONCEPTO PARA CxP POR DEVOLUCION DE SEGUROS', 'CXPDSE', 'C', 'DEVSEG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIAS DE CONTROL PARA TRAMITES', 'DCTRA', 'S', null, null, 6000, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIAS MINIMOS PARA DESEMBOLSO PARCIAL EN DIV VIGENTE', 'DDP', 'S', null, null, 20, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DESEMBOLSO DESCTO. DTOS. SIN RESPONSABILIDAD ME', 'DESDME', 'C', 'DESDDME', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DESEMBOLSO DESCTO. DTOS. SIN RESPONSABILIDAD ML', 'DESDML', 'C', 'DESDDML', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DESTINO SOBREGIROS', 'DESSOB', 'C', '1001', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DESTINO DE UNA OPERACION POR DEFECTO', 'DEST', 'C', '38', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DEVOLUCUON EN DESCUENTO DE DOCUMENTOS ML', 'DEVDD0', 'C', 'DEV-DD0', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DEVOLUCUON EN DESCUENTO DE DOCUMENTOS ME', 'DEVDD1', 'C', 'DEV-DD1', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DEVOLUCION EN INTERESES POR PAGO EN VP', 'DEVINT', 'C', 'DEVINT', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA DEVOLUCION DE SEGUROS', 'DEVSEG', 'C', '259595DVSE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIAS DE CONTROL PARA FECHA VALOR', 'DFVAL', 'S', null, null, 6000, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIA MAXIMO PARA FECHAS DE VENCIMIENTO', 'DIMAVE', 'T', null, 20, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIA MINIMO PARA FECHAS DE VENCIMIENTO', 'DIMIVE', 'T', null, 2, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIAS MINIMOS PARA HEREDAR UN PREPAGO DE LA ACTIVA A LA PASIVA', 'DIPP', 'S', null, null, 7, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO DE DIRECCION PARA CARTERA', 'DIR', 'C', '009', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TABLA  QUE CONTIENE LINEAS PARA DESEMBOLSO MASIVO', 'DMASIV', 'C', 'T18', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIAS MINIMOS PARA DIVIDENDOS QUINCENALES', 'DQUIN', 'S', null, null, 13, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DECRETO REGLAMENTARIO', 'DR', 'C', '4585/2006', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO ESTADO COBRO JURIDICO PASIVAS', 'ESTCJP', 'T', null, 97, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO EXEQUIAL', 'EXEQUI', 'C', 'EXEQUIAL', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARA VALIDACION DE OPERACIONES QUE INGRESAN A H.C.', 'FALTAN', 'I', null, null, null, 0, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE DESEMBOLSO RECONOCIMIENTO FAG', 'FDRFAG', 'C', 'FAG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FECHA DE PUESTA EN PRODUCCION DEF 4767', 'FE4767', 'F', null, null, null, null, null, null, 0.0,'CCA')
insert into cobis..cl_parametro values('FECHA COTIZACION UVR A FIN DE AÐO', 'FECUVR', 'D', null, null, null, null, null, 'Dec 31 2006 12:00AM', null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA OPERACION FECHA VALOR', 'FECVAL', 'C', '140320000004497', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR FINAGRO', 'FINAG', 'C', '224', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR FINDETER', 'FINDET', 'C', '222', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('SIGLAS PARA RECONOCER FORMAS DE PAGO DEL FNG', 'FNG_FP', 'C', 'FNG_%', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RUBRO PARA REGISTRAR LOS PAGOS DEL FNG', 'FNG_PO', 'F', null, null, null, null, null, null, 40.0,'CCA')
insert into cobis..cl_parametro values('RUBRO PARA REGISTRAR LOS PAGOS DEL FNG', 'FNG_RU', 'C', 'FNG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR LA FORMA DE PAGO DE BANCOS DE SEGUNDO', 'FPBSP', 'C', 'FPBSP', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('MEDIO DE PAGO PARA DESCARGAR DEPOSITOS EN GARANTIA', 'FPDGIA', 'C', 'PDGTIA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO RECONOCIMIENTO FAG', 'FPRFAG', 'C', 'FAG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO RECONOCIMIENTO SEGURO DE VIDA', 'FPRSVI', 'C', 'SEGVIDA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TIPO SUPERIOR DE GARANTIA HIPOTECARIA', 'GARHIP', 'C', '1100', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TIPO DE GARANTIA', 'GNACI', 'C', '5300', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO HONORARIOS DE ABOGADO', 'HONABO', 'C', 'HONABO', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('INTERES BANCARIO CORRIENTE PESOS', 'IBC', 'C', 'IBC', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('INTERES BANCARIO CORRIENTE EXTRANJERO', 'IBCEX', 'C', 'IBCEX', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA REFERENCIAL BASE PARA TASAS DE MORA', 'ICTE', 'C', 'TMCTE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('MAXIMO VALOR DEDUCIBLE POR INTERES', 'IDEDUC', 'M', null, null, null, null, 25726000.00, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IVA FAG EN REESTRUCTURACION', 'IFAGRE', 'C', 'IVACMPFAG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RUBRO INTERES DE MORA', 'IMO', 'C', 'IMO', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RUBRO INTERES CORRIENTE', 'INT', 'C', 'INT', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RUBRO INTERES ANTICIPADO', 'INTANT', 'C', 'INTANT', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RUBRO INTERES OPERACIONES DESCUENTO DE DOCUMENTOS', 'INTFAC', 'C', 'INTDES', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA IPC', 'IPC', 'T', null, 30, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('IDENTIFICA ITEM DE VALOR CONSTRUCCION PARA SEGUROS HIPOTECAS', 'ITEMVC', 'C', 'VALORCONSTRUCCION', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('LIMITE DE AJUSTE CONTABLE PARA OPERACIONES EN UVR', 'LAJUST', 'M', null, null, null, null, 2.00, null, null,'CCA')
insert into cobis..cl_parametro values('CLIENTES EN SITUACION LEY 550', 'LEY550', 'C', 'LEY', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CLIENTES EN SITUACION LEY 617', 'LEY617', 'C', 'LYS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('MAXIMO DE DIAS PARA GRACIA DE MORA', 'MDG', 'I', null, null, null, 200, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA SEGURO VIDA TRANQUILA', 'MICSEG', 'C', 'MICROSEG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION MIPYMES', 'MIPYME', 'C', 'MIPYMES', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('SEGURO VIDA TRANQUILA', 'MISEG', 'C', 'MICROSEG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('MONTO MINIMO DEBITO CUENTA', 'MMDC', 'M', null, null, null, null, 0.00, null, null,'CCA')
insert into cobis..cl_parametro values('MONTO LAVADO ACTIVOS', 'MONTOL', 'M', null, null, null, null, 10000000.00, null, null,'CCA')
insert into cobis..cl_parametro values('CODIGO DE MONEDA UVR', 'MUVR', 'T', null, 2, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA DEVOLUCION DE SEGUROS A CTA. DE AHORROS', 'NCAHO', 'C', 'NCAHO', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA DEVOLUCION DE SEGUROS A CTA. CORRIENTE', 'NCCC', 'C', 'NCCC', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE CAMBIOS DE FECHAS PERMITIDOS POR OPERACION', 'NCFE', 'T', null, 3, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO ND CTA AHORROS INTERNET', 'NDAHIT', 'C', 'NDAHIT', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA PAGO NOTA DEBITO CUENTA AHORROS', 'NDAHO', 'C', 'NDAHO', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO ND AHORROS POR INTERNET', 'NDAHOI', 'C', 'NDAHINTERN', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA PAGO NOTA DEBITO CUENTA CORRIENTE', 'NDCC', 'C', 'NDCC', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO ND CTA CORRIENTE INTERNET', 'NDCCIT', 'C', 'NDCCINTERN', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE DIAS DE CORRIMIENTO PERMITIDOS PARA CAMBIOS DE FECHAS', 'NDCFE', 'T', null, 10, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE CIFRAS DECIMALES', 'NDE', 'T', null, 2, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DECIMALES PARA TASA IPC', 'NDEIPC', 'T', null, 4, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE CIFRAS DECIMALES OTRA MONEDAS', 'NDEOM', 'T', null, 4, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('DIAS PARA PASAR A SIGUIENTE MES', 'NDO', 'T', null, 27, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE INTENTOS DE DEBITOS', 'NID', 'T', null, 90, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE SALARIOS MINIMOS PARA PREPAGO EN PASIVAS', 'NSMLPP', 'T', null, 0, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('OFICIAL DE SOBRGIROS', 'OFISOB', 'S', null, null, 55, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA BANCA VIRTUAL', 'OFIVB', 'I', null, null, null, 30030, null, null, null,'CCA')
insert into cobis..cl_parametro values('FONDOS DE SOBREGIROS', 'OFOSOB', 'C', 'A', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PERIODICIDAD ANUAL', 'PAN', 'C', 'A', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARTICIONES DE LOS PROCESOS', 'PAR0', 'I', null, null, null, 200, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARTICIONES DE LOS PROCESOS', 'PART', 'I', null, null, null, 200, null, null, null,'CCA')
insert into cobis..cl_parametro values('PORCENTAJE DE CUOTAS CANCELADAS PARA LA PALM', 'PCCP', 'F', null, null, null, null, null, null, 70.0,'CCA')
insert into cobis..cl_parametro values('PARAMETRO CONCEPTO DEPOSITOS EN GARANTIA', 'PDPOG', 'C', '216015DGP', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RUBRO PARA CONTABILIZACION DEL IVA', 'PIVA', 'C', 'IVA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE INTENTOS PARA CADA PROCESO.', 'PRETR0', 'T', null, 4, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE INTENTOS PARA CADA PROCESO.', 'PRETRY', 'T', null, 3, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE PROCESOS SIMULTANEOS', 'PRO0', 'T', null, 10, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('NUMERO DE PROCESOS SIMULTANEOS', 'PROC', 'T', null, 10, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RELACION PARA CONVENIOS', 'R-CONV', 'S', null, null, 2, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('MAXIMA GENERACION RUBROS DE CATALOGO', 'RCTMAX', 'T', null, 12, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('RECONOCIMIENTO INCENTIVO ICR', 'RECICR', 'C', 'ICR', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO INTERNA RENOVACION MONEDA LEGAL', 'RENOV0', 'C', 'CARTERA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO INTERNA RENOVACION OTRAS MONEDAS', 'RENOV1', 'C', 'CARTERA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PRESTAMOS TIPO ROTATIVO', 'ROT', 'C', 'O', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('SECTOR DE SOBREGIROS', 'SECSOB', 'C', '1', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO DEUDORES ANTICIPADO', 'SEDEAN', 'C', 'SEGDEUANT', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO DEUDORES VENCIDO', 'SEDEVE', 'C', 'SEGDEUVEN', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO EXTRAPRIMA', 'SEGEXT', 'C', 'SEGEXTRAPR', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO ROTURA MAQUINARIA', 'SEGROM', 'C', 'SEGROMAQUI', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO TODO RIESGO MAQUINARIA', 'SEGTRM', 'C', 'SEGTORMAQU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO DE VIDA', 'SEGURO', 'C', 'SEGVIDA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO TODO RIESGO VEHICULO', 'SEGVEH', 'C', 'SEGTORVHI', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SEGURO TODO RIESGO VIVIENDA', 'SEGVIV', 'C', 'SEGTORVIV', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('SUSPENSION MANUAL DE CAUSACION', 'SMC', 'C', 'VALOR', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA FORMA DE PAGO SOBRANTE AUTOMATICO', 'SOBAUT', 'C', 'SOBRANTE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO SUPERIOR VEHICULAR', 'SUVEH', 'C', '2100', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR TASA APLICAR DE IVA', 'TASIVA', 'C', 'IVA', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR TASA APLICAR DE TIMBRE', 'TASTIM', 'C', 'TIMBRE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TABLA DE COSTOS DE COBRANZAS', 'TCOBRA', 'C', 'T25', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TIMBRE QUE ASUME EL BANCO', 'TIMBAC', 'C', 'TIMBAC', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('VALOR IMPUESTO DE TIMBRE', 'TIMBRE', 'C', 'TIMBRE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TIMBRE EN PESOS DE OPERACIONES EN ME', 'TIMPME', 'C', 'IMPTIMBRE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA LIMITE USURA', 'TLU', 'C', 'TLU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA LIMITE USURA EXTRANJERA', 'TLUEX', 'C', 'TLU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA MAXIMA DE MORA PESOS', 'TMM', 'C', 'TMM', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA MAXIMA DE MORA EXTRANJERA', 'TMMEX', 'C', 'TMMEX', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('IDENTIFICADOR DE TODAS LAS CAUSALES DE PREPAGOS', 'TODCAU', 'C', '00', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TRASLADO DE AMORTIZACIÓN EN DTOS. DESCONTADOS', 'TRAMO', 'C', 'TRAMO', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TASA INICIAL UVR, PARA GENERACION DE TABLA AMORTIZACION ANUAL', 'TUVR', 'F', null, null, null, null, null, null, 160.016,'CCA')
insert into cobis..cl_parametro values('VARIACION INDICE DE PRECIOS AL CONSUMIDOR', 'VIPC', 'C', 'VIPC', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PERFIL DE AMORTIZACION CON INCENTIVO VIS', 'VISAMO', 'C', 'AMO_VIS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PERFIL DE CAUSACION CON INCENTIVO  VIS', 'VISCAU', 'C', 'CAU_VIS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PERFIL DE CORRECCION MONETARIA CON INCENTIVO VIS', 'VISCMO', 'C', 'CMO_VIS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PERFIL DE PAGOS CON INCENTIVO VIS', 'VISPAG', 'C', 'PAG_VIS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PERFIL DE SUSPENSO CON INCENTIVO VIS', 'VISSUA', 'C', 'SUA_VIS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PRESTAMOS DE VIVIENDA', 'VIV', 'C', 'VIV', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('Comision FAG a distribuir periodicamente', 'CMFAGP', 'C', 'COMFAGANU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO DE COMISION UNICA', 'COMUNI', 'C', 'COMFAGUNI', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('IVA ASOCIADO A FAG UNICO', 'ICFAGU', 'C', 'IVACOMFAGU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('Comision FAG a descontar en el Desembolso', 'CMFAGD', 'C', 'COMFAGDES', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('Iva asociado a la Comision FAG descontada en el desembolso', 'ICFAGD', 'C', 'IVACOMFAGD', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('Comision USAID a distribuir periodicamente', 'CMUSAP', 'C', 'COMUSASEM', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('Iva asociado a la Comision USAID descontada en el desembolso', 'ICUSAD', 'C', 'IVACOMUSAD', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO COMISION FNG EN EL DESEMBOLSO', 'COFNGD', 'C', 'COMFNGDES', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('COMISION FGA UNICA ANTICIPADA', 'COMFGA', 'C', 'COMFGAUNI', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('IVA COMISION FGA UNICA', 'IVAFGA', 'C', 'IVACOMFGAU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO DE IVA FNG DESEMBOLSO', 'IVFNGD', 'C', 'IVACOMFNGD', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO GRAVAMEN MOVIMIENTO FINANCIERO', 'GMF', 'C', 'GMF', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('COMISION GARANTIAS UNIVERSAL DESEMBOLSO', 'COMGAR', 'C', 'COMGARUNI', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('IVA COMISION GARANTIAS UNIVERSAL DESEMBOLSO', 'IVAGAR', 'C', 'IVACOMGARU', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('IVA COMISION GARANTIAS UNIVERSAL PERIODICA', 'IVAGRP', 'C', 'IVACOMGARP', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('COMISION GARANTIAS UNIVERSAL PERIODICA', 'COMGRP', 'C', 'COMGARP', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('HORA INICIO DESEMBOLSOS FINAGRO', 'HINIFI', 'C', '08:00', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('HORA FIN DESEMBOLSOS FINAGRO', 'HFINFI', 'C', '19:30', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('HORA INICIO DESEMBOLSOS FISU', 'HIFISU', 'C', '08:00', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('HORA FIN DESEMBOLSOS FISU', 'HFFISU', 'C', '19:30', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO PARA IDENTIFICAR CHEQUE LOCAL', 'CHELOC', 'C', 'CHOTBCOS', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO RECONOCIMIENTO FNG', 'RECFNG', 'C', 'RECFNG', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO RECONOCIMIENTO USAID', 'RECUSA', 'C', 'RECUSAID', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('TABLA FLEXIBLE', 'TFLEXI', 'C', 'FLEXIBLE', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('MONTO SALDO MINIMO', 'SALMIN', 'M', null, null, null, null, 1.00, null, null,'CCA')
insert into cobis..cl_parametro values('BANCA PEQUENA EMPRESA', 'BEMPRE', 'C', '2', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PARAMETRO DEL IVA PARA COMISION MIPYMES', 'IVAMIP', 'C', 'IVAMIPYMES', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('FORMA DE PAGO SALDO MINIMO', 'FSAMIN', 'C', 'SALDOSMINI', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('CUENTA PUENTE PARA NORMALIZACIONES', 'PTENOR', 'C', 'PTENOR', null, null, null, null, null, null,'CCA')
insert into cobis..cl_parametro values('PORCENTAJE PARA DETEMINAR COBRO DE SANCION X PREPAGO', 'PCPRE', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 50, 'CCA')
insert into cobis..cl_parametro values('PORCENTAJE PARA VALIDAR SI EL COBRO ES PREPAGO', 'PPAGAD', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 40, 'CCA')
insert into cobis..cl_parametro values('PORCENTAJE SANCION SOBRE VALOR PREPAGO', 'PCCOM', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'CCA')
insert into cobis..cl_parametro values('BANCA PEQUENA EMPRESA', 'RUBCPR', 'C', 'SNCPREPAGO', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('CODIGO CLASE COMERCIAL', 'CCCOM', 'C', '1', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('CODIGO CLASE CONSUMO', 'CCCON', 'C', '2', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('CODIGO CLASE VIVIENDA', 'CCVIV', 'C', '3', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('CODIGO SUBTIPO MICROCREDITO', 'CSMIC', 'C', '05', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PORCENTAJE RENOVACION REESTRUCTURACION', 'PRERE', 'I', NULL, NULL, NULL, 80, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PORCENTAJE CAPITAL RENOVAR', 'PCAPRE', 'I', NULL, NULL, NULL, 40, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('DIAS MORA PARA VENCIMIENTO AUT. DE OPERACIONES DE CUOTA UNICA', 'DMOVCU', 'T', NULL, 30, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('DIAS MORA PARA VENCIMIENTO AUT. DE OPERACIONES DE CUOTA NORMAL', 'DMOVCN', 'T', NULL, 90, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('TIPO DE DIVIDENDO CREDITOS QUINCENALES', 'QUIN', 'C', 'Q', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('RENDIMIENTO AHORRO GRUPAL', 'RAHOGR', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.05, 'CCA' )
insert into cobis..cl_parametro VALUES('VALIDA EXISTENCIA DE COBIS-CUENTA AHORROS', 'VALAHO', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cobis..cl_parametro VALUES('PORCENTAJE GARANTIA CREDITO GRUPAL', 'PGARGR', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 10.0, 'CCA')
insert into cobis..cl_parametro VALUES('PORCENTAJE GARANTIA CREDITO INTERCICLO', 'PGARIN', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 50.0, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PORCENTAJE INCENTIVOS 1 CUOTA IMPUNTUALES', 'PICIP', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0.93000000000000005, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PORCENTAJE INCENTIVOS PAGOS PUNTUALES', 'PIPP', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PARAMETRO PARA NOTA CREDITO CUENTA AHORROS', 'NCRAHO', 'C', 'NC_BCO_MN', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PARAMETRO PARA NOTA DEBITO CUENTA AHORROS', 'NCDAHO', 'C', 'ND_BCO_MN', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('USUARIO CAMBIO DE LINEA FINAGRO', 'USLIFI', 'C', 'CAMLINFIN', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('FORMATO DE DESEMBOLSO PARA RENOVACIONES', 'FDESRE', 'C', 'RENOVACION', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('DIAS DE PROCESO PARA DESEMBOLSO', 'DPDES', 'T', NULL, 15, NULL, NULL, NULL, NULL, NULL,'CCA')
INSERT INTO cobis..cl_parametro VALUES('REFERENCIA DEL SERVICIO EMISOR', 'RSEMI', 'C', NULL, NULL, NULL, NULL, NULL, NULL, NULL,'CCA')
INSERT INTO cobis..cl_parametro VALUES('NOMBRE DEL TITULAR DEL SERVICIO', 'NTSER', 'C', NULL, NULL, NULL, NULL, NULL, NULL, NULL,'CCA')
INSERT INTO cobis..cl_parametro VALUES('NUMERO DE REINTENTOS PARA DEBITO', 'NRID', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL,'CCA')

INSERT INTO cobis..cl_parametro VALUES('TIPO DE CUENTA DEL ORDENANTE', 'TCTAOR', 'C', '01', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('NUMERO DE CUENTA DEL ORDENANTE PARA CRE', 'CTAORD', 'C', '65506361908', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('NUMERO DE CUENTA DEL ORDENANTE PARA GAR', 'CTAGAR', 'C', '65506362002', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('NOMBRE DEL ORDENANTE', 'NOMORD', 'C', 'Santander Inclusion Financiera', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('ABREVIATURA COMERCIAL DEL ORDENANTE', 'ABRORD', 'C', 'SA de CV', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('NUMERO DE RFC DEL ORDENANTE', 'RFCORD', 'C', 'SIF170801PYA', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro VALUES('PAGO SEGURO', 'CTASTD', 'C', '65506362078', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cobis..cl_parametro values('CLASE DE VALOR PARA RUBRO DE COMISION COMMORA', 'CCMORA', 'C', 'V', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA') 
insert into cobis..cl_parametro values ('COMISION POR DEFECTO LCR', 'COMLCR', 'F', null, null, null, null, null, null, 0.3, 'CCA')
insert into cobis..cl_parametro values ('MONTO MINIMO DE DESEMBOLSO POR DEFECTO LCR', 'MINDES', 'M', null, null, null, null, 300, null, null, 'CCA')
insert into cobis..cl_parametro values ('MONTO INCREMENTO MAXIMO POR DEFECTO LCR', 'MAXINC', 'M', null, null, null, null, 0, null, null, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS VENCIMIENTO OP GRUPAL', 'DVOG', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro                         , pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PARAMETRO VALIDA REVERSO CANCELADAS', 'PAVACA'  , 'C'    , 'S'    , NULL      , NULL       , NULL  , NULL    , NULL       , NULL    , 'CCA')
                       
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int,  pa_producto) values('NUMERO DE DIAS ANTES DE COBRAR EL COMPRECAN','NCMPRE','I',9,'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('CÓDIGO DE COMERCIO (ISSUER)', 'ISSUER', 'C', '001123', 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('NOMBRE ARCHIVO XML (PAGO CORRESPONSAL)', 'NAXPC', 'C', 'PagoCorresponsal.xml', 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('RUTA BAT NOTIFICACION', 'RBATN', 'C', 'C:\Notificador\notification\', 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('PIE DE PAGINA REPORTE', 'RPPAG', 'C', 'DERECHOS RESERVADOS SANTANDER', 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_smallint, pa_producto) values ('MAXIMO DIAS VENCIMIENTO PRESTAMO SEMANAL', 'MDWNA', 'S', 21, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_smallint, pa_producto) values ('MAXIMO DIAS VENCIMIENTO PRESTAMO QUINCENAL', 'MDQNA', 'S', 15, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_smallint, pa_producto) values ('MAXIMO DIAS VENCIMIENTO PRESTAMO MENSUAL', 'MDMNA', 'S', 30, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_tinyint, pa_producto) values ('LONGITUD CODIGO OPERACION OPENPAY', 'LOOPA', 'T', 7, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('FORMATO FECHA OPENPAY', 'FFOPA', 'C', 'ddMMyy', 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_tinyint, pa_producto) values ('LONGITUD MONTO OPERACION OPENPAY', 'LMOPA', 'T', 8, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PORCENTAJE GARANTIA PREDETERMINADO', 'PORCGP', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'CCA')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('IVA INTERES', 'IVAINT', 'C', 'IVA_INT', null, null, null, null, null, null,'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESPERAR CANCELACION GARANTIA', 'CANGAR', 'C', 'ESPERAR CANCELACION GARANTIA', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_smallint, pa_producto) values ('OFICINA CENTRALIZADORA', 'OFICEN', 'S', 9001, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto) values ('DIAS PAGO SOSTENIDO', 'DPAGSO', 'I', 90, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_smallint, pa_producto) values ('NUM CUOTAS DE PAGO SOSTENIDO', 'CPAGSO', 'S', 3, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values('TIPO DE OPERACION DEFAULT PARA GARANTIA', 'TOPGAR', 'C', 'GRUPAL', 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('GENERA ARCHIVO DOMICILIACION DE PAGOS', 'GADOPA', 'C', 'S', null, null, null, null, null, null, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('GENERA ARCHIVO DOMICILIACION DE SEGUROS', 'GADOSE', 'C', 'S', null, null, null, null, null, null, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('NOMBRE DE ACTIVIDAD FLUJO PARA REVISION Y VALIDACION', 'NAREVA', 'C', 'REVISAR Y VALIDAR INFORMACIÓN', null, null, null, null, null, null, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('SEGURO PRODUCTO', 'SEGPRO', 'C', 'CNSF-S0068-0472-2017', 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('NO POLIZA', 'NROPOL', 'C', 'SCV-10060-', 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE SEMANAS PARA BACKUP (SEMBK)', 'SEMBK', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FACTOR DE SENSIBILIDAD PARA DISTRIBUCION DE PAGOS GRUPALES', 'SENSI', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'CCA')

insert into cobis..cl_parametro values ('IMPORTE DEL SEGURO', 'IMPSEG', 'F', null, null, null, null, null, null, 47.26, 'CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LCR CUOTAS A DIVIDIR', 'LCRCUO', 'M', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LCR CUOTAS VENCIDAS', 'LCRVEN', 'M', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'CCA')


insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LCR DIAS DE GRACIA', 'LCRGRA', 'I', NULL, NULL, NULL, 7, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LCR UMBRAL', 'LCRUMB', 'M', NULL, NULL, NULL, NULL, 100, NULL, NULL, 'CCA')


go

-- Parámetros Espera de Cancelación de Préstamos
delete from cobis..cl_parametro where pa_nemonico in ('CANCRA', 'EAGARL', 'CANCRI')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESPERAR CANCELACIÓN CRÉDITO AN', 'CANCRA', 'C', 'ESPERAR CANCELACIÓN CRÉDITO AN', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESPERA AUTOMATICA GAR LIQUIDA', 'EAGARL', 'C', 'ESPERA AUTOMATICA GAR LIQUIDA', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESPERAR CANCELACI�N CR�DITO AN', 'CANCRI', 'C', 'ESPERAR CANCELACIÓN CRÉDITO AN', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')


go


--CGS-138982 Pagos Referenciados
delete cobis..cl_parametro where pa_nemonico in('LGREF', 'CNVGAR', 'CNVPRE', 'REFOP', 'REFSTD','RFSTDG')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NRO CONVENIO GARANT�AS', 'CNVGAR', 'C', 'NRO199999', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NRO CONVENIO PRÉSTAMOS', 'CNVPRE', 'C', 'NRO199988', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('LONGITUD REFERENCIA OPENPAY', 'REFOP', 'I', NULL, NULL, NULL, 29, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('LONGITUD REFERENCIA SANTANDER', 'REFSTD', 'I', NULL, NULL, NULL, 15, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PARAMETRO REFSTG GAR', 'RFSTDG', 'I', NULL, NULL, NULL, 22, NULL, NULL, NULL, 'CCA')

--Parametro porcentaje para el calculo de la garantia
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS MAXIMO PARA PRECANCELACION', 'DIPRE', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'CCA')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CUENTA CONVENIO PRECAN', 'CTACON', 'C', '9742', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

go

--Parametro de dia de generacion de reportes funeal Net Bajas
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIA DE GENERACION REPORTE SEGUROS FUNERAL NET BAJAS', 'DGRFNB','I',NULL,NULL,NULL,25,NULL,NULL,NULL,'CCA')


delete cobis..cl_parametro where pa_nemonico  in ('CGEOFI')

insert into cobis..cl_parametro values ('CARGO DE GERENTE DE OFICINA', 'CGEOFI', 'S', null, null, 1, null, null, null, null,'CCA')

--Parametro de Cuenta Contable de Gar Liquidas 
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CUENTA CONTABLE PARA GARANTIAS LIQUIDAS', 'CTGARL', 'C', '241302', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

--MTA
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS CLIENTE NO RENOVADO', 'DNOREN', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CCA')

---


--PARAMETRO DIA DE EJECUICION DATO CUOTA PRY 

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIA DE EJECUCION SB_DATO_CUOTA_PRY', 'EJEHIS', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CCA')
GO

declare @w_codigo_act int

select @w_codigo_act = ac_codigo_actividad
from cob_workflow..wf_actividad
where ac_nombre_actividad like '%REVISAR Y%'

if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'CAREVA')
begin
     insert into cobis..cl_parametro (pa_parametro                        , pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int       , pa_money, pa_datetime, pa_float, pa_producto)
                              values ('CODIGO ACTIVIDAD REVISAR Y VALIDAR', 'CAREVA'   , 'I'    , NULL   , NULL      , NULL       , @w_codigo_act, NULL    , NULL       , NULL    , 'CCA'      )
end

use cobis
go

declare @w_codigo_act int

select @w_codigo_act = ac_codigo_actividad
from cob_workflow..wf_actividad
where ac_nombre_actividad like '%APROBAR PR%'

if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'CAAPSO')
begin
     insert into cobis..cl_parametro (pa_parametro                           , pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int       , pa_money, pa_datetime, pa_float, pa_producto)
                              values ('CODIGO ACTIVIDAD APROBACION SOLICITUD', 'CAAPSO'   , 'I'    , NULL   , NULL      , NULL       , @w_codigo_act, NULL    , NULL       , NULL    , 'CCA'      )
end

/*Parametro auxiliar de la conta para no considerar manejo de retenciones */

delete cobis..cl_parametro
 where pa_producto = 'CON'
   and pa_nemonico in ('APLRET')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('APLICA RETENCION', 'APLRET', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CON')

/* TIPOS DE DIVIDENDO */

truncate table cob_cartera..ca_tdividendo
go

insert into cob_cartera..ca_tdividendo values('D', 'DIA(S)', 'V', 1)
insert into cob_cartera..ca_tdividendo values('A', 'AÑO(S)', 'V', 360)
insert into cob_cartera..ca_tdividendo values('M', 'MES(ES)', 'V', 30)
insert into cob_cartera..ca_tdividendo values('T', 'TRIMESTRE(S)', 'V', 90)
insert into cob_cartera..ca_tdividendo values('S', 'SEMESTRE(S)', 'V', 180)
insert into cob_cartera..ca_tdividendo values('B', 'BIMESTRE(S)', 'V', 60)
insert into cob_cartera..ca_tdividendo values('W', 'SEMANAL', 'V', 7)
insert into cob_cartera..ca_tdividendo values('Q', 'QUINCENAL', 'V', 15)
insert into cob_cartera..ca_tdividendo values('BW', 'CATORCENAL', 'V', 14)
go

/* ESTADOS */

truncate table cob_cartera..ca_estado
go

insert into cob_cartera..ca_estado values('0', 'NO VIGENTE', 'N', 'N')
insert into cob_cartera..ca_estado values('1', 'VIGENTE', 'S', 'S')
insert into cob_cartera..ca_estado values('2', 'VENCIDO', 'S', 'S')
insert into cob_cartera..ca_estado values('3', 'CANCELADO', 'N', 'N')
insert into cob_cartera..ca_estado values('4', 'CASTIGADO', 'S', 'S')
insert into cob_cartera..ca_estado values('5', 'COBRO JURIDICO ACTIVAS', 'S', 'N')
insert into cob_cartera..ca_estado values('6', 'ANULADO', 'N', 'N')
insert into cob_cartera..ca_estado values('7', 'CONDONADO', 'N', 'N')
insert into cob_cartera..ca_estado values('9', 'SUSPENSO', 'S', 'S')
insert into cob_cartera..ca_estado values('97', 'COBRO JURIDICO PASIVAS', 'S', 'S')
insert into cob_cartera..ca_estado values('99', 'CREDITO', 'N', 'N')
insert into cob_cartera..ca_estado values('37', 'DIFERIDO', 'S', 'S')
insert into cob_cartera..ca_estado values('44', 'CAUSACION DE CASTIGO', 'N', 'N')
go

/* PARAMETROS POR TIPO DE LINEA */

truncate table cob_cartera..ca_default_toperacion
go


insert into cob_cartera..ca_default_toperacion values('GRUPAL', 0, 'N', NULL, 'N', 'S', 'N', 'V', 'S', 'N', 'P', 'T', 'S', 'D', 'W', 16, 'W', 1, 1, 0, 0, 'N', 360, 'FRANCESA', 'N', 0, 'S', 0, 'N', 0, 'E', 7, 'N', 'N', NULL, NULL, 'L', 'N', '999', '99', 'N', 'N', 'A', 'S', 'N', 'N', '1', NULL, 'N', 'N', 360, NULL, 16, 16, 4000, 60000, '9', '2', 'N', 'N', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
insert into cob_cartera..ca_default_toperacion values('INDIVIDUAL', 0, 'N', NULL, 'N', 'S', 'N', 'V', 'S', 'N', 'P', 'T', 'S', 'D', 'M', 3, 'W', 1, 1, 0, 0, 'N', 360, 'FRANCESA', 'N', 0, 'S', 0, 'N', 0, 'E', 7, 'N', 'N', NULL, NULL, 'L', 'N', '999', '99', 'N', 'N', 'A', 'S', 'N', 'N', '1', NULL, 'N', 'N', 360, NULL, 1, 12, 3000, 20000, '9', '2', 'N', 'N', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
insert into cob_cartera..ca_default_toperacion values('INTERCICLO', 0, 'N', NULL, 'N', 'S', 'N', 'V', 'S', 'N', 'P', 'N', 'S', 'D', 'W', 11, 'W', 1, 1, 0, 0, 'N', 360, 'FRANCESA', 'N', 0, 'S', 0, 'N', 0, 'E', 7, 'N', 'N', NULL, NULL, 'L', 'N', '999', '99', 'N', 'N', 'A', 'S', 'N', 'N', '1', NULL, 'N', 'N', 360, NULL, 1, 11, 600, 6000, '9', '2', 'N', 'N', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
go

/* CAMBIO DE ESTADO */

truncate table cob_cartera..ca_estados_man
go

insert into cob_cartera..ca_estados_man values('GRUPAL', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('GRUPAL', 'A', 1, 2, 90, 99999)
insert into cob_cartera..ca_estados_man values('GRUPAL', 'M', 1, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('GRUPAL', 'A', 2, 1, 0, 99999)
insert into cob_cartera..ca_estados_man values('GRUPAL', 'M', 2, 4, 0, 99999)

insert into cob_cartera..ca_estados_man values('INDIVIDUAL', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('INDIVIDUAL', 'A', 1, 2, 90, 99999)
insert into cob_cartera..ca_estados_man values('INDIVIDUAL', 'M', 1, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('INDIVIDUAL', 'A', 2, 1, 0, 99999)
insert into cob_cartera..ca_estados_man values('INDIVIDUAL', 'M', 2, 4, 0, 99999)

insert into cob_cartera..ca_estados_man values('INTERCICLO', 'M', 0, 6, 0, 99999)
insert into cob_cartera..ca_estados_man values('INTERCICLO', 'A', 1, 2, 90, 99999)
insert into cob_cartera..ca_estados_man values('INTERCICLO', 'M', 1, 4, 0, 99999)
insert into cob_cartera..ca_estados_man values('INTERCICLO', 'A', 2, 1, 0, 99999)
insert into cob_cartera..ca_estados_man values('INTERCICLO', 'M', 2, 4, 0, 99999)

insert into cob_cartera.. ca_estados_man values('REVOLVENTE','A',1,2,60,99999)

go

/*PARAMETRIA CASTIGO AUTOMATICO MAYOR A 180 DIAS */

delete from cob_cartera.. ca_estados_man  where em_dias_cont = 180

insert into cob_cartera.. ca_estados_man values('GRUPAL','A',1,4,180,99999)
insert into cob_cartera.. ca_estados_man values('GRUPAL','A',2,4,180,99999)
insert into cob_cartera.. ca_estados_man values('INDIVIDUAL','A',1,4,180,99999)
insert into cob_cartera.. ca_estados_man values('INDIVIDUAL','A',2,4,180,99999)
insert into cob_cartera.. ca_estados_man values('REVOLVENTE','A',1,4,180,99999)
insert into cob_cartera.. ca_estados_man values('REVOLVENTE','A',2,4,180,99999)

go

/* CATEGORIAS RUBRO */

truncate table cob_cartera..ca_categoria_rubro
go

insert into cob_cartera..ca_categoria_rubro values('A', 'Iva')
insert into cob_cartera..ca_categoria_rubro values('C', 'Capital')
insert into cob_cartera..ca_categoria_rubro values('D', 'Devoluciones')
insert into cob_cartera..ca_categoria_rubro values('G', 'Gastos')
insert into cob_cartera..ca_categoria_rubro values('H', 'Gastos Judiciales')
insert into cob_cartera..ca_categoria_rubro values('I', 'Interes')
insert into cob_cartera..ca_categoria_rubro values('M', 'Mora')
insert into cob_cartera..ca_categoria_rubro values('O', 'Comisiones')
insert into cob_cartera..ca_categoria_rubro values('R', 'Otros Cargos')
insert into cob_cartera..ca_categoria_rubro values('S', 'Seguros')
insert into cob_cartera..ca_categoria_rubro values('T', 'Impuestos')
go

/* CONCEPTOS */

truncate table cob_cartera..ca_concepto
go


insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('CAP', 'CAPITAL', 10, 'C')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('IMO', 'INTERES DE MORA', 13, 'M')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('INT', 'INTERES CORRIENTE', 11, 'I')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('COMMORA', 'COMMORA', 15, 'O')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('IVA_CMORA', 'IVA_CMORA', 16, 'A')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('COMPRECAN', 'COMPRECAN', 17, 'O')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('IVA_INT', 'IVA_INT', 12, 'A')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('IVA_COMPRE', 'IVA_COMPRE', 18, 'A')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('CXCINTES', 'CUENTA POR COBRAR INTERESES', 28, 'R')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('COM', 'COM', 19, 'O')
insert into cob_cartera..ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria) values ('IVA_COM', 'IVA_COM', 20, 'A')

go

/* RUBROS */

truncate table cob_cartera..ca_rubro
go


insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'CAP', 30, 'C', 'N', 'N', 'P', 'S', NULL, NULL, NULL, NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL,   'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'N', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'COMMORA', 10, 'O', 'N', 'N', 'M', 'N', NULL, NULL, 'TCMORA', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'COMPRECAN', 10, 'O', 'N', 'N', 'M', 'N', NULL, NULL, 'TPREPAGO', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'IMO', 10, 'M', 'N', 'S', 'P', 'S', NULL, NULL, 'TCERO', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N',  NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'INT', 20, 'I', 'N', 'S', 'P', 'S', NULL, NULL, 'TINTGRP', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'IVA_CMORA', 10, 'O', 'N', 'N', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'COMMORA', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'IVA_COMPRE', 10, 'O', 'N', 'N', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'COMPRECAN', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('GRUPAL', 0, 'IVA_INT', 20, 'O', 'N', 'S', 'P', 'S', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'INT', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'CAP', 30, 'C', 'N', 'N', 'P', 'S', NULL, NULL, NULL, NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL,   'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'N', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'COMMORA', 10, 'O', 'N', 'N', 'M', 'N', NULL, NULL, 'TCMORA', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'COMPRECAN', 10, 'O', 'N', 'N', 'M', 'N', NULL, NULL, 'TPREPAGO', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'IMO', 10, 'M', 'N', 'S', 'P', 'S', NULL, NULL, 'TCERO', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N',  NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'INT', 20, 'I', 'N', 'S', 'P', 'S', NULL, NULL, 'TINTIND', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'IVA_CMORA', 10, 'O', 'N', 'N', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'COMMORA', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'IVA_COMPRE', 10, 'O', 'N', 'N', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'COMPRECAN', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INDIVIDUAL', 0, 'IVA_INT', 20, 'O', 'N', 'S', 'P', 'S', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'INT', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'CAP', 30, 'C', 'N', 'N', 'P', 'S', NULL, NULL, NULL, NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL,   'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'N', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'COMMORA', 10, 'O', 'N', 'N', 'M', 'N', NULL, NULL, 'TCMORA', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'COMPRECAN', 10, 'O', 'N', 'N', 'M', 'N', NULL, NULL, 'TPREPAGO', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'IMO', 10, 'M', 'N', 'S', 'P', 'S', NULL, NULL, 'TCERO', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N',  NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'INT', 20, 'I', 'N', 'S', 'P', 'S', NULL, NULL, 'TINTINTER', NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'IVA_CMORA', 10, 'O', 'N', 'N', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'COMMORA', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'IVA_COMPRE', 10, 'O', 'N', 'N', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'COMPRECAN', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)
insert into cob_cartera..ca_rubro values('INTERCICLO', 0, 'IVA_INT', 20, 'O', 'N', 'S', 'P', 'S', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'INT', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)


go


truncate table cob_cartera..ca_codigos_prepago
go

insert into cob_cartera..ca_codigos_prepago values('10', 'CARGO POR MAYOR VALOR APROBADO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('11', 'POR BENEFICIARIO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('13', 'NO REPORTADO POR EL BANCO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('15', 'EXCEDE EL VALOR A FINANCIAR', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('20', 'FALTA APROBACION PREVIA', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('21', 'CANCELACION ORIGINADA POR BENEFICIARIO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('23', 'COBRO JURIDICO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('24', 'POR CONSOLIDACION DE PASIVOS', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('28', 'POR ORDEN DE FINAGRO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('31', 'ICR OTORGADO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('32', 'ICR CANCELADO', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('51', 'POR REFINANCIACION', 'N', 'V')
insert into cob_cartera..ca_codigos_prepago values('55', 'FOGAFIN', 'N', 'V')
go

/* TRANSACCIONES */

truncate table cob_cartera..ca_tipo_trn
go

insert into cob_cartera..ca_tipo_trn values('DES', 'DESEMBOLSO', 'S','S')
insert into cob_cartera..ca_tipo_trn values('PAG', 'PAGOS', 'S','S')
insert into cob_cartera..ca_tipo_trn values('IOC', 'INGRESO DE OTROS CARGOS', 'S','S')
insert into cob_cartera..ca_tipo_trn values('REJ', 'REAJUSTE DE INTERESES', 'N','N')
insert into cob_cartera..ca_tipo_trn values('ETM', 'CAMBIO DE ESTADO MANUAL', 'S','N')
insert into cob_cartera..ca_tipo_trn values('EST', 'CAMBIO DE ESTADO', 'N','S')
insert into cob_cartera..ca_tipo_trn values('PRV', 'CAUSACION DE INTERESES', 'N','S')
insert into cob_cartera..ca_tipo_trn values('RPA', 'REGISTRO DE PAGOS', 'N','S')
insert into cob_cartera..ca_tipo_trn values('RES', 'REESTRUCCTURACION', 'S','S')
insert into cob_cartera..ca_tipo_trn values('TCO', 'TRASLADO DE CARTERA A OTRA OFICINA', 'S','S')
insert into cob_cartera..ca_tipo_trn values('ACE', 'CLAUSULA ACELERATRORIA', 'S','N')
insert into cob_cartera..ca_tipo_trn values('CAS', 'CASTIGO DE OPERACIONES', 'S','S')
insert into cob_cartera..ca_tipo_trn values('CGR', 'CAMBIO DE GARANTIA', 'N','S')
insert into cob_cartera..ca_tipo_trn values('CRC', 'CAPITALIZACION DE RUBROS', 'N','S')
insert into cob_cartera..ca_tipo_trn values('PRO', 'PRORROGA DE CUOTA', 'S','N')
insert into cob_cartera..ca_tipo_trn values('AMO', 'AMORTIZACION DE INTERESES', 'N','S')
insert into cob_cartera..ca_tipo_trn values('CAN', 'CANCELACION DCTO. DTOS SIN RESPONSABILIDAD', 'N','S')
insert into cob_cartera..ca_tipo_trn values('HFM', 'HISTORICOS FIN DE MES', 'N','N')
insert into cob_cartera..ca_tipo_trn values('TRC', 'TRASLADO POR CIERRE DE CALIFICACION FIN DE MES', 'N','S')
insert into cob_cartera..ca_tipo_trn values('SUA', 'SUSPENSO AUTOMATICO', 'N','S')
insert into cob_cartera..ca_tipo_trn values('SUM', 'SUSPENSO MANUAL', 'S','N')
insert into cob_cartera..ca_tipo_trn values('CMO', 'CORRECCION MONETARIA', 'N','S')
insert into cob_cartera..ca_tipo_trn values('CLI', 'CAMBIO DE LINEA', 'S','S')
insert into cob_cartera..ca_tipo_trn values('AJP', 'AJUSTE CONTABLE PASIVA', 'S','S')
insert into cob_cartera..ca_tipo_trn values('MPC', 'MARCAR PASIVAS PARA PREPAGO POR COBRO JURIDICO', 'S','N')
insert into cob_cartera..ca_tipo_trn values('RCO', 'DEVOLUCION DE COMISIONES', 'N','S')
insert into cob_cartera..ca_tipo_trn values('TIC', 'TRASLADO DE INTERES CORRIENTE', 'N','N')
insert into cob_cartera..ca_tipo_trn values('MAN', 'MANTENIMIENTO OPERATIVO', 'S','N')
insert into cob_cartera..ca_tipo_trn values('MIP', 'MIGRACION PARCIAL', 'S','N')
insert into cob_cartera..ca_tipo_trn values('PRN', 'RENOVACION (PAGO A OBLIGACION RENOVADA)', 'S','S')
insert into cob_cartera..ca_tipo_trn values('DSE', 'DEVOLUCION SEGUROS EXTERNOS', 'N', 'S')
insert into cob_cartera..ca_tipo_trn values('DSP', 'DESPLAZAMIENTO DE CUOTAS', 'S', 'N')
insert into cob_cartera..ca_tipo_trn values ('REN', 'OPERACION RENOVADA', 'N', 'N')
go


delete from cobis..cl_parametro
where pa_nemonico in ('PCPREP')
and pa_producto = 'REC'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
						values ('PARAMETRIZACION CONTABLE PARA PROVISIONES', 'PCPREP', 'C', 'PRO_1391', 'REC')
GO

--Manejo de fondos - Fondo propio
delete from cob_cartera..ca_fuente_recurso 

insert into cob_cartera..ca_fuente_recurso (fr_fondo_id, fr_nombre, fr_fuente, fr_monto, fr_saldo, fr_utilizado, fr_estado, fr_tipo_fuente, fr_porcentaje, fr_porcentaje_otorgado, fr_fecha_vig, fr_reservado ) 
values ( 1, 'FONDOS PROPIOS', '1', 0, 0, 0, 'V', 'R', 0, 0, '12/31/2018', 0)

update cobis..cl_seqnos
set siguiente = 2
where bdatos = 'cob_cartera'
and tabla  = 'ca_fuente_recurso'


go

delete
from cobis..cl_parametro
where pa_nemonico = 'NCPPV'

insert into cobis..cl_parametro (pa_parametro                    , pa_nemonico, pa_tipo,    pa_int,    pa_producto)
                  values ('NUM CUOTAS PARA PLAZO VENCIDOS', 'NCPPV'    , 'I'    ,    53    ,    'CCA')


go


--Forma de pago para pagos objetados
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FORMA DE PAGO PARA ABONOS OBJETADOS', 'AB_OBJ', 'C', 'FP_OBJETADO', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
go

delete
from cobis..cl_parametro
where pa_nemonico = 'DVLCR'
and   pa_producto = 'CCA'

insert into cobis..cl_parametro (pa_parametro          , pa_nemonico, pa_tipo,  pa_tinyint, pa_producto)
                         values ('DIAS VENCIMIENTO LCR', 'DVLCR'    , 'T'    ,  60        , 'CCA')


go

delete cobis..cl_parametro WHERE pa_nemonico in ('HUDDD','IDOXXO')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('HORA ULTIMA DISPERSION DEL DIA', 'HUDDD', 'C', '17:00', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ID BANCO EN OXXO', 'IDOXXO', 'C', '49', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
go
go

--DIAS CANCELAR LCR
delete from cobis..cl_parametro where  pa_nemonico = 'DIASCA' and    pa_producto   = 'CCA'
delete from cob_cartera..ca_tipo_trn where tt_codigo='CLC'

insert into cobis..cl_parametro(pa_parametro,pa_nemonico,pa_tipo,pa_int,pa_producto)
values('DIAS CANCELACION ANTICIPADA','DIASCA','I',364,'CCA')

insert into cob_cartera..ca_tipo_trn values('CLC', 'CANCELACION ANTICIPADA LCR', 'S','N')

--COLECTIVOS
delete from cl_parametro where pa_nemonico = 'ESASEX'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ESPERA DE ASIGNACION DE ASESOR EXTERNO', 'ESASEX', 'C', 'ESPERAR ASIGNACI�N DE ASESOR E', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
go

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS ATRASO NO RENOVADO', 'DANORE', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CCA')
go

insert into cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_smallint,pa_producto)
values('LONGITUD CAMPO REFERENCIA EN VALIDAR REFERENCIA','LOREVR','S',22,'CCA')
go

--PARAMETRO ULTIMA HORA DE EJECUCION DEL REPORTE 
delete from cobis..cl_parametro where pa_nemonico = 'UFRCO'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ULTIMA FECHA DE EJECUCION REPORTE DE COBRANZAS', 'UFRCO', 'D', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

-- PARAMETRO PARA LIBERACIÓN CONTROLADA EN "GENERAR Y MODIFICAR CÓDIGO" de B2C
delete cobis..cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'ACTOFC'
insert into cobis..cl_parametro values('ACTIVAR TODAS LAS OFICINAS', 'ACTOFC', 'C', 'S', null, null, null, null, null, null,'CCA')

go

delete cobis..cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'HAPRAN'

insert into cl_parametro (pa_parametro                , pa_nemonico, pa_tipo, pa_char,  pa_producto)
values ('HABILITAR PRODUCTO ANIMATE', 'HAPRAN'   , 'C'    , 'N'    ,  'CCA'      )

go

delete from cl_parametro where pa_nemonico in ('DESCUO', 'CUODES')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DESPLAZAMIENTO DE CUOTAS', 'DESCUO', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO CUOTAS DE DESPLAZAMIENTO', 'CUODES', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CCA')

go
delete from cobis..cl_parametro where pa_nemonico = 'SEGAD' and pa_producto='CCA'

insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_money, pa_producto)
values('VALOR SEGURO ADICIONAL','SEGAD','M',48.00,'CCA')


--NUEVO RUBRO SEGURO ADICIONAL PARA REESTRUCTURACION
declare @w_id int

delete from ca_rubro where ru_concepto = 'SEGAD' and ru_toperacion = 'GRUPAL'

INSERT INTO ca_rubro (ru_toperacion, ru_moneda, ru_concepto, ru_prioridad, ru_tipo_rubro, ru_paga_mora, ru_provisiona, ru_fpago, ru_crear_siempre, ru_tperiodo, ru_periodo, ru_referencial, ru_reajuste, ru_banco, ru_estado, ru_concepto_asociado, ru_redescuento, ru_intermediacion, ru_principal, ru_saldo_op, ru_saldo_por_desem, ru_pit, ru_limite, ru_mora_interes, ru_iva_siempre, ru_monto_aprobado, ru_porcentaje_cobrar, ru_tipo_garantia, ru_valor_garantia, ru_porcentaje_cobertura, ru_tabla, ru_saldo_insoluto, ru_calcular_devolucion, ru_tasa_aplicar, ru_valor_max, ru_valor_min, ru_afectacion, ru_diferir, ru_tipo_seguro, ru_tasa_efectiva)
VALUES ('GRUPAL', 0, 'SEGAD', 12, 'O', 'N', 'N', 'M', 'N', NULL, NULL, NULL, NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)

delete from cob_cartera..ca_concepto where co_concepto = 'SEGAD'

select @w_id = max(co_codigo) + 1
from ca_concepto

insert into ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria)
values ('SEGAD','SEGURO ADICIONAL', @w_id, 'S')
GO
go
	 


delete from cobis..cl_parametro where pa_nemonico='DIVLIM' and pa_producto='CCA'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIVIDENDO LIMITE', 'DIVLIM', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CCA')

go

DELETE FROM cob_cartera..ca_tipo_trn WHERE tt_codigo='RES'


INSERT INTO ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)
VALUES ('RES', 'REESTRUCCTURACION', 'S', 'S')
go


delete cobis..cl_parametro where pa_nemonico = 'POCODE'

insert into cobis..cl_parametro (pa_parametro                          , pa_nemonico, pa_tipo, pa_float, pa_producto)
values ('PORCENTAJE CONDONACION DESPLAZAMIENTO', 'POCODE'   , 'F'    , 0.5     , 'CCA')


------------- PARAMETRO DIAS REPORTE SEGUROS
delete from cl_parametro where pa_nemonico in  ('DIRECO','MERECO') and pa_producto = 'CCA'
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PRIMER REPORTE DE CONSENTIMIENTO', 'DIRECO', 'I', NULL, NULL, NULL, 112, NULL, NULL, NULL, 'CCA')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MESES REPORTE DE CONSENTIMIENTO', 'MERECO', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')

delete cobis..cl_parametro where pa_nemonico = 'NDEDAD'
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_tinyint,   pa_producto)
values ('NUEMRO DIAS CALCULO EDAD', 'NDEDAD'   , 'T'    ,  10        ,   'ADM')

delete cobis..cl_parametro where pa_nemonico = 'MONSEG'
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_money,   pa_producto)
values ('MONTO SEGURO', 'MONSEG'   , 'M'    ,  48        ,   'ADM')
go

------------- PARAMETRO PARA ACTIVAR EL CALCULO DE TRES DIAS ANTES DEL PRIMER DESPLAZAMIENTO
delete from cobis..cl_parametro where pa_nemonico = 'AN31DS' and pa_producto = 'CCA'
insert into cobis..cl_parametro VALUES('ACTIVAR 3 DIAS ANTES PARA 1ER DSD CALCULO DIAS MORA Y MAX', 'AN31DS', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
go

------------- PARAMETRO DIAS REPORTE ASIGNACIONES
delete cl_parametro where pa_nemonico in ('MINATR','MAXATR')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MINIMO ATRASO REPORTE MOROSIDAD', 'MINATR', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CCA')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAXIMO ATRASO REPORTE MOROSIDAD', 'MAXATR', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'CCA')
GO

---  PARAMETROS REPORTE ZURICH
use cobis
GO 

delete from cl_parametro where pa_nemonico IN ('NRPOLZ','ANPOLZ','SEPROZ','SVIDAZ','SIFCEZ','SIFMIZ','SCANZ','COMSEZ','MONSEZ','DIRECZ','AMBISZ','FEINZU') 

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('ANIO POLIZA ZURICH', 'ANPOLZ', 'I', NULL, NULL, NULL, 2020, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('COMISION POR SEGURO ZURICH', 'COMSEZ', 'M', NULL, NULL, NULL, NULL, NULL, NULL, 0.0, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('DIAS PRIMER REPORTE DE CONSENTIMIENTO SEGZURCH', 'DIRECZ', 'I', NULL, NULL, NULL, 112, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA MONTO SEGURO ZURICH', 'MONSEZ', 'M', NULL, NULL, NULL, NULL, 12.0000, NULL, NULL, 'ADM')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('NO POLIZA ZURICH', 'NRPOLZ', 'C', 'ZUR-10060-', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA CANCER SEGZURICH', 'SCANZ ', 'M', NULL, NULL, NULL, NULL, 5000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SEGURO PRODUCTO ZURICH', 'SEPROZ', 'C', 'CNFS-S0018-0461-2020', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA ZURICH INFARTO CEREBRAL', 'SIFCEZ', 'M', NULL, NULL, NULL, NULL, 5000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA ZURICH INFARTO AL MIOCARIO', 'SIFMIZ', 'M', NULL, NULL, NULL, NULL, 5000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA ZURICH VIDA', 'SVIDAZ', 'M', NULL, NULL, NULL, NULL, 20000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('AMBIENTE ZURICH (AZUR)', 'AMBISZ', 'C', 'PROD', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('FECHA INICIO ZURICH', 'FEINZU', 'D', NULL, NULL, NULL, NULL, NULL, '10/24/2020', NULL, 'CCA')
GO
delete from cl_parametro where pa_nemonico in ('DATRE','MXILC','RADBL') and pa_producto='CCA'

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo, pa_smallint, pa_producto)
values('DIAS ATRASO MAXIMO CANDIDATO LCR','DATRE','S',7,'CCA')

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo, pa_smallint, pa_producto)
values('MAXIMO INTEGRANTES CON LCR','MXILC','S',50,'CCA')

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo, pa_smallint, pa_producto)
values('ROL AUTORIZA DESBLOQUEO','RADBL','S',32,'CCA')




---PARAMETRO PORCENTAJE DE PAGO CAT  Requerimiento #125283-----
delete from cobis..cl_parametro 
where pa_producto = 'CCA' and pa_nemonico = 'PPCAT'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PORCENTAJE DE PAGO CALCULO CAT', 'PPCAT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 25, 'CCA')
GO

--------DIAS POSPONER CANDIDATO -- Caso#161681
delete cobis..cl_parametro where pa_nemonico = 'DPC' and pa_producto = 'CCA'
insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS POSPONER CANDIDATO', 'DPC', 'S', NULL, NULL, 30, NULL, NULL, NULL, NULL, 'CCA')
GO

--------DIAS DESCARTAR CANDIDATO -- Caso#161681
delete cobis..cl_parametro where pa_nemonico = 'DDC' and pa_producto = 'CCA'
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS DESCARTAR CANDIDATO', 'DDC', 'S', NULL, NULL, 30, NULL, NULL, NULL, NULL, 'CCA')
go



-- Parametros para envio de sms
use cobis
GO

delete from cobis..cl_parametro where pa_nemonico in ('TRESC','TRESR','TPERSR')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TOTAL DE REGISTROS PARA ENVIO DE SMS COBRANZAS','TRESC','T',null,30,null,null,null,null,null,'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TOTAL DE REGISTROS PARA ENVIO DE SMS RECORDATORIOS','TRESR','T',null,30,null,null,null,null,null,'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TIEMPO PARA ELIMINAR REGISTROS DE SMS COBRANZAS','TPERSC','T',null,null,3,null,null,null,null,'CCA')

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('TIEMPO PARA ELIMINAR REGISTROS DE SMS RECORDATORIOS','TPERSR','T',null,null,3,null,null,null,null,'CCA')
GO

--------Requerimiento #154769 - Reporte de reintegros

delete from cobis..cl_parametro where pa_nemonico in ('RRPATH') and pa_producto = 'ADM'

--Ruta Reporte de Reintegro
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA REPORTE REINTEGROS','RRPATH','C','C:\WorkFolder\',null,null,null,null,null,null,'ADM')

go

--Disposiciones B2C -- Caso #162334
DELETE cl_parametro where pa_nemonico in ('MSCCTA', 'CHRSEP')
insert into cobis..cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('MASCARA CUENTA', 'MSCCTA', 'C', 'X', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')


INSERT INTO cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('CARACTERES SEPARACION', 'CHRSEP', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')
go

-- Solicitud Prellenada - Req. 168878
use cobis
go

delete cl_parametro where pa_nemonico in ('RSCGRE', 'RSCGPI', 'RSCRFR', 'RSCRFP') and pa_producto='CCA' 

insert into cl_parametro values('REPORTE SOLICITUD CREDITO GRUPAL RECA', 'RSCGRE', 'C', '14795-439-028351/03-00011-0123', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cl_parametro values('REPORTE SOLICITUD CREDITO GRUPAL PIE', 'RSCGPI', 'C', 'IF-001 (012023)', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cl_parametro values('REPORTE SOLICITUD CREDITO RENOVACION FINANCIADA RECA', 'RSCRFR', 'C', '14795-439-034275/01-00897-0321', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cl_parametro values('REPORTE SOLICITUD CREDITO RENOVACION FINANCIADA PIE', 'RSCRFP', 'C', 'IF-040 (062021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
go

--------Caso#166547
delete cl_parametro WHERE pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'
insert into cl_parametro values ('NUM DIAS ANTES PARA ELIMINAR REG CON ERROR CORRESPONSAL_TRN', 'ERCTRE', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'CCA')
go

delete cobis..cl_parametro where pa_nemonico = 'VASOCO'
insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALIDA SOCIO COMERCIAL', 'VASOCO', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')

--------Caso#176798--Comentario #12
delete from cl_parametro where pa_nemonico = 'NPRLCR' and pa_producto = 'CCA'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE PAGOS PARA REACTIVAR LINEA DE CREDITO', 'NPRLCR', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CCA')
go

-------Caso#183830
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CODIGO ID CORRESPONSAL CAJEROS', 'CICCJA', 'C', '00000000', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

-------Req.185234 - Seguros Individual 
use cobis
go

delete cl_parametro where pa_nemonico in ('MVAMSI') and pa_producto='CCA' 

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES VIGENCIA ASISTENCIA MEDICA SOLICITUD INDIVIDUAL', 'MVAMSI', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')
go

-------Caso#188497
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS ANTES PARA VENCIMIENTO DE CUOTAS', 'DAVCOU', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CCA')
GO

-- Caso 180130 - Modificaciones SMS Cobranzas - 20220811
delete from cl_parametro where pa_nemonico in ('SMSPRE','SMSCOB') and pa_producto = 'CCA'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SMS PREVENTIVO-CANT MIEMBROS MESA DIRECTIVA A NOTIFICAR(P,T,S)', 'SMSPRE', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SMS COBRANZA-CANT MIEMBROS MESA DIRECTIVA A NOTIFICAR(P,T,S)', 'SMSCOB', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'CCA')
go

delete cobis..cl_parametro where pa_nemonico = 'PGAIND'  and pa_producto = 'CCA'

insert into cl_parametro (
        pa_parametro                         , pa_nemonico, pa_tipo, pa_float, pa_producto)
values ('PORCENTAJE GARANTIA CREDITO INDIVIDUAL', 'PGAIND', 'F'    , 0       , 'CCA')

delete cobis..cl_parametro where pa_nemonico = 'PGARAN'  and pa_producto = 'CCA'

insert into cl_parametro (
        pa_parametro                         , pa_nemonico, pa_tipo, pa_float, pa_producto)
values ('PORCENTAJE GARANTIA CREDITO ANIMATE', 'PGARAN'   , 'F'    , 0      , 'CCA')

delete cobis..cl_parametro
where pa_nemonico = 'FEOLFE'

insert into cl_parametro (pa_parametro          , pa_nemonico, pa_tipo, pa_datetime , pa_producto)
                  values ('FECHA OLVIDO FERIADO', 'FEOLFE'   , 'D'    , '2022-11-02', 'ADM')

delete cobis..cl_parametro
where pa_nemonico = 'NDICOM'

insert into dbo.cl_parametro (pa_parametro               , pa_nemonico, pa_tipo, pa_tinyint, pa_producto)
                      values ('NUMERO DIAS COMPENSATORIO', 'NDICOM'   , 'T'    , 2         , 'ADM')	



delete cl_parametro
where pa_nemonico = 'COPAPE'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COLOCAR PAGOS EN PENDIENTE', 'COPAPE', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')

delete cl_parametro
where pa_nemonico = 'DAVPAP'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS ANTES VALIDA PAGOS PENDIENTE', 'DAVPAP', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'ADM')

--------->>>>>>>>>REQ#203379 OT plazos crédito individual 2023
delete cl_parametro where pa_nemonico = 'SEGMAX'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES MAXIMOS A REEMPLAZAR SEGURO IND', 'SEGMAX', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')

delete cl_parametro where pa_nemonico = 'SEGDEF'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES DEFAULT A REEMPLAZAR SEGURO IND', 'SEGDEF', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')
--------->>>>>>>>>Fin REQ#203379OT plazos crédito individual 2023

--------->>>>>>>>>REQ#193431 Reporte Cobranza linea'
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('HORA REPORTE COBRANZA EN LINEA', 'HRCBLI', 'C', '18:10:00', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA REPORTE COBRANZA EN LINEA', 'RRCBLI', 'C', 'D:\WorkFolder\COBRANZAENLINEA\', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
--------->>>>>>>>>Fin REQ#193431 Reporte Cobranza linea'
go

---->>>>PorCaso#193221
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALOR DE TASA PROMO', 'VTSPRO', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 80, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALOR DE TASA NO PROMO', 'VTNPRO', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 88, 'CCA')
go			
  
delete cobis..cl_parametro where pa_nemonico = 'HADESO'

insert into cl_parametro (pa_parametro                   , pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('HABILITAR DESEMBOLSO SOBRANTE', 'HADESO'   , 'C'    , 'N'    , 'CCA')

delete cobis..cl_parametro where pa_nemonico = 'FEINSO'

insert into cl_parametro (pa_parametro           , pa_nemonico, pa_tipo, pa_datetime     , pa_producto)
values ('FECHA INICIO SOBRANTE', 'FEINSO'   , 'D'    , @w_fecha_proceso, 'CCA')

go   
