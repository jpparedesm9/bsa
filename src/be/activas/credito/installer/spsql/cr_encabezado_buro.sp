/***********************************************************************/
/*     Archivo:                         cr_buro_encabezado.sp          */
/*     Stored procedure:                sp_buro_encabezado             */
/*     Base de Datos:                   cob_credito                    */
/*     Producto:                        Credito                        */
/*     Disenado por:                    D. Cumbal                      */
/*     Fecha de Documentacion:          12/Mar/2018                    */
/***********************************************************************/
/*               IMPORTANTE                                            */
/*     Este programa es parte de los paquetes bancarios propiedad de   */
/*     "MACOSA",representantes exclusivos para el Ecuador de la        */
/*     AT&T                                                            */
/*     Su uso no autorizado queda expresamente prohibido asi como      */
/*     cualquier autorizacion o agregado hecho por alguno de sus       */
/*     usuario sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante              */
/***********************************************************************/
/*                            PROPOSITO                                */
/*     Procedimiento para obterner el reporte de consultas a buro      */
/***********************************************************************/
/*               MODIFICACIONES                                        */
/*     FECHA          AUTOR                  RAZON                     */
/*  20/Jun/2019      S. Rojas             Emision Inicial - REQ 115975 */
/***********************************************************************/
use cob_credito
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

if object_id ('sp_buro_encabezado') is not null
begin
   drop proc sp_buro_encabezado
end
go

   create proc sp_buro_encabezado (
   @s_ssn                                    int          = null,
   @s_user                                   login        = null,
   @s_sesn                                   int          = null,
   @s_term                                   descripcion  = null,
   @s_date                                   datetime     = null,
   @s_srv                                    varchar(30)  = null,
   @s_lsrv                                   varchar(30)  = null,
   @s_rol                                    smallint     = null,
   @s_ofi                                    smallint     = null,
   @s_org_err                                char(1)      = null,
   @s_error                                  int          = null,
   @s_sev                                    tinyint      = null,
   @s_msg                                    descripcion  = null,
   @s_org                                    char(1)      = null,
   @t_rty                                    char(1)      = null,
   @t_trn                                    smallint     = null,
   @t_debug                                  char(1)      = 'N',
   @t_file                                   varchar(14)  = null,
   @t_from                                   varchar(30)  = null,
   @i_operacion                              char(1)      = null,     
   @i_ente                                   int          = null,
   @i_fecha                                  datetime     = null,
   @i_formato_fecha                          int          = 101 ,
   @i_nro_referencia_operador                varchar(25)  = null,
   @i_clave_pais                             varchar(2)   = null,
   @i_identificador_buro                     varchar(4)   = null,
   @i_clave_otorgante                        varchar(10)  = null,
   @i_clave_retorno_consumidor_principal     varchar(1)   = null,
   @i_clave_retorno_consumidor_secundario    varchar(1)   = null,
   @i_numero_control_consulta	             varchar(9)   = null )
as
declare
@w_error_number    int,
@w_sp_name         varchar(100),
@w_secuencial      int, 
@w_msg             varchar(255)
   
select @w_sp_name = 'sp_buro_encabezado'

if @i_fecha is null
   select @i_fecha = fp_fecha
   from cobis..ba_fecha_proceso

if @i_operacion='Q' begin

   select @w_secuencial = ib_secuencial
   from cob_credito..cr_interface_buro
   where ib_cliente = @i_ente
   and   ib_estado  = 'V'
   
   if @@rowcount = 0 begin
      select 
	  @w_error_number = 2108056 ,
	  @w_msg = 'No existe registro en el buro para el cliente.'
   end
   
   select 
   @i_ente ,
   be_nro_referencia_operador,
   be_clave_pais, 
   be_identificador_buro, 
   be_clave_otorgante, 
   be_clave_retorno_consumidor_principal, 
   be_clave_retorno_consumidor_secundario, 
   be_numero_control_consulta
   from cr_buro_encabezado
   where be_ib_secuencial = @w_secuencial


end --@i_operacion

if @i_operacion='I' begin
   
   select @w_secuencial = ib_secuencial
   from cob_credito..cr_interface_buro
   where ib_cliente = @i_ente
   and   ib_estado  = 'V'
   
   if @@rowcount = 0 begin
      select 
      @w_error_number = 2108056 ,
      @w_msg = 'No existe registro en buro para el cliente ingresado.'
   end

   INSERT INTO dbo.cr_buro_encabezado(
   be_ib_secuencial,
   be_nro_referencia_operador,
   be_clave_pais,
   be_identificador_buro,
   be_clave_otorgante,
   be_clave_retorno_consumidor_principal,
   be_clave_retorno_consumidor_secundario,
   be_numero_control_consulta)
   VALUES (
   @w_secuencial,
   @i_nro_referencia_operador,
   @i_clave_pais,
   @i_identificador_buro,
   @i_clave_otorgante,
   @i_clave_retorno_consumidor_principal,
   @i_clave_retorno_consumidor_secundario,
   @i_numero_control_consulta	)

    
   if @@error <> 0 
   begin
        set @w_error_number = 357043        
        goto ERROR
   end

end
   

return 0

ERROR:
EXEC cobis..sp_cerror
@t_from  = @w_sp_name,
@i_num   = @w_error_number

RETURN @w_error_number


go
