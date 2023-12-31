use cob_credito
go
IF OBJECT_ID ('dbo.sp_var_riesgo_individual_ext') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_riesgo_individual_ext
GO
/************************************************************************/
/*  Archivo:                sp_var_riesgo_individual_ext.sp         */
/*  Stored procedure:       sp_var_riesgo_individual_ext            */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*Procedure  tipo  Variable,  Retorna tipo de mercado del cliente.      */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR               RAZON                               */
/*  08/11/18    ATO                 Emision Inicial                     */
/* **********************************************************************/

CREATE PROC sp_var_riesgo_individual_ext(
   @s_ssn        int         = null,
   @s_ofi        smallint    = null,
   @s_user       login       = null,
   @s_date       datetime    = null,
   @s_srv		 varchar(30) = null,
   @s_term	     descripcion = null,
   @s_rol		 smallint    = null,
   @s_lsrv	     varchar(30) = null,
   @s_sesn	     int 	     = null,
   @s_org		 char(1)     = NULL,
   @s_org_err    int 	     = null,
   @s_error      int 	     = null,
   @s_sev        tinyint     = null,
   @s_msg        descripcion = null,
   @t_rty        char(1)     = null,
   @t_trn        int         = null,
   @t_debug      char(1)     = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   --variables
   @i_id_inst_proc    int,    --codigo de instancia del proceso
   @i_id_inst_act     int,    
   @i_id_asig_act     int,
   @i_id_empresa      int, 
   @i_id_variable     smallint )
AS
DECLARE 
 	@w_sp_name      varchar(32),
	@w_cliente   	int,
	@w_nivel_riesgo char(1),
	@w_return       int,
    ---var variables
    @w_valor_ant      varchar(255),
    @w_valor_nuevo    varchar(255)

SELECT @w_sp_name='sp_var_riesgo_individual_ext'


SELECT @w_cliente = convert(int,io_campo_1)
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_cliente = isnull(@w_cliente,0)

if @w_cliente = 0 return 0

--Riesgo Individual Externo del Cliente
SELECT @w_valor_nuevo = isnull(ea_nivel_riesgo_cg,'C')
from cobis..cl_ente_aux
where ea_ente = @w_cliente


--print 'Cliente: ' + convert(varchar,@w_cliente) + ', Riesgo Individual Externo: ' + @w_valor_nuevo 

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

if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())   
	if @@error > 0
	begin
          --registro ya existe			
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end             
END

return 0

go
