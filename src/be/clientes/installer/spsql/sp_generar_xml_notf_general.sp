USE cobis
go

IF OBJECT_ID ('dbo.sp_genera_xml_notf_general') IS NOT NULL
	DROP PROCEDURE dbo.sp_genera_xml_notf_general
GO

/*************************************************************************/
/*   Archivo:            sp_genera_xml_notf_general.sp                   */
/*   Stored procedure:   sp_genera_xml_notf_general                      */
/*   Base de datos:      cob_cartera                                     */
/*   Producto:           cobis                                           */
/*   Disenado por:       Paul Ortiz                                      */
/*   Fecha de escritura: 24/08/2017                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Genera archivo xml con informacion para el pago de la garantia      */
/*   liquida                                                             */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   24-08-2017          Paul Ortiz                Emision Inicial       */
/*   16-01-2018          Paul Ortiz                Quitar generacion XML */
/*************************************************************************/
create procedure sp_genera_xml_notf_general
(
    @i_codigo         int, --Codigo (desde tabla de notificaciones generales)
    @i_opcion         char(1) = null
)
as
declare @w_ruta_xml             varchar(255),
        @w_error                int,
        @w_sql_bcp              varchar(5000),
        @w_sql                  varchar(5000),
        @w_mensaje_bcp          varchar(150),
        @w_sp_name              varchar(30)

declare @resultadobcp table (linea varchar(max))

select @w_sp_name = 'sp_genera_xml_notf_general'

if @i_opcion = 'G'
begin
	
	select 	
		ng_mensaje, 
	    ng_correo, 
	    ng_asunto 	 
    from cobis..cl_notificacion_general
    where ng_codigo =  convert(varchar, @i_codigo) 
	
end

return 0

ERROR:

    set transaction isolation level read uncommitted

    exec cobis..sp_cerror @t_from = @w_sp_name, @i_num = @w_error
    return @w_error

GO

