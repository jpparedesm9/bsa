/******************************************************************************/
/* Archivo:            valofcact.sp                                           */
/* Stored procedure:   sp_var_valida_ofc_activa                               */
/* Producto:           CARTERA                                                */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Valida si se activa la funcionalidad para envio de codigo de enrolamiento  */
/* para todas las oficinas                                                    */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        AUTOR            RAZON                                        */
/******************************************************************************/
/* 10-Ene-2020  Walther Toledo   Emision inicial                              */
/******************************************************************************/
use cob_cartera
go

IF OBJECT_ID ('sp_var_valida_ofc_activa') IS NOT NULL
	DROP PROCEDURE sp_var_valida_ofc_activa
GO

create proc sp_var_valida_ofc_activa (
   @s_ssn            int           = null,
   @s_ofi            smallint      = null,
   @s_user           login         = null,
   @s_date           datetime      = null,
   @s_srv            varchar(30)   = null,
   @s_term           descripcion   = null,
   @s_rol            smallint      = null,
   @s_lsrv           varchar(30)   = null,
   @s_sesn           int           = null,
   @s_org            char(1)       = null,
   @s_org_err        int           = null,
   @s_error          int           = null,
   @s_sev            tinyint       = null,
   @s_msg            descripcion   = null,
   @t_rty            char(1)       = null,
   @t_trn            int           = null,
   @t_debug          char(1)       = 'N',
   @t_file           varchar(14)   = null,
   @t_from           varchar(30)   = null,
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int,
   @i_id_asig_act  int,
   @i_id_empresa     int,
   @i_id_variable  smallint  --,
   -- @o_id_resultado   smallint out
)

as
declare
@w_sp_name           varchar(30),
@w_tramite           int,
@w_band_ofc_act      char(1),
@w_valor_nuevo    	varchar(255),
@w_valor_ant      	varchar(255),
@w_oficina           int

select @w_sp_name = 'sp_var_valida_ofc_activa'

select @w_tramite = convert(int,io_campo_3)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_band_ofc_act = 'N'

select @w_band_ofc_act = 'S'
from cobis..cl_parametro 
where pa_nemonico = 'ACTOFC' 
and pa_producto = 'CCA'
and pa_char = 'S'

-- Parametro en N, se valida las oficinas
if @w_band_ofc_act = 'N'
begin
   select @w_oficina = tr_oficina 
   from cob_credito..cr_tramite 
   where tr_tramite = @w_tramite
   
   select @w_band_ofc_act = 'S'
   from cobis..cl_tabla x inner join cobis..cl_catalogo y 
   on x.codigo = y.tabla and x.tabla = 'cl_ofc_activa_gen_tkn'
   and estado = 'V' and y.codigo = convert(char(10),@w_oficina) 
end

select @w_valor_nuevo = @w_band_ofc_act

if @w_valor_nuevo = 'S'
begin
   select @w_valor_nuevo  = 'SI'
end
else
begin
   select @w_valor_nuevo  = 'NO'
end


--insercion en estrucuturas de variables
if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
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
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
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

