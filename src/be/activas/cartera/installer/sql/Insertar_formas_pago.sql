use cob_cartera
go 

delete from ca_producto_bancamia
where cp_producto in ('CARTERA','CHEPRO','CHLOCAL','CHOTPLAZA','ICR','DACENPAGO','DAPRE','DEPGTIA','EFEMN','FAG','NCAHO','NCCC','NDCC','VAC0','VAC2',      
					  'PAB','FPBSP221','FPBSP222','FPBSP224','DEVINT','DEVSEG','FDBSP221','FDBSP222','FDBSP224','SOBRANTE',  
					  'RECOFNG','PAGAJUST','RECFOGCAFE','PRAN','PRANBCO','PAGOSEBRA','SEGINCENDI','DESEMNCCH','FAEP','TRASPASIVA',
					  'PRANCAFE','PAGCONVENI','ALIVCAFET','ALIVCAFCDE','PDGTIA','DESSOB','PGOLAINVER','NDCCINTERN','NDAHINTERN','PRANARROZ', 
					  'USCARTERA','MONEXTRAN','VAC1','EFEC','EFECTIVO','EFEMON','FNG_CHLO','CHEGER','FORMA1','PAGOSINIES',
					  'PAGOEDATEL','PAGOGTECH','PAGOITP','DEVEXCPAGO','PAGCASTIGO','BMANIZ907-','BDUITA518-','BCHIQ518-', 'BBTAMON041','RENOVACION',
					  'BCOL744-76','BCOL522-03','BMONT807-1','BCAUC832-', 'BDORAD471-','BAPART610-','BCHINCH706','BSTARO720-','BAHMED465-','BBVAPLAN',  
					  'BBTABTA903','BBTAMES166','BBTAGIR679','BBTASOG111','BBTATUN956','TRANSFBANC','PAGOFFLINE','SALDOSMINI','AJUSTE_MEN','AJUSTE_MAY')
go

