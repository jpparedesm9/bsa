/************************************************************************/
/*  Archivo:                sp_var_porc_parentesco.sp                   */
/*  Stored procedure:       sp_var_porc_parentesco                      */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Milton Custode                              */
/*  Fecha de Documentacion: 08/May/2017                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA',representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/*	Procedure tipo Variable, Retorna parentesco familiar entre los       */
/* los integrantes del grupo                                            */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA           AUTOR           RAZON                               */
/*  08/Mayo/2017    M. Custode      Emision Inicial                     */
/*  08/Jul/2017     P. Ortiz        Corrección de Errores de SP         */
/*  29/Oct/2020     S. Rojas        Mejoras                             */
/* **********************************************************************/

use cob_credito
go
if object_id('sp_var_porc_parentesco') is not null
   drop procedure sp_var_porc_parentesco
go
create proc sp_var_porc_parentesco(
@s_ssn             int            = null,
@s_ofi             smallint       = null,
@s_user            login          = null,
@s_date            datetime       = null,
@s_srv             varchar(30)    = null,
@s_term            descripcion    = null,
@s_rol             smallint       = null,
@s_lsrv            varchar(30)    = null,
@s_sesn            int            = null,
@s_org             char(1)        = null,
@s_org_err         int            = null,
@s_error           int            = null,
@s_sev             tinyint        = null,
@s_msg             descripcion    = null,
@t_rty             char(1)        = null,
@t_trn             int            = null,
@t_debug           char(1)        = 'N',
@t_file            varchar(14)    = null,
@t_from            varchar(30)    = null,
--variables
@i_id_inst_proc    int,    --codigo de instancia del proceso
@i_id_inst_act     int,    
@i_id_asig_act     int,
@i_id_empresa      int, 
@i_id_variable     smallint 
)
as
declare 
@w_sp_name          varchar(32),
@w_tramite          int,
@w_return           int,
@w_grupo            int,
@w_sum_parentesco   int,
@w_num_integrantes  int,
@w_porcentaje       int,
@w_valor_ant        varchar(255),
@w_valor_nuevo      varchar(255),
@w_actividad        catalogo  
       

select @w_sp_name='sp_var_porc_parentesco'

select @w_tramite = convert(int,io_campo_3)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

select distinct @w_grupo = tg_grupo from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite and tg_monto > 0
select distinct @w_num_integrantes = count(tg_cliente) from cob_credito..cr_tramite_grupal where tg_tramite = @w_tramite and tg_monto > 0

select @w_sum_parentesco = count(DISTINCT in_ente_i)
from cobis..cl_tabla t, cobis..cl_catalogo c, cobis..cl_instancia
where t.codigo = c.tabla
and t.tabla  in ('cl_parentesco_1er','cl_parentesco_2er')
and convert(smallint,c.codigo) = in_relacion
and in_ente_i in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)
AND in_ente_d in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @w_grupo)

select @w_num_integrantes = isnull(@w_num_integrantes,0)

if @w_num_integrantes = 0 return 0

select @w_sum_parentesco = isnull(@w_sum_parentesco,0)

select @w_porcentaje = (@w_sum_parentesco * 100)/@w_num_integrantes

select @w_valor_nuevo = convert(varchar(20),@w_porcentaje)


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
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
begin
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
          @t_from = @w_sp_name,
          @i_num = 2101002
    return 1
    end 
end

return 0                                                                                                                                                                                               
go

