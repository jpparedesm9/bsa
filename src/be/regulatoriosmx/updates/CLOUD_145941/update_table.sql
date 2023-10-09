/**************************************************************/
/*  TABLA REPORTE CLIENTS MOROSIDAD  REQ#145941               */
/*  Johan Castro Reportes de asignaciones                     */
/**************************************************************/

--  reporte sp_reporte_morosidad
use cob_conta_super
go 

IF OBJECT_ID ('dbo.sb_reporte_morosidad') IS NOT NULL
	DROP table dbo.sb_reporte_morosidad
go

create table cob_conta_super..sb_reporte_morosidad (
[CLIENTE]                        varchar(100),
[BANCO]                          varchar(100),
[NOMBRE_CLIENTE]                 varchar(500),
[AGENCIA_ACTUAL]                 varchar(100),           
[FEC_REF_AGENCIA]                varchar(100),
[BUC]                            varchar(100),
[PAGOS_VENCIDOS]                 varchar(100),
[TOTAL_DEUDOR]                   varchar(100),                
[PAGO_MINIMO]                    varchar(100),
[MONTO_MOROSO]                   varchar(100),
[CODIGO_BLOQUEO]                 varchar(100),
[FEC_CODIGO_BLOQUEO]             varchar(100),        
[DIA_CORTE]                      varchar(100),
[DIAS_AGENCIA]                   varchar(100),
[DESC_PRODUCTO]                  varchar(100),
[CALLE_NO_CLIENTE]               varchar(100),           
[COLONIA_CLIENTE]                varchar(100),
[CIUDAD_CLIENTE]                 varchar(100),
[ESTADO]                         varchar(100),
[CODIGO_POSTAL]                  varchar(100),               
[LADA_1]                         varchar(100),
[TEL_1]                          varchar(100),
[LADA_2]                         varchar(100),
[TEL_2]                          varchar(100),                      
[LADA_3]                         varchar(100),
[TEL_3]                          varchar(100),
[AGENCIA_PREVIA]                 varchar(100),
[FEC_REF_AGENCIA_PREVIA]         varchar(100),      
[FEC_ULTIMA_COMPRA]              varchar(100),
[FEC_ULTIMA_DISPOSICION]         varchar(100),
[MONTO_ULTIMA_COMPRA]            varchar(100), 
[MONTO_ULTIMA_DISPOSICION]       varchar(100),  
[FECHA_APERTURA_CUENTA]          varchar(100),
[RFC]                            varchar(100),
[MONTO_ASIGNADO_AGENCIA]         varchar(100),
[MONTO_ASIGNADO_AGENCIA_PREV]    varchar(100),
[FECHA_LIMITE_PAGO]              varchar(100),
[LIMITE_CREDITO]                 varchar(100),
[CUENTA_CHEQUES]                 varchar(100),
[STACTECA]                       varchar(100),                   
[SALDO_VENCIDO_30_DIAS]          varchar(100),
[SALDO_VENCIDO_60_DIAS]          varchar(100),
[SALDO_VENCIDO_90_DIAS]          varchar(100),
[SALDO_VENCIDO_120_DIAS]         varchar(100),  
[SEGMENTO_ACTUAL]                varchar(100),
[SEGMENTO_POSTERIOR]             varchar(100),
[DIAS_FALTANTES]                 varchar(100),
[FECHA_CAMBIO_SEGMENTO]          varchar(100),
[CORREO]                         varchar(100),
[ID_GRUPAL]                      varchar(100),   --145941
[NOMBRE_GRUPO]                   varchar(100),   --145941
[ROL_CLIENTE]                    varchar(100),   --145941
[ATRASO_GRUPAL]                  varchar(100)    --145941
)

go


--  reporte sp_reporte_asigna_mora
IF OBJECT_ID ('dbo.sb_reporte_asigna_mora') IS NOT NULL
	DROP table dbo.sb_reporte_asigna_mora
go

create table sb_reporte_asigna_mora  (
[NO_CUENTA]                     varchar(24),
[PAGOS_VENCIDOS]                varchar(30),
[DIAS_MOROSOS]                  varchar(30),
[TOTAL_DEUDOR]                  varchar(30),           
[MONTO_MOROSO]                  varchar(30),
[PAGO_MINIMO]                   varchar(30),
[MONTO_ULTIMO_PAGO]             varchar(30),
[FECHA_ULTIMO_PAGO]             varchar(30),                
[ULTIMO_SALDO_MES_ANTERIOR]     varchar(30),
[SALDO_VENCIDO_30_DIAS]         varchar(30),
[SALDO_VENCIDO_60_DIAS]         varchar(30),
[SALDO_VENCIDO_90_DIAS]         varchar(30),          
[SALDO_VENCIDO_120_DIAS]        varchar(30),
[FECHA_PROX_VENCIMIENTO]        varchar(30),
[PLAZO_PACTADO]                 varchar(30),
[CLASIF]                        varchar(30),            
[MOTIVO]                        varchar(30),
[PV_1MES_ATRAS]                 varchar(30),
[PV_2MES_ATRAS]                 varchar(30),
[PV_3MES_ATRAS]                 varchar(30),               
[PV_4MES_ATRAS]                 varchar(30),
[PV_5MES_ATRAS]                 varchar(30),
[PV_6MES_ATRAS]                 varchar(30),
[TRASCODIFICADA]                varchar(30),
[INTERESES_ORDINARIOS]          varchar(30),   --145941
[IVA_INTERESES_ORDINARIOS]      varchar(30),   --145941
[COMISIONES_FALTA_PAGO]         varchar(30),   --145941
[IVA_COMISIONES]                varchar(30)    --145941
) 

go