insert into ca_producto_bancamia values( 'CARTERA',    'CUENTA PUENTE PAGOS DE CARTERA CON CARTERA Y REVERSA DE EFECTIVO', 'TCON',       0         , 100         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'CHEPRO',     'CHEQUES PROPIOS',                                                  'CHPR',       0         , 102         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'CHLOCAL',    'CHEQUES LOCALES',                                                  'CHLO',       0         , 103         , 'N','S', 'S', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'CHOTPLAZA',  'CHEQUES DE OTRAS PLAZAS',                                          'CHOT',       0         , 104         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'ICR',        'RECONOCIMIENTO INCENTIVO ICR',                                     'OTRO',       0         , 105         , 'N','N', 'N', 0            , 'N', null, 'ICR',        null, 'V', 'T') 
insert into ca_producto_bancamia values( 'DACENPAGO',  'DACIONES EN PAGO',                                                 'OTRO',       0         , 107         , 'N','N', 'N', 0            , 'N', null, 'DACENPAGO',  null, 'V', 'A') 
insert into ca_producto_bancamia values( 'DAPRE',      'PAGO TRANSFERENCIA CONTABLE DAPRE',                                'TCON',       0         , 108         , 'N','N', 'N', 0            , 'N', null, 'DAPRE',      null, 'V', 'A') 
insert into ca_producto_bancamia values( 'DEPGTIA',    'PAGOS CON TRANSFERENCIA CONTABLE DE DEPOSITOS EN GTIA.',           'TCON',       0         , 109         , 'N','N', 'N', 0            , 'N', null, 'DEPGTIA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'EFEMN',      'EFECTIVO MONEDA NACIONAL',                                         'EFEC',       0         , 110         , 'S','N', 'S', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'FAG',        'RECONOCIMIENTO FAG ORDINARIO',                                     'OTRO',       0         , 111         , 'N','N', 'N', 0            , 'N', null, 'FAG',        null, 'V', 'T') 
insert into ca_producto_bancamia values( 'NCAHO',      'NOTA CREDITO CUENTA DE AHORROS',                                   'NCAH',       0         , 112         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'NCCC',       'NOTA CREDITO CUENTA CORRIENTE',                                    'NCCC',       0         , 113         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'NDCC',       'NOTA DEBITO CUENTA CORRIENTE POR PAGO EN COBIS',                   'NDCC',       0         , 115         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'VAC0',       'TRANSFERENCIA CONTABLE PARA PAGOS MONEDA LEGAL',                   'TCON',       0         , 116         , 'N','N', 'N', 0            , 'N', null, 'VAC0',       null, 'V', 'T') 
insert into ca_producto_bancamia values( 'VAC2',       'TRANSFERENCIA CONTABLE PARA PAGOS MONEDA UVR',                     'TCON',       2         , 118         , 'N','N', 'N', 0            , 'N', null, 'VAC2',       null, 'V', 'T') 
insert into ca_producto_bancamia values( 'PAB',        'ACEPTACIONES BANCARIAS',                                           'TCTA',       0         , 120         , 'N','N', 'N', 0            , 'N', null, 'PAB',        null, 'V', 'T') 
insert into ca_producto_bancamia values( 'FPBSP221',   'PAGO AUTOMATICO BANCOLDEX',                                        'TBAN',       0         , 122         , 'N','N', 'N', 0            , 'N', null, 'FPBSP221',   null, 'V', 'P') 

insert into ca_producto_bancamia values( 'FPBSP222',   'PAGO AUTOMATICO FINDETER',                                         'TBAN',       0         , 123         , 'N','N', 'N', 0            , 'N', null, 'FPBSP222',   null, 'V', 'P') 
insert into ca_producto_bancamia values( 'FPBSP224',   'PAGO AUTOMATICO FINAGRO',                                          'TBAN',       0         , 124         , 'N','N', 'N', 0            , 'N', null, 'FPBSP224',   null, 'V', 'P') 
insert into ca_producto_bancamia values( 'DEVINT',     'DEVOLUCION INTERESES',                                             'OTRO',       0         , 125         , 'N','N', 'N', 0            , 'N', null, 'DEVINT',     null, 'V', 'A') 
insert into ca_producto_bancamia values( 'DEVSEG',     'DEVOLUCION SEGURO POR CANCELACION TOTAL',                          'OTRO',       0         , 126         , 'N','S', 'N', 0            , 'N', null, 'DEVSEG',     null, 'V', 'A') 
insert into ca_producto_bancamia values( 'FDBSP221',   'DESEMBOLSO PASIVAS BANCOLDEX',                                     'TBAN',       0         , 128         , 'N','N', 'N', 0            , 'N', null, 'FDBSP221',   null, 'V', 'P') 
insert into ca_producto_bancamia values( 'FDBSP222',   'DESEMBOLSO PASIVAS FINDETER',                                      'TBAN',       0         , 129         , 'N','N', 'N', 0            , 'N', null, 'FDBSP222',   null, 'V', 'P') 
insert into ca_producto_bancamia values( 'FDBSP224',   'DESEMBOLSO PASIVAS FINAGRO',                                       'TBAN',       0         , 130         , 'N','N', 'N', 0            , 'N', null, 'FDBSP224',   null, 'V', 'P') 
insert into ca_producto_bancamia values( 'SOBRANTE',   'SOBRANTE EN CANCELACION TOTAL',                                    'TCON',       0         , 136         , 'N','N', 'N', 0            , 'N', null, 'SOBRANTE',   null, 'V', 'T') 
insert into ca_producto_bancamia values( 'RECOFNG',    'RECONOCIMIENTO GARANTIA FNG',                                      'OTRO',       0         , 137         , 'N','N', 'N', 0            , 'N', null, 'RECOFNG',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGAJUST',   'PAGO POR AJUSTE CONTABLE',                                         'TCON',       0         , 138         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'RECFOGCAFE', 'RECONOCIMIENTO GARANTIA FOGACAFE',                                 'OTRO',       0         , 139         , 'N','N', 'N', 0            , 'N', null, 'RECFOGCAFE', null, 'V', 'A') 

insert into ca_producto_bancamia values( 'PRAN',       'PAGO POR CUENTA DEL PRAN',                                         'OTRO',       0         , 140         , 'N','N', 'N', 0            , 'N', null, 'PRAN',       null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PRANBCO',    'PAGO PRAN PARTE DEL  BANCO',                                       'OTRO',       0         , 141         , 'N','N', 'N', 0            , 'N', null, 'PRANBCO',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGOSEBRA',  'PAGO O DESEMBOLSOS  POR SEBRA',                                    'TCON',       0         , 142         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'SEGINCENDI', 'RECONOCIMIENTO SEG INCENDIO',                                      'OTRO',       0         , 143         , 'N','N', 'N', 0            , 'N', null, 'SEGINCENDI', null, 'V', 'A') 
insert into ca_producto_bancamia values( 'DESEMNCCH',  'DESEMBOLSO TRANSFERENCIA A CUENTAS',                               'TCTA',       0         , 144         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'T') 
insert into ca_producto_bancamia values( 'FAEP',       'FAEP-RECURSOS DE FAEP',                                            'TCON',       0         , 145         , 'N','N', 'N', 0            , 'N', null, 'FAEP',       null, 'V', 'A') 
insert into ca_producto_bancamia values( 'TRASPASIVA', 'PAG X TRASLADO INTERESES DE OP PASIVAS',                           'TBAN',       0         , 146         , 'N','N', 'N', 0            , 'N', null, 'TRASPASIVA', null, 'V', 'P') 
insert into ca_producto_bancamia values( 'PRANCAFE',   'PAGO POR CUENTA DEL PRAN CAFETERO',                                'OTRO',       0         , 147         , 'N','N', 'N', 0            , 'N', null, 'PRANCAFE',   null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGCONVENI', 'PAGO CONVENIO CENTRALIZADO',                                       'TCON',       0         , 148         , 'N','N', 'N', 0            , 'N', null, 'PAGCONVENI', null, 'V', 'A') 
insert into ca_producto_bancamia values( 'ALIVCAFET',  'ALIVIO CAFETERO',                                                  'OTRO',       0         , 149         , 'N','N', 'N', 0            , 'N', null, 'ALIVCAFET',  null, 'V', 'A') 
insert into ca_producto_bancamia values( 'ALIVCAFCDE', 'ALIVIO CAFETERO CALIFICACION  C-D-E',                              'OTRO',       0         , 150         , 'N','N', 'N', 0            , 'N', null, 'ALIVCAFCDE', null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PDGTIA',     'PAG DEPGTIA AUTOMATICO',                                           'TCON',       0         , 151         , 'N','N', 'N', 0            , 'N', null, 'PDGTIA',     null, 'V', 'A') 
insert into ca_producto_bancamia values( 'DESSOB',     'DESEMB CARTERIZACION SOBREGIROS',                                  'TCON',       0         , 152         , 'N','N', 'N', 99           , 'N', null, 'DESSOB',     null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PGOLAINVER', 'PAGO POR OLA INVERNAL',                                            'TCON',       0         , 153         , 'N','N', 'N', 0            , 'N', null, 'PGOLAINVER', null, 'V', 'A') 
insert into ca_producto_bancamia values( 'NDCCINTERN', 'ND CTA CTE PAGO POR INTERNET',                                     'NDCC',       0         , 154         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'NDAHINTERN', 'ND CTA AHORROS PAGO POR INTERNET',                                 'NDAH',       0         , 155         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PRANARROZ',  'PAGO PRAN ARROCERO',                                               'OTRO',       0         , 156         , 'N','N', 'N', 0            , 'N', null, 'PRANARROZ',  null, 'V', 'A') 
insert into ca_producto_bancamia values( 'USCARTERA',  'CTA PTE CARTERA DOLARES',                                          'TCON',       1         , 157         , 'N','N', 'N', 0            , 'N', null, 'USCARTERA',  null, 'V', 'A') 
insert into ca_producto_bancamia values( 'MONEXTRAN',  'TRANSACCION MONEDA EXTRANJERA',                                    'TCON',       1         , 158         , 'N','N', 'N', 0            , 'N', null, 'MONEXTRAN',  null, 'V', 'T') 
insert into ca_producto_bancamia values( 'VAC1',       'TRANSFRENCIA CONTABLE PARA PAGOS EN MDA EXT',                      'TCON',       1         , 159         , 'N','N', 'N', 0            , 'N', null, '',           null, 'V', 'T') 
insert into ca_producto_bancamia values( 'EFEC',       'EFECT',                                                            'EFEC',       0         , 160         , 'N','N', 'N', 0            , 'N', null, 'EFEC',       null, 'V', 'A') 
insert into ca_producto_bancamia values( 'EFECTIVO',   'EFECTIVO',                                                         'TCON',       0         , 161         , 'N','N', 'N', 0            , 'N', null, 'EFEC',       null, 'V', 'A') 
insert into ca_producto_bancamia values( 'EFEMON',     'EFECTIVO',                                                         'TCON',       0         , 162         , 'N','N', 'N', 0            , 'N', null, '',           null, 'V', 'T') 
insert into ca_producto_bancamia values( 'FNG_CHLO',   'CHEQUE LOCAL FONDO  NACIONAL DE GARANTIAS',                        'CHLO',       0         , 163         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'CHEGER',     'CHEQUE DE GERENCIA',                                               'CHGE',       0         , 164         , 'S','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'FORMA1',     'JKHLHGUIHHHIOYIIYY',                                               'CHLO',       0         , 165         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGOSINIES', 'PAGO POR SINIESTRO SVGD',                                          'TCON',       0         , 166         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGOEDATEL', 'RECAUDO POR CONVENIO EDATEL',                                      'OTRO',       0         , 167         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGOGTECH',  'RECAUDO CONVENIO BALOTO',                                          'OTRO',       0         , 168         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGOITP',    'PAGO INCPACIDAD TOTAL Y PERMANENTE',                               'OTRO',       0         , 169         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'DEVEXCPAGO', 'DEVOLUCION EXCESO DE PAGO',                                        'OTRO',       0         , 170         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGCASTIGO', 'APLICACION DE PAGOS CARTERA CASTIGADA',                            'OTRO',       0         , 171         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BMANIZ907-', 'BANCOLOMBIA MANIZALEZ 070-092907-30',                              'OTRO',       0         , 174         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BDUITA518-', 'BANCOLOMBIA DUITAMA 262-354518-81',                                'OTRO',       0         , 176         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BCHIQ518-',  'BANCOLOMBIA CHIQUINQUIRA 352-354518-28',                           'OTRO',       0         , 177         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBTAMON041', 'BANCO DE BOGOTA MONIQUIRA 895-00041-2',                            'OTRO',       0         , 190         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'RENOVACION', 'PA POR RENOVACION',                                                'OTRO',       0         , 192         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BCOL744-76', 'BANCOLOMBIA BTA RECAUDO 043-056744-76',                            'OTRO',       0         , 172         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BCOL522-03', 'BANCOLOMBIA MEDELLIN 097-985522-03',                               'OTRO',       0         , 173         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BMONT807-1', 'BANCOLOMBIA MONTERIA 091-444807-11',                               'OTRO',       0         , 175         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BCAUC832-',  'BANCOLOMBIA CAUCASIA 371-313832-20',                               'OTRO',       0         , 178         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BDORAD471-', 'BANCOLOMBIA LA DORADA 392-2390471-9',                              'OTRO',       0         , 179         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BAPART610-', 'BANCOLOMBIA APARTADO 645-2603610-3',                               'OTRO',       0         , 180         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BCHINCH706', 'BANCOLOMBIA CHINCHINA 706-2569187-8',                              'OTRO',       0         , 181         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BSTARO720-', 'BANCOLOMBIA SANTA ROSA DE CABAL 744-2848720-8',                    'OTRO',       0         , 182         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BAHMED465-', 'BANCOLOMBIA CTA AHORRO MEDELLIN 103-3265465-8',                    'OTRO',       0         , 183         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBVAPLAN',   'BBVA PLANETA RICA',                                                'OTRO',       0         , 184         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBTABTA903', 'BANCO DE BOGOTA BOGOTA 060031903',                                 'OTRO',       0         , 185         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBTAMES166', 'BANCO DE BOGOTA MESITAS 059-00016-6',                              'OTRO',       0         , 186         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBTAGIR679', 'BANCO DE BOGOTA GIRARDOT 348-08679-4',                             'OTRO',       0         , 187         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBTASOG111', 'BANCO DE BOGOTA SOGAMOSO 596-25111-6',                             'OTRO',       0         , 188         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'BBTATUN956', 'BANCO DE BOGOTA TUNJA 616-11956-6',                                'OTRO',       0         , 189         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'TRANSFBANC', 'TRANFERENCIAS BANCARIAS',                                          'TCON',       0         , 193         , 'S','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'PAGOFFLINE', 'PAGOS FUERA DE LINEA CONTINGENCIA',                                'OTRO',       0         , 194         , 'N','S', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values( 'SALDOSMINI', 'CANCELACION SALDOS MINIMOS',                                       'OTRO',       0         , 195         , 'N','N', 'N', 0            , 'N', null, 'CARTERA',    null, 'V', 'A') 
insert into ca_producto_bancamia values ('AJUSTE_MEN', 'AJUSTE POR DIFERENCIAS MENORES',                                   'TCON',       0         , 196         , 'N','N', 'N', 0            , 'N', null, 'AJUSTE_MEN', null, 'V', 'A')
insert into ca_producto_bancamia values ('AJUSTE_MAY', 'AJUSTE POR DIFERENCIAS MAYORES',                                   'TCON',       0         , 197         , 'N','N', 'N', 0            , 'N', null, 'AJUSTE_MAY', null, 'V', 'A')
go


--Actualizacion codigo valor
update ca_producto_bancamia set
cp_codvalor = cp_codvalor + 400
go
