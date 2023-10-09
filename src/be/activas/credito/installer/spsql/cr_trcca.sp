/***********************************************************************/
/*    Archivo:            cr_trcca.sp                                  */
/*    Stored procedure:   sp_tramite_cca                               */
/*    Base de Datos:      cob_credito                                  */
/*    Producto:           Credito                                      */
/*    Disenado por:       Myriam Davila                                */
/*    Fecha de Documentacion:     17/Mar/97                            */
/***********************************************************************/
/*            IMPORTANTE                                               */
/*    Este programa es parte de los paquetes bancarios propiedad de    */
/*    'MACOSA',representantes exclusivos para el Ecuador de la         */
/*    AT&T                                                             */
/*    Su uso no autorizado queda expresamente prohibido asi como       */
/*    cualquier autorizacion o agregado hecho por alguno de sus        */
/*    usuario sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante               */
/***********************************************************************/
/*            PROPOSITO                                                */
/*    Este stored procedure hace el ingreso de un nuevo                */
/*    registro   en la tabla cr_tramite, se dispara desde cartera      */
/*      y no crea los registros en la bdd de cartera                   */
/*      Se utiliza para crear operaciones directamente desde CCA       */
/***********************************************************************/
/*            MODIFICACIONES                                           */
/*    FECHA        AUTOR                  RAZON                        */
/*    17/Mar/97    Myriam Davila       Emision Inicial                 */
/*    19/Ene/97    Myriam Davila       Upgrade                         */
/*    12/Mar/99    S. Hernandez        Eliminacion getdate             */
/*    09/Ene/01    Zulma Reyes    ZR   GAP: CD00070                    */
/*    26/Ene/01    Zulma Reyes   (ZR1) GAP: CD00056 TEQUENDAMA         */
/*    05/Feb/01    Zulma Reyes   (ZR2) GD00064 TEQUENDAMA              */
/*    03/Jul/01    Sheela Burbano      Interfaces                      */
/*    07/Abr/17    Milton Custode      Ingreso del rol G grupales      */
/*    12/May/17    Luis Ponce           Campos nuevos Tramites Grupales*/
/*    24/Oct/17    Paul Ortiz          Parametro Garatia Liquida       */
/*    26/Ago/19    Nathali Mejia        Campos nuevos para actualizar  */
/*    05-07-2019   srojas              Reestructuración Buro histórico */
/*    19-11-2019   ACH                 Cambio PORCGP por PGARGR #129986*/
/*    08-01-2020   ACH                 LGU - Caso#133202               */
/***********************************************************************/


use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_tramite_cca')
   drop proc sp_tramite_cca
go

