/************************************************************************/
/*    Archivo:             sp_transacfun.sp                             */
/*    Stored procedure:    sp_transacfun                                */
/*    Base de datos:       cobis                                        */
/*    Producto:            Admin                                        */
/*    Disenado por:        Juan Tagle                                   */
/*    Fecha de escritura:  21-Feb-2014                                  */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'Cobiscorp'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                           PROPOSITO                                  */
/*    Este programa consulta, asigna y elimina las transacciones a las  */
/*    funcionalidades                                                   */
/*                         MODIFICACIONES                               */
/************************************************************************/
/*    FECHA          AUTOR        RAZON                                 */
/*    21/Feb/2014    J. Tagle     Emision Inicial                       */
/*    21/Abr/2016    BBO          Migracion SYB-SQL FAL                 */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_transacfun')
    drop  proc sp_transacfun
go

create proc sp_transacfun (
       @s_ssn              int         = null,
       @s_user             login       = null,
       @s_sesn             int         = null,
       @s_term             varchar(32) = null,
       @s_date             datetime    = null,
       @s_srv              varchar(30) = null,
       @s_lsrv             varchar(30) = null, 
       @s_rol              smallint    = null,
       @s_ofi              smallint    = null,
       @s_org_err          char(1)     = null,
       @s_error            int         = null,
       @s_sev              tinyint     = null,
       @s_msg              descripcion = null,
       @s_org              char(1)     = null,
       @t_show_version     bit         = 0,
       @t_debug            char(1)     = 'N',
       @t_file             varchar(14) = null,
       @t_from             varchar(32) = null,
       @t_trn              smallint    = null,
       @i_operacion        char(1)     = null,
       @i_modo             int = null,
       @i_rol              int = null,
       @i_prodname         varchar(10) = null,
       @i_producto         int = null,
       @i_culture          varchar(30) = null,
       @i_id_page          int = null,
       @i_componente       int = null,
       @i_id_page_hija     int = null,
       @i_transac          int = null,
       @i_siguiente        int = null
)
as

declare @w_sp_name  varchar(32),
        @w_compo    integer,
        @w_rep      integer,
        @w_nivel    integer,
        @w_prodname varchar(10),
        @w_cont     int, 
		@w_pa_cod 	varchar(10)

if @t_show_version = 1
begin
    print 'Stored procedure sp_transacfun, Version 4.0.0.0'
    return 0
end
        
select @w_sp_name = 'sp_transacfun',
       @i_culture = UPPER(@i_culture)

