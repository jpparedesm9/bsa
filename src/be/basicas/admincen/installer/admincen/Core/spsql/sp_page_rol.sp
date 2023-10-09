/************************************************************************/
/*    Archivo:             sp_page_rol.sp                               */
/*    Stored procedure:    sp_page_rol_an                               */
/*    Base de datos:       cobis                                        */
/*    Producto:            ADMIN.NET-Seguridades                        */
/*    Disenado por:        Alfonso Duque                                */
/*    Fecha de escritura:  20-Feb-2008                                  */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'Cobiscorp'.                                                      */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                PROPOSITO                                             */
/*    Este programa procesa las transacciones de:                       */
/*    mantenimiento de paginas por rol de                               */
/*    COBIS ADMIN NET                                                   */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*    20/02/2008    A. Duque    Emisión inicial                         */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_page_rol_an')
    drop proc sp_page_rol_an
go

create proc sp_page_rol_an (
    @s_ssn             int          = NULL,
    @s_user            login        = NULL,
    @s_sesn            int          = NULL,
    @s_term            varchar(32)  = NULL,
    @s_date            datetime     = NULL,
    @s_srv             varchar(30)  = NULL,
    @s_lsrv            varchar(30)  = NULL, 
    @s_rol             smallint     = NULL,
    @s_ofi             smallint     = NULL,
    @s_org_err         char(1)      = NULL,
    @s_error           int          = NULL,
    @s_sev             tinyint      = NULL,
    @s_msg             descripcion  = NULL,
    @s_org             char(1)      = NULL,
    @t_debug           char(1)      = 'N',
    @t_file            varchar(14)  = null,
    @t_from            varchar(32)  = null,
    @t_trn             smallint     = NULL,
    @i_operacion       varchar(1),
    @i_modo            smallint     = 0,
    @i_page_id         int          = NULL,
    @i_rol             int          = NULL,
    @i_tipo            int          = NULL
)
as

declare

    @w_today        datetime    ,
    @w_return       int         ,
    @w_sp_name      varchar(32)    

select @w_today = @s_date
select @w_sp_name = 'sp_page_rol_an'

/******** INSERCION *******/
if @i_operacion = 'I'
begin
    /****** CONTROL TRANSACCION ******/
    if @t_trn = 15311
    begin
        /***** CONTROL NULOS ********/
        if (
            @i_page_id is null or
            @i_rol is null
            )
        Begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 151001
            return 1
        end
        /******** CONTROL DE EXISTENCIA DEL ROL *******/
        if not exists ( select *
                        from ad_rol
                        where ro_rol=@i_rol)
        Begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 151026 
            return 1
        End
        
        /******** CONTROL DE EXISTENCIA DE LA PAGINA *******/
        if not exists ( select *
                        from an_page
                        where pa_id = @i_page_id)
        Begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 151165
            return 1
        End
        /******* INSERCION ********/
        insert into an_role_page 
        values (@i_page_id, @i_rol)
        
        /******** ERROR INSERCION *********/
        if @@error<>0 
        Begin
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 153069
        
            return 1
        End
        return 0
    end
    else
    /******* TRANSACCION INCORRECTA **********/
    begin 
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 151051
        return 1
    end
end 
/******* FIN INSERCION *********/
/********* BORRADO ********/
if @i_operacion = 'D'
begin
    /******** CONTROL DE TRANSACCION ********/
    if @t_trn = 15312
    begin
        /****** CONTROL DE EXISTENCIA DE ASOCIACION DE PAGE A ROL *******/
        if not exists ( select *
                        from an_role_page
                        where rp_rol=@i_rol
                        and rp_pa_id=@i_page_id)
        Begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 151166
            return 1
        end
        /***** BORRADO *******/
        delete an_role_page
        where rp_rol=@i_rol
            and rp_pa_id=@i_page_id
        
        /******** ERROR BORRADO ********/
        if @@error != 0
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 157092
            return 1
        end
        return 0
    end
    else 
    /******* ERROR TRANSACCION *********/
    begin
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 151051
        return 1
    end
end
/********* FIN BORRAR *********/

/********* SEARCH ***********/
if @i_operacion = 'S'
begin
    /*********** CONTROL TRANSACCION **************/
    If @t_trn = 15310
    begin
        /*** BUSQUEDA DE PAGINAS ASIGNADAS A UN ROL ****/
        if @i_tipo=3
        begin
            if @i_modo = 0
            begin
                /***** CONTROL NULOS ********/
                if (
                    @i_rol is null
                    )
                Begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 151001
                    
                    return 1
                end
    
                set rowcount 20
    
                /***** SEARCH *****/
    
                select    'Clave' = pa_id,
                    'Padre' = pa_id_parent,
                    'Etiqueta' = pa_name
                from an_page, an_role_page
                where rp_rol = @i_rol 
                    and pa_id = rp_pa_id
                order by pa_id
                
                set rowcount 0
                return 0
            end
            /*** Fin Modo 0 ***/
            if @i_modo = 1
            begin
     
                /***** CONTROL NULOS ********/
                if (
                    @i_page_id is null or
                    @i_rol is null
                    )
                Begin
                    exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 151001
     
                    return 1
                end
     
                set rowcount 20
     
                /***** SEARCH *****/
    
                select    'Clave' = pa_id,
                    'Padre' = pa_id_parent,
                    'Etiqueta' = pa_name
                from an_page, an_role_page
                where rp_rol = @i_rol 
                    and pa_id = rp_pa_id
                    and pa_id > @i_page_id
                order by pa_id
    
                set rowcount 0
                return 0
            end
            /*** Fin Modo 1 ***/
    
        end
    
        /*** Fin Tipo 3 ***/
    end
end

go
