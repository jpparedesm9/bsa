use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_est_complemento_xml') IS NOT NULL
	DROP table dbo.sb_est_complemento_xml
go
create table cob_conta_super..sb_est_complemento_xml
(
   se_Rfc_emisor   	     varchar (100),    	--cual es el rfc
   se_Nombre  			     varchar (100),	--si es un parametro
   se_RegimenFiscal 	     varchar (100),
   se_Rfc_receptor	     varchar (100), --si es el rfc del cliente
   se_UsoCFDI 			     varchar (100),
   se_ClaveProdServ 	     varchar (100), --parametro @w_clave_sat
   se_Cantidad     	     varchar (100),
   se_ClaveUnidad  	     varchar (100),
   se_Descripcion  	     varchar (100),
   se_ValorUnitario 	     varchar (100), --si es el Punitario del doc funcional 
   se_Importe 			     varchar (100),--importe del cuerpo del doc funcional
   se_Version			     varchar (100),--cual este este campo
   se_FechaPago           varchar (100),--pagoFechaPago del doc funcional
   se_FormaDePagoP        varchar (100),--pagoFormaDePagoP del doc funcional
   se_MonedaP             varchar (100),
   se_Monto               varchar (100), --pagoMonto del doc funcional
   se_RfcEmisorCtaOrd     varchar (100),--si es el rfc del cliente
   se_IdDocumento         varchar (100), --pagoIdDocumento del doc funcio
   se_Folio               varchar (100), --FolioReferencia del doc
   se_MonedaDR            varchar (100), 
   se_MetodoDePagoDR      varchar (100), 
   se_NumParcialidad      varchar (100),--pagoNumParcialidad
   se_ImpSaldoAnt         varchar (100),--pagoImpSaldoAnt
   se_ImpPagado           varchar (100),--pagoImpPagado
   se_ImpSaldoInsoluto    varchar (100),--pagoImpSaldoInsoluto
   se_banco               varchar (100),
   se_fecha               varchar (100),
   se_file_name           varchar (64),
   se_id_ente             int,
   se_estatus             char(1),
   se_rfc_ente            varchar(30),
   se_insert_date         datetime,
   se_rx_tipo_operacion   varchar(10),
   se_cuota_ini           int,
   se_cuota_hasta         int,
   se_folio_ref           varchar(50),
   se_deuda_pagar         money,
   se_sec_id              int,
   se_tipo_compl          char(1),
   se_fecha_afectacion    datetime
)
go

use cob_credito
go

IF OBJECT_ID ('dbo.cr_complemento_pago_xml') IS NOT NULL
	DROP table dbo.cr_complemento_pago_xml
go

create table dbo.cr_complemento_pago_xml
(
	linea             nvarchar(max),
	file_name         varchar (64),
	id_ente           int,
	status            char (1),
	rfc_ente          varchar (30),
	num_operation     varchar (24),
	insert_date       datetime,
	processing_date   datetime,
	tipo_operacion    varchar (10),
	in_fecha_fin_mes  datetime,
	rx_saldo_inso     money,
    rx_cuota_ini      int,
    rx_cuota_hasta    int,
    rx_deuda_pagar    money,
    rx_folio_ref      varchar(50),
	rx_saldo_inso_fin money,
	rx_sec_id         int,
	rx_tipo_compl     char(1),
	rx_id_documento   varchar(60),
	rx_fe_mes_afecta  datetime,
	rx_monto_pag      money
)
go

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'operacion_complemento' AND Object_ID = Object_ID(N'cob_credito..cr_complemento_pago_xml'))
begin 
   create index operacion_complemento on cob_credito..cr_complemento_pago_xml(num_operation) 	
end
go

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'complemento_banco_folio' AND Object_ID = Object_ID(N'cob_credito..cr_complemento_pago_xml'))
begin
   create index complemento_banco_folio on cob_credito..cr_complemento_pago_xml (num_operation, rx_folio_ref)
end
go

if not exists (SELECT 1  FROM sys.indexes WHERE Name = N'complemento_fin_mes' AND Object_ID = Object_ID(N'cob_credito..cr_complemento_pago_xml'))
begin
   create index complemento_fin_mes on cob_credito..cr_complemento_pago_xml (in_fecha_fin_mes)
end
go

update statistics cob_credito..cr_complemento_pago_xml
go


use cob_credito_his
go


IF OBJECT_ID ('dbo.cr_complemento_pago_xml_his') IS NOT NULL
	DROP table dbo.cr_complemento_pago_xml_his
go

create table dbo.cr_complemento_pago_xml_his
	(
	linea_his              nvarchar(max),
	file_name_his          varchar (64),
	id_ente_his            int,
	status_his             char (1),
	rfc_ente_his           varchar (30),
	num_operation_his      varchar (24),
	insert_date_his        datetime,
	processing_date_his    datetime,
	tipo_operacion_his     varchar (10),
	in_fecha_fin_mes_his   datetime,
	rxh_saldo_inso         money,
    rxh_cuota_ini          int,
    rxh_cuota_hasta        int,
    rxh_deuda_pagar        money,
    rxh_folio_ref          varchar(50),
    rxh_saldo_inso_fin     money,
    rxh_sec_id              int,
    rxh_tipo_compl         char(1),
    rxh_id_documento       varchar(60),
    rxh_fe_mes_afecta	   datetime,
	rxh_monto_pag          money
	)
go


if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'operacion_complemento_his' AND Object_ID = Object_ID(N'cob_credito_his..cr_complemento_pago_xml_his'))
begin
   create index operacion_complemento_his on cr_complemento_pago_xml_his (num_operation_his) 	
end
go

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'complemento_his_banco_folio' AND Object_ID = Object_ID(N'cob_credito_his..cr_complemento_pago_xml_his'))
begin
   create index complemento_his_banco_folio on cob_credito_his..cr_complemento_pago_xml_his (num_operation_his, rxh_folio_ref)	
end
go

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'complemento_his_fin_mes' AND Object_ID = Object_ID(N'cob_credito_his..cr_complemento_pago_xml_his'))
begin
   create index complemento_his_fin_mes on cob_credito_his..cr_complemento_pago_xml_his (in_fecha_fin_mes_his)	
end
go


update statistics cob_credito_his..cr_complemento_pago_xml_his
go

------------------
use cobis
go

if not exists(select 1 from cobis..ba_batch where ba_batch = 360081)
begin
    insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
    values (360081, 'GENERACION COMPLEMENTO PAGO', 'GENERACION COMPLEMENTO PAGO', 'SP', '2018-01-19', 36, 'P', 1, NULL, 'GRP_C_[OPE]_[FECHA]_[SEC].xml', 'cob_conta_super..sp_xml_comp_pag', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end
go




