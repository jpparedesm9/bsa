USE cobis
go
/*************************************************************/
/*   ARCHIVO:         	sp_return_parametro.sp               */
/*   NOMBRE LOGICO:   	sp_return_parametro                  */
/*   PRODUCTO:        		COBIS                            */
/*************************************************************/
/*                     IMPORTANTE                            */
/*   Esta aplicacion es parte de los  paquetes bancarios     */
/*   propiedad de MACOSA S.A.                                */
/*   Su uso no autorizado queda  expresamente  prohibido     */
/*   asi como cualquier alteracion o agregado hecho  por     */
/*   alguno de sus usuarios sin el debido consentimiento     */
/*   por escrito de MACOSA.                                  */
/*   Este programa esta protegido por la ley de derechos     */
/*   de autor y por las convenciones  internacionales de     */
/*   propiedad intelectual.  Su uso  no  autorizado dara     */
/*   derecho a MACOSA para obtener ordenes  de secuestro     */
/*   o  retencion  y  para  perseguir  penalmente a  los     */
/*   autores de cualquier infraccion.                        */
/*************************************************************/
/*                     PROPOSITO                             */
/*   Este procedimiento devuelve los valores                 */
/*   de los parametros 							             */
/*************************************************************/
/*                     MODIFICACIONES                        */
/*   FECHA         AUTOR               RAZON                 */
/*   25-Sep-2018  PXSG                Emision Inicial.       */
/*************************************************************/
IF OBJECT_ID ('dbo.sp_return_parametro') IS NOT NULL
	DROP PROCEDURE dbo.sp_return_parametro
GO

create proc sp_return_parametro (	
	@i_operacion		char(1)= null,
	@i_nemonico         CHAR(6)= null,
	@i_producto         CHAR(3)= NULL,
	@i_formato_fecha    int    = 101,
	@t_debug            char(1)       = 'N',
	@t_file             varchar(14)   = null,
    @t_show_version     bit           = 0 -- Mostrar la versión del programa

)
as

declare 
    @w_return           INT,
    @w_sp_name          varchar(32)

-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_return_parametro, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name = 'sp_return_parametro'
--Consulta
if @i_operacion = 'Q'
begin
	      select'Nemonico'    = pa_nemonico ,
             'Producto'       = pa_producto,
             'Parametro'      = pa_parametro,
             'Valor Char'     = pa_char,
             'Valor Tinyint'  = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int'      = pa_int,  
             'Valor Money'    = pa_money, 
             'Valor Float'    = pa_float,
             'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
             from   cobis..cl_parametro 
             WHERE pa_nemonico=@i_nemonico AND pa_producto=@i_producto
       if @@rowcount = 0
      begin
         select @w_return  = 601157
         goto ERROR
      end
	
end


return 0

ERROR:
   exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
   /*  'No corresponde codigo de transaccion' */
   return @w_return


GO
