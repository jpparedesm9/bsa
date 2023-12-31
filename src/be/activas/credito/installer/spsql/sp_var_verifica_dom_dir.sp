/************************************************************************/
/*  Archivo:                sp_var_verifica_dom_dir.sp                  */
/*  Stored procedure:       sp_var_verifica_dom_dir                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 29/Jun/2017                                 */
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
/* Procedure tipo Variable, Retorna SI si al menos un integrante del    */
/* grupo tiene el cuestionario desactualizado                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR                   RAZON                           */
/*  29/Jun/2017 P. Ortiz             Emision Inicial                    */
/*  03/Jul/2017 P. Ortiz             Modificacion para flujo Individual */
/*  20/Sep/2017 P. Ortiz             Agregar personas con mala califcac */
/*  28/Feb/2018 Ma. Jose Taco        Agregar condicion para validar los */
/*                                   miembros que participan en la solic*/
/* **********************************************************************/
USE cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_verifica_dom_dir')
	drop proc sp_var_verifica_dom_dir
go


create proc sp_var_verifica_dom_dir(
   @s_ssn      int         = null,
   @s_ofi      smallint    = null,
   @s_user     login       = null,
   @s_date     datetime    = null,
   @s_srv		varchar(30) = null,
   @s_term	   descripcion = null,
   @s_rol		smallint    = null,
   @s_lsrv	   varchar(30) = null,
   @s_sesn	   int 	      = null,
   @s_org		char(1)     = null,
   @s_org_err  int 	      = null,
   @s_error    int 	      = null,
   @s_sev      tinyint     = null,
   @s_msg      descripcion = null,
   @t_rty      char(1)     = null,
   @t_trn      int         = null,
   @t_debug    char(1)     = 'N',
   @t_file     varchar(14) = null,
   @t_from     varchar(30) = null,
   --variables
   @i_id_inst_proc int,    --codigo de instancia del proceso
   @i_id_inst_act  int,    
   @i_id_asig_act  int,
   @i_id_empresa   int, 
   @i_id_variable  smallint 
)
as
declare 
@w_sp_name       	varchar(32),
@w_tramite       	int,
@w_return        	int,
@w_fecha_proceso   datetime,
---var variables	
@w_asig_actividad 	int,
@w_valor_ant      	varchar(255),
@w_valor_nuevo    	varchar(255),
@w_actividad      	catalogo,
@w_grupo			   int,
@w_ente            int,
@w_aval            int,
@w_fecha			   datetime,
@w_fecha_dif		   datetime,
@w_ttramite        varchar(255),
@w_resultado       int,
@w_meses           int,
@w_fecha_min       datetime


select @w_sp_name='sp_var_verifica_dom_dir'
print @w_sp_name
select @w_grupo    = convert(int,io_campo_1),
	   @w_tramite  = convert(int,io_campo_3),
	   @w_ttramite = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

print '@w_grupo:'+convert(varchar,@w_grupo)
print '@w_tramite:'+convert(varchar,@w_tramite)

select @w_tramite = isnull(@w_tramite,0)

if @w_tramite = 0 return 0
    
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_meses = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MESVCC'
select @w_fecha_min = dateadd(mm, -@w_meses, @w_fecha_proceso)

if @w_ttramite = 'GRUPAL'
begin
  
  	select @w_ente = 0
	while 1 = 1
	begin
	   
	   select TOP 1 @w_ente = cg_ente 
	   from cobis..cl_cliente_grupo, 
	        cob_credito..cr_tramite_grupal
	   where cg_grupo = @w_grupo
	   and cg_grupo = tg_grupo
	   and cg_ente = tg_cliente
	   and cg_ente > @w_ente
	   and cg_estado <> 'C'
	   and tg_participa_ciclo = 'S'
	   order by cg_ente
	   
	   if @@rowcount = 0
	      break
	   
	   select @w_fecha     = vd_fecha,
	          @w_tramite   = vd_tramite,
	          @w_resultado = vd_resultado
	   from cr_verifica_datos 
	   where vd_cliente = @w_ente
	   and vd_tramite = (select max(vd_tramite) from cr_verifica_datos where vd_cliente = @w_ente) 
	   group by vd_fecha, vd_tramite, vd_resultado
	   
	   if (@w_fecha is null or @@rowcount = 0)
	   begin
	      select @w_valor_nuevo  = 'NO'
	      break
	   end	   
	   else
	   begin
	      if @w_fecha <= @w_fecha_min
	      begin
	         select @w_valor_nuevo  = 'NO'
	         break
	      end
	      else
	      begin
	         select @w_valor_nuevo  = 'SI'
		      select @w_fecha = null
		      select @w_fecha_dif = null
	      end	   
	        
	      if @w_resultado < (select pa_tinyint from cobis..cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'RVDGR')
	      begin
	         select @w_valor_nuevo  = 'NO'
	         break
	      end
	   end	   
	end
end
else
begin
	select @w_ente = @w_grupo
	
	declare @deudores as table(
	   ente  int not null
	)
	
	insert into @deudores values (@w_ente)		
	
	/* Obtener aval */
	PRINT @w_ttramite
	if @w_ttramite <> 'REVOLVENTE' begin
	   select @w_aval   = tr_alianza 
	   from cob_credito..cr_tramite 
	   where tr_tramite = @w_tramite	
	   
	   insert into @deudores values (@w_aval)
	end
	
	select @w_ente = 0
	while 1 = 1
	begin
	   select top 1 @w_ente = ente
	   from @deudores
	   where ente > @w_ente
	   order by ente asc
	   
	   if @@rowcount = 0 break
	   
	   select @w_fecha		= vd_fecha,
       @w_tramite	= vd_tramite,
       @w_resultado = vd_resultado
       from cr_verifica_datos, @deudores
       where vd_cliente = @w_ente
       and vd_tramite = (select max(vd_tramite) from cr_verifica_datos where vd_cliente = @w_ente)
       group by vd_fecha, vd_tramite, vd_resultado
   	
      if (@w_fecha is null or @@rowcount = 0)
   	  begin
   	     select @w_valor_nuevo  = 'NO'
   	     break
   	  end
   	  else
   	  begin
   	   if @w_fecha <= @w_fecha_min
   	   begin
   	      select @w_valor_nuevo  = 'NO'
   	      break
   	   end
   	   else
   	   begin
   	      select @w_valor_nuevo  = 'SI'
   	      select @w_fecha = null
   	      select @w_fecha_dif = null
   	   end
   	end
	end
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
          @t_from = @t_from,
          @i_num = 2101002
    return 1
	end 

end

return 0
go