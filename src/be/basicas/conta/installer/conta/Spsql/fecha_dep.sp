/********************************************************************/
/*         Archivo:                trancta.sp                       */
/*         Stored procedure:       sp_trancta                       */
/*         Base de datos:          cob_conta                        */
/*         Producto:               contabilidad                     */
/*         Disenado por:                                            */
/*         Fecha de escritura:     30-Sep-1993                      */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de   */
/*  "MACOSA", representantes exclusivos para el Ecuador de la       */
/*  "NCR CORPORATION".                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno de sus         */
/*  usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de MACOSA o su representante.             */
/*                           PROPOSITO                              */
/*  Este programa procesa las transacciones de:                     */
/*  Consulta de transacciones de una cuenta                         */
/*                         MODIFICACIONES                           */
/*         FECHA         AUTOR         RAZON                        */
/*                                                                  */
/********************************************************************/
use cob_conta
go

if exists (select 1 from cob_conta..sysobjects where name = 'sp_fecha_dep' and xtype = 'P')
    drop proc sp_fecha_dep
go

create proc sp_fecha_dep
(
   @i_empresa     tinyint,
   @i_fecha       datetime
)
as
declare
   @w_depurada     char(1),
   @w_fecha       datetime,
   @w_estado      char(1)
   
select @w_fecha = '01/01/1900'

select @w_fecha = max(cbd_fecha_tran)
from cob_conta..cb_depurar
where cbd_cantidad > 0

if @w_fecha >= @i_fecha
    select @w_depurada = 'S'
else 
    select @w_depurada = 'N'

select @w_depurada

    
return 0

go


