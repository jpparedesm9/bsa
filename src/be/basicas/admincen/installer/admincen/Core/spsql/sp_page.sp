/************************************************************************/
/*    Archivo:             sp_page.sp                                   */
/*    Stored procedure:    sp_page_an                                   */
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
/*    Insercion     (I)                                                 */
/*    Borrado       (D)                                                 */
/*    Actualizacion (U)                                                 */
/*    Search        (S)                                                 */
/*    Query         (Q)                                                 */
/*    Help          (H)                                                 */
/*    de funcionalidades para el nuevo esquema de seguridades para      */
/*    COBIS ADMIN NET                                                   */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*    20/02/2008    A- Duque    Emisión inicial                         */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_page_an')
   drop proc sp_page_an
go

create proc sp_page_an (
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
    @i_page_id         int          = NULL
)
as

declare

    @w_today        datetime    ,
    @w_return       int         ,
    @w_sp_name      varchar(32)    

select @w_today = @s_date
select @w_sp_name = 'sp_page_an'


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
    /*********** CONTROL TRANSACCION **************/
    If @t_trn = 15300
    begin
        if @i_modo = 0
         begin
            set rowcount 20
            
            select    'Clave' = pa_id,
                'Padre' = pa_id_parent,
                'Etiqueta' = pa_name
            from an_page
            order by pa_id
            
               set rowcount 0
               return 0
         end
        if @i_modo = 1
        begin
            set rowcount 20
            
            select    'Clave' = pa_id,
                'Padre' = pa_id_parent,
                'Etiqueta' = pa_name
            from an_page
            where pa_id > @i_page_id
            order by pa_id
            
            set rowcount 0
            return 0
         end
     end
end

go