create proc sp_tramite_cca (
   @s_ssn                int           = null,
   @s_user               login         = null,
   @s_sesn               int           = null,
   @s_term               varchar(30)   = null,
   @s_date               datetime      = null,
   @s_srv                varchar(30)   = null,
   @s_lsrv               varchar(30)   = null,
   @s_ofi                smallint      = null,
   @t_trn                smallint      = 21020,
   @t_debug              char(1)       = 'N',
   @t_file               varchar(14)   = null,
   @t_from               varchar(30)   = null,
   @i_tipo               char(1)       = null,
   @i_oficina_tr         smallint      = null,
   @i_usuario_tr         login         = null,
   @i_fecha_crea         datetime      = null,
   @i_oficial            smallint      = null,
   @i_sector             catalogo      = null,
   @i_ciudad             int           = null,
   @i_nivel_ap           tinyint       = null,
   @i_fecha_apr          datetime      = null,
   @i_usuario_apr        login         = null,
   @i_banco              cuenta        = null,
   @i_linea_credito      cuenta        = null,
   @i_toperacion         catalogo      = null,
   @i_producto           catalogo      = null,
   @i_monto              money         = 0,
   @i_moneda             tinyint       = 0,
   @i_periodo            catalogo      = null,
   @i_num_periodos       smallint      = 0,
   @i_destino            catalogo      = null,
   @i_ciudad_destino     int           = null,
   @i_cuenta_corriente   cuenta        = null,
--   @i_garantia_limpia    char = null,
   @i_renovacion         smallint      = null,
   @i_cliente            int           = null,   --SBU: 02/mar/2000
   @i_clase              catalogo      = null,   --AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           money         = null,
   @i_monto_des          money         = null,
   @i_grupal             char(1)       = null,     --MCU ingreso del rol grupal
   @i_promocion          char(1)       = null, --LPO Santander
   @i_acepta_ren         char(1)       = null, --LPO Santander
   @i_no_acepta          char(1000)    = null, --LPO Santander
   @i_emprendimiento     char(1)       = null, --LPO Santander
   @i_participa_ciclo    char(1)       = null, --LPO Santander
   @i_monto_aprobado     money         = null, --LPO Santander
   @i_garantia           float         = null, --LPO Santander
   @i_ahorro             money         = null, --LPO Santander
   @i_monto_max          money         = null, --LPO Santander
   @i_bc_ln              char(10)      = null, --LPO Santander   
   @i_plazo              int           = null, --Santander -- tr_plazo
   @i_tplazo             catalogo      = null, --Santander -- tr_tipo_plazo
   @i_alianza            int           = null,
   @i_experiencia_cli    char(1)       = null, --Santander
   @i_monto_max_tr       money         = null, --Santander
   @i_naturaleza         varchar(10)   = NULL,
   @i_tplazo_lcr         catalogo      = null,
   @i_operacion          char(1)       = 'I',
   @i_tramite            int           = null,
   @o_tramite            int           = null out
)
as


declare
@w_today              datetime,     -- FECHA DEL DIA
@w_return             int,          -- VALOR QUE RETORNA
@w_sp_name            varchar(32),  -- NOMBRE STORED PROC
@w_tramite            int,
@w_numero_linea       int,
@w_miembros           int,          --miembros que conforman el grupo
@w_operacion          int,          --Operacion temporal
@w_max_tramite        int,         -- LGU max tramite grupal
@w_toperacion         varchar(10), -- LGU tipo de operacion interciclo
@w_grupo_id           INT,          -- LGU id del grupo del interciclo
@w_grupo              INT,
@w_tramite_ant        INT,
@w_fecha_pro          datetime,
@w_max_tramite_grupal int,
@w_cliente_tmp        int,
@w_monto_ant          money,
@w_ciclo_grupal       int,
@w_parm_ofi_movil     int,
@w_promo_movil        char(1),
@w_integ_promo        int,
@w_credito_extra      money,
@w_folio_buro         varchar(64),
@w_comentario 	      varchar(510),
@w_integrantes        int,
@w_resultado          varchar(30),
@w_variables          varchar(255),
@w_result_values      varchar(255),
@w_parent             varchar(255),
@w_numero             int,
@w_proceso		      varchar(5),
@w_promocion 	      char(1),
@w_asig_act		      int,
@w_nombre		      varchar(50),
@w_clientes_ext	      int,
@w_numero_actual      int, 
@w_cliente_consultado int

print 'SMO @i_promocion '+@i_promocion
--EN EL CREATE desde el APP enviar M con eso se sabria que es desde el app

select @w_sp_name = 'sp_tramite_cca'
/*select @w_today = isnull(@s_date, getdate())  SMHB */
select @w_today = @s_date    --SMHB


select @w_parm_ofi_movil = pa_smallint from cobis..cl_parametro where pa_nemonico = 'OFIAPP' and pa_producto = 'CRE'
select @w_promo_movil = 'N'
select @w_comentario=''

