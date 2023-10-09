use cob_conta
go

SET NOCOUNT ON
go

SET ANSI_nullS ON
GO

SET QUOTED_IDENTIFIER ON
GO

print '------------------------------------------'
print '------  CREACION DE PERFIL CONTABLE ------'
print '------------------------------------------'
print ''
print 'Inicio Ejecucion Creacion de Perfiles Contables Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Empresa'
if exists (select 1 from cob_conta..sysobjects where name = 'cb_empresa')
begin
    if not exists (select 1 from cob_conta..cb_empresa)
                                    --EM_EMPRESA  EM_RUC         EM_DESCRIPCION       EM_REPLEGAL                  EM_CONTGEN         EM_MONEDA_BASE   EM_ABREVIATURA  EM_DIRECCION                                     EM_MATCONTGEN  EM_REVISOR          EM_MATREVISOR   EM_EMP_REVISOR        EM_NIT_EMPREV   EM_MAT_REVISOR
        insert into cb_empresa values(1,          '9000479818',  'BANCO COBIS S.A.',  'JORGE VILLARROEL BARRERA',  'CARLOS BELTRAN',  0,               'BANCO COBIS',  'AVENIDA 19 NO. 120 - 71 TERCER PISO - BOGOTA',  '22016 -T',    'ANDREA CHAVARRO',  '88877-T',      'DELLOITE & TOUCHE',  '8600005813',   '2340')
end
else
    print 'NO EXISTE TABLA COB_CONTA..CB_EMPRESA'
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
declare @w_empresa    int,
        @w_fecha     datetime

    select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
    select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'


print '-->Perfil Contable: Area Contable'
if exists (select 1 from cob_conta..sysobjects where name = 'cb_area')
begin

    if not exists(select 1 from cob_conta..cb_area where ar_empresa = @w_empresa and ar_area = 255)
    begin
                                            -- AR_EMPRESA  AR_AREA  AR_DESCRIPCION                              AR_AREA_PADRE  AR_ESTADO  AR_FECHA_ESTADO  AR_NIVEL_AREA  AR_CONSOLIDA  AR_MOVIMIENTO
        insert into cob_conta..cb_area values (@w_empresa, 255,     'BANCO DE LAS MICROFINANZAS BANCAMIA S.A',  null,          'V',       @w_fecha,        1,             'S',          'N')
    end

    if not exists(select 1 from cob_conta..cb_area where ar_empresa = @w_empresa and ar_area = 1010)
    begin
                                            -- AR_EMPRESA     AR_AREA  AR_DESCRIPCION  AR_AREA_PADRE  AR_ESTADO  AR_FECHA_ESTADO  AR_NIVEL_AREA  AR_CONSOLIDA  AR_MOVIMIENTO
        insert into cob_conta..cb_area values (@w_empresa,    1010,    'FINANCIERA',   255,           'V',       @w_fecha,        2,             'S',          'N')
    end

    if not exists(select 1 from cob_conta..cb_area where ar_empresa = @w_empresa and ar_area = 1011)
    begin
                                            -- AR_EMPRESA  AR_AREA  AR_DESCRIPCION  AR_AREA_PADRE  AR_ESTADO  AR_FECHA_ESTADO  AR_NIVEL_AREA  AR_CONSOLIDA  AR_MOVIMIENTO    
        insert into cob_conta..cb_area values (@w_empresa, 1011,    'COMERCIAL',    255,           'V',       @w_fecha,        2,             'S',          'N')
    end
    
    if not exists(select 1 from cob_conta..cb_area where ar_empresa = @w_empresa and ar_area = 30)
    begin
                                            -- AR_EMPRESA  AR_AREA  AR_DESCRIPCION  AR_AREA_PADRE  AR_ESTADO  AR_FECHA_ESTADO  AR_NIVEL_AREA  AR_CONSOLIDA  AR_MOVIMIENTO    
        insert into cob_conta..cb_area values (@w_empresa, 30,      'IMPUESTOS',    1010,          'V',       @w_fecha,        3,             'N',          'S')
    end

    if not exists(select 1 from cob_conta..cb_area where ar_empresa = @w_empresa and ar_area = 31)
    begin
                                            -- AR_EMPRESA  AR_AREA  AR_DESCRIPCION     AR_AREA_PADRE  AR_ESTADO  AR_FECHA_ESTADO  AR_NIVEL_AREA  AR_CONSOLIDA  AR_MOVIMIENTO
        insert into cob_conta..cb_area values (@w_empresa, 31,      'RED DE OFICINAS', 1011,          'V',       @w_fecha,        3,             'N',         'S')
    end
