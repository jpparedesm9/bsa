/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_get_list_nodes_parents.sp                */
/*    Stored procedure:     sp_get_list_nodes_parents                   */
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
/*   Este sp consulta todos los nodos padres de un nodo dado            */
/*   Es requerido para manejar la compatibilidad de las aplicaciones    */
/*   migradas de COM a CEN                                              */ 
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*   ago-2009          O. Guaño        Emision inicial                  */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_get_list_nodes_parents')
    drop procedure sp_get_list_nodes_parents
go


create proc sp_get_list_nodes_parents(
    @page_id           int = 0,
    @page_Name_Nemonic varchar(40) = null,
    @tipo              varchar(2) = 'Id'
)
as

declare 
    @page_name varchar(40),
    @page_parent int,
    @count_history int,
    @count_page int
       
select @page_parent = 999999
    

    if(@tipo = 'Id')
        select @page_id = @page_id
    else if(@tipo = 'Na')
         begin
          select @count_page = count(pa_id) from an_page where pa_name = @page_Name_Nemonic
          if(@count_page = 0)    
            return 1
          else
            select @page_id = pa_id from an_page where pa_name = @page_Name_Nemonic
       end
    else if(@tipo = 'Ne')
       begin
         select @count_page = count(pa_id) from an_page where pa_nemonic = @page_Name_Nemonic
         if(@count_page = 0)
           return 1
         else
           select @page_id= pa_id from an_page where pa_nemonic = @page_Name_Nemonic
       end

    select @count_history = 0

    create table #list_pages(pa_id int, pa_name varchar(40), pa_parent int)

    while @count_history < 5 and @page_parent != 0
    begin
    
       insert #list_pages(pa_id, pa_name, pa_parent) 
       select pa_id, pa_name, pa_id_parent
         from an_page
        where pa_id = @page_id  

             if @@error != 0
                return 1

      select @page_parent= pa_parent
        from #list_pages
       where pa_id = @page_id 
         

      select @count_history = @count_history + 1,
                 @page_id = @page_parent

    end
    select * from #list_pages

return 0
go