if(@i_operacion = 'I')
begin
	if @i_oficina_tr = @w_parm_ofi_movil begin

	   	select @i_oficina_tr	 = fu_oficina	
		from   cobis..cl_funcionario, 
	    cobis..cc_oficial
		where  	oc_oficial     = @i_oficial
		and oc_funcionario = fu_funcionario
	end
	
	if @i_linea_credito is not null
	begin
	   select
	   @w_numero_linea = li_numero
	   from      cob_credito..cr_linea
	   where   li_num_banco = @i_linea_credito
	   if @@rowcount = 0
	   begin
	      /** REGISTRO NO EXISTE **/
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2101010
	      return 1
	   end
	end
	
	-- OBTENCION DE PARAMETROS NO ENVIADOS ***********
	select @i_usuario_tr = isnull(@i_usuario_tr, @s_user)
	
	select
	@i_ciudad = of_ciudad
	from   cobis..cl_oficina
	where  of_oficina = @i_oficina_tr
	set transaction isolation level read uncommitted
	
	select @i_fecha_apr = isnull(@i_fecha_apr, @s_date)
	
	select @i_usuario_apr = isnull(@i_usuario_apr, @s_user)
	
	-- select @i_garantia_limpia = isnull(@i_garantia_limpia, 'S')
	
	select @i_garantia = (select pa_float from cobis..cl_parametro where pa_nemonico = 'PGARGR' and pa_producto = 'CCA') -- antes PORCGP
	 
	select @i_renovacion = isnull(@i_renovacion, 0)
	
	if @i_tipo is null             --SBU interfaces
	begin
	   if @i_renovacion = 0
	      select @i_tipo = 'O'
	   else
	      select @i_tipo = 'R'
	end
	
	-- INICIO DE TRANSACCION ***********
	begin tran
	   /* NUMERO SECUENCIAL DE TRAMITE */
	   exec cobis..sp_cseqnos
	   @t_debug = @t_debug,
	   @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_tabla = 'cr_tramite',
	   @o_siguiente = @w_tramite out
	
	   if @w_tramite is NULL
	   begin
	      /* NO EXISTE TABLA EN TABLA DE SECUENCIALES*/
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2101007
	      return 1
	   end
	   
	   --MTA Validar fecha de creacion del tramite
	   select @w_fecha_pro = fp_fecha from cobis..ba_fecha_proceso 
	   if (@w_today > @w_fecha_pro)
	   begin
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 101140 --fecha incongruentes
	      return 1
	   end   
	   	   
	   select @w_folio_buro = ib_folio
	   from cr_interface_buro 
	   where ib_cliente = @i_cliente
	   and   ib_estado  = 'V'
	   
	   /* INSERCION EN LA TABLA CR_TRAMITE */
	   insert into cr_tramite
	   (tr_tramite,         tr_tipo,             tr_oficina,          tr_usuario,          tr_fecha_crea,          tr_oficial,          tr_sector,
	    tr_ciudad,          tr_estado,           tr_nivel_ap,         tr_fecha_apr,        tr_usuario_apr,         tr_truta,            tr_secuencia,
	    tr_numero_op,       tr_numero_op_banco,  tr_proposito,        tr_razon,            tr_txt_razon,           tr_efecto,           tr_cliente,
	    tr_grupo,           tr_fecha_inicio,     tr_num_dias,         tr_per_revision,     tr_condicion_especial,  tr_linea_credito,    tr_toperacion,
	    tr_producto,        tr_monto,            tr_moneda,           tr_periodo,          tr_num_periodos,        tr_destino,          tr_ciudad_destino,
	    tr_cuenta_corriente,tr_renovacion,       tr_clase,            tr_sobrepasa,        tr_reestructuracion,    tr_concepto_credito, tr_aprob_gar,
	    tr_cont_admisible,  tr_montop,           tr_monto_desembolsop,tr_grupal,           tr_promocion,           tr_acepta_ren,       tr_no_acepta,
	    tr_emprendimiento,  tr_porc_garantia,    tr_plazo,            tr_tipo_plazo,       tr_alianza,             tr_experiencia,      tr_monto_max,
	    tr_periodicidad_lcr, tr_folio_buro)
	   values
	   (@w_tramite,         @i_tipo,             @i_oficina_tr,       @i_usuario_tr,       @w_today,               @i_oficial,          @i_sector,
	    @i_ciudad,          'A',                 @i_nivel_ap,         @i_fecha_apr,        @i_usuario_apr,         0,                   0,
	    null,               null,                null,                null,                null,                   null,                @i_cliente,
	    null,               null,                null,                null,                null,                   @w_numero_linea,     @i_toperacion,
	    @i_producto,        @i_monto,            @i_moneda,           @i_periodo,          @i_num_periodos,        @i_destino,          @i_ciudad_destino,
	    @i_cuenta_corriente,@i_renovacion,       @i_clase,            'N',                 'N',                    '3',                 '3',
	    'N',                @i_monto_mn,         @i_monto_des,        @i_grupal,           @i_promocion,           @i_acepta_ren,       @i_no_acepta,
	    @i_emprendimiento,  @i_garantia,         @i_plazo,            @i_tplazo,           @i_alianza,             @i_experiencia_cli, 
		@i_monto_max_tr,    @i_tplazo_lcr,       @w_folio_buro)
	
	   if @@error <> 0
	   begin
	      /* ERROR EN INSERCION DE REGISTRO */
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2103001
	      return 1
	   end
	
	   -- TRANSACCION DE SERVICIO
	   insert into ts_tramite (
	   secuencial, tipo_transaccion, clase,
	   fecha, usuario, terminal,
	   oficina, tabla, lsrv,
	   srv, tramite, tipo,
	   oficina_tr, usuario_tr, fecha_crea,
	   oficial, sector, ciudad,
	   estado, nivel_ap, fecha_apr,
	   usuario_apr, truta, secuencia,
	   numero_op, numero_op_banco, proposito,
	   razon, txt_razon, efecto,
	   cliente, grupo, fecha_inicio,
	   num_dias, per_revision, condicion_especial,
	   linea_credito, toperacion, producto,
	   monto, moneda, periodo,
	   num_periodos, destino, ciudad_destino,
	   cuenta_corriente, /* garantia_limpia,*/ renovacion,
	   clasecca, reestructuracion, concepto_credito,     --ZR y ZR1
	   aprob_gar, cont_admisible, alianza, exp_cliente, monto_max_tr)     --ZR1 y ZR2
	   values(
	   @s_ssn, @t_trn, 'N',
	   @s_date, @s_user, @s_term,
	   @s_ofi, 'cr_tramite', @s_lsrv,
	   @s_srv, @w_tramite, @i_tipo,
	   @i_oficina_tr, @i_usuario_tr, @w_today,
	   @i_oficial, @i_sector, @i_ciudad,
	   'N', @i_nivel_ap, @i_fecha_apr,
	   @i_usuario_apr, 0, 0,
	   null, null, null,
	   null, null, null,
	   @i_cliente, null, null,    --null, SBU: 02/mar/2000
	   null, null, null,
	   @w_numero_linea, @i_toperacion, @i_producto,
	   @i_monto, @i_moneda, @i_periodo,
	   @i_num_periodos, @i_destino, @i_ciudad_destino,
	   @i_cuenta_corriente, /*@i_garantia_limpia,*/ @i_renovacion,
	   @i_clase, 'N', '3',        --ZR y ZR1 emg Jun-19-01 cambio concepto credito y aprob garantia
	   '3', 'N', @i_alianza,   @i_experiencia_cli,   @i_monto_max_tr )            -- ZR1 y ZR2
	
	   if @@error <> 0
	   begin
	      /* ERROR EN INSERCION DE TRANSACCION DE SERVICIO */
	      exec cobis..sp_cerror
	      @t_debug = @t_debug,
	      @t_file  = @t_file,
	      @t_from  = @w_sp_name,
	      @i_num   = 2103003
	      return 1
	   end
	
	   --PRINT 'OBTENER NUMERO DE OPERACION DESDE TEMPORAL'
	   select
	   	@w_operacion    = opt_operacion,
	   	@w_toperacion   = opt_toperacion
	   from   cob_cartera..ca_operacion_tmp
	   where  opt_banco = @i_banco
	
		-- LGU-ini 10/abr/2017 ver si es una interciclo
		if exists(select 1 from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla = 'ca_interciclo' and t.codigo = c.tabla and c.codigo = @w_toperacion)
		begin
			-- buscar el tramite, operacion y banco GRUPAL
		   select @w_grupo_id = cg_grupo
		   from   cobis..cl_cliente_grupo
		   where  cg_ente = @i_cliente
	
			select
				@w_max_tramite = max(tg_tramite)
			from cob_credito..cr_tramite_grupal
			where tg_grupo = @w_grupo_id
	           
		   insert into cob_credito..cr_tramite_grupal
		   (tg_tramite,             tg_grupo,           tg_cliente,   tg_monto,
		    tg_grupal,              tg_operacion,       tg_prestamo,  tg_referencia_grupal,
	            tg_participa_ciclo,     tg_monto_aprobado,  tg_ahorro,
	            tg_monto_max,           tg_bc_ln)
		   select top 1
		    tg_tramite,             @w_grupo_id,        @i_cliente,   @i_monto,
		    @i_grupal,              @w_operacion,       @i_banco,     tg_referencia_grupal,
	            @i_participa_ciclo,     @i_monto_aprobado,  @i_ahorro,
	            @i_monto_max,           @i_bc_ln
		   from cob_credito..cr_tramite_grupal
		   where tg_tramite = @w_max_tramite
	           
		   if @@error <> 0
		   begin
		      /* ERROR EN INSERCION DE REGISTRO */
		      exec cobis..sp_cerror
		      @t_debug = @t_debug,
		      @t_file  = @t_file,
		      @t_from  = @w_sp_name,
		      @i_num   = 2103001
		      return 1
		   end
		end
		else
			if @i_grupal = 'S'
			begin
				-- PARA operaciones GRUPALES
			   select @w_miembros = count(1)
			   from   cobis..cl_cliente_grupo
			   where  cg_grupo = @i_cliente and cg_estado='V'
			   
			   declare @w_val_ahorro_vol int
			   select  @w_val_ahorro_vol = pa_int from cobis..cl_parametro where pa_nemonico = 'VAHVO' and pa_producto = 'CRE'
	
			   --PRINT 'OBTENER NUMERO DE OPERACION DESDE TEMPORAL'
			   select  @w_operacion    = opt_operacion
			   from   cob_cartera..ca_operacion_tmp
			   where  opt_banco = @i_banco
	
			   if @w_operacion is null or @i_banco is null
			   begin
			      /* ERROR EN INSERCION DE REGISTRO */
			      exec cobis..sp_cerror
			      @t_debug = @t_debug,
			      @t_file  = @t_file,
			      @t_from  = @w_sp_name,
				  @i_msg   = 'tramite_cca: BCO, REF_GRUPAL, OP no pueden ser nulos',
			      @i_num   = 2103001
			      return 1
			   end
	
            --Obtiene el ultimo tramite del grupo
	  		select
			@w_max_tramite_grupal = max(tg_tramite)
	   		from cob_credito..cr_tramite_grupal
	   		where tg_grupo = @i_cliente
		
		
                 insert into cob_credito..cr_tramite_grupal
			   (tg_tramite,             tg_grupo,                       tg_cliente,        tg_monto,             tg_grupal,     tg_operacion,     tg_prestamo,  tg_referencia_grupal,
	            tg_participa_ciclo,     tg_monto_aprobado,              tg_ahorro,         tg_monto_max,         tg_bc_ln)
			   select                                                                      
			    @w_tramite,             @i_cliente,                     cg_ente,           0,                    @i_grupal,     @w_operacion,     @i_banco,     @i_banco,
	            'N',                    0,                              @w_val_ahorro_vol, @i_monto_max,         @i_bc_ln
			   from cobis..cl_cliente_grupo
			   where cg_grupo = @i_cliente and cg_estado='V'
	                   
			   if @@error <> 0
			      begin
			      /* ERROR EN INSERCION DE REGISTRO */
			      exec cobis..sp_cerror
			      @t_debug = @t_debug,
			      @t_file  = @t_file,
			      @t_from  = @w_sp_name,
			      @i_num   = 2103001
			      return 1
               end
			      
				
		   exec cob_credito..sp_var_integrantes_original
			@i_id_inst_proc=-1,
			@i_id_inst_act=1,
			@i_id_asig_act =1,
			@i_id_empresa =1,
   			@i_id_variable =1,
			@i_tramite = @w_tramite,
			@i_grupo   = @i_cliente,
			@i_ttramite  = 'GRUPAL'

			 
		 --EJECUTA LA REGLAS MONTO GRUPAL E INCREMENTO GRUPAL
               exec @w_return = sp_grupal_reglas
                @s_ssn     = @s_ssn ,
               -- @s_rol     = @s_rol ,
                @s_ofi     = @s_ofi ,
                @s_sesn    = @s_sesn ,
                @t_trn     = 1111    ,
                @s_user    = @s_user ,
                @s_term    = @s_term ,
                @s_date    = @s_date ,
                @s_srv     = @s_srv ,
                @s_lsrv    = @s_lsrv ,
                @i_tramite = @w_tramite,
				@i_valida_part = 'N',
                @i_id_rule = 'INC_GRP'  -- encontral el % incremento y monto de ultima operacion cancelada
                
               if @w_return <> 0 
               begin
				  exec cobis..sp_cerror
			      @t_debug = @t_debug,
			      @t_file  = @t_file,
			      @t_from  = @w_sp_name,
			      @i_num   = 21008,
				  @i_msg   = 'Error al determinar PORCENTAJE DE INCREMENTO'
                end


              exec @w_return = sp_grupal_reglas
                @s_ssn     = @s_ssn ,
                --@s_rol     = @s_rol ,
                @s_ofi     = @s_ofi ,
                @s_sesn    = @s_sesn ,
                @t_trn     = 1111    ,
                @s_user    = @s_user ,
                @s_term    = @s_term ,
                @s_date    = @s_date ,
                @s_srv     = @s_srv ,
                @s_lsrv    = @s_lsrv ,
                @i_tramite = @w_tramite,
				@i_grupo   = @i_cliente,
				@i_valida_part = 'N',
                @i_id_rule = 'MONTO_GRP'  -- encontrar el monto maximo del cliente

                  if @w_return <> 0 
                  begin
				  exec cobis..sp_cerror
			      @t_debug = @t_debug,
			      @t_file  = @t_file,
			      @t_from  = @w_sp_name,
			      @i_num   = 21009,
				  @i_msg   =  'Error al determinar MONTO MAXIMO'
			   end
			
                /* se mueve el codigo porque solo debe 
                ejecutarse en grupales */
                -- ini ********************************
			select @w_ciclo_grupal = isnull(gr_num_ciclo,0) +1
		   from   cobis..cl_grupo
		   where  gr_grupo = @i_cliente
		   
		   
	  	   exec cob_credito..sp_monto_inicial
	  	   @i_tramite        = @w_tramite,
    	   @i_grupo          = @i_cliente,
    	   @i_promocion      = @i_promocion
			
                -- fin ********************************

            end -- if @i_grupal = 'S'
            
commit tran

select @o_tramite = @w_tramite

end

if(@i_operacion = 'U')
begin
	
	/* Actualizar frecuencia de Pago LCR */
   if exists (select 1 from cob_credito..cr_tramite where tr_tramite = @i_tramite) begin
      select @w_folio_buro = ib_folio
      from cr_interface_buro 
      where ib_cliente = @i_cliente
      and   ib_estado  = 'V'
	   
      update cob_credito..cr_tramite set
      tr_periodicidad_lcr 	= @i_tplazo_lcr,
      tr_folio_buro         = @w_folio_buro
      where tr_tramite = @i_tramite
      
      if @@error <> 0 begin
         /* ERROR EN INSERCION DE REGISTRO */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 2105001
         return 1
      end
		
	end
	
end

go
