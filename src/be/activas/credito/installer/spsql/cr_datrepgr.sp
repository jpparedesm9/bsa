/************************************************************/
/*   ARCHIVO:         cr_datrepgrp.sp                       */
/*   NOMBRE LOGICO:   sp_datos_reportes_miembro             */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Consulta la informacion para generacion de reportes de  */
/*  Prestamos Grupales.                                     */
/*  Operacion Q   RPT Cargo Recurrente por miembro          */
/*  Operacion Q1  RPT Pagare por miembro                    */
/*  Operacion Q2  RPT Caratula Credito Grupal-Main          */
/*  Operacion Q3  RPT Caratula Credito Grupal-ListaDePagos  */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR            RAZON                   */
/* 28/JUN/2017     WToledo          Emision Inicial         */
/* 08/MAR/2019   P. Ortiz Vera      Reporte Caratula LCR    */
/* 06/JUN/2019   ACHP               Envio decimales #118579 */
/* 27/ABR/2020   ACHP               Cambo PlazoCredit#138691*/
/* 08/Sep/2020   PMora              Req.140073              */
/* 24/Sep/2021   KVI                Req.167892              */
/* 13/Jul/2021	 DGA			    Req. 142165 Regla Pago 	*/
/*									Minimo CAT LCR		    */
/* 22/04/2022    ACH                182380,nombre comer prod*/
/************************************************************/
use cob_credito
go

if exists(select 1 from sysobjects where name = 'sp_datos_reportes_miembro')
    drop proc sp_datos_reportes_miembro
go

CREATE proc sp_datos_reportes_miembro (
	@s_ssn       int         = null,
	@s_sesn      int         = null,
	@s_ofi       smallint    = null,
	@s_rol       smallint    = null,
	@s_user      login       = null,
	@s_date      datetime    = null,
	@s_term      descripcion = null,
	@t_debug     char(1)     = 'N',
	@t_file      varchar(10) = null,
	@t_from      varchar(32) = null,
	@s_srv       varchar(30) = null,
	@s_lsrv      varchar(30) = null,
	@i_modo      int         = null,
	@i_operacion char(2),
	@i_tramite   int         = null,
	@i_formato_fecha int     = null
)
as
declare
@w_sp_name 				varchar(20),
@w_operacion         int,
@w_costo_anual_tot   money,
@w_tasa_int_anual    money,
@w_monto_credito     money,
@w_monto_tot_pag     money,
@w_lista_comisiones  varchar(300),
@w_porcentaje_mora   float,
@w_plazo_credito     varchar(50),
@w_desc_plz_cred     varchar(100),
@w_desc_moneda       varchar(100),
@w_nombre_comision   varchar(64), 
@w_valor_comis       float,
@w_monto_max_fijo    money,
@w_fecha_liq         datetime,
@w_monto_letra		   varchar(254),
@w_id_cliente        int,
@w_nombres           varchar(254),
@w_interes           float,
@w_direccion         varchar(254),
@w_id_tramite        int,
-- ----------------------------
@w_monto          money,
-- ----------------------------
@w_moneda				smallint,
@w_return				int,
@w_fecha_corte       datetime,
@w_fecha_pago        datetime,
@w_toperacion        varchar(10),
@w_toperacion_tr     catalogo,
@w_cliente           int,
@w_tmercado          catalogo,
@w_variables         varchar(255),
@w_result_values     varchar(255),
@w_parent            int,
@w_ciclo             int,
@w_valores_enviar    varchar(255),
@w_error             int,
@w_inst_proc         int,
@w_cat               float,
@w_tir               float, 
@w_tea               float,
@w_plazo_lcr         catalogo,
@w_fecha_corte_lcr   varchar(255),
@w_fecha_pago_lcr    varchar(255),
@w_operacion_padre   int,
@w_banco_padre       cuenta,
@w_fecha_proceso     datetime,
@w_codigo_act_rev    int,
@w_analista_op       varchar(30),
@w_ssn               int,
@w_sesn              int,
@w_msg               varchar(255),



-- Req. 167892 parametria ajustes regla --
@w_porcentaje_com           float,
@w_resultado_com            varchar(200),
@w_param_comision           float,
@w_param_regla              varchar(50),
@w_param_colectivo          varchar(30),  
@w_param_nivel_colectivos   varchar(30),
@w_tipo_mercado             varchar(30), 
@w_nivel_cliente            varchar(30),
    

