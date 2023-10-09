/************************************************************************/
/*  Archivo:                sp_var_aplica_cuestionario.sp               */
/*  Stored procedure:       sp_var_aplica_cuestionario                  */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           JRO                                         */
/*  Fecha de Documentacion: 23/Feb/2023                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/* Procedure tipo Variable retorna SI, si se cumple con la regla del    */
/* caso#200142 APLCUES. Variable tambiEn usada para la regla            */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA          AUTOR                   RAZON                        */
/************************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_aplica_cuestionario')
   drop proc sp_var_aplica_cuestionario
go

create proc sp_var_aplica_cuestionario(
    @s_ssn     int         = null,
    @s_ofi     smallint    = null,
    @s_user    login       = null,
    @s_date    datetime    = null,
    @s_srv     varchar(30) = null,
    @s_term    descripcion = null,
    @s_rol     smallint    = null,
    @s_lsrv    varchar(30) = null,
    @s_sesn    int         = null,
    @s_org     char(1)     = null,
    @s_org_err int         = null,
    @s_error   int         = null,
    @s_sev     tinyint     = null,
    @s_msg     descripcion = null,
    @t_rty     char(1)     = null,
    @t_trn     int         = null,
    @t_debug   char(1)     = 'N',
    @t_file    varchar(14) = null,
    @t_from    varchar(30) = null,
    --variables
    @i_id_inst_proc int, --codigo de instancia del proceso
    @i_id_inst_act  int,
    @i_id_asig_act  int,
    @i_id_empresa   int,
    @i_id_variable  smallint
)
as
declare
@w_sp_name              varchar(32),
@w_asig_actividad       int,
@w_valor_ant            varchar(255),
@w_valor_ant_rol        varchar(255),
@w_mensaje              varchar(255),
@w_return               int,
@w_fecha_proceso        datetime,
@w_tramite              int,
@w_max_orden            int,
@w_evalua_cuestionario  char(2),
@w_tproducto            varchar(255),
@w_valor_nuevo          varchar(255),
@w_valor_nuevo_rol      varchar(255),
@w_op_anterior          varchar(24),
@w_cliente              int,
@w_orden_rol            int,
@w_id_variable_rol      int,
@w_param_val_resp_min   int,
@w_tGrupal              varchar(256),
@w_tRenovacion          varchar(256),
@w_tIndividual          varchar(256),
@w_cuest_regist         int,
@w_cuest_fin            int

select @w_sp_name = 'sp_var_aplica_cuestionario'
print @w_sp_name

select @w_tramite  = convert(int, io_campo_3),
       @w_tproducto = io_campo_4
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite, 0)
if @w_tramite = 0 return 0

select @w_evalua_cuestionario = 'SI'
select @w_tIndividual = 'INDIVIDUAL',
       @w_tGrupal = 'GRUPAL',
	   @w_tRenovacion = 'RENOVACION'
	   
select @w_op_anterior = op_anterior
  from cob_cartera..ca_operacion
 where op_tramite = @w_tramite

if (@w_op_anterior is not null) begin
    select @w_tproducto = @w_tRenovacion
end

--TABLA PARA ENLISTAR LOS CLIENTES A EVALUAR
create table #clientes_evaluar(
    integrante int,
	tramite    int
)

--LISTADO de CLIENTES A EVALUAR
if (@w_tproducto = @w_tGrupal or @w_tproducto = @w_tRenovacion) begin
    insert into #clientes_evaluar
	select tg_cliente,
	       tg_tramite
      from cob_credito..cr_tramite_grupal 
     where tg_tramite = @w_tramite 
       and tg_monto > 0
       and tg_participa_ciclo = 'S'
end else if (@w_tproducto = @w_tIndividual) begin
    --cliente
	insert into #clientes_evaluar
    select op_cliente,
	       @w_tramite
      from cob_cartera..ca_operacion
     where op_tramite = @w_tramite

    --aval
    insert into #clientes_evaluar
    select tr_alianza,
	       @w_tramite
	from cob_credito..cr_tramite 
	where tr_tramite = @w_tramite
end
	
--1ra vez
if not exists (select 1 from cr_ej_regla_aplica_cuest where er_id_inst_proc = @i_id_inst_proc) begin
    print 'Primera vez - instancia proceso: ' + convert(varchar, @i_id_inst_proc)
	
	insert into cr_ej_regla_aplica_cuest
         ( er_id_inst_proc,     er_tramite,       er_cliente,        er_tproducto,      er_aplica,     er_orden,   er_login,  er_rol_w,  er_nemonico_regla,  er_fecha_evalua,  
		   er_valores_reglas,   er_in_etapa,      er_est_en_cred)
    select @i_id_inst_proc,     @w_tramite,       integrante,        @w_tproducto,      'N',           null,       null,      null,      null,               null,            
           null,                'N',              'V'
    from #clientes_evaluar

end else begin --2da vez o mAs
    print 'Ya existe - instancia proceso: ' + convert(varchar, @i_id_inst_proc)
	
	--Ingresar o actualizar registros de los integrantes/clientes en el trAmite
    select @w_cliente = 0
	while 1=1 begin -- inicio while
        select @w_cliente  = integrante,
		       @w_tramite  = tramite
        from #clientes_evaluar
		where integrante > @w_cliente
		order by integrante desc
		
        if @@rowcount = 0
           break
		
		--Cliente nuevo en el trAmite
		if not exists (select 1 from cr_ej_regla_aplica_cuest where er_id_inst_proc = @i_id_inst_proc and er_cliente = @w_cliente) begin
	        print 'Nuevo cliente: ' + convert(varchar, @w_cliente) + '-->>En instancia proceso: ' + convert(varchar, @i_id_inst_proc)
			insert into cr_ej_regla_aplica_cuest
                   ( er_id_inst_proc,     er_tramite,        er_cliente,        er_tproducto,       er_aplica,        er_orden,  er_login,  er_rol_w,  er_nemonico_regla,  er_fecha_evalua,  
				     er_valores_reglas,   er_in_etapa,       er_est_en_cred)
            values ( @i_id_inst_proc,     @w_tramite,        @w_cliente,        @w_tproducto,       'N',              null,      null,      null,      null,               null,             
			         null,                'N',               'V'   )
		end		
		--Si hay un cliente que ya no esta en el crEdito lo eliminamos
		else if not exists(select 1 from cr_ej_regla_aplica_cuest, #clientes_evaluar where er_id_inst_proc = @i_id_inst_proc and er_cliente = integrante and integrante = @w_cliente) begin
		    print 'Cliente ' + convert(varchar, @w_cliente) + '-->>Salio de instancia proceso: ' + convert(varchar, @i_id_inst_proc)
			update cr_ej_regla_aplica_cuest
			set er_est_en_cred = 'E'
			where er_id_inst_proc =  @i_id_inst_proc
			and er_cliente = @w_cliente
		end
	end -- fin while	
end

if not exists(select 1 from cr_ej_regla_aplica_cuest where er_id_inst_proc = @i_id_inst_proc) begin
    print 'error, no existe ni un registros para el proceso: ' + convert(varchar,  @i_id_inst_proc)
	select @w_evalua_cuestionario = ''
	return 1
end

--EJECUCION DE REGLAS
exec @w_return = sp_eje_reglas_cuestionario
@i_id_inst_proc	= @i_id_inst_proc,
@i_id_inst_act 	= @i_id_inst_act,
@i_id_asig_act 	= @i_id_asig_act,
@i_id_empresa  	= @i_id_empresa,
@i_id_variable 	= @i_id_variable 

if (@w_return != 0) begin
    print 'error, problema con la regla en el proceso: ' + convert(varchar,  @i_id_inst_proc)
	select @w_evalua_cuestionario = ''
	return 1
end
    
declare @w_num_reg_t int, @w_num_reg_n int

select @w_num_reg_t = count(1) from cob_credito..cr_ej_regla_aplica_cuest 
where er_id_inst_proc = @i_id_inst_proc
and er_est_en_cred = 'V'

print 'Resitros totales para el proceso: ' + convert(varchar, @i_id_inst_proc) + '-->>@w_num_reg_t' + convert(varchar, @w_num_reg_t)
	
select @w_num_reg_n = count(1) from cob_credito..cr_ej_regla_aplica_cuest 
where er_id_inst_proc = @i_id_inst_proc
and er_est_en_cred = 'V'
and er_aplica = 'N'
and er_orden is null

if(@w_num_reg_t = @w_num_reg_n )begin
    print 'No cumpliO ninguna regla el proceso: ' + convert(varchar, @i_id_inst_proc)
	select @w_evalua_cuestionario = 'NO'
end else begin

    if (@w_tproducto = @w_tIndividual)
	    select @w_param_val_resp_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'RVDIN' and pa_producto = 'CRE'
    else
       select @w_param_val_resp_min = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'RVDGR' and pa_producto = 'CRE'
    
	--Clientes con cuestionario mayor al mInimo
	select @w_cuest_regist = count(1)
	from cob_credito..cr_ej_regla_aplica_cuest, cr_verifica_datos
	where er_id_inst_proc = @i_id_inst_proc
	and er_aplica = 'S'
	--and er_login is not null
	--and er_in_etapa	= 'S'
	and er_est_en_cred  = 'V' 
	and er_cliente = vd_cliente 
	and vd_tramite = @w_tramite 
	and vd_resultado > @w_param_val_resp_min

	select @w_cuest_fin = isnull(@w_cuest_regist, 0) + isnull(@w_num_reg_n, 0)
	
	print 'Registros para el proceso: ' + convert(varchar, @i_id_inst_proc) + '-->>@w_cuest_fin: ' + convert(varchar, @w_cuest_fin) + '-->>@w_cuest_regist' + convert(varchar, @w_cuest_regist)
	
    if (@w_num_reg_t = @w_cuest_fin)
        select @w_evalua_cuestionario = 'NO'
		
	if (@w_evalua_cuestionario = 'SI') begin
	    --ASIGNACION DE USUARIO A LA SIGUIENTE ETAPA
        print 'si cumpliO alguna regla el proceso: ' + convert(varchar, @i_id_inst_proc)    
        --ASIGNACION DE USUARIO
        select @w_orden_rol = 0
        select @w_orden_rol = min(er_orden)
        from cr_ej_regla_aplica_cuest 
        where er_id_inst_proc = @i_id_inst_proc
        and er_aplica = 'S'
        and er_est_en_cred = 'V'
        and er_login is null --porque si la etapa regresa ya se tiene este dato
        
        if (@w_orden_rol is null) begin
            select @w_orden_rol = max(er_orden)
            from cr_ej_regla_aplica_cuest 
            where er_id_inst_proc = @i_id_inst_proc
            and er_aplica = 'S'
            and er_est_en_cred = 'V'
            and er_login is not null
        end
		   
        select @w_valor_nuevo_rol = 0
        select @w_valor_nuevo_rol = er_rol_w
        from cr_ej_regla_aplica_cuest 
        where er_id_inst_proc = @i_id_inst_proc
        and er_orden = @w_orden_rol
	    
        ----------**********----------**********----------**********----------**********----------**********----------**********
        ----------**********Se guarda la variable del rol para asignaciOn
        ----------**********----------**********----------**********----------**********----------**********----------**********    
        select @w_id_variable_rol = vb_codigo_variable
          from cob_workflow..wf_variable
         where vb_abrev_variable = 'ROLWF'
        
        -- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
        select @w_valor_ant_rol = isnull(va_valor_actual, '')
          from cob_workflow..wf_variable_actual
         where va_id_inst_proc = @i_id_inst_proc
           and va_codigo_var   = @w_id_variable_rol
        
        if @@rowcount > 0  --ya existe
        begin
          --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
          update cob_workflow..wf_variable_actual
             set va_valor_actual = @w_valor_nuevo_rol 
           where va_id_inst_proc = @i_id_inst_proc
             and va_codigo_var   = @w_id_variable_rol    
        end
        else
        begin
          insert into cob_workflow..wf_variable_actual
                 (va_id_inst_proc, va_codigo_var, va_valor_actual)
          values (@i_id_inst_proc, @w_id_variable_rol, @w_valor_nuevo_rol)
        end
	    
	end
end
print '-->>>aplica_cuestionario?: ' + @w_evalua_cuestionario + '-->>Para el proceso: ' + convert(varchar, @i_id_inst_proc)
----------**********----------**********----------**********----------**********----------**********----------**********
----------**********Se guarda la variable para ir por uno u otro camino
----------**********----------**********----------**********----------**********----------**********----------**********
select @w_valor_nuevo = @w_evalua_cuestionario

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