end
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
if exists (select 1 from cb_tipo_area where ta_producto = 14)
    delete cb_tipo_area where ta_producto = 14
go
                                  --ta_empresa ta_producto ta_tiparea ta_utiliza_valor ta_area ta_descripcion             ta_ofi_central
    insert into cb_tipo_area values(1,         14,         'CTB_OP',  'S',             31,     'OPERACIONES PLAZO FIJO',  7020)
    insert into cb_tipo_area values(1,         14,         'CTB_IMP', 'S',             31,     'IMPUESTOS PLAZO FIJO',    7020)
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Nivel Area Contable'
if not exists (select 1 from cob_conta..cb_nivel_area)
begin
                                              --NA_EMPRESA NA_NIVEL_AREA NA_DESCRIPCION
    insert into cob_conta..cb_nivel_area values(1,         1,            'COBISCORP')
    insert into cob_conta..cb_nivel_area values(1,         2,            'AREA')
    insert into cob_conta..cb_nivel_area values(1,         3,            'SUB-AREA')
end
go
--*-----------------------------------------------------------------------------------------------
if exists (select 1 from cob_conta..cb_codigo_valor)
    delete cob_conta..cb_codigo_valor where cv_producto = 14
go
                                                --CV_EMPRESA   CV_PRODUCTO   CV_CODVAL   CV_DESCRIPCION
    insert into cob_conta..cb_codigo_valor values(1,           14,           10,         'CAPITAL (PLAZO FIJO)')                                   
    insert into cob_conta..cb_codigo_valor values(1,           14,           11,         'CAPITALIZACION DE INTERESES')                            
    insert into cob_conta..cb_codigo_valor values(1,           14,           20,         'INTERES POR PAGAR (PLAZO FIJO)')                         
    insert into cob_conta..cb_codigo_valor values(1,           14,           21,         'INTERES VENCIDO (PLAZO FIJO)')                          
    insert into cob_conta..cb_codigo_valor values(1,           14,           25,         'DEVOLUCION CANJE - REV INTERESES')                      
    insert into cob_conta..cb_codigo_valor values(1,           14,           30,         'RETENCIONES (PLAZO FIJO)')                              
    insert into cob_conta..cb_codigo_valor values(1,           14,           40,         'GMF. GRAVAMEN MOVIMIENTO FINANCIERO (PLAZO FIJO)')       
    insert into cob_conta..cb_codigo_valor values(1,           14,           60,         'PCAP. PENALIZACION CAPITAL (PLAZO FIJO)')                
    insert into cob_conta..cb_codigo_valor values(1,           14,           70,         'PINT. PENALIZACION INTERES (PLAZO FIJO)')                
    insert into cob_conta..cb_codigo_valor values(1,           14,           1000,       'FORMAS DE PAGO (PLAZO FIJO)')                            
    insert into cob_conta..cb_codigo_valor values(1,           14,           1001,       'CTAS.PUENTE ORDENES DE PAGO (PLAZO FIJO)')               
    insert into cob_conta..cb_codigo_valor values(1,           14,           1002,       'CANJE PLAZO FIJO')                                       
    insert into cob_conta..cb_codigo_valor values(1,           14,           1003,       'DECREMENTRO TRASLADO OFICINA')                           
    insert into cob_conta..cb_codigo_valor values(1,           14,           1004,       'CAPITAL PIGNORADO')                                       
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Producto Conta'
if exists (select 1 from cob_conta..cb_producto where pr_producto = 14)
    delete cob_conta..cb_producto where pr_producto = 14
go
                                 --PR_EMPRESA  PR_PRODUCTO  PR_ONLINE  PR_ESTADO  PR_RESUMEN  PR_FECHA_MOD
    insert into cb_producto values(1,          14,          'N',       'V',       'S',        getdate())
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Perfil'
if exists (select 1 from cob_conta..cb_perfil where pe_producto = 14)
    delete from cob_conta..cb_perfil where pe_producto = 14
