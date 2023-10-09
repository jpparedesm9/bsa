/* **********************************************************************/
/*      Archivo           : sp_consulta_estados.sp                      */
/*      Stored procedure  : sp_consulta_estados                         */
/*      Base de datos     : cobis                                       */
/*      Producto          : Clientes                                    */
/*      Disenado por      : Ma. Jose Taco                               */
/*      Fecha de escritura: 29-Jun-2017                                 */
/* **********************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Permite consultar los estados del catalogo                          */
/* **********************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA            AUTOR                RAZON                     */
/*   29/Jun/2017         Ma Jose Taco         Emision inicial           */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_consulta_estados')
   drop proc sp_consulta_estados
go

create proc sp_consulta_estados(
    @i_operacion char(1) =null)
as
declare @w_codigo int

if @i_operacion = 'S'
begin
   select @w_codigo = 0
   select @w_codigo = codigo  
     from cl_tabla 
    where tabla= 'cl_provincia'
   
   select codigo,
          valor
     from cl_catalogo
    where tabla = @w_codigo
    order by valor
end
go
