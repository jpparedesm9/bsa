/***********************************************************************/
/*      Archivo:                        carga_cobis.sp                 */
/*      Stored procedure:               sp_carga_cobis                 */
/*      Base de Datos:                  cob_externos                   */
/*      Producto:                       Clientes                       */
/*      Disenado por:                   Ignacio Yupa                   */
/*      Fecha de Documentacion:         16/Ago/2016                    */
/***********************************************************************/
/*                      IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                      PROPOSITO                                       */
/* Realizar carga de clientes en la base cobis                          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_carga_cobis')
   drop proc sp_carga_cobis
go
create proc sp_carga_cobis
(
   @i_param1              char(1)      = 'S'
)
as

declare
   @w_sp_name           varchar(30),    --Setea nombre del Sp  
   @w_registros         int
   
-- ------------------------------------------------------------------
-- - Variables Iniciales
-- ------------------------------------------------------------------
select  @w_sp_name        = 'sp_carga_cobis'
        
--------------------------------
-- Eliminar Tablas Definitivas
--------------------------------
if upper(@i_param1) = 'N'
begin
    truncate table cobis..cl_refinh
    truncate table cobis..cl_trabajo
    truncate table cobis..cl_ref_personal
    truncate table cobis..cl_telefono
    truncate table cobis..cl_direccion
    truncate table cobis..cl_ente
    truncate table cobis..cl_ente_adicional
    truncate table cobis..cl_instancia
    update cobis..cl_seqnos set siguiente = 0 where tabla = 'cl_ente'
end

            select @w_registros = count(*)
            from cl_ente_mig
            where en_estado_mig = 'VE'
            
            if @w_registros <> 0
            begin           
                exec sp_traslada_cl_ente
                exec sp_traslada_cl_direccion 
                exec sp_traslada_cl_telefono 
                exec sp_traslada_cl_trabajo 
                exec sp_traslada_cl_ref_persona 
                exec sp_traslada_cl_refinh 
                exec sp_traslada_cl_instancia
            end
                
-- ------------------------------------------------------------------
-- - Actualizar Seqnos
-- ------------------------------------------------------------------
    update cobis..cl_seqnos set siguiente = (select max(en_ente) from cobis..cl_ente) + 1
    where tabla = 'cl_ente'

return 0
go

