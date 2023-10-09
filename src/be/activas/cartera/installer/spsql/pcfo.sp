/************************************************************************/
/*      Archivo:                pcfo.sp                                 */
/*      Stored procedure:       sp_pcca_fo                              */
/*      Base de datos:          cobis                                   */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Fabian de la Torre                      */
/*      Fecha de escritura:     Enero. 1999                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".	                                                */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Parametros para Origen de Fondos Perfiles contables             */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_pcca_fo')
        drop proc sp_pcca_fo
go


create proc sp_pcca_fo (
   @t_trn                smallint = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_criterio1          varchar(10) = null
)
as

declare
   @w_sp_name            varchar(32)

/* INICIALIZACION DE VARIABLES DE TRABAJO */
select @w_sp_name = 'sp_pcca_fo'

/* MOSTRAR A FRONT END LISTA DE CLASES DE CARTERA */
set rowcount 20

select 
'CODIGO'      =  A.codigo,
'DESCRIPCION' =  A.valor 
from cobis..cl_tabla B, cobis..cl_catalogo A 
where B.tabla = 'ca_fondos_nopropios'
and   A.tabla = B.codigo
and   (A.codigo > @i_criterio1 or @i_criterio1 is null)
union
select 
'CODIGO'      =  A.codigo,
'DESCRIPCION' =  A.valor 
from cobis..cl_tabla B, cobis..cl_catalogo A 
where B.tabla = 'ca_fondos_propios'
and   A.tabla = B.codigo
and   (A.codigo > @i_criterio1 or @i_criterio1 is null)
order by A.codigo

if @@rowcount = 0 begin
   exec cobis..sp_cerror
   @t_from  = @w_sp_name,
   @i_num   = 190100 
   return 1 
end
                                                                                                                                                                                                                                       
return 0
go