@w_desplazamiento    int, 
@w_cat_caratula		 float,			--Req. 142165     
@w_nombre_comercial_prod    varchar(255),
@w_tabla_cod_txd int

select @w_sp_name = 'sp_datos_reportes_miembro'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select @w_tabla_cod_txd = codigo from cobis..cl_tabla where tabla = 'cr_txt_documento'
		
if @i_formato_fecha is null
begin
	select @i_formato_fecha=103
end

if not exists (select 1 from cr_tramite where tr_tramite=@i_tramite)
begin
	exec cobis..sp_cerror
		 @t_debug = @t_debug,
		 @t_file  = @t_file,
		 @t_from  = @w_sp_name,
		 @i_num   = 2108034,
		 @i_msg   = "NO EXISTE TRAMITE"
	return 2108034
end

select @w_toperacion_tr = tr_toperacion from cr_tramite where tr_tramite = @i_tramite

if @w_toperacion_tr = 'REVOLVENTE'
begin
	select @w_monto_max_fijo  = tr_monto,
	    @w_moneda          = tr_moneda,
	    @w_toperacion_tr   = tr_toperacion
	from cr_tramite
	where tr_tramite = @i_tramite
end
else
begin
	select @w_operacion       = tg_operacion,
	    @w_monto_max_fijo  = tr_monto,
	    @w_moneda          = tr_moneda,
	    @w_toperacion_tr   = tr_toperacion,	   
        @w_banco_padre     = tg_referencia_grupal
	from cr_tramite, cr_tramite_grupal
	where tr_tramite = tg_tramite 
	and tr_tramite = @i_tramite
	
	select @w_operacion_padre =op_operacion
	from cob_cartera..ca_operacion
	where op_banco = @w_banco_padre
	
	if @w_operacion is null and @i_operacion = 'Q3'
	begin
	   select @w_operacion = op_operacion 
	     from cob_cartera..ca_operacion 
	    where op_tramite = @i_tramite  
	end
end
   
if @i_operacion ='Q' --RPT Cargo Recurrente
begin
   
   select @w_toperacion = op_toperacion from cob_cartera..ca_operacion where op_tramite = @i_tramite 

   if(@w_toperacion = 'GRUPAL')
   begin
       select 'NOMBRE_CLI'         = (select UPPER(isnull(en_nombre,''))+' '+UPPER(isnull(p_s_nombre,''))+' '+UPPER(isnull(p_p_apellido,''))+' '+UPPER(isnull(p_s_apellido,''))),
              'NUM_CTA_TARJ'       = ea_cta_banco,
              'MONTO_MAX'          = @w_monto_max_fijo,
              'PERIODICIDAD'       = td_descripcion,
              'FECH_VENC'          = di_fecha_ven,
              'NUM_CREDITO'        = op_banco,
	    	  'IMPORTE_SEM_APAGAR' = (SELECT sum(am_cuota) from cob_cartera..ca_amortizacion 
                                      WHERE am_dividendo = 1 AND am_operacion = OP.op_operacion),
              'FECHA_LIQUID'       = op_fecha_liq
         from cob_credito..cr_tramite_grupal,
              cob_cartera..ca_operacion OP,
              cobis..cl_ente,
              cobis..cl_ente_aux,
              cob_cartera..ca_dividendo,
              cob_cartera..ca_tdividendo
        where tg_tramite    = @i_tramite
          and tg_operacion  = op_operacion
          and tg_operacion  = di_operacion
          and tg_cliente    = en_ente
          and tg_cliente    = ea_ente
	      and tg_participa_ciclo = 'S'
	      and tg_monto_aprobado > 0
          and op_tdividendo = td_tdividendo
          and di_dividendo  = (select max(di_dividendo) 
                                 from cob_cartera..ca_dividendo di
                                where di.di_operacion = op_operacion)
        order by ea_ente   
   end
   else
   begin
     select @w_operacion = op_operacion 
       from cob_cartera..ca_operacion 
      where op_tramite = @i_tramite

     -- Se toma del sp cob_credito..sp_datos_credito operacion Q2
     select @w_monto_max_fijo = tr_monto
     from   cob_credito..cr_tramite,
            cob_credito..cr_deudores,
            cob_cartera..ca_operacion,
            cob_cartera..ca_default_toperacion
     where  tr_tramite    = @i_tramite
     and    tr_tramite    = de_tramite
     and    tr_tramite    = op_tramite
     and    dt_toperacion = op_toperacion
   
     select 'NOMBRE_CLI' = (select UPPER(isnull(en_nombre,''))+' '+UPPER(isnull(p_s_nombre,''))+' '+UPPER(isnull(p_p_apellido,''))+' '+UPPER(isnull(p_s_apellido,''))),
            'NUM_CTA_TARJ' = ea_cta_banco,
            'MONTO_MAX'    = @w_monto_max_fijo,
            'PERIODICIDAD' = td_descripcion,
            'FECH_VENC'    = op_fecha_fin,
            'NUM_CREDITO'  = op_banco,
            'IMPORTE_SEM_APAGAR' = (SELECT sum(am_cuota) from cob_cartera..ca_amortizacion 
                                  WHERE am_dividendo = 1 AND am_operacion = OP.op_operacion),
            'FECHA_LIQUID' = op_fecha_liq								  
     from  cob_cartera..ca_operacion OP,
           cobis..cl_ente,
           cobis..cl_ente_aux,
           cob_cartera..ca_tdividendo
     where op_operacion  = @w_operacion
     and   en_ente = op_cliente
     and   en_ente    = ea_ente
     and   op_tdividendo = td_tdividendo
     order by ea_ente
   end   
   return 0
