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

IF  EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'AK_ca_santander_pagos_procesados') AND type in (N'UQ')) begin
   ALTER TABLE ca_santander_pagos_procesados
   drop CONSTRAINT AK_ca_santander_pagos_procesados;
end 

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'pp_trn_id_corresp'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_santander_pagos_procesados'))
begin
   ALTER TABLE ca_santander_pagos_procesados
   DROP pp_trn_id_corresp              varchar(8) NULL	
end

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'pp_referencia'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_santander_pagos_procesados'))
begin
   ALTER TABLE ca_santander_pagos_procesados
   alter column pp_referencia              varchar(64) NOT null	
end


IF not EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'PK_ca_santander_pagos_procesados') AND type in (N'PK')) begin
    ALTER TABLE ca_santander_pagos_procesados
    ADD CONSTRAINT PK_ca_santander_pagos_procesados PRIMARY KEY (pp_cuenta,pp_referencia,pp_movimiento,pp_archivo);
end

go