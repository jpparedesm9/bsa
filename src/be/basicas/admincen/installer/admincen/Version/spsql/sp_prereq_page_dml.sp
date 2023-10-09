/************************************************************************/
/*  Archivo:            sp_prereq_page_dml.sp                           */
/*  Stored procedure:   sp_prereq_page_dml                              */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Cesar Guevara                                   */
/*  Fecha de escritura: 18-Feb-2010                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                       PROPOSITO                                      */
/*  Este programa procesa las operaciones de Insercion, Eliminacion y   */
/*  Busqueda de Prerequsitos de pagina para Admin .NET                  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA       AUTOR         RAZON                                     */
/*  18/02/2010  Cesar Guevara Emision Inicia                            */
/*  04/03/2010  Sandro Soto   Ajustes al codigo                         */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_prereq_page_dml')
   drop proc sp_prereq_page_dml
go

create proc sp_prereq_page_dml (
    @s_ssn          int         = NULL,
    @s_user         login       = NULL,
    @s_sesn         int         = NULL,
    @s_term         varchar(32) = NULL,
    @s_date         datetime    = NULL,
    @s_srv          varchar(30) = NULL,
    @s_lsrv         varchar(30) = NULL, 
    @s_rol          smallint    = NULL,
    @s_ofi          smallint    = NULL,
    @s_org_err      char(1)     = NULL,
    @s_error        int         = NULL,
    @s_sev          tinyint     = NULL,
    @s_msg          descripcion = NULL,
    @s_org          char(1)     = NULL,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = NULL,
    @t_from         varchar(32) = NULL,
    @t_trn          smallint    = NULL,
    @i_operacion    varchar(1),
    @i_modo         smallint    = 0,
    @i_tipo         char(1)     = NULL,
    @i_pa_id        int         = NULL,
    @i_prereq       varchar(10) = NULL,
	@o_id        int            = NULL output
)
as
declare @w_today        datetime,
        @w_return       int,
        @w_sp_name      varchar(32)

select @w_today = @s_date,
       @w_sp_name = 'sp_prereq_page_dml'

if ((@i_operacion = 'I' and @t_trn != 15369) or 
    (@i_operacion = 'D' and @t_trn != 15371) or
    (@i_operacion = 'S' and @t_trn != 15372))
    begin   
       /*Transaccion no permitida*/
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
        return 151051
    end     


/******** INSERCION *******/
if @i_operacion = 'I'
begin
    /* Control de existencia de pagina */
    if not exists (select 1 from an_page
                    where pa_id = @i_pa_id)
    begin
        /* La Pagina no se encuentra registrada */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157151
        return 157151
    end

    /* Control de existencia en catalogo aw_prerequisitos */
    if not exists (select 1 from cl_tabla T, cl_catalogo C
                    where T.codigo =  C.tabla
                      and T.tabla  = 'aw_prerequisitos'
                      and C.codigo = @i_prereq )
     begin
        /* No existe prerequisito */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 151146
        return 151146
    end

    if not exists (select 1 from an_prereq_page 
                      where pp_pa_id = @i_pa_id
                        and pp_prereq = @i_prereq)
       begin
          insert into an_prereq_page(pp_pa_id, pp_prereq)
                           values (@i_pa_id, @i_prereq)
            
          if @@error<>0 
             begin
                /*Existio un error al asociar el Prerequisitos de Pagina*/
                exec cobis..sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 157185
                return 157185
             end
       end
     else
       begin 
          /*Ya existe un registro de Prerequisisto para la Pagina con este codigo*/
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157186
            return 157186
       end
    return 0
end   
/******* FIN INSERCION *********/


/********* DELETE  ********/
if @i_operacion = 'D'
begin
    /* Control de existencia del Prerequisito de la Pagina */
    if not exists (select 1 from an_prereq_page
                    where pp_pa_id = @i_pa_id
                      and pp_prereq = @i_prereq)
    begin
        /* Prerequsito de la Pagina no esta registrado */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157187
        return 157187
    end

    /* Eliminacion de Prerequisito de Pagina */
    delete an_prereq_page
     where pp_pa_id = @i_pa_id
       and pp_prereq = @i_prereq

    if @@error != 0
    begin
        /*Existio un error al eliminar el Prerequisito de la Pagina*/
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157189
        return 157189
    end

    return 0
end  
/********* FIN DELETE *********/


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0
      begin
         select 'ID PAGINA'=pa_id,
				'PAGINA'   = pa_name,
                'PREREQ.'  = pp_prereq,
                'VALOR'    = C.valor
           from an_prereq_page, an_page, cl_tabla T, cl_catalogo C
          where pa_id = pp_pa_id
            and T.codigo = C.tabla
            and C.codigo = pp_prereq
            and T.tabla = 'aw_prerequisitos'
            and pp_pa_id = @i_pa_id
          order by pp_prereq

         if @@rowcount = 0
            begin
               /*No existen mas registros de Prerequsitos de Pagina*/
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 157190
               return 157190
            end
      end

   if @i_modo = 1
      begin
         select 'ID PAGINA'=pa_id,
				'PAGINA'   = pa_name,
                'PREREQ.'  = pp_prereq,
                'VALOR'    = C.valor
           from an_prereq_page, an_page, cl_tabla T, cl_catalogo C
          where pa_id = pp_pa_id
            and T.codigo = C.tabla
            and C.codigo = pp_prereq
            and T.tabla = 'aw_prerequisitos'
            and pp_pa_id = @i_pa_id
            and pp_prereq > @i_prereq
          order by pp_prereq

         if @@rowcount = 0
            begin
               /*No existen mas registros de Prerequsitos de Pagina*/
               exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 157190
               return 157190
            end
      end
   set rowcount 0
   return 0
end
/********* FIN SEARCH *********/

go