if @t_trn = 15390
begin       
-----------
-- INSERTAR
-----------
    if @i_operacion = 'I'
    begin        
        if @i_modo = 1   --Inserta 1 x transaccion base
            if not exists ( select 1 from cobis..an_transaction_component where    tc_co_id = @i_componente and tc_tn_trn_code = @i_transac and tc_oc_nemonic is null)
                insert into cobis..an_transaction_component 
                     values (@i_componente, @i_transac, null)
        if @i_modo = 2    --Inserta 1 x base PRodName
            if not exists ( select 1 from cobis..an_transaction_component where    tc_co_id = 0 and tc_tn_trn_code = @i_transac and tc_oc_nemonic = @i_prodname)
                insert into cobis..an_transaction_component 
                     values (0, @i_transac, @i_prodname)
    end 


    -----------
    -- ELIMINAR
    -----------
    if @i_operacion = 'E' 
    begin
        if @i_modo = 1   --Elimina 1 x transaccion base
        begin
            if exists ( select 1 from cobis..an_transaction_component where    tc_co_id = @i_componente and tc_tn_trn_code = @i_transac and tc_oc_nemonic is null)
                delete from cobis..an_transaction_component 
                where tc_co_id = @i_componente
                and tc_tn_trn_code = @i_transac
                and tc_oc_nemonic is null
        end
        
        if @i_modo = 2    --Elimina 1 x base PRodName
        begin
            if exists ( select 1 from cobis..an_transaction_component where    tc_co_id = 0 and tc_tn_trn_code = @i_transac and tc_oc_nemonic = @i_prodname)
                delete from cobis..an_transaction_component 
                where tc_co_id = 0
                and tc_tn_trn_code = @i_transac
                and tc_oc_nemonic = @i_prodname        
        end
            
    end 


    -----------
    -- CONSULTA        
    -----------
    if @i_operacion = 'S'
    begin
        set rowcount 0
        create table #autorizadas (id integer identity, transac integer null, label varchar(40) null)
		
		select @w_pa_cod = pa_char from cobis..cl_parametro
			where pa_nemonico ='CEAN'
			and pa_producto= 'ADM'
        if @i_modo = 0    --Buscar Paginas PADRE del producto
        begin
                select @w_rep = 1,
                    @w_nivel = 1,
                    @w_prodname = @i_prodname

                create table #tabla
                  (id     int identity, 
                   page   int null, 
                   parent int null, 
                   nivel  int null)

                --BUSQUEDA INICIAL 

                insert into #tabla
                select pa_id, pa_id_parent, @w_nivel --paginas con padres unicos en prodname
                from an_page
                where pa_prod_name = @w_prodname
                  and isnull(pa_id_parent,0) != 0
                  and pa_id_parent not in (select pa_id  --paginas del prodname
                                           from an_page, 
                                                an_label
                                           where pa_la_id   = la_id
                                             and isnull(pa_id_parent,0) != 0
                                             and pa_prod_name = @w_prodname)
                    
                --BUSQUEDA SECUENCIAL
                while (@w_rep=1)
                begin
                    select @w_nivel = @w_nivel + 1
                    insert into #tabla
                    select pa_id, pa_id_parent,@w_nivel -- padre de...
                    from an_page
                    where pa_id in (
                            select parent
                            from #tabla
                            where nivel = (@w_nivel - 1)
                            )
                    delete from #tabla where nivel = (@w_nivel - 1) and parent <> 0
                    if not exists(select 1 from #tabla where parent <> 0)
                        select @w_rep = 0

                    select @w_cont = count(*) from #tabla 

                    if @w_cont = 0 
                       break
                    
                end

                delete from #tabla where parent <> 0

                select pa_id, -1, la_label
                from an_page, an_label
                where pa_la_id = la_id
                and pa_id in (select page from #tabla)
				and la_cod = @w_pa_cod
        end
            
        
        if @i_modo = 1    --Buscar Paginas hijas  (paginas)
        begin
            select 'Pagina' = page.pa_id, 
                   'Componenete' = isnull(component.co_id,-1), 
                   'Label' = label.la_label
            from an_page page
               inner join an_label label           on label.la_id = page.pa_la_id 
                                                   and label.la_cod = 'ES_EC'
               left join an_page_zone zone        on zone.pz_pa_id = page.pa_id
               left join an_component component   on component.co_id = zone.pz_co_id
            where pa_prod_name = @i_prodname
              and pa_id_parent = @i_id_page
              and pa_id > isnull(@i_siguiente,0)
            --order by pa_order
            
            union
            
            select pa_id, pa_id_parent,la_label -- padre de...
            from an_page, an_label
            where pa_la_id = la_id
            and pa_id_parent = @i_id_page 
            and pa_prod_name <> @i_prodname
            and pa_id in (
                    select pa_id_parent
                    from an_page, an_label
                    where (pa_prod_name = @i_prodname)
                    and pa_la_id = la_id
                    and pa_id_parent not in (
                            select pa_id  --paginas del prodname
                            from an_page, an_label
                            where pa_la_id = la_id
                            and pa_prod_name = @i_prodname
                            )
                    )
            --order by pa_order
            
            union

            select 'Pagina' = -1,
                   'Componenete' = isnull(referencia.rc_child_co_id,-1), 
                   'Label' = label2.la_label
            from an_referenced_components referencia                                         
                 inner join an_label label2           on label2.la_id = referencia.rc_la_id 
                                                      and label2.la_cod = 'ES_EC'
                 inner join an_component component    on component.co_id = referencia.rc_parent_co_id
                                                      and referencia.rc_parent_co_id = @i_componente
        end    
        
        
        if @i_modo = 2    --TRANSACCIONES BAse de ProdName
        begin
			set rowcount 20
            select 'Código'       = trans.tn_trn_code,
                   'Tipo'         = 'Base ProdName',
                   'Transaccion'  = trans.tn_descripcion
            from cl_ttransaccion trans
            inner join an_transaction_component trancom on trancom.tc_tn_trn_code = trans.tn_trn_code
                                                        and trancom.tc_co_id = 0
                                                        and trancom.tc_oc_nemonic = @i_prodname
            where trans.tn_trn_code > isnull(@i_siguiente,0)
            order by trans.tn_trn_code
        end
        
            
        if @i_modo = 3    --TRANSACCIONES AUTORIZADAS  Por Operación, Base del Comp.
        begin    
				set rowcount 20
                select @w_compo = co_id
                from an_page, an_page_zone, an_component
                where     pa_id = pz_pa_id 
                and pz_co_id = co_id
                and pa_id = @i_id_page
                
                select  'TRN     ' = a.tn_trn_code,
                        'TIPO'     = 'Trans Operacion',
                        'DESCRIPCION' = a.tn_descripcion
                from cl_ttransaccion a
                inner join an_transaction_component b    on b.tc_tn_trn_code = a.tn_trn_code
                                                         and b.tc_oc_nemonic <> null
                where (b.tc_co_id = @i_componente  or  b.tc_co_id = @w_compo)
                  and a.tn_trn_code > isnull(@i_siguiente,0)
                    
                union

                select  'TRN     ' = a.tn_trn_code,
                        'TIPO'     = 'Base Componente',
                        'DESCRIPCION' = a.tn_descripcion
                from cl_ttransaccion a
                inner join an_transaction_component b    on b.tc_tn_trn_code = a.tn_trn_code
                                                         and b.tc_oc_nemonic is null
                where (b.tc_co_id = @i_componente  or  b.tc_co_id = @w_compo)
                  and a.tn_trn_code > isnull(@i_siguiente,0)
        end

        
        if @i_modo = 4    --TRANSACCIONES DISPONIBLES
        begin
            set rowcount 20
            select  'TRN     ' = tn_trn_code, 
                    'DESCRIPCION' = tn_descripcion
            from cl_ttransaccion, ad_pro_transaccion 
            where pt_transaccion = tn_trn_code
            and tn_trn_code > isnull(@i_siguiente,0)
            and tn_trn_code not in (  --BASE PRODNAME
                                    select tc_tn_trn_code 
                                    from an_transaction_component 
                                    where tc_co_id = 0 and tc_oc_nemonic = @i_prodname  --BASE PRODNAME
                                    )
                                    
            and tn_trn_code not in    (  --de Pagina
                                    select tc_tn_trn_code 
                                    from an_transaction_component 
                                    where tc_co_id in (
                                                    select co_id
                                                    from an_page, an_page_zone, an_component
                                                    where     pa_id = pz_pa_id 
                                                    and pz_co_id = co_id
                                                    and pa_id = @i_id_page
                                                        )
                                    )
            and tn_trn_code not in    (  --de Componente
                                    select tc_tn_trn_code 
                                    from an_transaction_component 
                                    where tc_co_id = @i_componente
                                    )
            and pt_producto = @i_producto
            order by tn_trn_code
        end    
        
        set rowcount 0
        return 0
    end

end -- trn 1998

return 0
go