end --@i_operacion='Q' FIN

if @i_operacion ='Q1' --RPT Pagare
begin
   create table #cr_tmp_tramite_pagare(
   tp_id_cliente     int null,
   tp_nombres        varchar(254) null,
   tp_monto          money null,
   tp_monto_letra    varchar(254) null,
   tp_id_tramite     int null,
   tp_interes        float null,
   tp_direccion      varchar(254) null)

   declare c_tramite_pagare cursor for
    select tg_cliente, 
           en.en_nomlar, 
           tg_monto,  
           CAST(tg_monto AS VARCHAR(254)),  
           op_tramite, 
           ro.ro_porcentaje,
          (select ci_descripcion + ', ' + 
                  pq_descripcion + ' - ' + 
                  isnull(di_descripcion,'') + ' ' + 
                  isnull(di_calle,'') + ' ' + 
                  isnull(convert(varchar,di_nro),'' )
             from cobis..cl_direccion,cobis..cl_parroquia, cobis..cl_ciudad 
            where di_ente = tg.tg_cliente and di_tipo in ('RE','AE')
              and di_principal = 'S'
              and pq_parroquia = di_parroquia
              and ci_ciudad = di_ciudad)

     from cob_credito..cr_tramite_grupal tg,
          cobis..cl_ente en,
          cob_cartera..ca_rubro_op ro,
			 cob_cartera..ca_operacion 
    where tg.tg_cliente   = en.en_ente
      and ro.ro_operacion = tg.tg_operacion
      and ro_concepto     ='INT'
      and tg.tg_tramite   = @i_tramite
			and op_operacion = tg_operacion
         and tg_monto != 0
     for read only

    open c_tramite_pagare
   fetch c_tramite_pagare
    into @w_id_cliente , @w_nombres , @w_monto , @w_monto_letra,
         @w_id_tramite , @w_interes , @w_direccion
   while @@fetch_status = 0
   begin
      exec @w_return = cob_interfase..sp_numeros_letras 
      @i_dinero = @w_monto,
      @i_moneda = @w_moneda,
      @i_idioma = 'E',
      @t_trn	 = 29322,
      @o_texto	 = @w_monto_letra out
      
      if(@w_return <> 0)
      begin 
         exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = @w_return,
          @i_msg   = "ERRO AL TRANSFORMAR MONTO"
         return @w_return
      end
      
      insert into #cr_tmp_tramite_pagare
      values(@w_id_cliente, @w_nombres, @w_monto, @w_monto_letra, @w_id_tramite, @w_interes, @w_direccion)

	fetch c_tramite_pagare
    into @w_id_cliente , @w_nombres , @w_monto , @w_monto_letra,
         @w_id_tramite , @w_interes , @w_direccion   
   end
   close c_tramite_pagare
   deallocate c_tramite_pagare

   select 'ID_CLIENTE'  = tp_id_cliente,
          'NOMBRE_CLI'  = tp_nombres,
          'MONTO'       = tp_monto,
          'MONTO_LETRA' = tp_monto_letra,
          'ID_TRAMITE'  = tp_id_tramite,
          'INTERES'     = tp_interes,
          'DIRECCION'	= tp_direccion     
   from #cr_tmp_tramite_pagare
   return 0
