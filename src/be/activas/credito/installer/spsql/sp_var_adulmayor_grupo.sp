/************************************************************************/
/*  Archivo:                sp_var_adulmayor_grupo.sp                   */
/*  Stored procedure:       sp_var_adulmayor_grupo                      */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           F.Sanmiguel                                 */
/*  Fecha de Documentacion: 10/Nov/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure tipo Variable, retorna el promedio de adultos mayores de un*/
/* grupo en base a las edades y el total de personas del grupo          */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  10/Nov/2019 F.Sanmiguel             Emision Inicial                 */
/* **********************************************************************/
USE cob_credito;
GO

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid = u.uid AND o.name = 'sp_var_adulmayor_grupo' AND u.name = 'dbo' AND o.type = 'P')
    DROP PROCEDURE sp_var_adulmayor_grupo;
GO

CREATE PROCEDURE [dbo].[sp_var_adulmayor_grupo](
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int = null,
	@s_user             varchar(30) = null,
	@s_sesn             int = null,
	@s_term             varchar(30) = null,
	@s_date             datetime = null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint = null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty              char(1)     = null,
	@t_trn				int = null,
	@t_show_version     BIT = 0,
    @i_id_inst_proc    	int,    --codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_grupo				int,
		@w_resultado			int,
		@w_asig_actividad 		int,	
        @w_total                float,
        @w_max_setenta          float,	
		@w_valor_ante      		varchar(255),
		@w_valor_nuevo    		varchar(255),
		@w_param_edad			int
		
select @w_sp_name = 'sp_var_adultos_mayores_grupo'

select @w_grupo 		= io_campo_1 
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc 	= @i_id_inst_proc

if @w_grupo is not null

if @t_debug = 'S'
begin
	print '@w_grupo: ' + convert(varchar, @w_grupo )	
end

select @w_param_edad = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EDADMA'


    select @w_max_setenta = count(*), 
            @w_total = (select count(*) from  cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V' ) from
             (select  FLOOR(DATEDIFF(DAY, p_fecha_nac, getDate()) / 365.25) as age 
              from cobis..cl_ente where en_ente in (select cg_ente from  cobis..cl_cliente_grupo where cg_grupo = @w_grupo and cg_estado = 'V' )
              and FLOOR(DATEDIFF(DAY, p_fecha_nac, getDate()) / 365.25) >=@w_param_edad) as q1

    select @w_resultado = round ((@w_max_setenta /@w_total )*100, 0)


if @w_resultado is null
begin
   select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
   exec   @w_error  = cobis..sp_cerror
          @t_debug  = 'N',
          @t_file   = '',
          @t_from   = @w_sp_name,
          @i_num    = @w_error
   return @w_error
end


select @w_valor_nuevo = convert(varchar,@w_resultado)

if @t_debug = 'S'
begin
	print '@w_valor_nuevo: ' + convert(varchar, @w_valor_nuevo )	
end

-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
select @w_valor_ante    = isnull(va_valor_actual, '')
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