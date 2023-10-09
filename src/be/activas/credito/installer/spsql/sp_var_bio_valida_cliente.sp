/************************************************************************/
/*  Archivo:                sp_var_bio_valida_cliente.sp                */
/*  Stored procedure:       sp_var_bio_valida_cliente                   */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Sonia Rojas                                 */
/*  Fecha de Documentacion: 09/Ene/2019                                 */
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
/*                        PROPOSITO                                     */
/* Procedure tipo Variable, Retorna SI cuando el cliente no tiene       */
/* vigente que debe cancelarse                                          */
/************************************************************************/
/*                     MODIFICACIONES                                   */
/*  FECHA       AUTOR           RAZON                                   */
/*  14/11/2020  Sonia Rojas    Emision Inicial                          */
/*  19/05/2022  ACH            #175319 - que tome los rechazado por doc */
/* **********************************************************************/
USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_var_bio_valida_cliente')
	drop proc sp_var_bio_valida_cliente
GO

CREATE procedure sp_var_bio_valida_cliente
(@s_ssn               int         = null,
 @s_ofi               smallint,
 @s_user              login,
 @s_date              datetime,
 @s_srv		          varchar(30) = null,
 @s_term	          descripcion = null,
 @s_rol		          smallint    = null,
 @s_lsrv	          varchar(30) = null,
 @s_sesn	          int         = null,
 @s_org		          char(1)     = NULL,
 @s_org_err           int         = null,
 @s_error             int         = null,
 @s_sev               tinyint     = null,
 @s_msg               descripcion = null,
 @t_rty               char(1)     = null,
 @t_trn               int         = null,
 @t_debug             char(1)     = 'N',
 @t_file              varchar(14) = null,
 @t_from              varchar(30) = null,
 --variables
 @i_id_inst_proc      int,    --codigo de instancia del proceso
 @i_id_inst_act       int,    
 @i_id_asig_act       int,
 @i_id_empresa        int, 
 @i_id_variable       smallint 
 )
as
declare
@w_sp_name       	varchar(32),
@w_tramite       	int,
@w_return        	int,
@w_valor_ant      	varchar(255),
@w_valor_nuevo    	varchar(255),
@w_secuencial       int = null,
@w_cliente          int       

select @w_sp_name='sp_var_bio_valida_cliente'

select 
@w_cliente = convert(int,io_campo_1)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_cliente = isnull(@w_cliente,0)

if @w_cliente = 0 return 0

select @w_valor_nuevo = 'SI'

select top 1 @w_secuencial = rb_secuencia
from   cobis..cl_respuesta_bio 
where  rb_inst_proc  = @i_id_inst_proc 
and    rb_ente       = @w_cliente 
order by rb_secuencia desc

--if  @@rowcount = 0 or @w_secuencial is null or exists (select 1 from cobis..cl_respuesta_bio where rb_secuencia = @w_secuencial and rb_resultado IN ('RECHAZADO', 'PENDIENTE'))
if  @@rowcount = 0 or @w_secuencial is null or exists (select 1 from cobis..cl_respuesta_bio where rb_secuencia = @w_secuencial and rb_resultado IN ('PENDIENTE')) 
                   or exists (select 1 from cobis..cl_respuesta_bio where rb_secuencia = @w_secuencial and rb_resultado in ('RECHAZADO') and (rb_aprobado_por_doc not in ('S') OR rb_aprobado_por_doc is null))
begin
   select @w_valor_nuevo = 'NO'
end
    
-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
from   cob_workflow..wf_variable_actual
where  va_id_inst_proc = @i_id_inst_proc
and    va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
   update cob_workflow..wf_variable_actual set 
   va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
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
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 

end

return 0
go