end --@i_operacion='Q1' FIN

if @i_operacion = 'Q2' --RPT Caratula Credito Grupal
begin
   /* Obtener instancia de proceso */
   select @w_inst_proc = io_id_inst_proc from cob_workflow..wf_inst_proceso where io_campo_3 = @i_tramite
   
   select @w_tasa_int_anual = ro_porcentaje--ro_porcentaje_efa 
     from cob_cartera..ca_rubro_op 
    where ro_operacion = @w_operacion 
      and ro_concepto  = 'INT'

   select @w_monto_credito = tr_monto,
          @w_desc_moneda   = mo_descripcion
     from cr_tramite, cobis..cl_moneda
    where tr_tramite = @i_tramite
      and mo_moneda  = tr_moneda
   
   if @w_toperacion_tr = 'REVOLVENTE'
      select @w_monto_tot_pag = sum(am_cuota) 
      from cob_cartera..ca_amortizacion 
      where am_operacion = @w_operacion
   else
   select @w_monto_tot_pag = sum(am_cuota) 
     from cob_cartera..ca_amortizacion 
      where am_operacion = @w_operacion_padre
      and   am_concepto  in ('CAP', 'INT', 'IVA_INT', 'IVA_ESPERA', 'INT_ESPERA')
   
   select @w_porcentaje_mora = (vd_valor_default / 12)
     from cob_cartera..ca_valor_det
    where vd_tipo   = 'TCMORA'
      and vd_sector = (select dt_clase_sector 
                         from cob_cartera..ca_default_toperacion 
                        where dt_toperacion = 'GRUPAL')

    select @w_lista_comisiones = ''

   declare c_comis_prest_grp cursor for
    select va_descripcion, vd_valor_default
      from cob_cartera..ca_valor_det, cob_cartera..ca_valor
   where vd_tipo   in ('TCMORA','TPREPAGO')
       and vd_sector = (select dt_clase_sector 
                         from cob_cartera..ca_default_toperacion 
                        where dt_toperacion = 'GRUPAL')
       and va_tipo = vd_tipo
       for read only

      open c_comis_prest_grp 
	  fetch c_comis_prest_grp 
      into @w_nombre_comision, @w_valor_comis
     while @@fetch_status = 0
     begin
           if(@w_lista_comisiones != '')
           begin
               select @w_lista_comisiones = @w_lista_comisiones + '; '
           end
           select @w_lista_comisiones = @w_lista_comisiones + @w_nombre_comision + ': ' + convert(varchar,@w_valor_comis) + '%'
           fetch c_comis_prest_grp into @w_nombre_comision, @w_valor_comis
     end --while @@fetch_status = 0
   close c_comis_prest_grp
	deallocate c_comis_prest_grp

   select @w_desc_plz_cred  = case when ltrim(c.codigo) = 'BW' then 'CATORCENAS'
                                   when ltrim(c.codigo) = 'M' then 'MESES'
								   when ltrim(c.codigo) = 'W' then 'SEMANAS' else '' end,
          @w_plazo_credito  = op_plazo,
          --@w_plazo_credito  = round(datediff(dd, op_fecha_ini, op_fecha_fin)/(SELECT td_factor FROM cob_cartera..ca_tdividendo where td_tdividendo = op_tplazo),0), --op_plazo,
          @w_fecha_liq      = op_fecha_liq,
          @w_costo_anual_tot= round(op_valor_cat,2,0),
		  @w_desplazamiento = isnull(op_desplazamiento,0),
		  @w_nombre_comercial_prod = op_promocion -- Para grupal
     from cob_cartera..ca_operacion,
          cobis..cl_tabla t,
          cobis..cl_catalogo c
    where op_tramite = @i_tramite
      and op_tplazo  = c.codigo
      and c.tabla = t.codigo
      and t.tabla = 'cr_tplazo_ind'

   --Fecha limite de pago
   SELECT @w_fecha_pago = di_fecha_ven
     FROM cob_cartera..ca_dividendo 
	WHERE di_operacion  = @w_operacion 
	  AND di_dividendo  = 1
	
	--Fecha de corte
	
	 SELECT @w_fecha_corte =op_fecha_liq
     FROM cob_cartera..ca_operacion 
	 WHERE op_operacion  = @w_operacion 
	
   /* SELECT @w_fecha_corte = fp_fecha 
	  FROM cobis..ba_fecha_proceso*/

   -- DESA: Parametro Pendiente @w_costo_anual_tot
    --select @w_costo_anual_tot  = convert(float,40.5) --aca hacer el cambio para consultar op_valor_cat  de la ca_operacion
	
    if @w_toperacion_tr = 'REVOLVENTE' 
      begin
		
        --LCRCUPINI esa es la regla para el monto    "Cupo Inicial LÃ­nea de CrÃ©dito Revolvente"
        --LCRTINT esa regla de tasa   "Tasa InterÃ©s CrÃ©dito Revolvente"
		
         --"Cupo Inicial LÃ­nea de CrÃ©dito Revolvente"
		select @w_cliente   = tr_cliente,
		       @w_plazo_lcr = tr_periodicidad_lcr
		from cob_credito..cr_tramite 
		where tr_tramite = @i_tramite
		
         select @w_codigo_act_rev = pa_int
         from   cobis..cl_parametro with (nolock)
         where pa_nemonico = 'CAREVA'
                  
         --Analista y tipo operacion
         select 
         @w_analista_op    = fu_nombre
         from cob_workflow..wf_inst_proceso  ,
              cob_workflow..wf_inst_actividad,
              cob_workflow..wf_asig_actividad,
              cob_workflow..wf_usuario       , 
              cobis..cl_funcionario    
         where io_campo_3         = @i_tramite
         and   ia_id_inst_proc    = io_id_inst_proc
         and   ia_id_inst_act     = aa_id_inst_act
         and   aa_id_destinatario = us_id_usuario
         and   us_login           = fu_login
         and   ia_codigo_act      = @w_codigo_act_rev 
      
         exec @w_ssn = cob_cartera..sp_gen_sec 
         @i_operacion  = -1

         exec @w_sesn = cob_cartera..sp_gen_sec 
         @i_operacion  = -1

         /* Evalua regla Cupo Inicial de la Cupo Inicial CrÃ©dito Revolvente*/
         exec @w_error       = cob_cartera..sp_ejecutar_regla
         @s_ssn              = @w_ssn,
         @s_ofi              = 1,
         @s_user             = @w_analista_op,
         @s_date             = @w_fecha_proceso,
         @s_srv      = 'SRV',
         @s_term             = 'TERM-1',
         @s_rol              = 1,
         @s_lsrv             = 'LSRV',
         @s_sesn             = @w_sesn,
         @i_regla            = 'LCRCUPINI',    
         @i_id_inst_proc     = @w_inst_proc,
         @o_resultado1       = @w_result_values  out  
         
         if @w_error <> 0 begin
            select @w_msg = 'ERROR AL EJECUTAR REGLA Cupo Inicial LÃ­nea de CrÃ©dito Revolvente' 
			exec @w_error = cobis..sp_cerror
				@t_debug  = 'N',
				@t_file   = '',
            @t_from   = 'sp_ejecutar_regla',
            @i_num    = @w_error,
			@i_msg    = @w_msg
		    return @w_error
         end
		 
		 --print 'Print @w_result_values de la regla LCRCUPINI >>'
		 --print @w_result_values
		 
		 select @w_monto_credito = convert(money,@w_result_values)
		
        --"Tasa InterÃ©s CrÃ©dito Revolvente"
		 exec @w_ssn = cob_cartera..sp_gen_sec 
          @i_operacion  = -1
		 
         exec @w_sesn = cob_cartera..sp_gen_sec 
          @i_operacion  = -1
		
         /* Evalua regla Cupo Inicial de la Tasa InterÃ©s de CrÃ©dito Revolvente*/
         exec @w_error       = cob_cartera..sp_ejecutar_regla
         @s_ssn              = @w_ssn,
         @s_ofi              = 1,
         @s_user             = @w_analista_op,
         @s_date             = @w_fecha_proceso,
         @s_srv              = 'SRV',
         @s_term             = 'TERM-1',
         @s_rol              = 1,
         @s_lsrv             = 'LSRV',
         @s_sesn             = @w_sesn,
         @i_regla            = 'LCRTINT',    
         @i_id_inst_proc     = @w_inst_proc,
         @o_resultado1       = @w_result_values  out  
		
         if @w_error <> 0 begin
            select @w_msg = 'ERROR AL EJECUTAR REGLA Tasa InterÃ©s de CrÃ©dito Revolvente' 
			exec @w_error = cobis..sp_cerror
				@t_debug  = 'N',
				@t_file   = '',
            @t_from   = 'sp_ejecutar_regla',
            @i_msg    = @w_msg,
				@i_num    = @w_error
		    return @w_error
         end 
         
         --print 'Print @w_result_values de la regla LCRTINT >>'
		 --print @w_result_values
    
		select @w_tasa_int_anual = convert(money, @w_result_values)
		
		
	    --EJECUCION DE LA REGLA DE PORCENTAJE DE COMISION 

		--"Comisión por Utilización LCR"
		
		/* Parámetros por defecto Colectivo + nivel de colectivo */

        select @w_param_colectivo =  pa_char from cobis..cl_parametro WHERE pa_nemonico = 'CDDFCL'
        select @w_param_nivel_colectivos =  pa_char from cobis..cl_parametro WHERE pa_nemonico = 'CDDFNC'
		/* Obtencion de parametros */
        select @w_param_comision = pa_float from cobis..cl_parametro where pa_nemonico = 'COMLCR'
		
		select 
        @w_tipo_mercado = ea_colectivo ,
        @w_nivel_cliente = ea_nivel_colectivo
        from cobis..cl_ente_aux 
        where ea_ente  = @w_cliente

        select @w_param_regla   = isnull(@w_tipo_mercado, @w_param_colectivo) + '|' + isnull(@w_nivel_cliente, @w_param_nivel_colectivos ) + '|' +  convert(varchar,@w_monto_credito)
        print '@w_param_regla: '+ @w_param_regla
		
        exec @w_error           = cob_cartera..sp_ejecutar_regla
        @s_ssn                  = @s_ssn,
        @s_ofi                  = @s_ofi,
        @s_user                 = @s_user,
        @s_date                 = @w_fecha_proceso,
        @s_srv                  = @s_srv,
        @s_term                 = @s_term,
        @s_rol                  = @s_rol,
        @s_lsrv                 = @s_lsrv,
        @s_sesn                 = @s_ssn,
        @i_regla                = 'LCRPORCOM', 
        @i_tipo_ejecucion       = 'REGLA', 
        @i_valor_variable_regla = @w_param_regla,
        @o_resultado1           = @w_resultado_com out
        
        if @w_error <> 0 begin 		   
		   select @w_msg = 'ERROR: AL EJECUTAR LA REGLA DE PORCENTAJE DE COMISION'
		   exec @w_error = cobis..sp_cerror
				@t_debug  = 'N',
				@t_file   = '',
                @t_from   = 'sp_ejecutar_regla',
                @i_msg    = @w_msg,
				@i_num    = @w_error
		   return @w_error			
        end
        
        select @w_porcentaje_com = isnull(convert(float,@w_resultado_com),@w_param_comision)
		
		
		/* Calculo de CAT */
		
		
		select @w_cat_caratula = isnull(tr_cat_caratula ,0) -- Req. 142165
		from cr_tramite where
		tr_tramite = @i_tramite 						
		
		if ( @w_cat_caratula  = 0) begin 					-- Req. 142165
		
		   exec @w_error = cob_cartera..sp_tir 
		   @i_id_inst_proc = @w_inst_proc,
		   @i_considerar_iva = 'N',
		   @i_tasa			= @w_tasa_int_anual,			--Req. 142165
	       @o_cat          = @w_cat out,
	       @o_tir          = @w_tir out, 
	       @o_tea          = @w_tea out
		   
		   if @w_error<>0
		   begin
		       exec @w_error = cobis..sp_cerror
		           @t_debug  = 'N',
		           @t_file   = '',
		           @t_from   = 'sp_rules_param_run',
		           @i_num    = @w_error		   
				   
		   end
		   
		   update cr_tramite set 		 					-- Req. 142165
		   tr_cat_caratula = @w_cat
		   where tr_tramite = @i_tramite		   
		end 												-- Req. 142165
		else select @w_cat = @w_cat_caratula 				-- Req. 142165
		  
		  
		  
		  
		select @w_costo_anual_tot = @w_cat
		
		select @w_plazo_credito = pa_smallint from cobis..cl_parametro where pa_nemonico = 'NPZLCR'
		select @w_desc_plz_cred = pa_char from cobis..cl_parametro where pa_nemonico = 'DPZLCR'
		
        /* REQ#140485
        if @w_plazo_lcr = 'W' --SEMANAL
        begin
            select @w_fecha_pago_lcr = 'martes siguiente a la fecha de la disposiciÃ¯Â¿Â½n'
            select @w_fecha_corte_lcr = 'todos los lunes'
        end
        else if @w_plazo_lcr = 'BW' --CATORCENAL
        begin
            select @w_fecha_pago_lcr  = 'segundo martes a partir de la primera disposiciÃ¯Â¿Â½n'
            select @w_fecha_corte_lcr = 'al cierre del dÃ¯Â¿Â½a hÃ¯Â¿Â½bil anterior de la fecha lÃ¯Â¿Â½mite de pago'
        end
        else if @w_plazo_lcr = 'M' --MENSUAL
        begin
            select @w_fecha_pago_lcr  = 'el dÃ¯Â¿Â½a cinco de cada mes'
            select @w_fecha_corte_lcr = 'al cierre del dÃ¯Â¿Â½a hÃ¯Â¿Â½bil anterior de la fecha lÃ¯Â¿Â½mite de pago'
        end
        */
        
        --EQ#140485
        select @w_fecha_pago_lcr = 'martes'
        select @w_fecha_corte_lcr = 'lunes'
		
		
		--plazo del credito
		if @w_plazo_lcr = 'W' --SEMANAL
        begin
            select @w_plazo_credito = 52
			select @w_desc_plz_cred = 'SEMANAS'
		    --select @w_desc_plz_cred = (select valor from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla = 'cr_tplazo_ind')
			--                                                                and codigo = @w_plazo_lcr)
        end
        else if @w_plazo_lcr = 'BW' --CATORCENAL
        begin
            select @w_plazo_credito = 26
			select @w_desc_plz_cred = 'CATORCENAS'
		    --select @w_desc_plz_cred = (select valor from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla = 'cr_tplazo_ind')
			--                                                                and codigo = @w_plazo_lcr)
        end
        else if @w_plazo_lcr = 'M' --MENSUAL
        begin
            select @w_plazo_credito = 12
			select @w_desc_plz_cred = 'MESES'
		    --select @w_desc_plz_cred = (select valor from cobis..cl_catalogo where tabla = (select codigo from cobis..cl_tabla where tabla = 'cr_tplazo_ind')
			--                                                                and codigo = @w_plazo_lcr)
        end

		select 'COSTO_ANUAL_TOT'  = convert(varchar(10),@w_costo_anual_tot),  -- 1
          'TASA_INT_ANUAL'   = convert(varchar(10),@w_tasa_int_anual),        -- 2
          'MONTO_CREDITO'    = format(@w_monto_credito, 'C') ,    -- 3
          'MONTO_TOT_PAG'    = format(@w_monto_tot_pag, 'C') ,    -- 4
          'LISTA_COMISIONES' = @w_lista_comisiones,    -- 5
          'PORCENTAJE_MORA'  = @w_porcentaje_mora,     -- 6
          'PLAZO_CREDITO'    = @w_plazo_credito,       -- 7
          'DESCRIP_MONEDA'   = @w_desc_moneda,         -- 8
          'DESCRIP_PLAZO'    = @w_desc_plz_cred,       -- 9
          'FECHA_LIMITE_PAGO'= @w_fecha_pago_lcr,      -- 10
	      'FECHA_CORTE'      = @w_fecha_corte_lcr,     -- 11
          'DESPLAZAMIENTO'   = 0,                      -- 12
          'FECHA_LIQUIDA'    = @w_fecha_liq,           -- 13
		  'COMISION_LCR'     = convert(varchar(10),@w_porcentaje_com), -- 14
		  'NOMBRE_PRODUCTO'  = (select valor from cobis..cl_catalogo where tabla = @w_tabla_cod_txd and codigo = 'RIXCT01') -- 15
 	end
	else
	begin		
		if ( @w_nombre_comercial_prod = 'S')
		    select @w_nombre_comercial_prod = valor from cobis..cl_catalogo where tabla = @w_tabla_cod_txd and codigo = 'GPSCT01' -- TU CRÃ‰DIITO ANÃMATE'			
		else if ( @w_nombre_comercial_prod = 'N')
		    select @w_nombre_comercial_prod = valor from cobis..cl_catalogo where tabla = @w_tabla_cod_txd and codigo = 'GPNCT01' -- TU CRÃ‰DITO GRUPAL		    
		
		select 'COSTO_ANUAL_TOT'  = convert(varchar(10),@w_costo_anual_tot),  -- 1
	          'TASA_INT_ANUAL'   = convert(varchar(10),@w_tasa_int_anual),    -- 2
	          'MONTO_CREDITO'    = format(@w_monto_credito, 'C') ,    -- 3
	          'MONTO_TOT_PAG'    = format(@w_monto_tot_pag, 'C') ,    -- 4
	          'LISTA_COMISIONES' = @w_lista_comisiones,    -- 5
	          'PORCENTAJE_MORA'  = @w_porcentaje_mora,     -- 6
	          'PLAZO_CREDITO'    = @w_plazo_credito,       -- 7
	          'DESCRIP_MONEDA'   = @w_desc_moneda,         -- 8
	          'DESCRIP_PLAZO'    = @w_desc_plz_cred,       -- 9
			  'FECHA_LIMITE_PAGO'=  convert(varchar(10), @w_fecha_pago, @i_formato_fecha),    -- 10
			  'FECHA_CORTE'      = convert(varchar(10), @w_fecha_corte, @i_formato_fecha),    -- 11
              'DESPLAZAMIENTO'   = @w_desplazamiento,    -- 12
	          'FECHA_LIQUIDA'    = @w_fecha_liq,         -- 13
			  'COMISION_LCR'     = convert(varchar(10),@w_porcentaje_com),    -- 14
		      'NOMBRE_COMERCIAL_PROD'  = @w_nombre_comercial_prod    -- 15 
	end
   
   return 0
