/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : Modificación pagos interdia
--Descripción del Problema   : Creación tabla control de pagos procesados
--Responsable                : Nelson Trujillo
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Remediaciones
--Nombre Archivo             : REM-CLI-IEN-20180131.sql
/*----------------------------------------------------------------------------------------------------------------*/
use cob_cartera
GO

PRINT 'Drop table ca_santander_pagos_procesados'
IF OBJECT_ID ('ca_santander_pagos_procesados') IS NOT NULL
	DROP TABLE ca_santander_pagos_procesados
GO

PRINT 'Create table ca_santander_pagos_procesados'
CREATE TABLE ca_santander_pagos_procesados
	(
	pp_cuenta     cuenta      NOT NULL,
	pp_referencia VARCHAR(64) NOT NULL,
	pp_movimiento VARCHAR(64) NOT NULL,
	pp_fecha_pago VARCHAR(8)  NOT NULL,	  
	pp_archivo    VARCHAR(64) NOT NULL,
    pp_fecha_proceso DATETIME NOT NULL,
	CONSTRAINT PK_ca_santander_pagos_procesados PRIMARY KEY (pp_cuenta, pp_referencia, pp_movimiento)
	)
GO
