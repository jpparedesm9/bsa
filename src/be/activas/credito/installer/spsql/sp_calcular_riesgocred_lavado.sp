/*************************************************************************/  
/*   Archivo:              sp_calcular_riesgocred_lavado.sp	             */
/*   Stored procedure:     sp_calcular_riesgocred_lavado                 */
/*   Base de datos:        cob_credito                                   */
/*   Producto:             Crédito                                       */
/*   Disenado por:         Sonia Rojas                                   */
/*   Fecha de escritura:   Enero 2019                                    */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   Genera reporte regulatorio baxico desde la sarta 22                 */
/*                                                                       */
/*       Parametros de Entrada                                           */
/*			Fecha de proceso                                             */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    14/Enero/2019          SRO               Emision inicial           */
/*                                                                       */
/*************************************************************************/
USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_calcular_riesgocred_lavado') IS NOT NULL
	DROP PROCEDURE dbo.sp_calcular_riesgocred_lavado
GO


create procedure sp_calcular_riesgocred_lavado (
   @s_ssn          int             = null,
   @s_ofi          smallint        = null,
   @s_user         login           = null,
   @s_date         datetime        = null,
   @s_srv          varchar(30)     = null,
   @s_term	       descripcion     = null,
   @s_rol          smallint        = null,
   @s_lsrv	       varchar(30)     = null,
   @s_sesn	       int 	           = null,
   @s_org          char(1)         = null,
   @s_org_err      int 	           = null,
   @s_error        int 	           = null,
   @s_sev          tinyint         = null,
   @s_msg          descripcion     = null,
   @t_rty          char(1)         = null,
   @t_trn          int             = null,
   @t_debug        char(1)         = 'N',
   @t_file         varchar(14)     = null,
   @t_from         varchar(30)     = null,
   --variables
   @i_id_inst_proc  int,    --codigo de instancia del proceso
   @i_id_inst_act   int,    
   @i_id_empresa    int, 
   @o_id_resultado  smallint  out
)as

declare 
@w_riesgo_aceptable       varchar(10),
@w_sp_name                varchar(50),
@w_error                  int,
@w_msg                    varchar(255),
@w_fecha_proceso          datetime,
@w_ente                   int,
@w_tramite                int

select @w_sp_name = 'sp_calcular_riesgocred_lavado'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select 
@w_ente               = io_campo_1,
@w_tramite            = isnull(io_campo_3,0)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @@rowcount = 0 or @w_ente is null begin
   select @w_error = 2108070
   goto ERROR
end

if @w_tramite = 0 return 0 

exec @w_error       = sp_regla_matriz_riesgo
@i_operacion        = 'I',
@i_ente             = @w_ente

if @w_error <> 0 begin
   select @w_msg = 'ERROR AL EJECUTAR LA MATRIZ DE RIEGSO' 
   goto ERROR
end 


exec @w_error       = cob_cartera..sp_ejecutar_regla
@s_ssn              = @s_ssn,
@s_ofi              = @s_ofi,
@s_user             = @s_user,
@s_date             = @w_fecha_proceso,
@s_srv              = @s_srv,
@s_term             = @s_term,
@s_rol              = @s_rol,
@s_lsrv             = @s_lsrv,
@s_sesn             =  @s_ssn,
@i_regla            = 'LCRRMAX',    
@i_id_inst_proc     = @i_id_inst_proc,
@o_resultado1       = @w_riesgo_aceptable out  

if @w_error <> 0 begin
   select @w_msg = 'ERROR AL EJECUTAR REGLA RIESGO MAXIMO LCR' 
   goto ERROR
end 


if @w_riesgo_aceptable = 'SI' begin 
   --Cliente Colectivo
   if exists (select 1 from cob_cartera..ca_operacion where op_toperacion = 'REVOLVENTE' and op_cliente = @w_ente) begin
       select @o_id_resultado = 5
	end
	else begin
	   select @o_id_resultado = 1
	end
end else 
   select @o_id_resultado = 3
   

return 0

ERROR:
exec cobis..sp_cerror 
@t_from  = @w_sp_name, 
@i_num   = @w_error, 
@i_msg   = @w_msg

return @w_error

go