go
                                           --PE_EMPRESA   PE_PRODUCTO  PE_PERFIL    PE_DESCRIPCION
    insert into cob_conta..cb_perfil values (1,           14,          'APE_DPF',   'APERTURA DE UNA OPERACION (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'BOC_DPF',   'BALANCE OPERATIVO CONTABLE (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'CAN_DPF',   'CANCELACION / PAGO / RENOVACION (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'CAU_DPF',   'CAUSACION DE INTERESES (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'DEV_DPF',   'DEVOLUCION DE RETENCIONES (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'END_DPF',   'ENDOSO (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'ENJ_DPF',   'ENAJENACION (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'ORD_DPF',   'ORDENES DE PAGO (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'TOP_DPF',   'TRASLADO DE OPERACION (PLAZO FIJO)')
    insert into cob_conta..cb_perfil values (1,           14,          'PIG_DPF',   'PIGNORACION (PLAZO FIJO)')
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Parametro'
if exists (select 1 from cob_conta..cb_parametro where pa_transaccion = 14 or pa_transaccion like '14%')
    delete from cob_conta..cb_parametro where pa_transaccion = 14 or pa_transaccion like '14%'
go
                                              --PA_EMPRESA  PA_PARAMETRO   PA_DESCRIPCION                              PA_STORED          PA_TRANSACCION 
    insert into cob_conta..cb_parametro values (1,          'DPF_CAP_21',  'CAPITAL CON QUE SE CONSTITUYE EL CDT',     'sp_pf01_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_FOPAGO',  'FORMA DE PAGO (EFECTIVO, CHEQUE, ETC.)',   'sp_pf02_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_GMF_25',  'GRAVAMEN M.FINANCIEROS(CTAXPAGAR)',        'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_GMF_51',  'GRAVAMEN M.FINANCIEROS(GASTO)',            'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_INT_25',  'INTERES POR PAGAR (CTAXPAGAR)',            'sp_pf01_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_INT_51',  'INTERES POR PAGAR (GASTO)',                'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_ORPAGO',  'ORDEN DE PAGO (CTA.PUENTE)',               'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_PCA_42',  'PENALIZACION CAPITAL (GANANCIA)',          'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_PIN_42',  'PENALIZACION INTERES (GANANCIA)',          'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_RET_25',  'RETENCION EN LA FUENTE (CTAXPAGAR)',       'sp_pf03_pf',      14)
    insert into cob_conta..cb_parametro values (1,          'DPF_PIGNOR',  'PIGNORACION',                              'sp_pf01_pf',      14)
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Detalle Perfil'
if exists (select 1 from cob_conta..cb_det_perfil where dp_producto = 14)
    delete from cob_conta..cb_det_perfil where dp_producto = 14
go
                                               --DP_EMPRESA  DP_PRODUCTO  DP_PERFIL    DP_ASIENTO   DP_CUENTA       DP_AREA     DP_DEBCRED   DP_CODVAL   DP_TIPO_TRAN   DP_ORIGEN_DEST   DP_CONSTANTE   DP_FUENTE
    insert into cob_conta..cb_det_perfil values (1,          14,          'END_DPF',   1  ,         'DPF_CAP_21'  , 'CTB_OP'  , 2,           10   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'PIG_DPF',   1  ,         'DPF_CAP_21'  , 'CTB_OP'  , 2,           10   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   1  ,         'DPF_CAP_21'  , 'CTB_OP'  , 1,           10   ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   2  ,         'DPF_CAP_21'  , 'CTB_OP'  , 2,           10   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'APE_DPF',   1  ,         'DPF_CAP_21'  , 'CTB_OP'  , 2,           10   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'BOC_DPF',   1  ,         'DPF_CAP_21'  , 'CTB_OP'  , 2,           10   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   1  ,         'DPF_CAP_21'  , 'CTB_OP'  , 1,           10   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   12 ,         'DPF_CAP_21'  , 'CTB_OP'  , 2,           11   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'APE_DPF',   3  ,         'DPF_FOPAGO'  , 'CTB_OP'  , 1,           1000 ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   10 ,         'DPF_FOPAGO'  , 'CTB_OP'  , 2,           1000 ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'ENJ_DPF',   2  ,         'DPF_FOPAGO'  , 'CTB_OP'  , 2,           1000 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'ORD_DPF',   2  ,         'DPF_FOPAGO'  , 'CTB_OP'  , 2,           1000 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'DEV_DPF',   2  ,         'DPF_FOPAGO'  , 'CTB_OP'  , 2,           1000 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   5  ,         'DPF_GMF_25'  , 'CTB_IMP' , 2,           40   ,      'N' ,          'C' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'ORD_DPF',   4  ,         'DPF_GMF_25'  , 'CTB_OP'  , 2,           40   ,      'N' ,          'C' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'ORD_DPF',   5  ,         'DPF_GMF_51'  , 'CTB_OP'  , 1,           40   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   6  ,         'DPF_GMF_51'  , 'CTB_IMP' , 1,           40   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'END_DPF',   2  ,         'DPF_INT_25'  , 'CTB_OP'  , 2,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'PIG_DPF',   2  ,         'DPF_INT_25'  , 'CTB_OP'  , 2,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAU_DPF',   1  ,         'DPF_INT_25'  , 'CTB_OP'  , 2,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAU_DPF',   3  ,         'DPF_INT_25'  , 'CTB_OP'  , 1,           25   ,      'N' ,          'D' ,            ''  ,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   2  ,         'DPF_INT_25'  , 'CTB_OP'  , 1,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'BOC_DPF',   2  ,         'DPF_INT_25'  , 'CTB_OP'  , 2,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'APE_DPF',   2  ,         'DPF_INT_25'  , 'CTB_OP'  , 2,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   5  ,         'DPF_INT_25'  , 'CTB_OP'  , 1,           20   ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   6  ,         'DPF_INT_25'  , 'CTB_OP'  , 2,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   3  ,         'DPF_INT_51'  , 'CTB_OP'  , 1,           21   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAU_DPF',   4  ,         'DPF_INT_51'  , 'CTB_OP'  , 2,           25   ,      'N' ,          'D' ,            ''  ,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAU_DPF',   2  ,         'DPF_INT_51'  , 'CTB_OP'  , 1,           20   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'DEV_DPF',   3  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 2,           1001 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'ORD_DPF',   1  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 1,           1000 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   3  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 1,           1001 ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   4  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 2,           1001 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   11 ,         'DPF_ORPAGO'  , 'CTB_OP'  , 2,           1001 ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   7  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 1,           1003 ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   8  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 2,           1003 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   9  ,         'DPF_ORPAGO'  , 'CTB_OP'  , 1,           1000 ,      'N' ,          'O' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'TOP_DPF',   10 ,         'DPF_ORPAGO'  , 'CTB_OP'  , 2,           1000 ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   8  ,         'DPF_PCA_42'  , 'CTB_OP'  , 2,           60   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   9  ,         'DPF_PIN_42'  , 'CTB_OP'  , 2,           61   ,      'N' ,          'D' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'CAN_DPF',   4  ,         'DPF_RET_25'  , 'CTB_IMP' , 2,           30   ,      'N' ,          'C' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'ENJ_DPF',   1  ,         'DPF_RET_25'  , 'CTB_IMP' , 1,           30   ,      'N' ,          'C' ,            null,          'L')
    insert into cob_conta..cb_det_perfil values (1,          14,          'DEV_DPF',   1  ,         'DPF_RET_25'  , 'CTB_IMP' , 1,           30   ,      'N' ,          'C' ,            null,          'L')
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Relacion Parametro'
if exists (select 1 from cob_conta..cb_relparam where re_producto = 14)
   delete from cob_conta..cb_relparam where re_producto = 14
go
                                             --RE_EMPRESA  RE_PARAMETRO    RE_CLAVE     RE_SUBSTRING   RE_PRODUCTO   RE_TIPO_AREA   RE_ORIGEN_DEST
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P01.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P02.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P03.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P04.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P05.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P06.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P07.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P08.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P09.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P10.0.PA',  '21110401',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_CAP_21',   'P11.0.PA',  '21110401',    14,           'CTB_OF',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'EFEC.0.0',   '1101',        14,           'CTB_OP',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'OTROS.0.0',  '110390',       14,           'CTB_OP',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'CHQL.0.0',   '110202',      14,           'CTB_OP',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'CHQE.0.0',   '110202',      14,           'CTB_OP',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'CHG.0.0',    '110202',      14,           'CTB_OP',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'AHO.0.0',    '210101020100',  14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'CTE.0.0',    '210101020100',  14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_FOPAGO',   'FFR.0.0',    '21110401',    14,           'CTB_OF',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_GMF_25',   '0',          '240108',      14,           'CTB_IMP',     'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P01.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P02.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P03.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P04.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P05.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P06.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P07.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P08.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P09.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P10.0.PA',  '24010206',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_INT_25',   'P11.0.PA',  '24010206',    14,           'CTB_OF',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_ORPAGO',   '0',         '110390',        14,           'CTB_OP',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_INT_51',   '0',         '6102',        14,           'CTB_OF',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_GMF_51',   '0',         '6102',        14,           'CTB_OF',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_PCA_42',   '0',         '50502309',    14,           'CTB_OP',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_PIN_42',   '0',         '50502309',    14,           'CTB_OP',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_RET_25',   '0',         '240108',      14,           'CTB_OP',      'O')

    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P01.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P02.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P03.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P04.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P05.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P06.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P07.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P08.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P09.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P10.0.PA',  '21110402',    14,           'CTB_OF',      'O')
    insert into cob_conta..cb_relparam values (1,          'DPF_PIGNOR',   'P11.0.PA',  '21110402',    14,           'CTB_OF',      'O')
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Concepto Retencion'
if not exists (select 1 from cob_conta..cb_conc_retencion where cr_codigo = '0215')
begin

    insert into cob_conta..cb_conc_retencion values (1,           '0215',     'RENDIM CDTS MENOS DE 5 AÑOS', 0,       0.05,           'C',       'R')
    insert into cob_conta..cb_conc_retencion values (1,           '0215',     'RENDIM CDTS MENOS DE 5 AÑOS', 0,       0.05,           'D',       'R')
	end
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Perfil Contable'
if exists (select 1 from cob_pfijo..pf_tranperfil)
    delete from cob_pfijo..pf_tranperfil
go
                                               --TP_TRAN  TP_ESTADO  TP_PERFIL    TP_TIPO_TRN  TP_TRN_REC
    insert into cob_pfijo..pf_tranperfil values (14545,   'N',       'APE_DPF',   'APE',       'APE')
    insert into cob_pfijo..pf_tranperfil values (14545,   'R',       'APE_DPF',   'APE',       'APE')
    insert into cob_pfijo..pf_tranperfil values (14901,   'N',       'APE_DPF',   'APE',       'APE')
    insert into cob_pfijo..pf_tranperfil values (14901,   'R',       'APE_DPF',   'APE',       'APE')
    insert into cob_pfijo..pf_tranperfil values (14989,   'N',       'APE_DPF',   'APE',       null )
    insert into cob_pfijo..pf_tranperfil values (14990,   'N',       'APE_DPF',   'APE',       null )
    insert into cob_pfijo..pf_tranperfil values (14995,   'N',       'APE_DPF',   'APE',       null )
    insert into cob_pfijo..pf_tranperfil values (14995,   'R',       'APE_DPF',   'APE',       null )
    
    insert into cob_pfijo..pf_tranperfil values (14903,   'N',       'CAN_DPF',   'CAN',       'CAN')
    insert into cob_pfijo..pf_tranperfil values (14903,   'R',       'CAN_DPF',   'CAN',       'CAN')
    insert into cob_pfijo..pf_tranperfil values (14905,   'N',       'CAN_DPF',   'CAN',       'CAN')
    insert into cob_pfijo..pf_tranperfil values (14905,   'R',       'CAN_DPF',   'CAN',       null )
    insert into cob_pfijo..pf_tranperfil values (14155,   'N',       'CAN_DPF',   'CAN',       'CAN')
    insert into cob_pfijo..pf_tranperfil values (14543,   'N',       'CAN_DPF',   'CAN',       null )
    insert into cob_pfijo..pf_tranperfil values (14543,   'R',       'CAN_DPF',   'CAN',       null )
    insert into cob_pfijo..pf_tranperfil values (14952,   'N',       'CAN_DPF',   'FFR',       'APE')
    insert into cob_pfijo..pf_tranperfil values (14947,   'N',       'CAN_DPF',   'REN',       null )
    insert into cob_pfijo..pf_tranperfil values (14165,   'N',       'CAN_DPF',   'REN',       null )
    insert into cob_pfijo..pf_tranperfil values (14165,   'R',       'CAN_DPF',   'REN',       null )
    insert into cob_pfijo..pf_tranperfil values (14919,   'N',       'CAN_DPF',   'REN',       'REN')
    insert into cob_pfijo..pf_tranperfil values (14919,   'R',       'CAN_DPF',   'REN',       'REN')
    
    insert into cob_pfijo..pf_tranperfil values (14926,   'N',       'CAU_DPF',   'CAU',       null )
    insert into cob_pfijo..pf_tranperfil values (14926,   'R',       'CAU_DPF',   'CAU',       null )
    
    insert into cob_pfijo..pf_tranperfil values (14149,   'N',       'END_DPF',   'END',       null )
    
    insert into cob_pfijo..pf_tranperfil values (14107,   'N',       'PIG_DPF',   'PIG',       null )
    insert into cob_pfijo..pf_tranperfil values (14307,   'R',       'PIG_DPF',   'PIG',       null )
    
    insert into cob_pfijo..pf_tranperfil values (14168,   'N',       'ENJ_DPF',   'ENJ',       null )
    insert into cob_pfijo..pf_tranperfil values (14168,   'R',       'ENJ_DPF',   'ENJ',       null )
    
    insert into cob_pfijo..pf_tranperfil values (14943,   'N',       'ORD_DPF',   'EOP',       'CAN')
    
    insert into cob_pfijo..pf_tranperfil values (14201,   'N',       'TOP_DPF',   'TOP',       'TOP')
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
print '-->Perfil Contable: Equivalencias'
delete cob_pfijo..pf_equivalencias where eq_modulo = 36 and eq_tabla in ('CATPRODUCT','TIPCONCEPT','TIPESTPRY')
go
                                                  --EQ_MODULO  EQ_TABLA       EQ_VAL_PFIJO  EQ_VAL_PFI_INI  EQ_VAL_PFI_FIN   EQ_VAL_INTERFAZ   EQ_DESCRIPCION                                                   
    insert into cob_pfijo..pf_equivalencias values (36,        'CATPRODUCT',  null,         30,             999999999,       'CDT',            'CERTIFICADO DE DEPOSITO A TERMINO')
    insert into cob_pfijo..pf_equivalencias values (36,        'CATPRODUCT',  null,         1,              29,              'CDAT',           'CERTIFICADO DE DEPOSITO A TERMINO FIJO')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'CAP',        null,           null,            'CAP',            'CAPITAL')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'INT',        null,           null,            'INT',            'INTERES')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'RET',        null,           null,            'RET',            'RETENCION')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'GMF',        null,           null,            'GMF',            'GRAVAMEN MOVIMIENTO FINANCIERO')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'CHC',        null,           null,            'CHCOMER',        'CHEQUE COMERCIAL')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'CHQL',       null,           null,            'CHLOCAL',        'CHEQUE LOCAL')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'CHG',        null,           null,            'CHGEREN',        'CHEQUE GERENCIA')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'PCHC',       null,           null,            'CTAPTE',         'CTA PTE CHEQUE COM')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'CTRL',       null,           null,            'CTAPTE',         'CTA PTE')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'EFEC',       null,           null,            'EFMN',           'EFECTIVO')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'OTROS',      null,           null,            'CTAPTE',         'CTA PTE')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'VXP',        null,           null,            'CTAPTE',         'CTA PTE')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPCONCEPT',  'SEBRA',      null,           null,            'SEBRA',          'SEBRA')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPESTPRY',   'ING',        null,           null,            '0',              'NO VIGENTE')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPESTPRY',   'ACT',        null,           null,            '1',              'VIGENTE')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPESTPRY',   'VEN',        null,           null,            '2',              'VENCIDO')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPESTPRY',   'CAN',        null,           null,            '3',              'CANCELADO')
    insert into cob_pfijo..pf_equivalencias values (36,        'TIPESTPRY',   'XACT',       null,           null,            '0',              'NO VIGENTE')
