/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_information_page_offbanking.sp           */
/*    Stored procedure:     sp_information_page_offbanking              */
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
/*   Este sp consulta todas las paginas  autorizadas web                */
/*   para un rol determinado                                            */
/*                                                                      */
/************************************************************************/
/*                   MODIFICACIONES                                     */
/*    FECHA             AUTOR           RAZON                           */
/*   Abril-2011     B. Cuenca     Consulta de paginas autorizadas Web   */
/*                                para carga de Menu de Office Banking  */
/*   Agosto-2011    M. Davila     Correccion y Optimizacion             */
/*   04/Nov/2013     M.Cabay      Ingre @w_servername para Distribución */
/*                                por branch                            */
/************************************************************************/

use cobis
go

/***************************************************************************/
/*   Elimina el procedimiento almacenado sp_information_page_offbanking */
/***************************************************************************/

if exists (select * from sysobjects where name = 'sp_information_page_offbanking')
    drop  proc sp_information_page_offbanking
go

/***************************************************************************/
/*    Crea el procedimiento almacenado sp_information_page_offbanking   */
/***************************************************************************/

create proc sp_information_page_offbanking (
    @s_srv             varchar(30)     = NULL,
    @s_ofi             smallint = NULL,  
    @i_role            int = null,
    @i_tipo            char(2) = null,
    @i_type_comp       char(2) = null,
    @i_culture         varchar(30) = null,
    @i_id_page         int = null
)
as
declare @w_sp_name    varchar(32),
        @w_pa_id_parent int, 
        @w_pa_id    int,
        @w_parent_aux    int,
        @w_servername varchar(40)
        
--Se recupera el nombre del servidor en base a la oficina
 exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output
        
select @w_sp_name = 'sp_information_page_offbanking',
       @i_culture = UPPER(@i_culture)


if @i_tipo = 'OB'
begin

    -- tabla temporal para el menu
    -- inserci¢n de los componentes tipo hoja   
    select pa_id_parent,
          pa_id,
          pa_order,
          pa_icon,
          pa_name,
          'la_label' = isnull(la_label,'-'),
          pa_splitter,
          pa_nemonic,
          co_class,
          convert (varchar(255), isnull(replace (co_namespace,'[servername]',@w_servername),'')) co_namespace,
          co_arguments
    into  #tmp_menu
    from  an_role_page,
          an_page left outer join an_label on (la_id = pa_la_id and la_cod = @i_culture),
          an_page_zone,
          an_component
    where rp_rol   = @i_role
          and  rp_pa_id = pa_id
          and  pz_pa_id = pa_id   
          and  pz_co_id = co_id
          and  co_ct_id = @i_type_comp
   
    -- proceso para encontrar los nodos que conforman el resto de la jerarqu¡a
    CREATE TABLE #tmp_parents
    ( tmp_pa_id_parent        int    null)


    DECLARE cur_hoja cursor for
    select pa_id,
           pa_id_parent
    from   #tmp_menu
    where  pa_id_parent <> 0
    FOR READ ONLY

   
    OPEN  cur_hoja        
    FETCH cur_hoja
    INTO  @w_pa_id, @w_pa_id_parent

    while @@FETCH_STATUS = 0        
    begin

        insert into #tmp_parents (tmp_pa_id_parent)
        values (@w_pa_id_parent)

        if @@error <> 0
        begin       

            exec cobis..sp_cerror
                @t_from  = @w_sp_name,
                @i_num   = 151169        -- Error inesperado de BDD consulte a su Administrador

            close cur_hoja
            deallocate cur_hoja

            return 1
        end
    
        -- este lazo encuentra para cada nodo hoja, los padres siguiendo la jerarquia de la tabla an_page, hasta llegar a pa_id_parent=0
        select @w_parent_aux = @w_pa_id_parent
      
        while @w_parent_aux <> 0
        begin
         
            select @w_parent_aux = pa_id_parent
            from   an_page
            where  pa_id = @w_parent_aux
            
            if @@rowcount = 0
            begin
                -- Esto se daria si la bdd esta inconsistente y no existe el registro padre 
                -- se puso este control para evitar un lazo infinito
                exec cobis..sp_cerror
                    @t_from  = @w_sp_name,
                    @i_num   = 151169        -- Error inesperado de BDD consulte a su Administrador
            
                close cur_hoja
                deallocate cur_hoja
            
                return 1
            end


            insert into #tmp_parents (tmp_pa_id_parent)
                           values (@w_parent_aux)

            if @@error <> 0
            begin
                exec cobis..sp_cerror
                    @t_from  = @w_sp_name,
                    @i_num   = 151169        -- Error inesperado de BDD consulte a su Administrador
            
                close cur_hoja
                deallocate cur_hoja
            
                return 1
            end        

        end

        FETCH cur_hoja
        INTO  @w_pa_id, @w_pa_id_parent
      
    end

    close cur_hoja
    deallocate cur_hoja

    -- insertar el resto de nodos en la tabla temporal #tmp_menu
    ------- se hace un distinct por cuanto en la tabla #tmp_parents estan todos los padres de los nodo hoja
    ------- y los nodos hoja comparten padres.

    insert into #tmp_menu
    select distinct pa_id_parent,
          pa_id,
          pa_order,
          pa_icon,
          pa_name,
          isnull(la_label, '-'),
          pa_splitter,
          pa_nemonic,
          null,
          null,
          null
    from  an_page left outer join an_label on (la_id = pa_la_id and la_cod = @i_culture),
          #tmp_parents
    where pa_id    = tmp_pa_id_parent

    if @@error <> 0
    begin
        exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 151169        -- Error inesperado de BDD consulte a su Administrador
       
        return 1
    end        

    select * from #tmp_menu
    where  pa_id > isnull(@i_id_page,0)
    order  by pa_id

end -- fin if i_tipo OB

return 0
go
