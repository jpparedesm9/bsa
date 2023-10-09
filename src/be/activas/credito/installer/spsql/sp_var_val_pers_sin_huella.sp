/************************************************************************/
/*  Archivo:                sp_var_val_pers_sin_huella.sp               */
/*  Stored procedure:       sp_var_val_pers_sin_huella                  */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           ACH                                         */
/*  Fecha de Documentacion: 16-Junio-2021                               */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la AT&T       */
/*  Su uso no autorizado queda expresamente prohibido asi como cualquier*/
/*  autorizacion o agregado hecho por alguno de sus usuario sin el      */
/*  debido consentimiento por escrito de la Presidencia Ejecutiva de    */
/*  MACOSA o su representante                                           */
/************************************************************************/
/*                            PROPOSITO                                 */
/* Procedure tipo Variable. Retorna SI, si todos los clientes que tengan*/
/* huella tiene cargado el documento                                    */

/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR                     RAZON                      */
/*  16/06/2021    ACH     Emision Inicial, caso 155695                  */
/*  16/15/2022    ACH     #175319-cond no aprob. monto, defin tabla temp*/

/* **********************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_val_pers_sin_huella')
	drop proc sp_var_val_pers_sin_huella
go
--
CREATE PROC sp_var_val_pers_sin_huella (
   @s_ssn        int          = null,
   @s_ofi        smallint,
   @s_user       login,
   @s_date       datetime,
   @s_srv        varchar(30)  = null,
   @s_term	     descripcion  = null,
   @s_rol		 smallint     = null,
   @s_lsrv	     varchar(30)  = null,
   @s_sesn	     int 	      = null,
   @s_org		 char(1)      = NULL,
   @s_org_err    int 	      = null,
   @s_error      int 	      = null,
   @s_sev        tinyint      = null,
   @s_msg        descripcion  = null,
   @t_rty        char(1)      = null,
   @t_trn        int          = null,
   @t_debug      char(1)      = 'N',
   @t_file       varchar(14)  = null,
   @t_from       varchar(30)  = null,
   --variables
   @i_id_inst_proc int,    --codigo de instancia del proceso
   @i_id_inst_act  int,    
   @i_id_asig_act  int,
   @i_id_empresa   int, 
   @i_id_variable  smallint 
)
AS
DECLARE 
@w_sp_name       	varchar(32),
@w_tramite       	int,
@w_return        	INT,
---var variables	
@w_asig_actividad 	int,
@w_valor_ant      	varchar(255),
@w_valor_nuevo    	varchar(255) = 'SI',
@w_actividad      	catalogo,
@w_ente             int,
@w_cliente          int = 0,
@w_rfc              varchar(30),
@w_curp             varchar(64),
@w_toperacion       varchar(20),
@w_cadena_err       varchar(2000) = '',
@w_cadena_tmp       varchar(255)  = '',
@w_inicio           int = 0,
@w_len              int = 255,
@w_numero           int,
@w_fecha_nac        datetime,
@w_usuario          varchar(30),
@w_msg_err          varchar(90),
@w_linea            int = 1,
@w_tabla            int, 
@w_codigo           char(10)
       
create table #clientes(
   cliente      int,
   huella       char(1),
   doc_cargado  char(1),
   cumple       char(1)
)

select 
@w_sp_name    ='sp_var_val_pers_sin_huella',
@w_msg_err    = 'Verificar que los clientes con huella tengan cargado el documento correspondiente'

select 
@w_ente       = io_campo_1, --cliente/grupo/
@w_tramite    = io_campo_3,
@w_toperacion = io_campo_4
FROM cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0

if @w_toperacion = 'GRUPAL' begin
    insert #clientes
    select tg_cliente, 
           'N',
           'N',
		   'N'
    from cob_credito..cr_tramite_grupal	
    where tg_tramite = @w_tramite
	and tg_participa_ciclo = 'S'
	and tg_monto > 0
end else begin
   insert into #clientes  values ( @w_ente, 'N', 'N','N' )   
end

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_ind'
select @w_codigo = codigo from cobis..cl_catalogo where tabla = @w_tabla AND codigo = '009'--acta de nacimiento

update #clientes
set doc_cargado = dd_cargado
from cob_credito..cr_documento_digitalizado
where dd_cliente = cliente
and dd_tipo_doc = @w_codigo
and dd_inst_proceso = 0 
and dd_grupo = 0

update #clientes
set huella = eb_sin_huella_dactilar
from cobis..cl_ente_bio 
where eb_ente = cliente

update #clientes
set cumple = case when doc_cargado = huella then 'S'
		     else 'N' end

while 1 = 1 begin
   select top 1 @w_cliente = cliente
   from #clientes
   where cliente  > @w_cliente
   order by cliente asc
   
   if @@rowcount = 0 break
   
   if exists (SELECT 1 FROM #clientes where cumple = 'N' and cliente = @w_cliente)
   begin
       select @w_cadena_err = @w_cadena_err + '-' +convert(varchar, @w_cliente)
   end
end

if @w_cadena_err is not null and rtrim(ltrim(@w_cadena_err)) <> '' and len(@w_cadena_err) <> 0 begin
   select @w_valor_nuevo = 'NO'
end   

print 'resp:sp_var_val_pers_sin_huella:'+@w_valor_nuevo+'--Grupo:'+convert(varchar(30),@w_ente) +'--Tramite:'+convert(varchar(30),@w_tramite)

delete cob_workflow..wf_observaciones 
where ob_id_asig_act = @i_id_asig_act
and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
where ol_id_asig_act = @i_id_asig_act 
and ol_texto like '%'+@w_msg_err+'%')   

delete cob_workflow..wf_ob_lineas 
where ol_id_asig_act = @i_id_asig_act 
and ol_texto like '%'+@w_msg_err+'%'
    
if @w_cadena_err is not null and rtrim(ltrim(@w_cadena_err)) <> '' and len(@w_cadena_err) <> 0 begin

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

--insercion en estrucuturas de variables
if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
from cob_workflow..wf_variable_actual
where va_id_inst_proc = @i_id_inst_proc
and va_codigo_var     = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
   update cob_workflow..wf_variable_actual set 
   va_valor_actual       = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var     = @i_id_variable    
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


