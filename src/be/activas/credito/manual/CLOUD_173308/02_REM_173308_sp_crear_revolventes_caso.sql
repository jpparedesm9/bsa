use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_crear_revolventes_caso_173308')
	drop proc sp_crear_revolventes_caso_173308
go

create proc sp_crear_revolventes_caso_173308 (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = NULL,
   @s_org_err         char(1)     = NULL,
   @s_error           int         = NULL,
   @s_sev             tinyint     = NULL,
   @s_msg             descripcion = NULL,
   @s_org             char(1)     = NULL,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_operacion       char(1)     = 'A',
   --@i_fecha_ing       datetime    = null,
   --@i_grupo           int         = null,
   @i_cliente         int         = null,
   @i_periodicidad    varchar(10) = null,
   @i_accion          char(1)     = 'A',
   --@i_asesor_reasig   int         = null,
   --@i_descripcion     varchar(600)= null,
--->>>nuevos-------select @i_accion = 'A', @i_operacion = 'A'
   @i_asesor 		 varchar(14),-- = cc_asesor
   --@i_periodicidad   varchar(10),--= 'BW',--cc_periodicidad, --***ver que dato enviar
   @i_fecha_ven      datetime--= cc_fecha_liq, --***ver que dato enviar   
)as
declare 
   @w_ts_name         varchar(32),
   @w_sp_name         varchar(32),
   @w_return          int,
   @w_error           int,
   @w_user            login,
   @w_oficina         int,
   @w_periodicidad    varchar(10),
   @w_accion          char(1),
   @w_subtipo         char(1),
   @w_asesor          login,
   @w_asesor_reasig   login,
   @w_asesor_ini      login,
   @w_fecha_proceso   datetime,
   @w_dias_post       smallint,
   @w_rol_sup         tinyint,
   @w_estado_jefe     char(1),
   @w_ofi_lcr         int,
   @w_ofi_gerente     int,
   @w_fecha_liq       datetime,
   @w_fecha_ven       datetime,
   @w_monto           money,
   @w_cliente         int,
   @w_toperacion      varchar(10),
   @w_moneda          tinyint,
   @w_destino         varchar(10),
   @w_ciudad          int,
   @w_tipo            char(1),
   @w_tramite_out     int,
   @w_inst_proc       int,
   @w_commit          char(1),
   @w_ced_ruc         varchar(30),
   @w_oficial         int,
   @w_grupo			  int,
   @w_porcentaje_max  int,
   @w_integrantes_grupo	int,
   @w_integrantes_lcr	int,
   @w_fecha_descrip     datetime,
   @w_descripcion       varchar(600),
   @w_date              datetime,
   @w_tramite_prev      int --KVI 20210729

select @w_sp_name = 'sp_crear_revolventes_caso_173308'

   -- Validar codigo de transacciones --
if ((@t_trn <> 1722 and @i_operacion = 'A'))
begin
   select @w_error = 151051 --Transaccion no permitida
   goto ERROR
end

/* OBTENCION DE DATA */
--Sacar oficina del asesor
select @w_oficina = fu_oficina from cobis..cl_funcionario where fu_login = @s_user
--Fecha Proceso
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
--Dias para porsponer
--select @w_dias_post = pa_smallint from cobis..cl_parametro where pa_nemonico = 'DPC' and pa_producto = 'CCA'
--Coordinardor
select @w_rol_sup = ro_rol from cobis..ad_rol where ro_descripcion = 'COORDINADOR'
--Oficina Defecto Pantalla de Autorizar Promocion LCR
select @w_ofi_lcr = pa_smallint from cobis..cl_parametro where pa_nemonico = 'OFILCR'

--Acciones (Autorizar, Descartar, Posponer)

