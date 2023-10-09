/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_perfil.sp                                */
/*    Stored procedure:     sp_perfil                                   */
/*    Base de datos:        cobis                                       */
/*    Producto:             Banca Virtual                               */
/*                                                                      */
/************************************************************************/
/*                                                                      */
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'Cobiscorp'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                PROPOSITO                                             */
/*   Este sp consulta todos los roles                                   */
/*                                                                      */
/************************************************************************/
/*                   MODIFICACIONES                                     */
/*    FECHA             AUTOR           RAZON                           */
/*   Mayo-2011     B. Cuenca     Consulta de todos los roles            */
/*                     para Office Banking                              */
/************************************************************************/

use cobis
go

/***************************************************************************/
/*   Elimina el procedimiento almacenado sp_perfil                         */
/***************************************************************************/

if exists (select * from sysobjects where name = 'sp_perfil')
    drop  proc sp_perfil
go

/***************************************************************************/
/*    Crea el procedimiento almacenado sp_perfil                  */
/***************************************************************************/
create proc sp_perfil (                                                                                                                                                                                                                                          
    @login                  varchar(30)=null,                                                                                                                                                                                                                         
    @i_rol                  tinyint = 0,                                                                                                                                                                                                                        
    @i_filas                int = 0                                                                                                                                                                                                                     
)                                                                                                                                                                                                                                                             
as                                                                                                                                                                                                                                                           
    set rowcount @i_filas
                                                                                                                                                                                                                                                              
    select  ro_rol,
            convert(varchar(40),ro_descripcion) as ro_descripcion,
            'N' as pre_change
    from  ad_rol                                                                                                                                                                                                                                    
    where ro_estado = 'V'
          and  ro_rol > isnull(@i_rol,0)  
    order  by ro_rol
                                                                                                                                                                                                                                         
    return 0
go
