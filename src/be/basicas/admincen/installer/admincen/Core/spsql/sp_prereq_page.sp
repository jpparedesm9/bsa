/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_prereq_page.sp                           */
/*    Stored procedure:     sp_prereq_page                              */
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
/*   Este sp consulta los prerrequisitos de las paginas                 */
/*   Es requerido para compatibilidad de las aplicaciones migradas      */
/*   de COM a CEN                                                       */
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*    08-03-2010  Sandro Soto   Uso de pa_name en lugar de pp_page      */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_prereq_page')
    drop procedure sp_prereq_page
go


create proc sp_prereq_page(
    @tipo_operacion char(1) = null,
    @i_modo         smallint = 0,
    @i_page            varchar(40) = null,
    @i_prereq       catalogo = null
)
as
   set rowcount 20
   if(@tipo_operacion = 'S')
   begin
    if @i_modo = 0
    begin
        select an_page.pa_name, an_prereq_page.pp_prereq
        from an_prereq_page, an_page
           where pp_pa_id = pa_id
        order by pa_name, pp_prereq
      
        set rowcount 0
    end
    else /*modo = 1*/    
    begin
        select an_page.pa_name, an_prereq_page.pp_prereq
        from an_prereq_page, an_page
        where pp_pa_id = pa_id
              and pa_name+pp_prereq>@i_page+@i_prereq
        order by pa_name, pp_prereq
        
            set rowcount 0
       end    
   end
   else if(@tipo_operacion = 'N')
      select count(distinct pp_prereq)
      from an_prereq_page
return 0
go
   
