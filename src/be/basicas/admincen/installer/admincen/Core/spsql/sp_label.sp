/************************************************************************/
/*    Archivo:             sp_label.sp                                  */
/*    Stored procedure:    sp_label_an                                  */
/*    Base de datos:       cobis                                        */
/*    Producto:            ADMIN-Seguridades                            */
/*    Disenado por:        Alfonso Duque Acosta                         */
/*    Fecha de escritura:  28-Feb-2008                                  */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    Cobiscorp.                                                        */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                PROPOSITO                                             */
/*    Este programa procesa las maneja la definicion de labels          */
/*    para ADMIN NET                                                    */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*      30/7/2009      SPA       Se cambia catalogo a an_culture        */
/*                               de acuerdo a definicion de FAL         */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_label_an')
   drop proc sp_label_an
go

create proc sp_label_an (
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
    @i_id              int          = NULL,
    @i_cultura         catalogo     = NULL,
    @i_label           descripcion  = NULL
)
as
declare
    @w_today        datetime,
    @w_return       int,
    @w_sp_name      varchar(32),
    @w_id           int

select @w_today = @s_date,
    @w_sp_name = 'sp_label_an'


/******** INSERCION *******/
if @i_operacion = 'I'
begin
    /****** CONTROL TRANSACCION ******/
    if @t_trn = 15305
    begin
        /***** CONTROL NULOS ********/
        if (
           @i_cultura is null or
           @i_label is null
           )
        Begin
            exec cobis..sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 151001

            return 1
        end
        
        /******** CONTROL DE EXISTENCIA DE LA CULTURA *******/
        if not exists (select *
                from cl_catalogo C, cl_tabla T
                where C.tabla=T.codigo
                and T.tabla='an_culture'
                and C.codigo=@i_cultura)
        Begin
            exec cobis..sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 151167

            return 1
        End

        if @i_id is null
        begin
            select @w_id = isnull(max(la_id),0) + 1
            from an_label
            where la_cod = @i_cultura
        end
        else
        begin
            select @w_id = @i_id
        end

        if not exists (    select *
                from an_label
                where la_id = @w_id
                and la_cod = @i_cultura)
        Begin

            /******* INSERCION ********/
            
            insert into an_label(
                la_id,  la_cod,   la_label)
            values (
                @w_id,  @i_cultura,  @i_label)
    
        
            /******** ERROR INSERCION *********/
            if @@error<>0 
            Begin
                exec cobis..sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 153070
            
                return 1
            End

        End
        else
        Begin

            /******* ACTUALIZACION ********/
            
            update an_label
            set la_label = @i_label
            where la_id = @w_id
                and la_cod = @i_cultura
    
        
            /******** ERROR INSERCION *********/
            if @@error<>0 
            Begin
                exec cobis..sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 155071
            
                return 1
            End

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


/******** UPDATE *******/
if @i_operacion = 'U'
begin
    /****** CONTROL TRANSACCION ******/
    if @t_trn = 15306
    begin
        /***** CONTROL NULOS ********/
        if (
            @i_cultura is null
            or @i_label is null
           )
        Begin
            exec cobis..sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 151001

            return 1
        end
        
        /******** CONTROL DE EXISTENCIA DE LA CULTURA *******/
        if not exists (    select *
                from cl_catalogo C, cl_tabla T
                where C.tabla=T.codigo
                and T.tabla='an_culture'
                and C.codigo=@i_cultura)
        Begin
            exec cobis..sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 151167

            return 1
        End

        if @i_id is null
        begin
            select @w_id = isnull(max(la_id),0) + 1
            from an_label
            where la_cod = @i_cultura
        end
        else
        begin
            select @w_id = @i_id
        end


        if not exists (    select *
                from an_label
                where la_id = @w_id
                and la_cod = @i_cultura)
        Begin

            /******* INSERCION ********/
            
            insert into an_label(
                la_id,  la_cod,   la_label)
            values (
                @w_id,  @i_cultura,  @i_label)
    
        
            /******** ERROR INSERCION *********/
            if @@error<>0 
            Begin
                exec cobis..sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 153070
            
                return 1
            End

        End
        else
        Begin

            /******* ACTUALIZACION ********/
            
            update an_label
            set la_label = @i_label
            where la_id = @w_id
                and la_cod = @i_cultura
    
        
            /******** ERROR INSERCION *********/
            if @@error<>0 
            Begin
                exec cobis..sp_cerror
                       @t_debug    = @t_debug,
                       @t_file     = @t_file,
                       @t_from     = @w_sp_name,
                       @i_num      = 155071
            
                return 1
            End

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
/******* FIN UPDATE *********/


