/*************************************************************************/
/*   Archivo:            sp_riesgo_ind_externo.sp                        */
/*   Stored procedure:   sp_riesgo_ind_externo                           */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       Paul Ortiz Vera                                 */
/*   Fecha de escritura: 01/06/2018                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa ejecuta la regla de riesgo individual externo         */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     C                    Ejecuta la matriz                            */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 01/06/2018   Paul Ortiz Vera     Version Inicial                      */
/* 04/Sep/2018  Patricio Mora       Requerimiento 100980                 */
/* 04/09/2018   Paul Ortiz Vera     Version Inicial                      */
/* 23/03/2019   Paul Ortiz Vera     Modificaciones req 100908            */
/* 05-07-2019   srojas              Reestructuracion Buro historico      */
/* 28-03-2022   KVI                 Error 179794                         */
/* 21-03-2023   KVI                 Req.203112-Calificacion Nivel Resgo1 */
/* 29-05-2023   DCU                 Error 207570                         */
/*************************************************************************/
use cobis
go

if object_id ('sp_riesgo_ind_externo') is not null
   drop procedure sp_riesgo_ind_externo
go

create proc sp_riesgo_ind_externo (
       @s_ssn                int         = null,
       @s_user               login       = null,
       @s_term               varchar(32) = null,
       @s_date               datetime    = null,
       @s_sesn               int         = null,
       @s_culture            varchar(10) = null,
       @s_srv                varchar(30) = null,
       @s_lsrv               varchar(30) = null,
       @s_ofi                smallint    = null,
       @s_rol                smallint    = null,
       @s_org_err            char(1)     = null,
       @s_error              int         = null,
       @s_sev                tinyint     = null,
       @s_msg                descripcion = null,
       @s_org                char(1)     = null,
       @t_debug              char(1)     = 'N',
       @t_file               varchar(10) = null,
       @t_from               varchar(32) = null,
       @t_show_version       bit         = 0,
       @i_operacion          char(1)     = 'C',
       @i_ente               int         = null,
       @i_debug              char(1)     = 'N', --S: Si, N: No, R: Reporte, A: Reporte con actualizacion
	   @i_tipo_calif_eva_cli varchar(10) = null, -- Req.203112
	   @i_dias_vig_buro      int         = null, -- Req.203112
       @i_evaluar_reglas     char(1)     = null, -- S evalua nuevamente las reglas si no regresa los valores en base
       @i_excepcionable      char(1)     = 'N' ,
       @o_codigo             int         = null  out,
       @o_nivel              char(1)     = null  out,    
       @o_semaforo           varchar(32) = null  out,
       @o_puntos             varchar(3)  = null  out
)
as

declare   
@w_sp_name            varchar(32),
@w_ts_name            varchar(32),
@w_num_error          int,
@w_nivel              char(1),
@w_semaforo           varchar(32),
@w_puntos             varchar(3),
@w_param_dias         smallint,
@w_param_cta_re       smallint,
@w_param_cta_ant      smallint,
@w_param_cta_mit      smallint,
@w_cant               int,
@w_cant_f             int,
@w_cant_h			  int,
@w_cant_a			  int,
@w_cant_sha           int,
@w_nro_ciclo          int,
@w_fecha_proceso      datetime,
@w_cont               int,
@w_valor              varchar(24),
@w_cta_mitigadora     char(1),
@w_cuentas_nf         int,
@w_fecha_act          datetime,
@w_auto_calif         char(1),
@w_cuentas_b3         int,
@w_secuencial         int,
@w_dias_caducidad     int  -- Error 179794

   
select @w_sp_name = 'sp_riesgo_ind_externo'

-- Inicio Error 179794
select @w_dias_caducidad = @i_dias_vig_buro--isnull(pa_int ,90) from cobis..cl_parametro where pa_nemonico = 'BCPC'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

if not exists (select 1 from cob_credito..cr_interface_buro where ib_cliente = @i_ente)
begin
  return 1
end

if @i_excepcionable = 'N' and exists(select 1 from cob_credito..cr_interface_buro
          where ib_cliente = @i_ente
   		  and   ib_estado  = 'V'
   		  and   datediff(dd,ib_fecha,@w_fecha_proceso) > @w_dias_caducidad
		 ) 
