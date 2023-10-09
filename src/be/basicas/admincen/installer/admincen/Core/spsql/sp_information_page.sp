/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_information_page_SQL.sp                  */
/*    Stored procedure:     sp_information_page                         */
/*    Base de datos:        cobis                                       */
/*    Producto:             COBIS Explorer . Net                        */
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
/*   Este sp consulta todas las p ginas  autorizadas                    */
/*   para un rol determinado                                            */
/*                                                                      */
/************************************************************************/
/*                   MODIFICACIONES                                     */
/*    FECHA        AUTOR        RAZON                                   */
/*   sep-2009     S. Paredes    Control de label por cultura            */
/*   Dic-2010     B. Cuenca     Se a¤ade cursor para obtener paginas    */
/*                              autorizadas por rol                     */
/*   ABR/15/2016  BBO           Migracion SYB-SQL FAL                   */
/************************************************************************/

use cobis
go

/************************************************************************/
/*   Elimina el procedimiento almacenado sp_information_page            */
/************************************************************************/

if exists (select * from sysobjects where name = 'sp_information_page')
    drop  proc sp_information_page
go

/************************************************************************/
/*    Crea el procedimiento almacenado sp_information_page              */
/************************************************************************/

create proc sp_information_page (
    @i_role            int = null,
    @i_tipo            char(1) = null,
    @i_culture         varchar(30) = null,
    @i_id_page         int = null
)
as
declare @w_sp_name    varchar(32),
        @w_rp_pa_id int, 
        @w_pa_id_parent int, 
        @w_contador int
        
select @w_sp_name = 'sp_information_page',
       @i_culture = UPPER(@i_culture)


if @i_tipo = 'A'
begin

        if not exists(select rp_rol from an_role_page  )
        begin
            --raiserror 101001 'No existe dato solicitado, rol'
            RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')  --migracion SYB-SQL 15042016
        end
        else 
            select min(rp_rol) from an_role_page 
    
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existe dato solicitado'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')  --migracion SYB-SQL 15042016
    end
end
if @i_tipo = 'B'
begin
    select distinct rp_pa_id,
        rp_rol,
        pa_order,
        pa_icon,
        pa_name,
        la_label,
        pa_splitter,
        pa_nemonic
    from an_page,
        ad_rol,
        an_role_page,
        an_label
    where la_id = pa_la_id
        and pa_id=rp_pa_id
        and ro_rol=rp_rol
        and  rp_rol=@i_role
        and la_cod = @i_culture
    order by rp_rol asc
    
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end

if @i_tipo = 'C'
begin
    select distinct rp_pa_id,
        pa_order, 
        pa_icon, 
        pa_name,
        la_label,
        pa_splitter,
        pa_nemonic
    into #padres
     
    from
        an_page,
        ad_rol,
        an_role_page,
        an_label
    where la_id = pa_la_id
        and pa_id=rp_pa_id
        and ro_rol=rp_rol
        and rp_rol=@i_role
        and la_cod = @i_culture
    order by rp_pa_id asc
    
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
    create table #hijos
    ( pa_id_parent int null,
      pa_order     int null,
      pa_icon      varchar(40) null,
      pa_name      varchar(40) null,
      la_label     varchar(100) null,
      pa_splitter  varchar(20) null,
      pa_nemonic   varchar(40) null,
      pa_id     int null
    )
                        
    
    declare cursor_pages cursor for
    select rp_pa_id
    from #padres
    order by rp_pa_id
      
    open cursor_pages
    while 1=1
    begin
        fetch cursor_pages  
        into @w_rp_pa_id
        if @@fetch_status != 0 
            break
      
        select @w_contador = 0
    
        select @w_pa_id_parent = @w_rp_pa_id
    
        --Barre cada Pagina Hoja hacia atras para obtener sus respectivos padres hasta llegar al id_padre=0
        while @w_pa_id_parent <> 0
        begin      
    
            select @w_contador = @w_contador + 1
        
            if @w_contador = 15
            begin
                --raiserror 101001 'Error en los datos de pagina'
                RAISERROR ('%d %s', 16, 1, 101001, 'Error en los datos de pagina')  --migracion SYB-SQL 15042016
                return @w_pa_id_parent
            end
        
            if exists (select 1 from an_page where pa_id = @w_pa_id_parent )
            begin     
                if not exists (select 1 
                               from an_label 
                               where la_cod = @i_culture 
                                   and la_id = (select pa_la_id
                                   from an_page where pa_id = @w_pa_id_parent))
                begin
                    insert into #hijos
                    select pa_id_parent,
                        pa_order,
                        pa_icon,
                        pa_name,
                        'No existe Label',
                        pa_splitter,
                        pa_nemonic,pa_id
                    from an_page
                    where pa_id = @w_pa_id_parent
        
                    --Para obtener solo el id_parent
                    select @w_rp_pa_id = pa_id_parent
                    from an_page
                    where pa_id = @w_pa_id_parent
                end
                else
                begin
                    insert into #hijos
                    select pa_id_parent,
                        pa_order, 
                        pa_icon, 
                        pa_name, 
                        la_label,
                        pa_splitter,
                        pa_nemonic,pa_id
                    from an_page, 
                        an_label
                    where pa_la_id = la_id 
                        and la_cod = @i_culture 
                        and pa_id = @w_pa_id_parent 
         
                    if @@rowcount =  0
                    begin
                        --raiserror 101001 'No existen datos solicitados'
                        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
                        return 1
                    end
        
                    --Para obtener el id_parent
                    select @w_rp_pa_id = pa_id_parent
                    from an_page, 
                        an_label
                    where pa_la_id = la_id 
                        and la_cod = @i_culture 
                        and pa_id = @w_pa_id_parent
        
                end
                select @w_pa_id_parent =  @w_rp_pa_id
             
            end
            else
            begin
                --raiserror 101001 'No existe valores para la pagina enviada'
                RAISERROR ('%d %s', 16, 1, 101001, 'No existen valores para la pagina enviada')  --migracion SYB-SQL 15042016
                return 1
            end
        end --cierra el while
        
    end --cierra el cursor
    close cursor_pages
    
    DEALLOCATE cursor_pages;
    
    select * from #hijos
    
end -- fin if i_tipo C
return 0
go
