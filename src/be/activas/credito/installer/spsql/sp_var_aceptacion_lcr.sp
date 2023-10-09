/* ********************************************************************* */
/*      Archivo:                sp_var_aceptacion_lcr.sp                 */
/*      Stored procedure:       sp_var_aceptacion_lcr                           */
/*      Base de datos:          cob_credito                                  */
/*      Producto:               Credito                                  */
/*      Disenado por:           Alexander Inca                           */
/*      Fecha de escritura:     30-01-2019                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Generar XML para cuestionarios GRUPAL e INDIVIDUAL               */
/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      30/01/2019      AINCA                Version Inicial             */

/* ********************************************************************* */

USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_var_aceptacion_lcr') IS NOT NULL
    DROP PROCEDURE dbo.sp_var_aceptacion_lcr
GO

CREATE proc sp_var_aceptacion_lcr (
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int,
	@s_user             varchar(30),
	@s_sesn             int,
	@s_term             varchar(30),
	@s_date             datetime,
	@s_srv              varchar(30),
	@s_lsrv             varchar(30),
	@s_ofi              smallint,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty              char(1)     = null,
	@t_trn				int 		= null,
	@t_show_version     bit 		= 0,
    @i_id_inst_proc    	int,    --codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare	@w_sp_name 			varchar(64),
		@w_error			int,
		@w_valor_ant      	varchar(255),
		@w_valor_nuevo    	varchar(255),
		@w_acepta_lcr       varchar(5),
		@w_id_inst_act      int,
		@w_asig_act         int
		
select @w_sp_name = 'sp_var_aceptacion_lcr'

-- se obtiene la respuesta por la instacia de proceso y la instancia de actividad

select top 1 @w_id_inst_act = ia_id_inst_act
from cob_workflow..wf_inst_actividad 
where ia_id_inst_proc = @i_id_inst_proc
and ia_tipo_dest is null
order by ia_id_inst_act desc 

select @w_acepta_lcr = dc_lcr_resp_estatus 
from cob_credito..cr_resp_documents_lcr
where dc_lcr_inst_process = @i_id_inst_proc
and   dc_lcr_inst_actividad = @w_id_inst_act
and   dc_lcr_fecha_document = (select max(dc_lcr_fecha_document) 
                              from cob_credito..cr_resp_documents_lcr
                              where dc_lcr_inst_process = @i_id_inst_proc
                              and   dc_lcr_inst_actividad = @w_id_inst_act)

select @w_error = 0

if ((@w_acepta_lcr = 'SI') or (@w_acepta_lcr is null))
   select @w_valor_nuevo = 'SI'
else
   select @w_valor_nuevo = 'NO'


-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
	update cob_workflow..wf_variable_actual
	   set va_valor_actual = @w_valor_nuevo 
	 where va_id_inst_proc = @i_id_inst_proc
	   and va_codigo_var   = @i_id_variable
	
end
else
begin
	insert into cob_workflow..wf_variable_actual
			(va_id_inst_proc, va_codigo_var, va_valor_actual)
	values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end


return 0