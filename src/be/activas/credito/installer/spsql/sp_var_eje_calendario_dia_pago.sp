/************************************************************************/
/*  Archivo:                sp_var_eje_calendario_dia_pago.sp           */
/*  Stored procedure:       sp_var_eje_calendario_dia_pago              */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 15/Nov/2022                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                           PROPOSITO                                  */
/* Procedure tipo Variable, Retorna 'SI' cuando cumple la regla caso    */
/* contrario NO                                                         */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA        AUTOR                   RAZON                          */
/*  15/11/2022    ACH     Emision Inicial - REQ#194284 Dia de Pago      */
/* **********************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_eje_calendario_dia_pago')
	drop proc sp_var_eje_calendario_dia_pago
go

create procedure sp_var_eje_calendario_dia_pago
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
@w_sp_name       	varchar(256),
@w_return        	int,
@w_valor_ant      	varchar(255),
@w_valor_nuevo    	varchar(255),
@w_error            int,
@w_respuesta        varchar(10),
@w_msg_err          varchar(256),
@w_linea            int = 1,
@w_numero           int,
@w_cadena_err       varchar(2000) = '',
@w_cadena_tmp       varchar(255)  = '',
@w_usuario          varchar(30),
@w_len              int = 255,
@w_inicio           int = 0

 
select @w_sp_name = 'sp_var_eje_calendario_dia_pago'
select @w_msg_err    = 'Modificar el día de pago, solicita a tu gerente modifique el cambio de dia de pago. Recuerda que esto impacta en tu documentacion'

exec sp_eje_calendario_dia_pago
     @i_id_inst_proc = @i_id_inst_proc,
     @o_respuesta    = @w_respuesta out

select @w_valor_nuevo = @w_respuesta

print 'salida sp_var_eje_calendario_dia_pago: ' + @w_valor_nuevo + '--i_id_asig_act: ' + convert(varchar, @i_id_asig_act)+ '--i_id_variable: ' + 
convert(varchar, @i_id_variable)

--Para observacion
delete cob_workflow..wf_observaciones 
where ob_id_asig_act = @i_id_asig_act
and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
where ol_id_asig_act = @i_id_asig_act 
and ol_texto like '%'+@w_msg_err+'%')   

delete cob_workflow..wf_ob_lineas 
where ol_id_asig_act = @i_id_asig_act 
and ol_texto like '%'+@w_msg_err+'%'

if (@w_valor_nuevo = 'NO') begin 
    select @w_cadena_err = concat (@w_msg_err, @w_cadena_err)
    select @w_valor_nuevo = 'NO'
    select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
    select @w_numero = max(ob_numero)+ 1 from cob_workflow..wf_observaciones where ob_id_asig_act = @i_id_asig_act 
    select @w_numero = isnull( @w_numero, 0 ) + 1
          
    insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
    values (@i_id_asig_act, @w_numero, getdate(), 4, 1, 'a', @w_usuario)
    
    while 1 = 1 begin
       select @w_cadena_tmp = substring(@w_cadena_err, @w_inicio, @w_len)
      
       if @w_cadena_tmp is null OR len(@w_cadena_tmp) = 0 break
      
       insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
       values (@i_id_asig_act, @w_numero, @w_linea, @w_cadena_err)
       select  @w_linea = @w_linea + 1
      
       select @w_inicio = @w_inicio  + @w_len  
       
    end
end

--valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
from   cob_workflow..wf_variable_actual
where  va_id_inst_proc = @i_id_inst_proc
and    va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
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