end --@i_operacion='Q2' FIN

if @i_operacion = 'Q3' --RPT Caratula Credito Grupal - Lista de Pagos
begin
   select 'NUMERO'     = am_dividendo , 
          'MONTO'	     = sum(am_cuota),
          'FECHA_VENC' = di_fecha_ven
     from cob_cartera..ca_amortizacion,
          cob_cartera..ca_dividendo
    where am_operacion = @w_operacion
      and am_operacion = di_operacion
      and am_dividendo = di_dividendo
    group by am_dividendo,di_fecha_ven
 
   return 0
end --@i_operacion='Q3' FIN


--Inicio Req.197007
if @i_operacion = 'Q4' -- Parametros Caratula Contrato
begin
   select 'RGASE1' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'RGASE1' and pa_producto = 'CRE'), --1
          'RGASE2' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'RGASE2' and pa_producto = 'CRE'), --2
          'DESCUO' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'DESCUO' and pa_producto = 'CCA'), --3
          'RCGSG1' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'RCGSG1' and pa_producto = 'CRE'), --4
    	  'RCGSG2' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'RCGSG2' and pa_producto = 'CRE'), --5
    	  'RDRECA' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'RDRECA' and pa_producto = 'CRE'), --6
          'RECASG' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'RECASG' and pa_producto = 'CRE'), --7
		  'PPREPA' = (select pa_char from cobis..cl_parametro where pa_nemonico = 'PPREPA' and pa_producto = 'CRE')  --8
	  
   return 0
end --@i_operacion='Q4' FIN
--Fin Req.197007

go
