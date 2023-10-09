/**********************************************************************************************************************/
/*No Bug                     :                                                                                        */
/*Título de la Historia      : REQ 104991 – PAGO NO APLICADO                                                          */
/*Fecha                      : 25/07/2018                                                                             */
/*Descripción del Problema   : Se debe agregar columnas a tabla ca_santander_pagos_procesados para registrar la       */
/*                             referencia host to host; se borran registros con error en PRD.                         */
/*Descripción de la Solución : Crear modificación de la tabla                                                         */
/*Autor                      : Sonia Rojas                                                                            */
/**********************************************************************************************************************/


use cob_cartera
GO

IF  EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'PK_ca_santander_pagos_procesados') AND type in (N'PK')) begin
    ALTER TABLE ca_santander_pagos_procesados
    DROP CONSTRAINT PK_ca_santander_pagos_procesados;
end

if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'pp_trn_id_corresp'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_santander_pagos_procesados'))
begin
   ALTER TABLE ca_santander_pagos_procesados
   ADD pp_trn_id_corresp              varchar(8) NULL	
end

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'pp_referencia'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_santander_pagos_procesados'))
begin
   ALTER TABLE ca_santander_pagos_procesados
   alter column pp_referencia              varchar(64) null	
end

IF  not EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'AK_ca_santander_pagos_procesados') AND type in (N'UQ')) begin
   ALTER TABLE ca_santander_pagos_procesados
   ADD CONSTRAINT AK_ca_santander_pagos_procesados UNIQUE (pp_cuenta,pp_movimiento,pp_archivo,pp_referencia)
end 

delete from ca_corresponsal_trn where co_referencia = 'PG0000000008688' and co_estado = 'E' and co_accion = 'R'
go