go
--*-----------------------------------------------------------------------------------------------


--*-----------------------------------------------------------------------------------------------
if exists(select 1 from cob_pfijo..pf_plazo_contable)
    delete cob_pfijo..pf_plazo_contable
go
                                                  --PC_PLAZO_CONT  PC_PLAZO_MIN  PC_PLAZO_MAX PC_DESCRIPCION
    insert into cob_pfijo..pf_plazo_contable values('P01',         30,           60,          'PLAZO DE 30  A 60   DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P02',         61,           90,          'PLAZO DE 61  A 90   DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P03',         91,           120,         'PLAZO DE 91  A 120  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P04',         121,          150,         'PLAZO DE 121 A 150  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P05',         151,          180,         'PLAZO DE 151 A 180  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P06',         181,          270,         'PLAZO DE 181 A 270  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P07',         271,          360,         'PLAZO DE 271 A 360  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P08',         361,          540,         'PLAZO DE 361 A 540  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P09',         541,          720,         'PLAZO DE 541 A 720  DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P10',         721,          1080,        'PLAZO DE 721 A 1080 DIAS')
    insert into cob_pfijo..pf_plazo_contable values('P11',         1080,         9999,        'PLAZO MAYOR  A 1081 DIAS')
go

print ''
print 'Fin Ejecucion Creacion de Perfiles Contables Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
go