if @i_operacion = 'A'
begin  
   select @w_asesor = @i_asesor,
          @w_periodicidad = @i_periodicidad,
          @w_fecha_ven = @i_fecha_ven   
	--select @w_asesor 		 = cc_asesor,--***ver que dato enviar
	--		--@w_asesor_reasig = cc_asesor_asig,
	--		 @w_periodicidad  = 'BW',--cc_periodicidad, --***ver que dato enviar
	--		 @w_fecha_ven     = cc_fecha_liq, --***ver que dato enviar
			--@w_date          = cc_date,
			--@w_fecha_descrip = cc_fecha_descrip
	--from cob_cartera..ca_lcr_candidatos
	--where cc_fecha_ing = @i_fecha_ing
	--and   cc_grupo     = @i_grupo
	--and   cc_cliente   = @i_cliente
		
	if(@i_accion = 'A')
	begin
		
		select @w_subtipo = en_subtipo from cobis..cl_ente 
		where en_ente = @i_cliente
		
		if @w_asesor_reasig is not null
			select @w_asesor_ini = @w_asesor_reasig
		else if @w_asesor is not null 
			select @w_asesor_ini = @w_asesor

        
		
		if (@w_asesor_ini is null)
		begin
			select @w_error = 710602 --Se debe definir Asesor para iniciar el flujo!
			goto ERROR
		end
		
		if (@w_periodicidad is null)
		begin
			select @w_error = 710603 --Se debe definir periodicidad para iniciar el flujo!
			goto ERROR
		end
		
		--Oficina asesor de Inicio
		select @w_oficina = fu_oficina from cobis..cl_funcionario 
		where fu_login = @w_asesor_ini
		
		--Oficina de Gerente logeado
		--select @w_ofi_gerente = fu_oficina from cobis..cl_funcionario 
		--where fu_login = @s_user
		--
		--if(@w_ofi_gerente <> @w_oficina)
		--begin
		--	select @w_error = 710608 --La oficina del asesor es diferente a la de gerente, por favor regularice!
		--	goto ERROR
		--end
		
		select @w_oficial = oc_oficial 
		from   cobis..cc_oficial, cobis..cl_funcionario
		where  oc_funcionario = fu_funcionario
		and    fu_login = @w_asesor_ini
		
		-- VALIDAR EXSITENCIA DE OFICIALES
		if not exists(select 1 from cobis..cc_oficial, cobis..cl_funcionario where oc_funcionario = fu_funcionario 
		     and oc_oficial = @w_oficial)
		begin
			select @w_error = 151091 -- NO EXISTE OFICIAL
			--select @w_msg = 'No existe oficial: ' + convert(varchar, @w_oficial)
			goto ERROR
		end	
		
		if @@trancount = 0
		begin
			select @w_commit = 'S'
			begin tran
		end
		
		PRINT 'asesor:' + convert(VARCHAR(30), @w_asesor_ini)
		---- si existe grupal no hay problema si hay una revolvente probleme...
		exec @w_error        = cob_workflow..sp_inicia_proceso_wf 
		@t_trn               = 73506,
		@i_login             = @w_asesor_ini,
		@i_id_proceso        = 5,
		@i_campo_1           = @i_cliente,
		@i_campo_3           = 0,
		@i_campo_4           = 'REVOLVENTE',
		@i_campo_5           = 0,
		@i_campo_6           = 0.00,
		@i_campo_7           = @w_subtipo,
		@i_ruteo             = 'M',
		@i_id_empresa        = 1,
		@i_ofi_inicio        = @w_ofi_lcr,
		@i_canal             = 0,
		@o_siguiente         = @w_inst_proc out, -- LGU obtener la instancia de proceso
		@o_siguiente_alterno = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
		@s_srv               = @s_srv,
		@s_user              = @s_user,
		@s_term              = @s_term,
		@s_ofi               = @w_oficina,
		@s_rol               = @s_rol,
		@s_ssn               = @s_ssn,
		@s_lsrv              = @s_lsrv,
		@s_date              = @s_date,
		@s_sesn              = @s_sesn,
		@s_org               = @s_org,
		@s_culture           = @s_culture
		
		if ((@@error <> 0) or (@w_error <> 0))
		begin
			goto ERROR
		end
		
		/* Informacion para crear el tramite */
		
		select @w_tipo = 'O'
		select @w_toperacion = 'REVOLVENTE'
		select @w_monto = 0.0
		select @w_destino = '01'
		
		--Ciudad
		select @w_ciudad = of_ciudad from cobis..cl_oficina where of_oficina = @w_oficina
		--Moneda
		select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC'
		
		--///////////////////////////////
		--CREA TRAMITE
		--///////////////////////////////
		begin try 
			print 'Antes de crear tramite'
			
			print 'INICIA PRINTS'
			Print '@w_tipo ' + convert(varchar,@w_tipo)
			Print '@w_oficina ' + convert(varchar,@w_oficina)
			Print '@w_fecha_ven ' + convert(varchar,@w_fecha_ven)
			Print '@w_asesor_ini ' + convert(varchar,@w_asesor_ini)
			Print '@w_oficial ' + convert(varchar,@w_oficial)
			Print '@w_ciudad ' + convert(varchar,@w_ciudad)
			Print '@w_toperacion ' + convert(varchar,@w_toperacion)
			Print '@w_monto ' + convert(varchar,@w_monto)
			Print '@w_moneda ' + convert(varchar,@w_moneda)
			Print '@w_destino ' + convert(varchar,@w_destino)
			Print '@i_cliente ' + convert(varchar,@i_cliente)
			Print '@w_periodicidad ' + convert(varchar,@w_periodicidad)
			Print '@s_user ' + convert(varchar,@s_user)
			Print '@s_ssn ' + convert(varchar,@s_ssn)
			Print '@w_fecha_proceso ' + convert(varchar,@w_fecha_proceso)
			Print '@s_sesn ' + convert(varchar,@s_sesn)
			print 'FINALIZA PRINTS'
			 
			exec @w_error = cob_credito..sp_tramite_cca 
				@i_tipo				= @w_tipo,
				@i_oficina_tr		= @w_oficina,
				@i_fecha_crea		= @w_fecha_ven,
				@i_oficial			= @w_oficial,
				@i_sector			= 'S',
				@i_ciudad			= @w_ciudad,
				@i_toperacion		= @w_toperacion,
				@i_producto			= 'CCA',
				@i_monto			= @w_monto,
				@i_moneda			= @w_moneda,
				@i_destino			= @w_destino,
				@i_ciudad_destino	= @w_ciudad,
				@i_cliente			= @i_cliente,
				@i_tplazo_lcr		= @w_periodicidad,
				@i_operacion		= 'I',
				@o_tramite			= @w_tramite_out out,
				@s_user				= @s_user,
				@s_term				= @s_term,
				@s_ofi				= @s_ofi,
				@s_ssn				= @s_ssn,
				@s_lsrv				= @s_lsrv,
				@s_date				= @w_fecha_proceso
		
		end try
		begin catch 
		if @w_error <> 0 or @@error <> 0
		begin
			goto ERROR
		end
		end catch 
		
		-- POV-ini. generar el XML
		--Tramite
		select @w_tramite_prev = max(op_tramite) --KVI 20210729
        from cob_cartera..ca_operacion
        where op_cliente = @i_cliente
        and op_toperacion = 'REVOLVENTE'
        and op_estado not in (0,6)

		update cob_workflow..wf_inst_proceso 
		set io_campo_3 = @w_tramite_out,
		    io_campo_5 = @w_tramite_prev
		where io_id_inst_proc = @w_inst_proc
		
		select @w_inst_proc = io_id_inst_proc from cob_workflow..wf_inst_proceso where io_campo_3 = @w_tramite_out
		if @@rowcount = 0
		begin
		  select @w_error = 710601 -- ERROR EN ACTUALIZACION
		  --select @w_msg = 'No existe informacion para esa instancia de proceso'
		  goto ERROR
		end
		
		--Extraer ruc
		select @w_ced_ruc = en_ced_ruc from cobis..cl_ente where en_ente = @i_cliente
		
		if not exists (select 1 from cob_credito..cr_deudores where de_tramite = @w_tramite_out) 
		begin
			insert into cob_credito..cr_deudores
			select @w_tramite_out, @i_cliente, 'D', @w_ced_ruc, null, 'S'
			if @@error <> 0
			begin
			  select @w_error = 150000 -- ERROR EN INSERCION
			  goto ERROR
			end 
		end
		else
		begin
			update cob_credito..cr_deudores set 
			de_cliente = @w_cliente, 
			de_rol     = 'G',
			de_ced_ruc = null , 
			de_segvida = null, 
			de_cobro_cen = 'N'
			where de_tramite = @w_tramite_out
			if @@error <> 0
			begin
			  select @w_error = 710601 -- ERROR EN ACTUALIZACION
			  goto ERROR
			end
		end	
	   
	    if @w_commit = 'S'
		begin
		    print 'commit S'
		    PRINT @@trancount
			commit tran  -- Fin atomicidad de la transaccion
			select @w_commit = 'N'
		end
	end
	
	goto fin
end


goto fin
--Control errores
ERROR:

	if @w_commit = 'S'
	begin
		rollback tran
		select @w_commit = 'N'
	end
	
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_error
   return @w_error

fin:
   return 0

go