begin
  update cobis..cl_ente_aux
  set ea_nivel_riesgo_cg = null
  where ea_ente = @i_ente
  
  update cobis..cl_ente
  set p_calif_cliente = null
  where en_ente in(@i_ente)
  
  return 1
end   
-- Fin Error 179794

if (@i_evaluar_reglas = 'N') begin	    
    select @o_nivel = ea_nivel_riesgo_cg -- @w_letra
	from cobis..cl_ente_aux
    where ea_ente = @i_ente 
    
    select @o_semaforo = p_calif_cliente -- @w_color
	from cobis..cl_ente
    where en_ente = @i_ente
    and en_subtipo = 'P'

    update cob_credito..cr_vigencia_tipo_calif
	set vg_evaluo_buro = @i_evaluar_reglas, 
	    vg_result_eval = @o_semaforo + '|' + @o_nivel + '|'
	where vg_ente = @i_ente

    print 'No evaluo Reglas -->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Color: ' + @o_semaforo + '-->>RiesgoIndExt: ' + @o_nivel
	select @o_nivel, @o_semaforo 

	return 0
end

-- Parametros --
select @w_param_dias     = pa_smallint from cobis..cl_parametro where pa_nemonico  = 'DIAREX'
select @w_param_cta_re    = pa_smallint from cobis..cl_parametro where pa_nemonico  = 'DIACRE'
select @w_param_cta_ant   = pa_smallint from cobis..cl_parametro where pa_nemonico  = 'DIACAE'
select @w_param_cta_mit   = pa_smallint from cobis..cl_parametro where pa_nemonico  = 'DIACME'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select 
@w_fecha_act 	= ib_fecha,
@w_secuencial   = ib_secuencial
from cob_credito..cr_interface_buro 
where ib_cliente = @i_ente 
and ib_estado    = 'V'

select valor
into #cr_tipo_negocio
from cobis..cl_tabla t,cobis..cl_catalogo c
where t.tabla  = 'cr_tipo_negocio' 
and t.codigo = c.tabla 

select distinct @i_ente as bc_id_cliente,
@w_fecha_act AS bc_fecha_actualizacion,
bc_forma_pago_actual,
bc_historico_pagos,
--bc_saldo_actual,bc_tipo_contrato,
bc_nombre_otorgante,
bc_clave_observacion,
convert(money,replace(replace(bc_saldo_vencido,'+',''),'-','')) as bc_saldo_vencido,
bc_tipo_contrato,
isnull(bc_mop_historico_morosidad_mas_grave,'00') AS bc_mop_historico,
bc_fecha_apertura_cuenta = (case when bc_fecha_apertura_cuenta is null then null
						when len(bc_fecha_apertura_cuenta) = 7 then
	                   		convert(datetime,SUBSTRING(bc_fecha_apertura_cuenta,1,1) + '/' +SUBSTRING(bc_fecha_apertura_cuenta,2,2) + '/' + SUBSTRING(bc_fecha_apertura_cuenta,4,4),103)
						else 
	                   		convert(datetime,SUBSTRING(bc_fecha_apertura_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_apertura_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_apertura_cuenta,5,4),103) end),
bc_fecha_cierre_cuenta   = (case when bc_fecha_cierre_cuenta is null or bc_fecha_cierre_cuenta = '01010001'then null
	                  	when len(bc_fecha_cierre_cuenta) = 7 then
	                   		convert(datetime,SUBSTRING(bc_fecha_cierre_cuenta,1,1) + '/' +SUBSTRING(bc_fecha_cierre_cuenta,2,2) + '/' + SUBSTRING(bc_fecha_cierre_cuenta,4,4),103)
						else 
	                  		convert(datetime,SUBSTRING(bc_fecha_cierre_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_cierre_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_cierre_cuenta,5,4),103) end),
