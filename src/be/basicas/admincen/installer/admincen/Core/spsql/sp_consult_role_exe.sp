/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_consult_role_exe.sp                      */
/*    Stored procedure:     sp_consult_role_exe                         */
/*    Base de datos:        cobis                                       */
/*    Producto:             COBIS Explorer . NET                        */
/*                                                                      */
/************************************************************************/
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'Cobiscorp'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                                                                      */
/*                PROPOSITO                                             */
/*   Este sp consulta todos los roles asociados a un usuario Cobis      */
/*   para una aplicacion ejecutable que se va a correr dentro de CEN    */
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*   FECHA        AUTOR        RAZON                                    */
/*   18-nov-2009        S. Paredes      Creaci¢n                        */
/*   13-Ene-2014        M. Cabay        Se elimna raiserror para que se */
/*                                      controle por número de registros*/
/************************************************************************/

use cobis
go

/************************************************************************/
/*   Elimina el procedimiento almacenado sp_consult_role_exe            */
/************************************************************************/

if exists (select * from sysobjects where name = 'sp_consult_role_exe')
    drop  proc sp_consult_role_exe
go

/************************************************************************/
/*    Crea el procedimiento almacenado sp_consult_role_exe            */
/************************************************************************/

create proc sp_consult_role_exe(
    @i_user_login  varchar(30),
    @i_module_id   int
)
as

declare @w_sp_name varchar(32)
select @w_sp_name = 'sp_consult_role_exe'

    select ur_role
      from an_user_role_exe
     where ur_user  = @i_user_login 
       and ur_mo_id = @i_module_id

return 0  
go
