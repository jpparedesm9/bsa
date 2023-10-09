/*************************************************************************/
/*  Archivo:                sp_eje_reglas_cuestionario.sp                */
/*  Stored procedure:       sp_eje_reglas_cuestionario                   */
/*  Base de Datos:          cob_credito                                  */
/*  Producto:               Credito                                      */
/*  Disenado por:           ACH                                          */
/*  Fecha de Documentacion: 23/Feb/2023                                  */
/*************************************************************************/
/*                           IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  "MACOSA", representantes exclusivos para el Ecuador de la AT&T.      */
/*  Su uso no autorizado queda expresamente prohibido asi como           */
/*  cualquier autorizacion o agregado hecho por alguno de sus usuario    */
/*  sin el debido consentimiento por escrito de la Presidencia Ejecutiva */
/*  de MACOSA o su representante                                         */
/*************************************************************************/
/*                            PROPOSITO                                  */
/* Procedure para evaluar las reglas de cuestionario por rol             */
/*************************************************************************/
/*                         MODIFICACIONES                                */
/*  FECHA      AUTOR      RAZON                                          */
/*************************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_eje_reglas_cuestionario')
   drop proc sp_eje_reglas_cuestionario
go

create proc sp_eje_reglas_cuestionario(
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
@w_tramite              int,
@w_mensaje              varchar(255),
@w_return               int,
@w_cliente              int,
@w_tproducto             varchar(255),
@w_resultado1           char(2),
@w_op_anterior          varchar(24),
@w_operacion            int,
@w_promocion            char(1),
@w_oficina              int,
@w_nivel_riesgo         char(1),
@w_num_ciclo_indiv      int,
@w_dias_atraso          int,
@w_monto                money,
@w_valor_variable_regla varchar(255),
@w_orden                int,
@w_nemonico_regla       varchar(10),
@w_aplica               char(1),
@w_login                login,
@w_evalua_cuestionario  char(2),
@w_id_rol_wf            int,
@w_monto_i              money,
@w_num_ciclo_ind        int,
@w_ciclo_grupal         int,
@w_tGrupal              varchar(256),
@w_tRenovacion          varchar(256),
@w_tIndividual          varchar(256),
@w_est_vigente          int,
@w_est_vencido          int,
@w_est_no_vigente       int,
@w_est_cancelado        int,
@w_est_castigado        int,
@w_est_etapa2           int,
@w_dias_max_atraso      int

select @w_sp_name = 'sp_eje_reglas_cuestionario'
print @w_sp_name

select @w_evalua_cuestionario = 'SI'

select @w_cliente = convert(int, io_campo_1),
       @w_tramite = convert(int, io_campo_3),
       @w_tproducto = io_campo_4
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc = @i_id_inst_proc

select @w_tramite = isnull(@w_tramite, 0)

if @w_tramite = 0 return 0

select @w_tIndividual = 'INDIVIDUAL',
       @w_tGrupal = 'GRUPAL',
	   @w_tRenovacion = 'RENOVACION'

--CONSULTAR ESTADOS
exec @w_return = cob_cartera..sp_estados_cca
     @o_est_vigente   = @w_est_vigente    out,--1
     @o_est_vencido   = @w_est_vencido    out,--2
     @o_est_novigente = @w_est_no_vigente out,--0
     @o_est_cancelado = @w_est_cancelado  out,--3
     @o_est_castigado = @w_est_castigado  out,--4
     @o_est_etapa2    = @w_est_etapa2     out --12

if @w_return != 0
   goto ERROR

-->>LISTADO DE REGLAS Y ORDEN PARA EVALUACION
select *
into #orden_eje_cuestionario
from cr_orden_eje_cuestionario
where oe_tproducto = @w_tproducto
and oe_estado = 'V'
order by oe_orden asc

create table #cli_ej_regla_aplica_cuest (
    id_inst_proceso int,    
    cliente   int,    
    tproducto varchar(20),    
    aplica    char(1),
    orden     int,
    login     login,
    rol_w     int,
    nemonico_regla char(10),
    fecha_evalua   datetime,
    valores_reglas varchar(256),
    monto          money,
    nivel_riesgo   varchar(10),
    ciclo_ind      int,
    ciclo_grupal   int,
    dias_atraso    int,
    tramite        int
)
--Antiguos
if exists (select 1 from cr_ej_regla_aplica_cuest where er_id_inst_proc = @i_id_inst_proc and er_aplica = 'S' and er_est_en_cred = 'V' and er_in_etapa = 'N' and er_login is null or ltrim(rtrim(er_login)) = '') begin
    print 'Registros antiguos para proceso: ' + convert(varchar, @i_id_inst_proc)
	insert into #cli_ej_regla_aplica_cuest ( 
	        id_inst_proceso,        cliente,           tproducto,             aplica,
	        orden,                  login,             rol_w,                 nemonico_regla,
	        fecha_evalua,           valores_reglas,    tramite
			)                                          
	 select er_id_inst_proc,        er_cliente,        er_tproducto,          er_aplica,
           er_orden,                er_login,          er_rol_w,              er_nemonico_regla,
    	   er_fecha_evalua,         er_valores_reglas, er_tramite    
    from cr_ej_regla_aplica_cuest
    where er_id_inst_proc = @i_id_inst_proc
    and er_aplica = 'S'
    and er_est_en_cred = 'V'
	and er_in_etapa = 'N'
    and (er_login is null or ltrim(rtrim(er_login)) = '')
	
end else begin -->>LISTADO DE CLIENTES A EVALUAR -- primera vez
    print 'Registros nuevos para proceso: ' + convert(varchar, @i_id_inst_proc)
	insert into #cli_ej_regla_aplica_cuest ( 
	        id_inst_proceso,        cliente,           tproducto,             aplica,
	        orden,                  login,             rol_w,                 nemonico_regla,
	        fecha_evalua,           valores_reglas,    tramite
			)                                          
	 select er_id_inst_proc,        er_cliente,        er_tproducto,          er_aplica,
           er_orden,                er_login,          er_rol_w,              er_nemonico_regla,
    	   er_fecha_evalua,         er_valores_reglas, er_tramite    
    from cr_ej_regla_aplica_cuest
    where er_id_inst_proc = @i_id_inst_proc
    and er_aplica = 'N'
    and er_est_en_cred = 'V'
end

if (@w_tproducto = @w_tIndividual) begin
    --Sacamos el aval
    select aval = tr_alianza
	into #aval
	from cob_credito..cr_tramite 
	where tr_tramite = @w_tramite
	
	delete #cli_ej_regla_aplica_cuest
	from #aval
	where cliente = aval
end

-->>VARIABLE PRODUCTO
select @w_op_anterior = op_anterior
  from cob_cartera..ca_operacion
 where op_tramite = @w_tramite

if (@w_op_anterior is not null) begin
    select @w_tproducto = @w_tRenovacion
end

update #cli_ej_regla_aplica_cuest
set tproducto = @w_tproducto

--PROMOCION, OFICINA
select @w_promocion = isnull(op_promocion,'N'),
         @w_oficina = op_oficina,
	   @w_operacion = op_operacion
  from cob_cartera..ca_operacion
 where op_tramite = @w_tramite
	   
--MONTO
if (@w_tproducto = @w_tGrupal or @w_tproducto = @w_tRenovacion) begin
    update #cli_ej_regla_aplica_cuest 
       set monto = tg_monto
      from cr_tramite_grupal 
     where tg_tramite = tramite 
       and cliente = tg_cliente
	   and tg_monto > 0
       and tg_participa_ciclo = 'S'
end else begin
    update #cli_ej_regla_aplica_cuest
	   set monto = op_monto
      from cob_cartera..ca_operacion
     where op_tramite = tramite
end

--NIVEL DE RIESGO - referencia sp_var_nivel_riesgo
update #cli_ej_regla_aplica_cuest
   set nivel_riesgo = ea_nivel_riesgo_cg
  from cobis..cl_ente_aux
 where ea_ente = cliente

--NUMERO CICLO INDIVIDUAL
--Esta variable identifica el nUmero del ciclo en el cual se encuentra el cliente para determinar si se aplicara o no el cuestionario.
if (@w_tproducto = @w_tGrupal or @w_tproducto = @w_tRenovacion) begin
    update #cli_ej_regla_aplica_cuest
    set ciclo_ind = isnull(en_nro_ciclo, 0) + 1 --Se suma 1 porque que estamos en una nueva solicitud
    from cobis..cl_ente 
    where cliente = en_ente
end else begin    
    declare @num int
	select @num = count(1)
	--into #ciclo_ind
	from #cli_ej_regla_aplica_cuest, cob_cartera..ca_operacion 
    where op_toperacion = @w_tIndividual
    and op_estado in (@w_est_vigente, @w_est_cancelado, @w_est_vencido, @w_est_etapa2, @w_est_castigado)
    and op_cliente = cliente

	update #cli_ej_regla_aplica_cuest
	   set ciclo_ind = isnull(@num, 0) + 1 --Se suma 1 porque que estamos en una nueva solicitud
end

--NUMERO CICLO GRUPAL
--Toma el ciclo grupal en el que se encuentra el cliente

if (@w_tproducto = @w_tGrupal or @w_tproducto = @w_tRenovacion) begin
    update #cli_ej_regla_aplica_cuest
    set ciclo_grupal = isnull(gr_num_ciclo, 0) + 1 --Se suma 1 porque que estamos en una nueva solicitud
    from  cobis..cl_grupo
    where gr_grupo = @w_cliente
	
end else begin
    
    create table #ciclo_tmp (
        ciclo_c int,
        cliente_c int
    )
	
	insert into #ciclo_tmp
	select isnull(gr_num_ciclo, 0),
           cg_ente
     from cobis..cl_cliente_grupo, cobis..cl_grupo, #cli_ej_regla_aplica_cuest
    where cg_grupo = gr_grupo
      and cg_estado = 'V' 
      and cg_ente = cliente
    
    update #cli_ej_regla_aplica_cuest
       set ciclo_grupal = ciclo_c --No sumo porque no estoy en un flujo grupal
      from #ciclo_tmp
     where cliente = cliente_c
end

-->>DIAS ATRASO
--Esta variable identifica el nUmero de dIas de atraso mAximo del cliente por producto
select @w_cliente = 0
while 1 = 1 begin
    select @w_tproducto = tproducto,
	         @w_cliente = cliente
      from #cli_ej_regla_aplica_cuest
	 where cliente > @w_cliente
	 order by cliente desc
	
    if @@rowcount = 0
       break    
    
	select @w_dias_max_atraso = null
    exec @w_return = cob_cartera..sp_dias_max_atraso
         @i_tproducto = @w_tproducto,
         @i_cliente = @w_cliente,
         @i_modo = 1,
    	 @o_dias_max_atraso  = @w_dias_max_atraso out

    if @w_return != 0
        goto ERROR

    update #cli_ej_regla_aplica_cuest
	   set dias_atraso = @w_dias_max_atraso
	 where cliente = @w_cliente
	 
end
	
select @w_orden = 0
while 1=1 begin -- inicio while orden
	
	select @w_nemonico_regla = oe_nemonico_regla,
	                @w_orden = oe_orden,
		        @w_id_rol_wf = oe_id_rol_wf
	 from #orden_eje_cuestionario
	where oe_orden > @w_orden
    order by oe_orden desc
	
    if @@rowcount = 0	   
       break
    
    print 'Inicio evaluacion Regla: ' + @w_nemonico_regla + '-->>orden: ' + convert(varchar, @w_orden)
	select @w_cliente = 0	
	while 1=1 begin -- inicio while eje regla
        select @w_cliente         = cliente,    
               @w_tproducto       = tproducto,
			   @w_monto_i         = monto,
			   @w_nivel_riesgo    = nivel_riesgo,
			   @w_num_ciclo_ind   = isnull(ciclo_ind, 0),
			   @w_ciclo_grupal    = isnull(ciclo_grupal, 0),
			   @w_dias_atraso     = dias_atraso
        from #cli_ej_regla_aplica_cuest
		where cliente > @w_cliente
		and aplica = 'N'
		order by cliente desc
		
        if @@rowcount = 0
           break

        --VARIABLE PRODUCTO | PROMOCION | OFICINA | MONTO | NIVEL DE RIESGO | NUMERO CICLO INDIVIDUAL | NUMERO CICLO GRUPAL | DIAS ATRASO
		select @w_valor_variable_regla  = @w_tproducto + '|' + 
		                                  @w_promocion + '|' + 
										  convert(varchar, @w_oficina) + '|' + 
										  convert(varchar, @w_monto_i) + '|' + 
										  @w_nivel_riesgo  + '|' + 
										  convert(varchar, @w_num_ciclo_ind) + '|' + 
										  convert(varchar, @w_ciclo_grupal) + '|' + 
										  convert(varchar, @w_dias_atraso)
	    	
        print 'Cliente: ' + convert(varchar, @w_cliente) + '-->>@w_valor_variable_regla: ' + @w_valor_variable_regla 
		update #cli_ej_regla_aplica_cuest set
		fecha_evalua   = getdate(),
		valores_reglas = @w_valor_variable_regla
		where id_inst_proceso = @i_id_inst_proc
		and cliente = @w_cliente
			
        exec @w_return = cob_cartera..sp_ejecutar_regla
           @s_ssn                   = @s_ssn,
           @s_ofi                   = @s_ofi,
           @s_user                  = @s_user,
           @s_date                  = @s_date,
           @s_srv                   = @s_srv,
           @s_term                  = @s_term,
           @s_rol                   = @s_rol,
           @s_lsrv                  = @s_lsrv,
           @s_sesn                  = @s_sesn,
           @i_regla                 = @w_nemonico_regla,
           @i_valor_variable_regla  = @w_valor_variable_regla,
           @i_tipo_ejecucion        = 'REGLA',
           @o_resultado1            = @w_resultado1 out
        
        if @w_return != 0
        begin
		   goto ERROR
        end
		
		print '-->>@w_resultado1 : ' + @w_resultado1
		if (@w_resultado1 = 'SI') begin
		    update #cli_ej_regla_aplica_cuest set
			aplica         = 'S', --@w_resultado1,
			orden          = @w_orden,
			login          = null,
			rol_w          = @w_id_rol_wf,
			nemonico_regla = @w_nemonico_regla,
			fecha_evalua   = getdate(),
			valores_reglas = @w_valor_variable_regla
			where id_inst_proceso = @i_id_inst_proc
			and cliente = @w_cliente
		end
    end -- fin while eje regla
end -- fin while orden

--ACTUALIZACION FINAL
update cr_ej_regla_aplica_cuest
set er_id_inst_proc = id_inst_proceso,
    er_cliente         = cliente,
    er_tproducto       = tproducto,
    er_aplica          = aplica,
    er_orden           = orden,
    er_login           = login,
    er_rol_w           = rol_w,
    er_nemonico_regla  = nemonico_regla,
	er_fecha_evalua    = fecha_evalua,
	er_valores_reglas  = valores_reglas 
from #cli_ej_regla_aplica_cuest
where er_id_inst_proc = id_inst_proceso
and er_cliente = cliente
and er_tproducto = tproducto

--PeticiOn del cliente, los datos del aval serAn los mismos del cliente del tramite(Ernesto vIa teams 10May2023)
if (@w_tproducto = @w_tIndividual) begin
    select t_aplica = er_aplica,
	       t_orden = er_orden,
		   t_login = er_login,
		   t_rol_w = er_rol_w,
		   t_nemonico_regla = er_nemonico_regla,
		   t_fecha_evalua = er_fecha_evalua,
		   t_valores_reglas = er_valores_reglas,
		   t_in_etapa = er_in_etapa,
		   t_id_inst_proc = er_id_inst_proc
	into #datos_regla
	from cr_ej_regla_aplica_cuest, cob_credito..cr_tramite
	where er_id_inst_proc = @i_id_inst_proc
	and er_tramite = tr_tramite
	and er_cliente = tr_cliente
	
	update cr_ej_regla_aplica_cuest
	   set er_aplica = t_aplica,
	       er_orden = t_orden,
	       er_login = t_login,
	       er_rol_w = t_rol_w,
	       er_nemonico_regla = t_nemonico_regla,
	       er_fecha_evalua = t_fecha_evalua,
	       er_valores_reglas = t_valores_reglas,
	       er_in_etapa = t_in_etapa
	from #datos_regla
    where er_id_inst_proc = @i_id_inst_proc
	and er_id_inst_proc = t_id_inst_proc
end

return 0

ERROR:
   exec @w_return = cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return,
      @i_msg   = @w_mensaje
   return @w_return
go
