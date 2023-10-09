/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_query_catalog_config.sp                  */
/*    Stored procedure:     sp_query_catalog_config                     */
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
/*   Este sp consulta todos los querys, acciones y columnas necesarias  */
/*   para presetar la informacion de un pseudocatalogo especifico       */
/*                                                                      */ 
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*   mar-2010        G. Jimenez        Emision inicial                  */
/*   02-Jun-2010     S. Paredes       Cambiar @i_rol y @i_culture       */
/*   31-Ene-2011     S. Paredes       Mod @i_query_name a varchar(64)   */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_query_catalog_config')
    drop procedure sp_query_catalog_config
go

create proc sp_query_catalog_config
(
    @s_rol         smallint = null, 
    @s_culture     varchar(10) = null, 
    @t_debug       char(1) = 'N', 
    @t_file        varchar(10) = null, 
    @t_from        varchar(32) = null, 
    @t_trn         smallint = null, 
    @i_operation   char(1), 
    @i_query_name  varchar(64), 
    @i_mode        tinyint = 0, 
    @i_next        int = 0
)
AS
declare @w_sp_name    varchar(30)
    select @w_sp_name = 'sp_query_catalog_config'
    
    if @t_trn != 15322 /*'Transaccion no corresponde'*/
    begin
    exec sp_cerror
         @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 101183
             return 1
    end
    
        /*Query Info*/
    if    @i_operation = 'I'
    begin
        select qu_query_id, 
               qu_query_name, 
               qu_dto_full_name  
          from an_query
         where qu_query_name = @i_query_name
    end
    
    /*Query Actions*/
    if @i_operation = 'A'
    begin
        select
            qa_query_id,
            qa_type,
            qa_is_input_dto_required,
            qa_method_name,
            qc_interface_full_name,
            qc_implementation_full_name
        from
            an_query_action inner join an_query on qu_query_id=qa_query_id
            inner join an_query_component on qa_qc_id = qc_id
        where qu_query_name = @i_query_name
        order by qa_type
    end
    
    /*QueryColumns*/
    if @i_operation = 'C'
    begin
        select
            cl_query_id,
            cl_order,
            la_label,
            cl_datatype,
            cl_name,
            cl_width,
            cl_allow_search,
            cl_is_id,
            cl_is_description,
            cl_catalog_table
        from    
            an_query_column inner join an_query on cl_query_id = qu_query_id
            inner join an_label on cl_la_id = la_id
        where qu_query_name = @i_query_name
        and UPPER(la_cod) = UPPER(@s_culture)
        order by cl_order
    end
return 0
go