bc_cuenta_financiera        =  case when ltrim(rtrim(bc_tipo_contrato)) in ('RE','SM','HE','HI') then 'H' 
                                		when ltrim(rtrim(bc_tipo_contrato)) in ('AU','RV') then 'A' 
												when exists(select 1 from #cr_tipo_negocio where ltrim(rtrim(bc_nombre_otorgante)) in (ltrim(rtrim(valor))) )
                               		then 'N' else 'S' end,
bc_cuenta_reciente          = 'N',
bc_cuenta_antigua           = 'N'
into #cr_buro_cuenta	   
from cob_credito..cr_buro_cuenta
where bc_ib_secuencial = @w_secuencial
and  ((bc_fecha_cierre_cuenta is null or  datediff(dd,((case when bc_fecha_cierre_cuenta = '01010001'  
or bc_fecha_cierre_cuenta is null then null
when len(bc_fecha_cierre_cuenta) = 7 then
   convert(datetime,SUBSTRING(bc_fecha_cierre_cuenta,1,1) + '/' +SUBSTRING(bc_fecha_cierre_cuenta,2,2) + '/' + SUBSTRING(bc_fecha_cierre_cuenta,4,4),103)
else 
   convert(datetime,SUBSTRING(bc_fecha_cierre_cuenta,1,2) + '/' +SUBSTRING(bc_fecha_cierre_cuenta,3,2) + '/' + SUBSTRING(bc_fecha_cierre_cuenta,5,4),103) end)),@w_fecha_act) <= @w_param_dias))

/* Actualizar NULL a 00 */
update #cr_buro_cuenta
set bc_forma_pago_actual = '00'
where bc_forma_pago_actual is null

-- Universo para sumatoria en calificacion E
select * 
into #cr_buro_cuenta_sum
from #cr_buro_cuenta

-- Actualizacion saldo vencido
update #cr_buro_cuenta
set bc_saldo_vencido = 0
where bc_forma_pago_actual = '01'
and   (bc_saldo_vencido is null or bc_saldo_vencido = 0)
  
-- Tipos de Cuentas
select @w_cta_mitigadora = case when (select count(*) from #cr_buro_cuenta where bc_cuenta_financiera in ('S', 'A', 'H') and bc_forma_pago_actual = '01' and bc_fecha_cierre_cuenta is null
                                       and (datediff(dd,bc_fecha_apertura_cuenta, bc_fecha_actualizacion) >= @w_param_cta_mit)) >=1 
                                then 'S' else 'N' end

update #cr_buro_cuenta
set bc_cuenta_reciente = 'S'
where (datediff(dd, bc_fecha_apertura_cuenta,bc_fecha_actualizacion) < @w_param_cta_re
or bc_forma_pago_actual in ('UR','00'))

update #cr_buro_cuenta
set bc_cuenta_antigua = 'S'
where (datediff(dd, bc_fecha_cierre_cuenta,bc_fecha_actualizacion) > @w_param_cta_ant)


if @i_debug = 'S'
	select * from #cr_buro_cuenta

--Clasificacion
select @w_cant = count(*) from #cr_buro_cuenta
select @w_cant_f = count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'S'
select @w_cant_h = count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'H'
select @w_cant_a = count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'A'
select @w_cant_sha = count(*) from #cr_buro_cuenta where bc_cuenta_financiera <> 'N'

if exists (select 1 from cobis..cl_clientes_calif where cc_ente = @i_ente)
begin
	select @w_auto_calif = cc_calif from cobis..cl_clientes_calif 
	where cc_ente = @i_ente
	
	if(@w_auto_calif = 'F')
	begin
		select @w_nivel    = 'F',
			@w_semaforo = 'ROJO',
			@w_puntos   = 'S/C'
		goto prefin
	end
	else if(@w_auto_calif = 'C')
	begin
		select @w_nivel    = 'C',
			@w_semaforo = 'VERDE',
			@w_puntos   = '0'
		goto prefin
	end
	else if(@w_auto_calif = 'A')
	begin
		select @w_nivel     = 'A',
			@w_semaforo  = 'VERDE',
			@w_puntos    = '2'
		goto prefin
	end
	else if(@w_auto_calif = 'B')
	begin
		select @w_nivel = 'B',
			@w_semaforo  = 'VERDE',
			@w_puntos    = '1'
		goto prefin
	end
	else if(@w_auto_calif = 'D')
	begin
		select @w_nivel    = 'D',
			@w_semaforo = 'VERDE',
			@w_puntos   = '-1'
   	goto prefin
	end
	else if(@w_auto_calif = 'E')
	begin
		select @w_nivel    = 'E',
	       @w_semaforo = 'AMARILLO',
	       @w_puntos   = '-2'
	   goto fin
	end
end




select @i_operacion = 'F'
if @i_operacion = 'F'
begin
	select @w_nro_ciclo = en_nro_ciclo 
	from cobis..cl_ente 
	where en_ente = @i_ente
	--Para ciclo = 0 -> Cliente Nuevo
	if    @w_nro_ciclo < 1 or @w_nro_ciclo is null
	begin
		if exists(select 1 from #cr_buro_cuenta where bc_forma_pago_actual in ('99'))
		begin
			if @i_debug = 'S'
		   	print 'F1-1'
		   
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end
		
		if exists(select 1 from #cr_buro_cuenta 
		         where bc_clave_observacion in ('FD', 'SG', 'IM', 'LO', 'FR') and bc_saldo_vencido > 2000 )
		begin
			if @i_debug = 'S'
				print 'F1-2'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end 
		
		if exists(select 1 from #cr_buro_cuenta 
		        where bc_cuenta_financiera = 'H'
		         and bc_forma_pago_actual in ('02','03','04','05','06','07','96','97','98') --mayor a 01
		         and bc_saldo_vencido > 2000)
		begin
		   if @i_debug = 'S'
		   	print 'F1-3'
		   
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end
		
		if exists(select 1 from #cr_buro_cuenta 
		        where bc_cuenta_financiera = 'A'
		         and bc_forma_pago_actual in ('03','04','05','06','07','96','97','98') --mayor a 02
		         and bc_saldo_vencido > 2000)
		begin
		   if @i_debug = 'S'
		   	print 'F1-4'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end
	end
	--> Ciclo 1 - 3 -> Clientes 
	if(@w_nro_ciclo between 1 and 3)
	begin
		if exists(select 1 from #cr_buro_cuenta where bc_forma_pago_actual in ('99'))
		begin
		   if @i_debug = 'S'
		   	print 'F2-1'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end 
		
		if exists(select 1 from #cr_buro_cuenta where bc_clave_observacion in ('FD', 'SG', 'IM', 'LO', 'FR') and bc_saldo_vencido > 5000) -- 1
		begin
		   if @i_debug = 'S'
			   print 'F2-2'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end 
		
		if exists(select 1 from #cr_buro_cuenta 
		        where bc_cuenta_financiera in ('H', 'A')
		         and bc_forma_pago_actual in ('03','04','05','06','07','96','97','98')
		         and bc_saldo_vencido > 5000) -- 2
		begin
		   if @i_debug = 'S'
		   	print 'F2-3'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end
	end
	--> Ciclo mayor igual a 4 -> Clientes 
	if(@w_nro_ciclo >= 4)
	begin
		if exists(select 1 from #cr_buro_cuenta where bc_forma_pago_actual in ('99'))
		begin
		   if @i_debug = 'S'
		   	print 'F3-1'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end
		
		--SE COMENTAN SEGUN CASO 148206
		/*if exists(select 1 from #cr_buro_cuenta where bc_clave_observacion in ('FD', 'SG', 'IM', 'LO', 'FR'))
		begin
		   if @i_debug = 'S'
		   	print 'F3-2'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end */ 
	end
	-- 3
	if(@w_nro_ciclo = 1)
	begin
		if exists(select 1 from #cr_buro_cuenta 
		        where bc_cuenta_financiera in ('H')
		         and bc_forma_pago_actual in ('02','03','04','05','06','07','96','97','98')
		         and bc_saldo_vencido > 5000)
		begin
		   if @i_debug = 'S'
		   	print 'F2-3'
			
			select @w_nivel    = 'F',
			       @w_semaforo = 'ROJO',
			       @w_puntos   = 'S/C'
			goto prefin
		end
	end
end

select @i_operacion = 'C'
if @i_operacion = 'C'
begin 
	if not exists(select 1 from #cr_buro_cuenta)
	begin
	   if @i_debug = 'S'
	   	print 'C-1'
		
		select @w_nivel    = 'C',
		       @w_semaforo = 'VERDE',
		       @w_puntos   = '0'
		goto prefin
	end
	
	if (@w_cant = (select count(*) from #cr_buro_cuenta where bc_cuenta_financiera ='N'))
	begin
	   if @i_debug = 'S'
	   	print 'C-2'
		
		select @w_nivel    = 'C',
		    @w_semaforo = 'VERDE',
		    @w_puntos   = '0'
		goto prefin
	end
	
	if(@w_cant_sha != 0)
	begin
		if (@w_cant_sha = (select count(*) from #cr_buro_cuenta 
						where bc_cuenta_financiera in ('S', 'A', 'H')
						and (bc_cuenta_reciente = 'S' 
						       or bc_cuenta_antigua = 'S')) )
		begin
		   if @i_debug = 'S'
		   	print 'C-3'
			
			select @w_nivel    = 'C',
			       @w_semaforo = 'VERDE',
			       @w_puntos   = '0'
			goto prefin
		end
	end
end

select @i_operacion = 'A'
if @i_operacion = 'A'
begin
	if exists(select 1 from #cr_buro_cuenta 
	       where bc_cuenta_financiera in ('S', 'A', 'H')
	       and bc_cuenta_reciente = 'N')
	begin
		if @i_debug = 'S'
				print 'A - 1'
		
		if exists(select 1 from #cr_buro_cuenta 
					where bc_cuenta_financiera = 'H'
					and bc_forma_pago_actual not in ('UR','00','01')) 
		   or exists (select 1 from #cr_buro_cuenta 
					where bc_cuenta_financiera = 'H'
					and bc_forma_pago_actual in ('UR','00','01')
					and bc_mop_historico not in ('00','01') )
		begin
			select @i_operacion = 'B'
		end
		else
		begin
			if @i_debug = 'S'
				print 'A - 2'
			
			if exists(select 1 from #cr_buro_cuenta 
					where bc_cuenta_financiera = 'A'
					and bc_forma_pago_actual not in ('UR','00','01'))
		      or exists (select 1 from #cr_buro_cuenta 
					where bc_cuenta_financiera = 'A'
					and bc_forma_pago_actual in ('UR','00','01')
					and bc_mop_historico not in ('00','01'))
		   begin
				select @i_operacion = 'B'
			end
			else
			begin
				if @i_debug = 'S'
					print 'A - 3'
				
				if exists(select 1 from #cr_buro_cuenta 
						where bc_cuenta_financiera = 'S'
						and bc_forma_pago_actual not in ('UR','00','01'))
		         or exists (select 1 from #cr_buro_cuenta 
						where bc_cuenta_financiera = 'S'
						and bc_forma_pago_actual in ('UR','00','01')
						and bc_mop_historico not in ('00','01','02'))
		      begin
					select @i_operacion = 'B'
				end
				else
				begin
					if @i_debug = 'S'
						print 'A - 4'
					
					if exists(select 1 from #cr_buro_cuenta 
								where bc_cuenta_financiera = 'N'
								and bc_forma_pago_actual not in ('UR','00','01') )
					begin
						select @i_operacion = 'B'
					end
					else
					begin
						
						if @i_debug = 'S'
							print 'A - 5'
						
						if exists(select 1 from #cr_buro_cuenta 
									where bc_forma_pago_actual in ('02','03','04','05','06','07','96','97','98') )
						begin
							select @i_operacion = 'B'
						end
						else
						begin
							if @i_debug = 'S'
								print 'A - 6: Se queda en A'
							
							select @w_nivel     = 'A',
							    @w_semaforo  = 'VERDE',
							    @w_puntos    = '2'
							goto prefin
						end
					end
				end
			end
		end
	end
end

select @i_operacion = 'B'
if @i_operacion = 'B'
begin
	if exists (select 1 from #cr_buro_cuenta 
	           	where bc_cuenta_financiera in ('S', 'A', 'H')
	            and bc_cuenta_reciente = 'N')
	begin	
		if @i_debug = 'S'
				print 'B - 1'
		
		if not exists(select 1 from #cr_buro_cuenta where bc_cuenta_financiera = 'S'
	           	and bc_forma_pago_actual in ('04','05','06','07','96','97','98'))
	   begin
	   	if ((select count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'H'
						and bc_forma_pago_actual in ('01')) = @w_cant_h)
			begin
				if @i_debug = 'S'
						print 'B - 2'
				
				if ((select count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'A'
						and bc_forma_pago_actual in ('01', '02')) = @w_cant_a)
				begin
					if @i_debug = 'S'
						print 'B - 3'
					
					select @w_cuentas_b3 = (select count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'N'
									and bc_forma_pago_actual in ('UR','00','01','02','03','04','05','06','07','96','97','98')) 
					
					if ((select count(*) from #cr_buro_cuenta where bc_cuenta_financiera = 'N' and (bc_forma_pago_actual in ('UR','00','01') 
								or (bc_forma_pago_actual in ('02','03') and bc_saldo_vencido <= 10000))
								or ((bc_forma_pago_actual in ('04','05','06','07','96','97','98') 
								      and bc_saldo_vencido <= 1000))) = @w_cuentas_b3)
					begin
						if @i_debug = 'S'
							print 'B - 4'
						
						if ((select count(*) from #cr_buro_cuenta where bc_cuenta_financiera ='S'
										and bc_forma_pago_actual in ('UR','00','01', '02', '03') and bc_saldo_vencido <= 10000) = @w_cant_f)
						begin
							
							if @i_debug = 'S'
								print 'B - 5: Se queda en B'
							
							select @w_nivel = 'B',
							@w_semaforo  = 'VERDE',
							@w_puntos    = '1'
							goto prefin
						end
						else
						begin
							select @i_operacion = 'D'
						end
					end
					else
					begin
						select @i_operacion = 'D'
					end
				end
				else
				begin
					select @i_operacion = 'D'
				end
			end
			else
			begin
				select @i_operacion = 'D'
			end
	   end
	   else
		begin
			select @i_operacion = 'D'
		end
	end
end

select @i_operacion = 'D'
if (@i_operacion = 'D') 
begin		
	if (((select count(*) from #cr_buro_cuenta 
		where bc_forma_pago_actual in ('96','97','98')) <= 4)
		and (@w_cta_mitigadora = 'S'))
		or ((select count(*) from #cr_buro_cuenta 
		where bc_forma_pago_actual in ('96','97','98')) = 0)
	begin
		if @i_debug = 'S'
	   	print 'D - 1'
	   
		if ((select count(*) from #cr_buro_cuenta 
				where bc_cuenta_financiera in ('N', 'S')
				and bc_forma_pago_actual in ('02', '03')
				and bc_saldo_vencido <= 20000) = (select count(*) from #cr_buro_cuenta 
																where bc_cuenta_financiera in ('N', 'S')
																and bc_forma_pago_actual in ('02', '03')))
			or ((select count(*) from #cr_buro_cuenta 
					where bc_cuenta_financiera in ('N', 'S')
					and bc_forma_pago_actual in ('02', '03')) = 0)
		begin
		   if @i_debug = 'S'
		   	print 'D - 2 y 3'
		   
			if ((select count(*) from #cr_buro_cuenta 
				where bc_cuenta_financiera = 'S'
				and bc_forma_pago_actual in ('04', '05', '06', '07')
				and bc_saldo_vencido <= 1000) = (select count(*) from #cr_buro_cuenta 
																where bc_cuenta_financiera = 'S'
																and bc_forma_pago_actual in ('04', '05', '06', '07')))
				or ((select count(*) from #cr_buro_cuenta 
				where bc_cuenta_financiera = 'S'
				and bc_forma_pago_actual in ('04', '05', '06', '07') ) = 0) 
			begin
				if @i_debug = 'S'
			   	print 'D - 4'
			   
				if ((select count(*) from #cr_buro_cuenta 
				   where bc_cuenta_financiera = 'N'
					and bc_forma_pago_actual in ('04','05','06','07')
					and bc_saldo_vencido <= 2000) = (select count(*) from #cr_buro_cuenta 
											   where bc_cuenta_financiera = 'N'
												and bc_forma_pago_actual in ('04','05','06','07')))
					or ((select count(*) from #cr_buro_cuenta 
				   where bc_cuenta_financiera = 'N') = 0)
				begin
				   if @i_debug = 'S'
				   	print 'D - 5'
				   
					if ((select count(*) from #cr_buro_cuenta 
					        where bc_cuenta_financiera = 'H'
					         and bc_forma_pago_actual in ('02','03','04','05','06','07','96','97','98')
					         and bc_saldo_vencido <= 3000) >= 1) -- 5
					         or ((select count(*) from #cr_buro_cuenta 
					         where bc_cuenta_financiera = 'H'
					         and bc_forma_pago_actual in ('02','03','04','05','06','07','96','97','98')) = 0 )
					begin
					   if @i_debug = 'S'
					   	print 'D - 6'
					   
						if ((select count(*) from #cr_buro_cuenta 
						        where ltrim(rtrim(bc_tipo_contrato)) in ('AU', 'RV')
						         and bc_forma_pago_actual in ('03','04','05','06','07','96','97','98')
						         and bc_saldo_vencido <= 3000) >= 1) -- 4
						         or ((select count(*) from #cr_buro_cuenta 
						         where ltrim(rtrim(bc_tipo_contrato)) in ('AU', 'RV')
						         and bc_forma_pago_actual in ('03','04','05','06','07','96','97','98')) = 0)
						begin
						   if @i_debug = 'S'
						   	print 'D - 7'
							
							select @w_nivel    = 'D',
					   		@w_semaforo = 'VERDE',
					   		@w_puntos   = '-1'
					   	goto prefin
						end
					end
				end
			end
		end
	end
end

select @i_operacion = 'E'
if @i_operacion = 'E'
begin 
	-- 6
	if ((select count(*) from #cr_buro_cuenta 
		where bc_cuenta_financiera = 'H'
		 and bc_forma_pago_actual in ('02','03','04','05','06','07','96','97','98')
		 and bc_saldo_vencido > 3000 and bc_saldo_vencido <= 5000) >= 1)
	begin
		if @i_debug = 'S'
			print 'E - 1'
		select @w_nivel    = 'E',
		   @w_semaforo = 'AMARILLO',
		   @w_puntos   = '-2'
		goto prefin
	end
	
	-- 7
	if ((select count(*) from #cr_buro_cuenta 
		where ltrim(rtrim(bc_tipo_contrato)) in ('AU', 'RV')
		 and bc_forma_pago_actual in ('03','04','05','06','07','96','97','98')
		 and bc_saldo_vencido > 3000 and bc_saldo_vencido <= 5000) >= 1)
	begin
	   if @i_debug = 'S'
		print 'E - 2'
		
		select @w_nivel    = 'E',
		@w_semaforo = 'AMARILLO',
		@w_puntos   = '-2'
		goto prefin
	end
	
	if @w_nivel is null or @w_semaforo is null
	begin
		select @w_nivel    = 'E',
	       @w_semaforo = 'AMARILLO',
	       @w_puntos   = '-2'
	end
	
	goto fin
end

prefin:
	select @o_nivel = @w_nivel,
	@o_semaforo 	= @w_semaforo,
	@o_puntos   	= @w_puntos
	
	if @i_debug = 'N' or @i_debug = 'A' --A - Reporte con actualizacion
	begin
		update cobis..cl_ente_aux 
		set ea_sum_vencido 	= null,
		ea_num_vencido 		= null 
		where ea_ente = @i_ente
	end
	
	if @i_debug = 'S'
		select @o_nivel
	
	goto fin
	
fin:
	select @o_nivel    = @w_nivel,
	@o_semaforo = @w_semaforo,
	@o_puntos   = @w_puntos
	
    update cob_credito..cr_vigencia_tipo_calif
    set vg_evaluo_buro = @i_evaluar_reglas , 
        vg_result_eval = @o_semaforo + '|' + @o_nivel + '|' + @o_puntos
    where vg_ente = @i_ente

	/* Se ejecuta solo si la calificacion es E */
	if @w_nivel = 'E'
	begin
		if @i_debug = 'N' or @i_debug = 'A' --A - Reporte con actualizacion
		begin
			update cobis..cl_ente_aux
			set   ea_sum_vencido = (select sum (bc_saldo_vencido) 
									from  #cr_buro_cuenta_sum
									where bc_forma_pago_actual in ('02','03','04','05','06','07')
									and   bc_id_cliente = @i_ente),
				  ea_num_vencido = (select count (*) from  #cr_buro_cuenta_sum
									where bc_forma_pago_actual in ('02','03','04','05','06','07')
									and   bc_id_cliente = @i_ente)               
			where ea_ente = @i_ente
		end
	end
	
	if @i_debug = 'N' or @i_debug = 'A' --A - Reporte con actualizacion
	begin
		update cobis..cl_ente_aux 
		set ea_nivel_riesgo_cg  = @o_nivel,
		ea_puntaje_riesgo_cg 	= @o_puntos,
		ea_fecha_evaluacion  	= @w_fecha_proceso,
		ea_nivel_riesgo_1       = @o_nivel,             -- Req.203112
        ea_nivel_riesgo_2       = null,                 -- Req.203112
		ea_tipo_calif_eva_cli   = @i_tipo_calif_eva_cli -- Req.203112
		where ea_ente = @i_ente
		
	end
	
	if @i_debug = 'A' --A - Reporte con actualizacion
	begin
		update cobis..cl_ente
		set p_calif_cliente		= @o_semaforo
		where en_ente = @i_ente
	end
	
	if @i_debug = 'S'
		select @o_nivel
	
	return 0

errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
go
