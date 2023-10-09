use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_bloq_val_cc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_bloq_val_cc
    IF OBJECT_ID('dbo.sp_bloq_val_cc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_bloq_val_cc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_bloq_val_cc >>>'
END
go


create proc sp_bloq_val_cc (
	@s_ssn                int,
      @s_ssn_branch         int = 0,
	@s_srv                varchar(30),
	@s_lsrv               varchar(30),
	@s_user               varchar(30),
	@s_sesn               int,
	@s_term               varchar(10),
	@s_date               datetime,
      @s_org		    char(1),
	@s_ofi                smallint,    /* Localidad origen transaccion */
	@s_rol                smallint = 1,
	@s_org_err            char(1) = null, /* Origen de error:[A], [S] */
	@s_error              int = null,
	@s_sev                tinyint = null,
	@s_msg                varchar(240) = null,
	@t_debug              char(1) = 'N',
	@t_file               varchar(14) = null,
	@t_from               varchar(32) = null,
	@t_rty                char(1) = 'N',
	@t_trn		    smallint,
	@t_ejec		    char(1) = null,	
	@i_cta		    varchar(24),
	@i_mon		    tinyint,
	@i_accion	          char(1),
	@i_causa	          char(2) = null,
      @i_valor	          money = null,
	@i_sec		    int = null,
	@i_aut		    varchar(64) = null,
	@i_solicit	          varchar(64) = null,
	@i_plazo	          smallint = null,
	@i_formato_fecha      int = 101,
      @i_oficio             varchar(8) = null,
      @i_oficio_l           varchar(8) = null,
      @i_demanda            char(30) = null,  
	@i_producto	          smallint = null, 
 	@i_enlinea            varchar(1) = 'S',
	@i_sec_dpago          int = null,
	@i_pit		      char(1) = 'N',	
        @i_cenit            char(1) = 'N',
        @i_oficina_dest  smallint=null,
      @o_fecha_ven          varchar(10) = null out,
      @o_secuencial         int = null out,
      @o_ssn_host           int = null out, 
      @o_oficina            smallint = null out,
	@o_disponible	    money = null out,
	@o_12h		    money = null out,
	@o_24h		    money = null out,
	@o_48h		    money = null out,
      @o_remesas            money = null out,
      @o_monto_blq          money = null out,
	@o_saldo_girar	    money = null out,
	@o_clase_clte         char(1) = null out,
	@o_prod_banc          tinyint = null out,
      @o_hb_secuencial      int= null out  -- ARV ABR/30/2001
        
)
as
declare @w_return               int,
	  @w_sp_name              varchar(30),
	  @w_ctacte               int,
        @w_est                  char(1),
	  @w_filial               tinyint,
	  @w_num_bloqueos         smallint,
	  @w_secuencial           int,
	  @w_monto_bloq           money,
	  @w_saldo_para_girar     money,
	  @w_dif                  money,
	  @w_saldo_contable       money,
        @w_saldo1               money,
        @w_saldo                money,
        @w_monto1               money,
        @w_monto                money,
        @w_causa                varchar(3),
	  @w_fecha_ven		  smalldatetime,
        @w_tipo_bloqueo         char(1),
	  @w_oficio		        varchar(8),
	  @w_mensaje              varchar(240),
        @w_oficial              smallint,      
        @w_cliente              int,  
        @w_cuenta               int,  
        @w_tipo                 char(1), 
        @w_contrato             int,     
        @w_fecha_aut            datetime,
        @w_monto_aut            money,   
	  @w_oficina              smallint, 
        @w_autorizante          varchar(14),      
        @w_cta_banco            varchar(20),
        @w_nombre               char(64),   
        @w_ced_ruc              varchar(30),
        @w_direc                tinyint,    
        @w_ciclo                char(1),    
        @w_tprom                char(1),    
        @w_descdir              char(120),  
        @w_tipodir              char(1),    
        @w_prod_banc            smallint,   
        @w_disponible           money,      
        @w_origen               varchar(3), 
        @w_festivo              datetime,   
        @w_auxiliar             int,        
        @w_iva                  float,
        @w_categoria            varchar(10),
        @w_tipo_ente            varchar(10),
        @w_rol_ente             char(1),
        @w_tipo_def             char(1),
        @w_default              int,
        @w_promedio1            money,
        @w_prom_disp            money,
        @w_personalizada        char(1),
        @w_comision             money,
        @w_valor_cobro          money,
        @w_viva                 money,
        @w_producto             tinyint,
        @w_oficina_cta          smallint,
        @w_especial             char(1),  
        @w_iva_anio             money, 	
        @w_baseiva_anio         money, 	
        @w_ciudad               int,
	  @w_clase_clte           char(1),
	  @w_aux_emb              char(1),
	  @w_3xmil                char(1),
	  @w_ste_pago             int,
	  @w_cod_convenio         int,
        @w_numdeciimp           tinyint,
        @w_piva                 float,
        @w_impuesto             money,
        @w_val_emb              money,
        @w_imp_emb              money,
        @w_dif_emb              money,
        @w_indicador            tinyint,
	@w_cau			varchar(3)



/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_bloq_val_cc'

/* Modo de debug */

if  @t_trn not in (9, 10)
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror1
	   @t_debug     = @t_debug,
	   @t_file      = @t_file,
	   @t_from      = @w_sp_name,
	   @i_num	= 201048,
	   @i_pit	= @i_pit
   return 201048
end

select @w_ctacte      = cc_ctacte,
	@w_cta_banco    = cc_cta_banco,
	@w_est          = cc_estado,
	@w_prod_banc    = cc_prod_banc,
	@w_nombre       = cc_nombre,
	@w_cliente      = cc_cliente,
	@w_ced_ruc      = cc_ced_ruc,
	@w_direc        = cc_direccion_ec,
	@w_ciclo        = cc_ciclo,
	@w_tprom        = cc_tipo_promedio,
	@w_descdir      = cc_descripcion_ec,
	@w_tipodir      = cc_tipo_dir,
	@w_oficial      = cc_oficial,
	@w_origen       = cc_origen,
	@w_disponible   = cc_disponible,
      @w_num_bloqueos = cc_num_blqmonto,
	@w_monto_bloq   = cc_monto_blq,
	@w_clase_clte   = cc_clase_clte,	--NVR
	@w_oficina      = cc_oficina,
	@w_categoria    = cc_categoria,
      @w_tipo_def     = cc_tipo_def,
      @w_default      = cc_default,
      @w_personalizada = cc_personalizada,
      @w_rol_ente     = cc_rol_ente,
      @w_promedio1    = cc_promedio1,
      @w_disponible   = cc_disponible,
      @w_tipo_ente    = cc_tipocta,
      @w_prom_disp    = cc_prom_disponible,
      @w_filial       = cc_filial,
	@w_oficial      = cc_oficial, --ARV DIC/27/00
      @w_3xmil        = cc_nxmil
  from	cob_cuentas..cc_ctacte
 where	cc_cta_banco = @i_cta
   and	cc_moneda    = @i_mon
   and cc_estado   != 'G'           /* Cuenta de Gerencia */

if @@rowcount != 1
begin
  /* No existe cuenta_banco */
   exec cobis..sp_cerror1
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201004,
	   @i_pit	= @i_pit
   return 201004
end

select @o_oficina = @w_oficina

/*  Determinacion de bloqueo de cuenta  */
if @i_causa not in ('2','5')
begin
   select  @w_tipo_bloqueo = cb_tipo_bloqueo
     from  cob_cuentas..cc_ctabloqueada
    where  cb_cuenta = @w_ctacte
      and  cb_estado = 'V'
      and  cb_tipo_bloqueo in ('3', '2')
   if @@rowcount != 0
   begin
        select @w_mensaje = rtrim (valor)
        from cobis..cl_catalogo
        where tabla = (select codigo from cobis..cl_tabla
                        where tabla = 'cc_tbloqueo')
        and codigo = @w_tipo_bloqueo
        select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
        exec cobis..sp_cerror1
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 201008,
                @i_sev          = 1,
                @i_msg          = @w_mensaje,
	   	@i_pit		= @i_pit
        return 201008
   end   
end

select @w_ciudad = of_ciudad
  from cobis..cl_oficina, cobis..cl_ciudad
 where ci_ciudad = of_ciudad
   and of_oficina = @w_oficina

/*conversion plazo para proceso batch en levantamiento bloqueo CPA */
  if @i_plazo is not null
  begin
     select @w_auxiliar = 1
     select @w_fecha_ven = dateadd(day, @i_plazo, @s_date)
     select @o_fecha_ven = convert(varchar(10),@w_fecha_ven,@i_formato_fecha)

     select @w_festivo = df_fecha
       from cobis..cl_dias_feriados
      where df_fecha = @w_fecha_ven
        and df_ciudad = @w_ciudad     
   if @@rowcount = 1
   begin
        while @w_auxiliar = 1
        begin
             select @w_fecha_ven = dateadd(day, 1, @w_festivo)
             
             select @w_festivo = df_fecha
               from cobis..cl_dias_feriados
              where df_fecha = @w_fecha_ven
                and df_ciudad = @w_ciudad
             if @@rowcount = 0 
                 select @w_auxiliar =0 
        end
       select @o_fecha_ven = @w_fecha_ven  
     end
  end

                                                                          
/* Validaciones */

if @i_causa != '2' and @i_causa != '5' /* CLE permitir embargos ctas inactivas */
if @w_est != 'A' 
begin
 if @i_cenit  = 'N'  or   (@i_cenit  = 'S' and  @w_est = 'C') 
 begin 
      /* Cuenta no activa o cancelada */
      exec cobis..sp_cerror1
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201005,
	   @i_pit	= @i_pit
      return 201005
 end 
end
else /* CLE Para embargos no se verifica ctas inactivas */
begin 
if @w_est = 'C' 
begin
      /* Cuenta cancelada */
      exec cobis..sp_cerror1
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201005,
	   @i_pit	= @i_pit
      return 201005
end

end



if @i_accion not in ('B', 'L')
begin
   /* No existe tipo de accion */
   exec cobis..sp_cerror1
	   @t_debug     = @t_debug,
	   @t_file      = @t_file,
	   @t_from      = @w_sp_name,
	   @i_num	= 251019,
	   @i_pit	= @i_pit
   return 251019
end

/* Calculo del saldo contable y saldo para girar de la cuenta */
exec @w_return = cob_cuentas..sp_calcula_saldo
     @t_debug	    = @t_debug,
     @t_file		    = @t_file,
     @t_from		    = @w_sp_name,
     @i_cuenta	    = @w_ctacte,
     @i_fecha	    = @s_date,
     @i_ofi	    	    = @s_ofi,
     @o_saldo_para_girar = @w_saldo_para_girar out,
     @o_saldo_contable   = @w_saldo_contable out
if @w_return != 0
      return @w_return


/* Transaccion de bloqueos por valor a la cuenta */
if @t_trn = 9
begin
   select   @w_dif = @w_saldo_para_girar - @i_valor

-- print 'saldo_para_girar :%1!', @w_saldo_para_girar


-- CPA 08/22/2002  Adiciona condicion @i_causa != '7'
   if @w_saldo_para_girar < @i_valor and @i_causa != '7'	
   begin
      /* Valor a bloquear execede el saldo para girar */
      exec cobis..sp_cerror1
	    @t_debug   = @t_debug,
	    @t_file    = @t_file,
	    @t_from    = @w_sp_name,
	    @i_num     = 201072,
	   @i_pit	= @i_pit
      return 201072
   end

/*** OLI 01262006. Comentado porque CLientes envia el valor ya descontado el GMF
-- Causa 2 es para EMBARGOS
   if @i_causa = '2' 
   begin 
      if @w_3xmil = 'N'
      begin
         select @w_piva= pa_float
           from cobis..cl_parametro
          where pa_nemonico = 'IMDB'
            and pa_producto = 'CTE'
	
         if @@rowcount = 0
	   begin
            exec cobis..sp_cerror1
	         @t_file  = null,
                 @t_from  = @w_sp_name,
                 @i_num   = 201196,
	   	 @i_pit	= @i_pit
            return 201196
         end
	   select @w_numdeciimp = pa_tinyint
           from cobis..cl_parametro
          where pa_producto = 'CTE'
            and pa_nemonico = 'DIM'
         if @@rowcount <> 1
         begin
            exec cobis..sp_cerror1
                 @t_from      = @w_sp_name,
                 @i_num       = 201196,
	   	 @i_pit	      = @i_pit
            return 201196
         end
           
         select @w_impuesto    = isnull((round((@i_valor * @w_piva),@w_numdeciimp)),0)
         select @w_valor_cobro = @i_valor + @w_impuesto

         if @w_saldo_para_girar < @w_valor_cobro
         begin
	      select @w_val_emb   = @i_valor - @w_impuesto
            select @w_imp_emb   = isnull((round((@w_val_emb * @w_piva),@w_numdeciimp)),0)
            select @w_dif_emb   = @w_impuesto - @w_imp_emb
            select @i_valor     = @w_val_emb + @w_dif_emb
         end
      end
   end
   else ***/
   
   if @i_causa <> '2'
   begin   
      select @w_num_bloqueos = @w_num_bloqueos + 1
      select @w_monto_bloq   = @w_monto_bloq + @i_valor
   end

   /* Generacion del secuencial para la insercion en la tabla cc_his_bloqueo */

   exec @w_return = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cc_his_bloqueo',
	  @o_siguiente = @w_secuencial out
   if @w_return != 0
      return @w_return
--print '@w_secuencial %1!', @w_secuencial
   select @o_hb_secuencial = @w_secuencial -- ARV ABR/30/2001 

   /* Actualizacion de las tablas: cc_his_bloqueo y cc_ctacte */

   begin tran

      insert into cc_his_bloqueo
		    (hb_ctacte, hb_secuencial, hb_accion, hb_monto_blq,
		     hb_valor, hb_fecha, hb_autorizante, hb_oficina,
		     hb_causa, hb_saldo, hb_levantado, hb_fecha_ven, hb_hora,
		     hb_solicitante,  hb_oficio_crea, hb_demanda, 
		     hb_oficio_levanta)
	     values (@w_ctacte, @w_secuencial, 'B', @w_monto_bloq,
		     @i_valor, @s_date, @i_aut, @s_ofi,
		     @i_causa, @w_dif, 'NO', @w_fecha_ven, getdate(),
		     @i_solicit, @i_oficio, @i_demanda, 
		     @i_oficio_l)

      if @@error != 0
      begin
	  /* Error en creacion de registro en cc_his_bloqueo */
	  exec cobis..sp_cerror1
		@t_debug      = @t_debug,
		@t_file       = @t_file,
		@t_from       = @w_sp_name,
		@i_num        = 203009,
	   	@i_pit	      = @i_pit
	  return 203009
      end


      /* Determinar si el bloqueo es por Embargo */
      if @i_causa = "2"
      begin
	if @w_est = 'I'
	   select @w_cau = '36'
   	else
	   select @w_cau = '34'
	
         /*  Generar la nota de debito por la retencion */
         exec @w_return = cob_cuentas..sp_ccndc_automatica
              @s_srv	     = @s_srv,
	       @s_ofi	     = @s_ofi,
	       @s_ssn	     = @s_ssn,
	       @s_user	     = @s_user,
              @t_trn          = 50, 
              @i_cta          = @i_cta,
              @i_corr		='N',
	       @i_bloq_no      = 'S',
              @i_val          = @i_valor,
              @i_cau          = @w_cau, 
              @i_mon          = @i_mon,
              @i_alt          = 10,
              @i_fecha        = @s_date,
              @i_pit	     = @i_pit,
	      @i_enlinea	     = @i_enlinea,
	      @i_inmovi	     = 'S'

         if @w_return <> 0
            return @w_return

         update cob_cuentas..cc_ctacte
	     set cc_embargada_fijo = "S"
          where cc_ctacte	= @w_ctacte
           
           if @@rowcount != 1
            begin
	      /* Error en actualizacion de registro en cc_ctacte */
	      exec cobis..sp_cerror1
                   @t_debug      = @t_debug,
                   @t_file       = @t_file,
                   @t_from       = @w_sp_name,
                   @i_num        = 205001,
	   	   @i_pit	 = @i_pit
	      return 205001
            end

        end
      else
        begin   

          /* Actualizar los campos de bloqueos en la tabla cc_ctacte */

          update   cob_cuentas..cc_ctacte
	     set   cc_num_blqmonto  = @w_num_bloqueos,
	           cc_monto_blq	    = @w_monto_bloq	   
           where   cc_ctacte	= @w_ctacte

          if @@rowcount != 1
            begin
	      /* Error en actualizacion de registro en cc_ctacte */
	      exec cobis..sp_cerror1
                   @t_debug      = @t_debug,
                   @t_file       = @t_file,
                   @t_from       = @w_sp_name,
                   @i_num        = 205001,
	   	   @i_pit	 = @i_pit
	      return 205001
            end
       end
        
        /* SE COMENTA BLOQUEO CUENTA DE BENEFICIARIO POR SOLICITUD DEL BANCO
        if @i_causa = "12"
        begin
                     	
                update cob_cuentas..cc_detpago
                   set cd_sec_bloqueo = @w_secuencial
                 where cd_num_cta = @w_cta_banco
                   and cd_secuencial = @i_sec_dpago
              	         
	        if @@rowcount != 1
                begin
	             /* Error en actualizacion de registro en cc_ctacte */
	             exec cobis..sp_cerror1
		            @t_debug      = @t_debug,
		       	    @t_file       = @t_file,
		       	    @t_from       = @w_sp_name,
		   	    @i_num	  = 208156,
	   		    @i_pit	  = @i_pit
	      	     return 208156
                end
        end
	FIN COMENTARIO */
        

      /* Creacion de transaccion de servicio */
	if @i_causa = '2' and @s_ofi <> @i_oficina_dest
   	begin
     		select @w_oficina = @i_oficina_dest
     		select @w_indicador = 1
   	end

      insert into cob_cuentas..cc_tsbloqueo_valor
		      (secuencial, tipo_transaccion, tsfecha,
		       usuario, terminal, oficina, reentry, origen,
		       cta_banco, fecha, valor, accion, causa,
		       autorizante, moneda, hora, solicitante, fecha_vencim,
                       oficina_cta,ssn_branch,
		       oficio_crea, demanda, oficio_levanta,
		       clase_clte, prod_banc, oficial,indicador) --ARV DIC/27/00
	       values (@s_ssn, @t_trn, @s_date,
		       @s_user, @s_term, @s_ofi, @t_rty, @s_org,
		       @i_cta, @s_date, @i_valor, 'B', @i_causa,
		       @i_aut, @i_mon, getdate(), @i_solicit, @w_fecha_ven,
                       @w_oficina,@s_ssn_branch,
		       @i_oficio, @i_demanda, @i_oficio_l,
		       @w_clase_clte, @w_prod_banc, @w_oficial,@w_indicador)


      if @@error != 0
      begin
	  /* Error en creacion de transaccion de servicio */
	  exec cobis..sp_cerror1
		  @t_debug	 = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 203005,
	   	  @i_pit	 = @i_pit
	  return 203005
      end

   commit tran

-- Enviar los resultados para COBIS Branch II

 select @o_disponible = cc_disponible,
          @o_12h        = cc_12h,
          @o_24h        = cc_24h,
          @o_48h        = cc_48h,
          @o_remesas = cc_remesas,
          @o_monto_blq = cc_monto_blq
   from cc_ctacte
   where cc_ctacte = @w_ctacte

/* Calculo del saldo contable y saldo para girar de la cuenta */
exec @w_return = cob_cuentas..sp_calcula_saldo
	@t_debug	    = @t_debug,
	@t_file	    = @t_file,
	@t_from	    = @w_sp_name,
	@i_cuenta	    = @w_ctacte,
	@i_fecha	    = @s_date,
	@i_ofi	    = @s_ofi,
        @o_saldo_para_girar = @o_saldo_girar out,
	@o_saldo_contable   = @w_saldo_contable out
if @w_return != 0
      return @w_return

select @o_ssn_host = @s_ssn,
       @o_secuencial = @w_secuencial   /*REQ para grabar el secuencial en el servidor local*/
select @o_clase_clte = @w_clase_clte	
select @o_prod_banc  = @w_prod_banc

--IYE
   if @t_ejec = 'R'
   begin
   select "results_submit_rpc",
	  r_ssn_host    = @s_ssn, 
	  r_sec_host    = @w_secuencial--,
	  --r_monto_blq	= @w_monto_bloq,
	  --r_num_bloq	= @w_num_bloqueos

   exec @w_return = cob_cuentas..sp_resultados_branch_cc
                    @i_cuenta       = @w_ctacte,
                    @i_fecha        = @s_date,
                    @i_ofi          = @s_ofi,
		    @i_tipo_cuenta  = 'O'

   if @w_return != 0
       return @w_return
   end
   return 0

end

-- Transaccion de levantamiento de bloqueos a la cuenta
if @t_trn = 10
begin
     if @s_term in ('SAFE','FX11') -- Usado por la Interface OLF - COBIS
     begin
         -- Verificar que exista Secuencial de Bloqueo
         if not exists (select *
                        from   cob_cuentas..cc_his_bloqueo
                        where  hb_ctacte = @w_ctacte
                        and    hb_secuencial = @i_sec
                        and    hb_levantado = 'NO')
         begin
             -- Secuencial No Existe
         exec cobis..sp_cerror1
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 351066,
	   	  @i_pit   = @i_pit
             return 351066
         end
     end

   -- Generacion del secuencial para la insercion en la tabla cc_his_bloqueo
   exec @w_return = cobis..sp_cseqnos
          @t_debug	  = @t_debug,
          @t_file	  = @t_file,
          @t_from 	  = @w_sp_name,
          @i_tabla	  = 'cc_his_bloqueo',
	  @o_siguiente	  = @w_secuencial out
	  
   if @w_return != 0
      return @w_return

--print 'w_ctacte :%1!', @w_ctacte
--print 'i_sec :%1!', @i_sec

   select   @w_monto_bloq = hb_valor,
            @w_saldo      = hb_saldo,
            @w_monto      = hb_monto_blq,
            @w_causa      = hb_causa,
	    @w_oficio     = hb_oficio_crea
     from   cob_cuentas..cc_his_bloqueo
    where   hb_ctacte = @w_ctacte
      and   hb_secuencial = @i_sec
      and   hb_levantado = 'NO'
      --and   hb_oficio_crea = @i_oficio

   if @@rowcount != 1
   begin
   /* Error en creacion de registro en cc_his_bloqueo */
      exec cobis..sp_cerror1
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_num        = 201198,
	   @i_pit	 = @i_pit
      return 201198
   end

   if @i_valor > @w_monto_bloq
   begin
       /* Valor a levantar excede el monto bloqueado */
       exec cobis..sp_cerror1
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 201073,
	    @i_pit     = @i_pit
       return 201073
   end
 

   if @w_causa = '2' and @i_causa <> '2'
   begin
       /* La causa del levantamiento no es valida */
       exec cobis..sp_cerror1
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 201162,
	    @i_pit	= @i_pit
       return 201162
   end


   /* Actualizacion de las tablas: cc_his_bloqueo y cc_ctacte */

   begin tran

     if @i_valor = @w_monto_bloq
       begin

         update cob_cuentas..cc_his_bloqueo
            set hb_levantado = 'SI',
		hb_oficio_levanta = @i_oficio_l
          where hb_ctacte = @w_ctacte
            and hb_secuencial = @i_sec

         if @@rowcount != 1
         begin
	   /* Error en creacion de registro en cc_his_bloqueo */
	   exec cobis..sp_cerror1
		@t_debug      = @t_debug,
		@t_file       = @t_file,
		@t_from       = @w_sp_name,
		@i_num        = 203009,
	   	@i_pit	      = @i_pit
           return 203009
         end


      /* Determinar si es un desembargo */
      if @w_causa = "2"
        begin

          select @w_saldo1 = @w_saldo,
                 @w_monto1 = @w_monto

          update  cob_cuentas..cc_ctacte
             set  cc_embargada_fijo = 'N'
           where cc_ctacte  = @w_ctacte

           if @@rowcount != 1
            begin
	      /* Error en actualizacion de registro en cc_ctacte */
	      exec cobis..sp_cerror1
                   @t_debug      = @t_debug,
                   @t_file       = @t_file,
                   @t_from       = @w_sp_name,
                   @i_num        = 205001,
	   	   @i_pit	 = @i_pit
	      return 205001
            end

        end
      else
        begin 

          update  cob_cuentas..cc_ctacte
             set cc_num_blqmonto   = cc_num_blqmonto - 1,
                 cc_monto_blq	   = cc_monto_blq - @i_valor
           where cc_ctacte  = @w_ctacte

          if @@rowcount != 1
            begin
	      /* Error en actualizacion de registro en cc_ctacte */
	      exec cobis..sp_cerror1
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num	 = 205001,
	   	   @i_pit	 = @i_pit
	      return 205001
            end

          select @w_saldo1 = @w_saldo + @w_monto_bloq,
                 @w_monto1 = @w_monto - @w_monto_bloq

        end
        
        /* II EAA Feb/17/2003 */
        /* SE COMENTA BLOQUEO CUENTA DE BENEFICIARIO POR SOLICITUD DEL BANCO
        if @w_causa = '8'
        begin
        
	     select @w_ste_pago = max(isnull(cd_sec_pago,0))
               from cob_cuentas..cc_detpago
                  
             select @w_ste_pago = @w_ste_pago + 1

             update cob_cuentas..cc_detpago
                set cd_estado = 'C',
                    cd_sec_pago = (@w_ste_pago + 1),
                    cd_fecha_pago = @s_date
              where cd_num_cta = @w_cta_banco
       	        and cd_sec_bloqueo = @i_sec

	     if @@rowcount != 1
             begin
	        /* Error en actualizacion de registro en cc_ctacte */
	         exec cobis..sp_cerror1
		       	@t_debug      = @t_debug,
		       	@t_file       = @t_file,
		       	@t_from       = @w_sp_name,
		   	@i_num	      = 208156,
	   		@i_pit	      = @i_pit
	      	 return 208156
             end

        end
        FIN COMENTARIO */
        /* FI EAA Feb/17/2003 */

      select @o_hb_secuencial = @w_secuencial -- ARV ABR/30/2001 


       /* insercion del registro de levantamiento */

         insert into cc_his_bloqueo
		    (hb_ctacte, hb_secuencial, hb_accion, hb_monto_blq,
		     hb_valor, hb_fecha, hb_autorizante, hb_oficina,
		     hb_causa, hb_saldo, hb_levantado, hb_fecha_ven, hb_hora,
		     hb_solicitante, hb_sec_asoc,
		     hb_oficio_crea, hb_demanda, hb_oficio_levanta)
  	     values (@w_ctacte, @w_secuencial, 'L', @w_monto1,
		     @i_valor, @s_date, @i_aut, @s_ofi,
		     @i_causa, @w_saldo1, 'OK', @w_fecha_ven, getdate(),
		     @i_solicit, @i_sec,
		     @i_oficio, @i_demanda, @i_oficio)

      if @@error != 0
      begin
	  /* Error en creacion de registro en cc_his_bloqueo */
	  exec cobis..sp_cerror1
		@t_debug      = @t_debug,
		@t_file       = @t_file,
		@t_from       = @w_sp_name,
		@i_num        = 203009,
	        @i_pit	      = @i_pit
	  return 203009
      end

      select @o_hb_secuencial = @w_secuencial -- ARV ABR/30/2001 

      /* Creacion de transaccion de servicio */

--print 'sec :%1!', @s_ssn
      insert into cob_cuentas..cc_tsbloqueo_valor
		      (secuencial, tipo_transaccion, tsfecha,
		       usuario, terminal, oficina, reentry, origen,
		       cta_banco, fecha, valor, accion, causa,
		       autorizante, moneda, hora, solicitante, fecha_vencim,
                       oficina_cta,ssn_branch,
		       oficio_crea, demanda, oficio_levanta,
		       clase_clte, prod_banc, oficial) --ARV DIC/27/00
	       values (@s_ssn, @t_trn, @s_date,
		       @s_user, @s_term, @s_ofi, @t_rty, @s_org,
		       @i_cta, @s_date, @i_valor, 'L', @i_causa,
		       @i_aut, @i_mon, getdate(), @i_solicit, @w_fecha_ven,
                       @o_oficina,@s_ssn_branch,
		       @i_oficio, @i_demanda, @i_oficio_l,
		       @w_clase_clte, @w_prod_banc, @w_oficial)

      if @@error != 0
      begin
	  /* Error en creacion de transaccion de servicio */
	  exec cobis..sp_cerror1
		     @t_debug	 = @t_debug,
		     @t_file	 = @t_file,
		     @t_from	 = @w_sp_name,
		     @i_num	 = 203005,
	   	     @i_pit	 = @i_pit
	  return 203005
      end
   commit tran

   select @o_clase_clte = @w_clase_clte	
   select @o_prod_banc  = @w_prod_banc

-- Enviar los resultados para COBIS Branch II

 select @o_disponible = cc_disponible,
          @o_12h        = cc_12h,
          @o_24h        = cc_24h,
          @o_48h        = cc_48h,
          @o_remesas = cc_remesas,
          @o_monto_blq = cc_monto_blq
   from cc_ctacte
   where cc_ctacte = @w_ctacte

/* Calculo del saldo contable y saldo para girar de la cuenta */
exec @w_return = cob_cuentas..sp_calcula_saldo
	@t_debug	    = @t_debug,
	@t_file		    = @t_file,
	@t_from		    = @w_sp_name,
	@i_cuenta	    = @w_ctacte,
	@i_fecha	    = @s_date,
	@i_ofi	    	    = @s_ofi,
        @o_saldo_para_girar = @o_saldo_girar out,
	@o_saldo_contable   = @w_saldo_contable out
if @w_return != 0
      return @w_return

select @o_ssn_host = @s_ssn,
           @o_secuencial = @w_secuencial   /*REQ para grabar el secuencial en el servidor local*/
 
--IYE
   if @t_ejec = 'R'
   begin

   select "results_submit_rpc",
	  r_ssn_host    = @s_ssn, 
          r_sec_host    = @w_secuencial--,
	  --r_monto_blq	= @w_monto_bloq,
	  --r_num_bloq	= @w_num_bloqueos

   exec @w_return = cob_cuentas..sp_resultados_branch_cc
                    @i_cuenta       = @w_ctacte,
                    @i_fecha        = @s_date,
                    @i_ofi          = @s_ofi,
		    @i_tipo_cuenta  = 'O'

   if @w_return != 0
       return @w_return
   end

   return 0
   end
end
go
IF OBJECT_ID('dbo.sp_bloq_val_cc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_bloq_val_cc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_bloq_val_cc >>>'
go

go
use cob_cuentas
go
