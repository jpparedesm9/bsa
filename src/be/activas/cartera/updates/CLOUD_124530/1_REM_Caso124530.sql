use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reporte_pagos_elavon') IS NOT NULL
	DROP table dbo.ca_reporte_pagos_elavon
go

create table dbo.ca_reporte_pagos_elavon
	(
	rp_usuario            varchar (250),
	rp_nombre_usuario     varchar (250),	
	rp_num_dispositivo    varchar (250),
	rp_num_operacion      varchar (250),
	rp_referencia         varchar (250),
	rp_importe            varchar (250),
	rp_fecha              varchar (250),
	rp_num_afiliacion     varchar (250),
	rp_tipo_operacion     varchar (250),
	rp_tipo_pago          varchar (250)
	)
go

declare @w_batch int
select @w_batch = 7450

if exists (select 1 from cobis..ba_batch where ba_batch = @w_batch)
    select * from cobis..ba_batch where ba_batch = @w_batch
else
    insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
    values (@w_batch, 'REPORTE ELAVON', 'REPORTE SEGUROS ELAVON', 'SP', getdate(), 7, 'P', 1, 'CARTERA', 'REPORTE_ELAVON_', 'cob_cartera..sp_reporte_pagos_elavon', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\')
go