/********* BORRADO ********/
if @i_operacion = 'D'
begin
    /******** CONTROL DE TRANSACCION ********/
    if @t_trn = 15307
    begin
    
        /******** CONTROL DE EXISTENCIA DEL LABEL *******/
        if not exists (    select *
                from an_label
                where la_id = @i_id
                and la_cod = @i_cultura)
        Begin
            exec cobis..sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 151168

            return 1
        End

        /***** BORRADO *******/

        delete an_label
        where la_id = @i_id
            and la_cod = @i_cultura

        /******** ERROR BORRADO ********/

           if @@error != 0
           begin
            exec cobis..sp_cerror
                   @t_debug    = @t_debug,
                   @t_file     = @t_file,
                   @t_from     = @w_sp_name,
                   @i_num      = 157093

            return 1
           end

        return 0
    end
    else 
    /******* ERROR TRANSACCION *********/
    begin
        exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num     = 151051

        return 1
    end
end  
/********* FIN BORRAR *********/


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
    /*********** CONTROL TRANSACCION **************/
    If @t_trn = 15308
    begin
             if @i_modo = 0
             begin

                 set rowcount 20

            /***** SEARCH *****/

                select
                    'ID' = la_id,
                    'CULTURA' = la_cod,
                    'DESCRIPCION' = substring(C.valor,1,20),
                    'LABEL'=la_label
                from 
                    an_label, 
                    cl_catalogo C,
                    cl_tabla T
                where T.tabla = 'an_culture'
                    and C.tabla = T.codigo
                    and la_cod = C.codigo
                order by la_cod, la_id
    
                if @@rowcount=0
                Begin
                    exec sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 151121
                    set rowcount 0
                    return 1
                End

                   set rowcount 0
                   return 0
             end
            if @i_modo = 1
            begin

            /***** CONTROL NULOS ********/
                if (
                    @i_cultura is null
                       )
                Begin
                    exec cobis..sp_cerror
                           @t_debug  = @t_debug,
                           @t_file   = @t_file,
                           @t_from   = @w_sp_name,
                           @i_num    = 151001
    
                    return 1
                end

                 set rowcount 20

            /***** SEARCH *****/

                select
                    'ID' = la_id,
                    'CULTURA' = la_cod,
                    'DESCRIPCION' = substring(C.valor,1,20),
                    'LABEL'=la_label
                from 
                    an_label, 
                    cl_catalogo C,
                    cl_tabla T
                where T.tabla = 'an_culture'
                    and C.tabla = T.codigo
                    and la_cod = C.codigo
                    and ((la_cod=@i_cultura and la_id>@i_id) or (la_cod>@i_cultura))
                order by la_cod, la_id

                if @@rowcount=0
                Begin
                    exec sp_cerror
                        @t_debug    = @t_debug,
                        @t_file     = @t_file,
                        @t_from     = @w_sp_name,
                        @i_num      = 151121
                    set rowcount 0
                    return 1
                End

                set rowcount 0
                return 0
             end
    end
    else
    /***** TRANSACCION INCORRECTA **********/
    begin
        exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 151051

            return 1
    end
end
/********* FIN SEARCH *********/

go
