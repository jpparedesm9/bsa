use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_nota_credito_debito') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_nota_credito_debito
    IF OBJECT_ID('dbo.sp_nota_credito_debito') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_nota_credito_debito >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_nota_credito_debito >>>'
END
go

create proc sp_nota_credito_debito (
	@t_debug		char(1) = 'N',
	@t_file	        	varchar(14) = null,
	@t_from	        	varchar(30) = null,
        @t_trn                  int,
        @t_rty                  char(1),
        @t_corr                 char(1),
        @s_ofi                  smallint,
        @s_rol                  smallint,
        @s_org                  char(1),
        @s_user                 varchar(30),
        @s_sesn			int = null,
        @s_srv                  varchar(30),
        @s_lsrv                 varchar(30),
        @s_term                 varchar(10),
        @s_ssn                  int,
        @s_ssn_branch           int = null,  /*RQU: Pers Branch II */
        @s_date                 datetime = null, /*RQU Pers Branch II */ 
        @t_ssn_corr             int,
        @t_ejec                 char(1) = null, /* FVE:resultados para BRANCH */
        @p_rssn_corr            int,
        @p_lssn                 int,
	@i_sus	                int,
	@i_cta	                varchar(24),
	@i_cuenta	        int,
        @i_val                  money,
	@i_ind		        tinyint,
	@i_ori			char(1),
	@i_cau			varchar(3),
        @i_dep                  int,
	@i_nchq                 int,
	@i_valch                money,
	@i_mon	        	tinyint,
	@i_factor		smallint,
	@i_fecha		datetime,
	@i_nos			varchar(30) = null,
	@i_ids			varchar(13) = null,
	@i_reverso		char(1) = null,
	@i_pit			char(1) = 'N',
        @i_dif                  char(1) = 'N',
	@o_sldcont		money out,
	@o_slddisp		money out,
	@o_nombre		varchar(30) out,
	@o_val_ser		money out,
	@o_val_mon		money out,
	@o_val_icc		money = null out,
	@o_val_2x1000		money = null out,
	@o_sus_flag		tinyint out,
	@o_prod_banc		tinyint = null out,
	@o_clase_clte		char(1) = null out,
	@o_impuesto		money = null out,
        -- II ERP 29/May/2001 CCCC00327
        @o_pide_aut	        char(1) = 'N' out,  
        @o_dif		        money = null out
        -- FI ERP 29/May/2001 CCCC00327
)
as
declare	@w_return		int,
	@w_sp_name		varchar(30),
	@w_estado       	char(1),
        @w_alicuota             numeric (11,10),
	@w_sec	 		int,
	@w_alic 		money,
        @w_disponible           money,
        @w_protestos            money,
        @w_val	                money,
        @w_promedio1            money,
        @w_monto_blq            money,
        @w_12h                  money,
        @w_24h                  money,
        @w_mon                  tinyint,
        @w_chequeras            smallint,
        @w_cheque_ini           int,
        @w_reentry              varchar(255),
        @w_suspensos            smallint,
        @w_remesas              money,
        @w_valor                money,
        @w_acum                 money,
        @w_numdeci              tinyint,
        @w_contador             smallint,
        @w_secuencial           int,
        @w_clave                int,
	@w_mensaje		varchar(240),
	@w_tipo_bloqueo		varchar(3),
	@w_estado_actual	char(1),
	@w_estado_anterior      char(1),
        @w_saldo_para_girar     money,
        @w_saldo_contable       money,
	@w_causa_np		char(3),
	@w_clase_np		char(1),
	@w_tipo_prom		char(1),
	@w_ssn_tmp		int,
	@w_cobrado		money,
	@w_tmp			int,
	@w_flag			tinyint,
	@w_factor               smallint,
	@w_desc_causa		varchar(64),
	@w_desc_clase		varchar(64),
	@w_tipo1		char(1),
	@w_trn			int,
	@w_usadeci		char(1),
	@w_prom_disp		money,
	@w_accion		char(1),
	@w_dif			money,
	@w_credmes		money,
	@w_credhoy		money,
	@w_debmes		money,
	@w_debhoy		money,
        @w_revocados            smallint,
        @w_ciudad               int,
	@w_fecha_efe		smalldatetime,
	@w_cont			tinyint,
	@w_dias_ret		tinyint,
        @w_12h_dif              money,
        @w_rem_hoy              money,
        @w_tasa_icc		float,
        @w_reg_icc		char(1),
        @w_accion_nc            char(1),
        @w_cliente              int,
	@w_val_total		money,
	@w_imp_2x1000		float,
	@w_reg_imp2x1000	char(1),
	@w_comision		money,
	@w_valor_cobro		money,
	@w_val_cob_rev		money,
	@w_com_rev		money,
	@w_cobro_total		money,
	@w_clase_clte		char(1),
	@w_categoria		char(1),
	@w_ciudad_cta		int,
	@w_oficina		smallint,
	@w_ciudad_loc		int,
	@w_tipo_ente		char(1),
	@w_prod_banc		tinyint,
	@w_rol_ente		char(1),
	@w_tipo_def             char(1),
        @w_producto             tinyint,
        @w_tipo                 char(1),
        @w_codigo               int,
        @w_personaliza          char(1),
	@w_filial		tinyint,
	@w_dias_sobregiro       smallint,
	@w_cta_banco            varchar(24),
	@w_nombre               varchar(64), 
	@w_disp                 money,
	@w_sldcont              money,
-- ARV ABRIL/05/2001
	@w_val_efe	        money,
	@w_comision_1		char(1), 
	@w_piva			float,
	@w_timpuesto		real,
	@w_impuesto		money,
	@w_lim_sobregiro	tinyint,
	@w_numdeciimp		tinyint,
	@w_tot_intereses	money,
	@w_tot_bloq		money,
	@w_slddis		money,
	@w_ant_fec_lab		datetime,
        @w_dep_ini              tinyint,
	@w_paquete 		int, --CLE 11042006
-- FI ARV ABRIL/05/2001
	@o_exento		char(1),
	@o_base			money,
	@o_porcentaje		float

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_nota_credito_debito'



/*  Modo de debug  */

/* Determina factor para hacer credito o debito */
if @t_trn < 49 
    select @w_factor = 1
else
    select @w_factor = -1

/* Encuentra los decimales a utilizar */
select @w_usadeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_mon

if @w_usadeci = 'S'
begin
   select @w_numdeci = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = 'CTE'
      and pa_nemonico = 'DCI'
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror1
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201196,
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
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201196,
           @i_pit	= @i_pit
           
      return 201196
   end

end
else
        select @w_numdeci = 0,
	       @w_numdeciimp = 0



select @w_ciudad = pa_int
  from cobis..cl_parametro
 where pa_producto = 'CTE'
   and pa_nemonico = 'CMA'

if @@rowcount <> 1
  begin

    /* Error en lectura de parametro de dias del anio */
    exec cobis..sp_cerror1
         @i_num       = 201196,
         @i_msg       = 'ERROR EN LECTURA DE PARAMETRO DE CIUDAD',
         @i_pit	      = @i_pit
    return 201196
  end


select @w_ant_fec_lab = min(dl_fecha)
  from cob_cuentas..cc_dias_laborables
 where dl_ciudad = @w_ciudad
   and dl_num_dias = -1




if @t_trn > 48
   select @w_tipo1 = '2'
else
   select @w_tipo1 = '1'

/*  Determinacion de bloqueo de cuenta  */
select @w_tipo_bloqueo = cb_tipo_bloqueo
  from cob_cuentas..cc_ctabloqueada
 where cb_cuenta = @i_cuenta
   and cb_estado = 'V'
   and (cb_tipo_bloqueo = @w_tipo1
         or cb_tipo_bloqueo = '3')
if @@rowcount != 0
begin
   	select @w_mensaje = rtrim (valor)
     	  from cobis..cl_catalogo
     	 where tabla = (select codigo from cobis..cl_tabla
     			 where tabla = 'cc_tbloqueo')
     	   and codigo = @w_tipo_bloqueo
     	select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
     	exec cobis..sp_cerror1 
     		@t_debug  = @t_debug,   @t_file	= @t_file,
     		@t_from	  = @w_sp_name, @i_num	= 201008, 
     		@i_sev	  = 1,          @i_msg	= @w_mensaje,
     		@i_pit	  = @i_pit
     	return 201008
end

/* Calcular el saldo */
exec @w_return = cob_cuentas..sp_calcula_saldo
                        @t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name, 
                        @i_cuenta       = @i_cuenta,
                        @i_fecha        = @i_fecha,
                        @i_ofi          = @s_ofi,
			@o_saldo_para_girar = @w_saldo_para_girar out,
			@o_saldo_contable   = @w_saldo_contable out
if @w_return != 0
   return @w_return

/* Encuentra datos de trabajo de la cuenta */
 select	@w_remesas    = cc_remesas,
	@w_tipo_prom  = cc_tipo_promedio,
	@o_nombre     = substring(cc_nombre,1,30),
	@w_12h        = cc_12h,
        @w_12h_dif    = cc_12h_dif,
	@w_24h        = cc_24h,
	@w_mon        = cc_moneda,
	@w_disponible = cc_disponible,
	@w_chequeras  = cc_chequeras,
	@w_cheque_ini = cc_cheque_inicial,
	@w_suspensos  = cc_suspensos,
	@w_protestos  = cc_protestos,
	@w_monto_blq  = cc_monto_blq,
	@w_promedio1  = cc_promedio1,
	@w_prom_disp  = cc_prom_disponible,
	@w_credmes    = cc_creditos_mes,
	@w_credhoy    = cc_creditos_hoy,
	@w_debmes     = cc_debitos_mes,
	@w_debhoy     = cc_debitos_hoy,
        @w_revocados  = cc_revocados,
        @w_rem_hoy    = cc_rem_hoy,
        @w_cliente    = cc_cliente,
	@w_clase_clte = cc_clase_clte,
	@w_categoria  = cc_categoria,
	@w_oficina    = cc_oficina,
	@w_tipo_ente  = cc_tipocta,
	@w_prod_banc  = cc_prod_banc,
	@w_rol_ente   = cc_rol_ente,
	@w_tipo_def   = cc_tipo_def,
        @w_producto     = cc_producto,
        @w_tipo         = cc_tipo,
        @w_codigo       = cc_default,
        @w_personaliza  = cc_personalizada,
	@w_filial	= cc_filial,
	@w_dias_sobregiro    = cc_dias_sob_cont,		-- EAA 23/Feb/01
        @w_cta_banco	    = cc_cta_banco,		-- EAA 23/Feb/01
	@w_reg_imp2x1000 = cc_nxmil,			-- EAA 19/Abr/01 CC00179
	@w_lim_sobregiro = cc_lim_sobregiro,
        @w_dep_ini      = cc_dep_ini,
  	@w_paquete   = cc_paquete  --CLE 11042006
   from cob_cuentas..cc_ctacte
  where cc_ctacte = @i_cuenta
    and cc_estado != 'G'            /* Cuenta de Gerencia */


select @w_ciudad_cta = of_ciudad
  from cobis..cl_oficina
 where of_oficina = @w_oficina

if @@rowcount != 1
begin
     exec cobis..sp_cerror1
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from        = @w_sp_name,
          @i_num         = 201094,
          @i_pit	= @i_pit         
end
 

select @w_ciudad_loc = of_ciudad
  from cobis..cl_oficina
 where of_oficina = @s_ofi

if @@rowcount != 1
begin
     exec cobis..sp_cerror1
          @t_debug       = @t_debug,
          @t_file        = @t_file,
          @t_from        = @w_sp_name,
          @i_num         = 201094,
          @i_pit	 = @i_pit
          
end


-- II ARV ABRIL/05/2001 verifica si tiene comision la causal

select @w_comision_1 = 'N'

if @t_trn = 50
begin  
	select @w_comision_1 = an_comision
	  from cob_remesas..re_accion_nd
	 where an_producto = 3
	   and an_causa = @i_cau
	if @@rowcount =0
	begin
		select  @w_impuesto = 0,
			@w_timpuesto  = 0
	end
	else
		if  @w_comision_1 = 'S'
		begin

			exec sp_exento_impuestos
				@i_trn 		= @t_trn,
				@i_empresa	= 1,
				@i_impuesto	= 'V',
				@i_causal	= @i_cau,
				@i_debcred	= 'C',
				@i_oforig_admin	= @s_ofi,
				@i_ofdest_admin = @w_oficina,
				@i_ente   	= @w_cliente,
				@i_producto	= 3,
				@i_pit		= @i_pit,
				@o_exento	= @o_exento  out,
				@o_base		= @o_base out,
				@o_porcentaje	= @o_porcentaje	out

		if @o_exento = 'N'

			select @w_piva = @o_porcentaje
		else
			select @w_piva = 0


			select @w_impuesto = round((@i_val * @w_piva / 100), @w_numdeciimp)
			select @w_timpuesto  = @w_piva
			select @o_impuesto=@w_impuesto


	end
end

if @t_trn = 50 and @w_comision_1 = 'S'
	select @w_val_efe = isnull(@i_val,0)  + isnull(@w_impuesto,0),
               @i_val = @w_val_efe 


if @w_trn = 50
   if @w_lim_sobregiro != 1 and @w_saldo_para_girar < @i_val
	begin
	  exec cobis..sp_cerror1
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 208065,
               @i_pit	= @i_pit
               
           return 208065
	end


-- ID EAA 19/Abr/01 CC00179
-- Se aplica o no ICC e impuesto 2x1000
/*select @w_reg_icc = en_retencion,
       @w_reg_imp2x1000 = en_exc_por2
from cobis..cl_ente
where en_ente = @w_cliente*/
-- FD EAA 19/Abr/01

if @w_reg_icc = 'S'
begin
  select @w_tasa_icc = pa_float
    from cobis..cl_parametro
   where pa_nemonico = 'ICC'
     and pa_producto = 'CTE'

  if @@rowcount = 0
     begin
       exec cobis..sp_cerror1
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @t_from,
            @i_num   = 201196,
            @i_pit   = @i_pit
            
       return 201196
     end 
end
else
   select @w_tasa_icc = 0, @o_val_icc = 0

if @w_reg_imp2x1000 = "N" and @t_trn > 48
   begin
        /*Impuesto del 2x1000 a los debitos*/
        select @w_imp_2x1000 = pa_float
        from cobis..cl_parametro
        where pa_nemonico = 'IMDB'
        and pa_producto = 'CTE'

        if @@rowcount = 0
           begin
              exec cobis..sp_cerror1
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @t_from,
                @i_num   = 201196,
                @i_pit	 = @i_pit
                
              return 201196
           end
           select @o_val_2x1000 = round((@i_val * @w_imp_2x1000),@w_numdeciimp)
   end
else
        select @o_val_2x1000 = 0
        
if @i_cau = '336' or @i_cau = '430' or @i_cau = '295' or @i_cau = '493' or @i_cau = '290' or @i_cau = '311' or @i_cau = '117'
   select @o_val_2x1000 = 0
               
        
        
/** Bloqueo de cuenta sobregiradas */
/** II - EAA 23/Feb/2001  cc00190 **/

if @w_disponible < 0
begin

     if @w_dias_sobregiro > 30 and @i_val > 0
     begin
            select @w_tot_intereses = sum(isnull(us_interes_acum,0)) +
                                      sum(isnull(us_int_causados,0)) +
                                      sum(isnull(us_int_contingentes,0))
              from cob_cuentas..cc_uso_sobregiro
             where us_cuenta = @i_cuenta
               and us_fecha_reg = @w_ant_fec_lab

            if @w_tot_intereses is null
              
select @w_tot_intereses = 0


            select @w_tot_bloq = sum(isnull(hb_valor,0))
              from cc_his_bloqueo
             where hb_ctacte = @i_cuenta
               and hb_causa = '7'
               and hb_accion = 'B'
               and hb_levantado = 'NO'


            if @w_tot_bloq is null
              
select @w_tot_bloq = 0


            if @w_tot_bloq < @w_tot_intereses
            begin
                   select @w_tot_intereses = @w_tot_intereses - @w_tot_bloq


                   if @w_tot_intereses > @i_val
                      select @w_tot_intereses = @i_val


                   exec @w_return = cob_cuentas..sp_bloq_val_cc
                          @s_ssn          = @s_ssn,
                          @s_srv          = @s_srv,
                          @s_ofi          = @s_ofi,
                          @s_date         = @s_date,
                          @s_user         = @s_user,
                          @s_sesn         = @s_ssn,
                          @s_term         = @s_term,
                          @s_lsrv         = @s_lsrv,
                          @s_org          = 'L',
                          @s_ofi          = 1,
                          @t_trn          = 9,
                          @i_cta          = @i_cta,
                          @i_mon          = 0,
                          @i_aut          = @s_user,
                          @i_solicit      = 'BANCO AGRARIO',
                          @i_accion       = 'B',
          @i_causa        = '7',
                          @i_valor        = @w_tot_intereses,
                          @i_enlinea      = 'N',
                          @i_pit	  = @i_pit,
                          @o_disponible   = @w_slddis out

                  if @w_return <> 0
                     return @w_return
            end
     end
end
     

--Calculo valor debito total
 select @w_val_total = @i_val + @o_val_2x1000 

if @t_trn in (51, 49, 47) and @i_factor = 1
begin
     exec @w_return = cob_cuentas..sp_valida_cheque 
     		@t_debug 		= @t_debug, 
     		@t_file			= @t_file,
     		@t_from			= @w_sp_name,
     		@i_cuenta		= @i_cuenta, 
     		@i_cheque		= @i_nchq, 
     		@i_val_cta		= 'N',
     		@i_moneda		= @i_mon,
     		@i_cheque_ini		= @w_cheque_ini,
     		@i_chequeras		= @w_chequeras,
     		@i_pit			= @i_pit,
     		@o_estado_actual	= @w_estado_actual	out, 
     		@o_estado_anterior	= @w_estado_anterior	out, 
     		@o_causa_np		= @w_causa_np		out, 
     		@o_clase_np		= @w_clase_np 		out
     if @w_return <> 0
     	return @w_return
     if @w_estado_actual in ('A', 'R')
     begin
     	select	@w_desc_causa = rtrim(valor)
     	  from	cobis..cl_catalogo
     	 where  tabla = (select codigo from cobis..cl_tabla
     				where tabla = 'cc_causa_np')
     	select	@w_desc_clase = rtrim(valor)
     	  from	cobis..cl_catalogo
     	 where  tabla = (select codigo from cobis..cl_tabla
     				where tabla = 'cc_clase_np')
     	select 	@w_mensaje = 'Causa: ' + @w_desc_causa + 
     			     ' Clase: ' + @w_desc_clase
     end
     if @w_estado_actual = 'R' and @t_trn not in (47,49)
     begin
     	select	@w_mensaje = 'Cheque revocado ' + @w_mensaje
     	exec cobis..sp_cerror1 
     		@t_debug= @t_debug,   @t_file  = @t_file,
     		@t_from	= @w_sp_name, @i_num   = 201009, 
     		@i_sev	= 1,          @i_msg   = @w_mensaje,
     		@i_pit  = @i_pit
     	return 201009
     end
     if @w_estado_actual != 'R' and @t_trn = 49
     begin
        exec cobis..sp_cerror1
                @t_debug= @t_debug, @t_file = @t_file,
                @t_from = @w_sp_name, @i_num  = 201009,
                @i_msg  = 'Favor usar la revocatoria administrativa',
                @i_pit  = @i_pit
                
        return 201009
     end
     if @w_estado_actual = 'A'
     begin
     	select @w_mensaje = 'Cheque anulado ' + @w_mensaje
     	exec cobis..sp_cerror1
     		@t_debug= @t_debug, @t_file	= @t_file,
     		@t_from	= @w_sp_name, @i_num	= 201010, 
     		@i_sev	= 1, @i_msg	= @w_mensaje,
     		@i_pit  = @i_pit
     		
     	return 201010
     end
     if @w_estado_actual = 'P'
     begin
     	/*  Cheque ya ha sido pagado  */
     	exec cobis..sp_cerror1
     		@t_debug= @t_debug, @t_file	= @t_file,
     		@t_from	= @w_sp_name, @i_num	= 201011,
     		@i_pit	= @i_pit
     		     	
     	return 201011
     end
     if @w_estado_actual = 'C'
     begin
     	/*  Cheque certificado  */
     	exec cobis..sp_cerror1 
     		@t_debug= @t_debug, @t_file	= @t_file,
     		@t_from	= @w_sp_name, @i_num	= 201012,
     		@i_pit  = @i_pit
     		
     	return 201012
     end
end

if @t_trn = 51 and @i_factor = -1 and @w_protestos = 0
begin
	exec cobis..sp_cerror @t_debug	= @t_debug, @t_file = @t_file,
					  @t_from = @w_sp_name, @i_num = 201029,
					  @i_pit  = @i_pit
					  
	return 201029
end

/* Encuentra alicuota del promedio */
select @w_alicuota = fp_alicuota
  from cob_cuentas..cc_fecha_promedio
 where fp_tipo_promedio = @w_tipo_prom
   and fp_fecha_inicio = convert(smalldatetime,@i_fecha)
if @@rowcount = 0
begin
     exec cobis..sp_cerror1
         @t_debug        = @t_debug, @t_file         = @t_file,
         @t_from         = @w_sp_name, @i_num          = 201060,
         @i_pit		 = @i_pit
         
     return 201060
end

select @o_val_ser = 0, @o_val_mon = 0
/* Validar Fondos */
if @t_trn > 48 and @t_trn != 51
begin
	if @s_org = 'U'
	   select @w_ssn_tmp = @t_ssn_corr
	else
 	   if @s_org = 'S'
	      select @w_ssn_tmp = @p_rssn_corr

	if @i_ind = 2 and @i_val > @w_12h and @i_factor = 1
	  begin
	     exec cobis..sp_cerror1
                  @t_debug = @t_debug,
                  @t_file = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num = 201026,
                  @i_pit = @i_pit
                   
	     return 201026
	  end
	if @i_ind = 3 and @i_val > @w_24h and @i_factor = 1
	  begin
	     exec cobis..sp_cerror1
                  @t_debug = @t_debug,
                  @t_file = @t_file,
                  @t_from = @w_sp_name,
                  @i_num = 201026,
                  @i_pit = @i_pit 
	     return 201026
	  end
	if @i_ind = 4 and @i_val > @w_remesas and @i_factor = 1
       	  begin
	     exec cobis..sp_cerror1
                  @t_debug = @t_debug,
                  @t_file = @t_file,
                  @t_from = @w_sp_name,
                  @i_num = 201027,
                  @i_pit = @i_pit
                   
	     return 201027
	  end

	/* Determina la existencia en la tabla de transacciones de servicio */
	/* La variable @w_tmp solo sirve para que al query no despliegue nada */
	/* @w_flag = 1 existe en transacciones de servicio    */
	/* @w_flag = 0 no existe en transacciones de servicio */

	select @w_flag = 1

        if @s_org = "U"  /*RQU: Personalizaci¢n Branch II  30-Nov-1998*/
        begin
	  select @w_tmp = alterno
          from cob_cuentas..cc_tsval_suspenso 
	  where remoto_ssn = @t_ssn_corr   
          and   oficina    = @s_ofi  
	  if @@rowcount = 0
	   select @w_flag = 0 
        end
        else
        begin
          select @w_tmp = alterno
          from cob_cuentas..cc_tsval_suspenso 
	  where secuencial = @w_ssn_tmp          

	  if @@rowcount = 0
	   select @w_flag = 0 
        end
	/* Encuentra accion para la causa de las notas de debito */
	select @w_accion = an_accion
	  from cob_remesas..re_accion_nd
	 where an_producto = 3
	   and an_causa = @i_cau
	if @@rowcount = 0
		select @w_accion = 'S'

        -- II ERP 29/May/2001 CCCC00327   
        if (@w_saldo_para_girar < @w_val_total and @t_trn = 50)
           begin
             if @s_term in ('PIT','SAFE','FX11')
                select @o_pide_aut = 'N'
             else
                select @o_pide_aut = 'S'

             select @o_dif = @w_val_total - @w_saldo_para_girar
           end
        -- FI ERP 29/May/2001 CCCC00327

	if  (@i_ind = 1 and @w_saldo_para_girar < @w_val_total and 
		@i_factor = 1 and
	     @t_trn != 51 and @w_accion = 'V') or 
	    (@w_flag = 1 and @i_ind = 1 and @i_factor = -1 and @w_accion = 'V')
	begin
                begin tran
		select @w_suspensos = @w_suspensos + @i_factor
		/* Valor a poner en suspenso */
		if @w_saldo_para_girar <= 0
		begin
			/* pone todo a suspenso */
			select @w_val = @w_val_total
			select @o_sus_flag = 2
			select @o_val_ser = @w_val_total
		end
		else
		begin
			/* pone solo el faltante a suspenso */
		   	select @w_val = @w_val_total - @w_saldo_para_girar
			select @o_sus_flag = 1
			select @o_val_ser = @w_val
			select @o_val_mon = @w_val_total - @w_val
		end

  		exec @w_return = cobis..sp_cseqnos
          		@t_debug = @t_debug,
          		@t_file  = @t_file,
          		@t_from  = @w_sp_name,
          		@i_tabla = 'cc_val_suspenso',
          		@o_siguiente = @w_sec out

     		if @w_return != 0
        		return @w_return

     		if @w_sec > 2147483640
     		begin
        		select @w_sec = 1
        		update cobis..cl_seqnos
        		   set siguiente = @w_sec
        		 where tabla ='cc_val_suspenso'
		end

                if @t_trn = 51 or @t_trn = 49
                   select @w_trn = 50
                else
                   select @w_trn = @t_trn

		if @i_factor = 1
		begin

        insert into cob_cuentas..cc_val_suspenso
     		  	     (vs_cuenta, vs_secuencial, vs_servicio, vs_estado,
                              vs_procesada, vs_valor, vs_fecha, vs_oficina,
                              vs_hora, vs_ssn, vs_clave)
     		  values (@i_cuenta, @w_sec, @i_cau, 'N',
                          'N', @w_val, @i_fecha, @s_ofi,
                          getdate(), @s_ssn, 0)

                  if @@error != 0
     		    begin
     	     	      exec cobis..sp_cerror1 
                           @t_debug = @t_debug,
                           @t_file = @t_file,
                           @t_from = @w_sp_name, @i_num = 203011,
                           @i_pit  = @i_pit
                            
     	       	      return 203011
     		    end

		  if @i_sus is not null
		   
begin
		           select @w_suspensos = @w_suspensos - 1

			   update cob_cuentas..cc_val_suspenso
			      set vs_estado = 'C',
			          vs_procesada = 'S'
			    where vs_cuenta = @i_cuenta
			      and vs_secuencial = @i_sus
			   if @@rowcount != 1
			   begin
     				exec cobis..sp_cerror1
                                     @t_debug = @t_debug,
                                     @t_file = @t_file,
                                     @t_from  = @w_sp_name,
                                     @i_num  = 205013,
                                     @i_pit  = @i_pit
                                     
     				return 205013
			   end
		    end
                end
                else
		begin
		     select @w_val = vs_valor,
		   	    @w_clave = vs_clave
		       from cob_cuentas..cc_val_suspenso
		      where vs_fecha = @i_fecha
		        and vs_ssn   = @w_ssn_tmp
		     
		     if @w_val = @w_val_total
		     begin
			  select @o_sus_flag = 2
			  select @o_val_ser = @w_val
		     end
		     else
		     begin
			  select @o_sus_flag = 1
			  select @o_val_ser = @w_val
			  select @o_val_mon = @w_val_total - @w_val
		     end

		     update cob_cuentas..cc_val_suspenso 
		        set vs_estado = 'A', vs_procesada = 'S'
		      where vs_fecha = @i_fecha
		        and vs_ssn = @w_ssn_tmp
                     if @@rowcount != 1
		     begin
	     			exec cobis..sp_cerror1
                                     @t_debug = @t_debug,  @t_file = @t_file,
                                     @t_from = @w_sp_name, @i_num = 205013,
                                     @i_pit  = @i_pit
                                      
	     			return 205013
		     end
		end 
		select @w_promedio1 = @w_promedio1 - convert (money, 
				     round((@w_val_total - @w_val)*@w_alicuota,
				      @w_numdeci)) * @i_factor
		select @w_prom_disp = @w_prom_disp - convert (money,
				     round((@w_val_total - @w_val)*@w_alicuota,
				      @w_numdeci)) * @i_factor
		if @i_reverso = 'R'
                   select @w_credmes = @w_credmes+@w_val_total*@i_factor*(-1),
	                  @w_credhoy = @w_credhoy+@w_val_total*@i_factor*(-1)
		else
		   select @w_debmes = @w_debmes + @o_val_mon * @i_factor,
		          @w_debhoy = @w_debhoy + @o_val_mon * @i_factor
				
                /* Actualizacion de Cuentas Corrientes */

               	update cob_cuentas..cc_ctacte
               	   set cc_suspensos       = @w_suspensos,
		       cc_promedio1       = @w_promedio1, 
		       cc_disponible      = @w_disponible - 
                                            (@w_val_total - @w_val)* @i_factor,
                       cc_prom_disponible = @w_prom_disp,
		       cc_debitos_mes	  = @w_debmes,
		       cc_debitos_hoy	  = @w_debhoy,
                       cc_creditos_mes    = @w_credmes,
                       cc_creditos_hoy    = @w_credhoy,
		       cc_contador_trx    = cc_contador_trx + @i_factor
                 where @i_cuenta = cc_ctacte
               	if @@rowcount != 1
		begin
	  		exec cobis..sp_cerror1
                             @t_debug  = @t_debug, @t_file = @t_file,
                             @t_from = @w_sp_name, @i_num = 205001,
                             @i_pit  = @i_pit
                             
	     		return 205001
		end
		select @o_sldcont = @w_saldo_contable + (@w_val_total-@w_val)
					* @i_factor * @w_factor
		select @o_slddisp = @w_disponible + (@w_val_total - @w_val) * 
						@i_factor * @w_factor
             	commit tran
                /*RQU: Personalizaci¢n Branch II 30-Nov-98*/
                /* SP que devuelve resultados para Branch II */
                if @t_ejec = 'R'
                begin
                   exec @w_return = cob_cuentas..sp_resultados_branch_cc
                        @i_cuenta       = @i_cuenta,
                        @i_fecha        = @s_date,
                        @i_ofi          = @s_ofi,
			@i_tipo_cuenta  = 'O'

                   if @w_return != 0
                       return @w_return
                end
	     	return 0
	end
	else
        if  (@i_ind = 1 and @w_saldo_para_girar < @w_val_total 
		and @i_factor = 1 
             and @t_trn != 51 and @w_accion = 'E') or 
	    (@w_flag = 1 and @i_ind = 1 and @i_factor = -1 and @w_accion = 'E')
	begin
		exec cobis..sp_cerror1 
                     @t_debug = @t_debug,   @t_file = @t_file,
                     @t_from = @w_sp_name,  @i_num = 201017,
                     @i_pit = @i_pit
                     
	     	return 201017
	end

end

begin tran
if @t_trn = 51
begin
	select @w_dif = @i_valch - @w_saldo_para_girar

        /* La multa es por el valor total del cheque */
	/* select @i_val = @w_dif * 0.1             */

        select @i_val = round((@i_valch * 0.1), @w_numdeci)

	select @w_protestos = @w_protestos + @i_factor
	if @w_saldo_para_girar < @i_val
	begin
		if @w_saldo_para_girar > $0
			select @w_cobrado = @w_saldo_para_girar
		else
			select @w_cobrado = $0 
	end
	else
		select @w_cobrado = @i_val

	exec @w_return = cob_cuentas..sp_protesto
			@i_cuenta   = @i_cuenta,
			@i_nchq     = @i_nchq,
			@i_ori      = @i_ori,
			@i_valch    = @i_valch,
			@i_val      = @i_val,
			@i_causa    = @i_cau,
			@i_cobrado  = @w_cobrado,
			@i_fecha    = @i_fecha,
			@i_factor   = @i_factor,
			@i_oficina  = @s_ofi,
			@i_usuario  = @s_user,
			@i_pit      = @i_pit,
			@t_trn      = @t_trn,
			@t_debug    = @t_debug,
			@t_file     = @t_file,
			@t_from     = @w_sp_name
	if @w_return <> 0
   		return @w_return

	select @i_val = @w_cobrado
end

/* Actualizacion de tabla de cuentas corrientes */
-- EMO ICC 29-dic-1999
if @t_trn < 49
begin
  select @w_accion_nc = an_accion
    from cob_remesas..re_accion_nc
   where an_producto = 3
     and an_causa = @i_cau

  if @@rowcount = 0
     select @w_accion_nc = 'S'
  
  if (@w_reg_icc = 'S' and @w_accion_nc = 'S')
  begin
     select @o_val_icc = round((@w_val_total * @w_tasa_icc)/100,@w_numdeci)
     select @i_val = @w_val_total - @o_val_icc 
  end
end

select @w_alic = @w_val_total * @w_alicuota  /*  alicuota */
select @w_promedio1 = @w_promedio1 + round(@w_alic,@w_numdeci) * 
			@i_factor * @w_factor
if @t_trn > 48
begin
   if @i_reverso = 'R'
      select @w_credmes = @w_credmes + @w_val_total * @i_factor * (-1),
	     @w_credhoy = @w_credhoy + @w_val_total * @i_factor * (-1)
   else
      select @w_debmes = @w_debmes + @w_val_total * @i_factor,
             @w_debhoy = @w_debhoy + @w_val_total * @i_factor
end
else
begin
   if @i_reverso = 'R'
      select @w_debmes = @w_debmes + @w_val_total * @i_factor * (-1),
             @w_debhoy = @w_debhoy + @w_val_total * @i_factor * (-1)
   else
      select @w_credmes = @w_credmes + @w_val_total * @i_factor,
	     @w_credhoy = @w_credhoy + @w_val_total * @i_factor
end

if @i_ind = 1
begin
   select @w_disponible = @w_disponible + @w_val_total * @i_factor * @w_factor
   select @w_prom_disp = @w_prom_disp + round(@w_alic,@w_numdeci) *
                            @i_factor * @w_factor
end
else
   if @i_ind = 2
    begin

      select @w_12h = @w_12h + (@i_val * @i_factor * @w_factor)

      if @i_dif = 'S'
          select @w_12h_dif = @w_12h_dif + (@i_val*@i_factor * @w_factor)

    end
   else
      if @i_ind = 3
      begin

         /* Determinar la ciudad de deposito */

         select @w_ciudad = of_ciudad
           from cobis..cl_oficina
          where of_filial = 1
            and of_oficina = @s_ofi

         select @w_24h = @w_24h + @i_val * @i_factor * @w_factor

         /* Determinar el numero de dias de retencion para la ciudad */

         select @w_dias_ret = cr_dias
           from cob_remesas..re_ciudad_retencion
          where  cr_ciudad= @w_ciudad

         if @@rowcount = 0
          begin

            /* Determinar el parametro general */

            select @w_dias_ret = pa_tinyint
              from cobis..cl_parametro
             where pa_producto = 'CTE'
               and pa_nemonico = 'DIRE'

            if @@rowcount = 0
              begin
                exec cobis..sp_cerror1
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 205001,
                     @i_pit	     = @i_pit
                     
                return 205001
              end

          end

         /* Determinar la fecha de efectivizacion del deposito */

         if @i_dif = 'S'
	    select @w_dias_ret = @w_dias_ret + 1
            select @w_fecha_efe = dateadd(dd,1,@i_fecha),
                   @w_cont = 0

         while @w_cont < @w_dias_ret
	    begin
             if exists (select df_fecha from cobis..cl_dias_feriados
                         where df_ciudad = @w_ciudad
                           and df_fecha = @w_fecha_efe)
             select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
             else
	     begin
	     select @w_cont = @w_cont + 1
	     if @w_cont < @w_dias_ret
	        select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)
	     end
	    end

         /* Corregir el deposito en la tabla de depositos */

         if not exists (select cd_cuenta
                          from cob_cuentas..cc_ciudad_deposito
                         where cd_cuenta = @i_cuenta
                           and cd_ciudad = @w_ciudad
                           and cd_fecha_depo = @i_fecha
                           and cd_fecha_efe  = @w_fecha_efe)
           begin

              insert into cob_cuentas..cc_ciudad_deposito
                     (cd_cuenta, cd_ciudad, cd_fecha_depo,
                      cd_fecha_efe, cd_valor)
              values (@i_cuenta, @w_ciudad, @i_fecha,
                      @w_fecha_efe, @i_val)


              if @@error != 0
                begin
                  exec cobis..sp_cerror1
                       @t_debug        = @t_debug,
                       @t_file         = @t_file,
                       @t_from         = @w_sp_name,
                       @i_num          = 205001,
                       @i_pit	       = @i_pit
                       
                  return 205001
                end

           end
         else
           begin

             update cob_cuentas..cc_ciudad_deposito
                set cd_valor = cd_valor + (@i_val * @i_factor * @w_factor)
              where cd_cuenta = @i_cuenta
                and cd_ciudad = @w_ciudad
                and cd_fecha_depo = @i_fecha
                and cd_fecha_efe  = @w_fecha_efe

             if @@rowcount != 1
               begin
                 exec cobis..sp_cerror1
                      @t_debug        = @t_debug,
                      @t_file         = @t_file,
                      @t_from         = @w_sp_name,
                      @i_num          = 205001,
                      @i_pit	      = @i_pit
                      
                 return 205001
               end

           end

      end
      else
         select @w_remesas = @w_remesas + @i_val * @i_factor * @w_factor,
                @w_rem_hoy = @w_rem_hoy + @i_val * @i_factor * @w_factor

if @i_sus is not null
begin
     select @w_suspensos = @w_suspensos - 1

     update cob_cuentas..cc_val_suspenso
        set vs_estado = 'C',
            vs_procesada = 'S'
      where vs_cuenta = @i_cuenta
        and vs_secuencial = @i_sus
     if @@rowcount != 1
     begin
     	exec cobis..sp_cerror1
       		@t_debug        = @t_debug,
       		@t_file         = @t_file,
       		@t_from         = @w_sp_name,
       		@i_num          = 205013,
       		@i_pit		= @i_pit
       		
        return 205013
     end
end

if @t_trn = 48 and @w_dep_ini = 1
   select @w_dep_ini = 0

update cob_cuentas..cc_ctacte
   set cc_disponible      = @w_disponible, 
       cc_promedio1       = @w_promedio1,
       cc_12h             = @w_12h,
       cc_12h_dif         = @w_12h_dif,
       cc_24h             = @w_24h,
       cc_remesas         = @w_remesas,
       cc_rem_hoy         = @w_rem_hoy,
       cc_protestos       = @w_protestos,
       cc_suspensos       = @w_suspensos,
       cc_monto_blq       = @w_monto_blq,
       cc_fecha_ult_mov   = @i_fecha,
       cc_prom_disponible = @w_prom_disp,
       cc_creditos_mes    = @w_credmes,
       cc_creditos_hoy    = @w_credhoy,
       cc_debitos_hoy     = @w_debhoy,
       cc_debitos_mes     = @w_debmes,
       cc_contador_trx    = cc_contador_trx + @i_factor,
       cc_revocados       = @w_revocados,
       cc_dep_ini         = @w_dep_ini
 where @i_cuenta = cc_ctacte
if @@rowcount != 1
begin
      exec cobis..sp_cerror1
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 205001,
                @i_pit		= @i_pit
                
      return 205001
end


if @w_ciudad_cta <> @w_ciudad_loc
begin
          if @i_factor = 1
          begin
               /* Se realiza el cobro de comision por transaccion nacional */

               exec @w_return = cob_remesas..sp_genera_costos
                    @s_srv          = @s_srv,
                    @s_ofi          = @s_ofi,
                    @s_ssn          = @s_ssn,
                    @s_user         = @s_user,
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_fecha        = @i_fecha,
                    @i_valor        = 1,
                    @i_categoria    = @w_categoria,
                    @i_tipo_ente    = @w_tipo_ente,
                    @i_rol_ente     = @w_rol_ente,
                    @i_tipo_def     = @w_tipo_def,
                    @i_prod_banc    = @w_prod_banc,              
                    @i_producto     = @w_producto,
                    @i_moneda       = @i_mon,
                    @i_tipo         = @w_tipo,
                    @i_codigo       = @w_codigo,
                    @i_servicio     = 'TRNA',
                    @i_rubro        = '3',
                    @i_disponible   = @w_disponible,
                    @i_contable     = @w_saldo_contable,
                    @i_promedio     = @w_promedio1,
                    @i_prom_disp    = @w_prom_disp,
                    @i_personaliza  = @w_personaliza,
                    @i_filial       = @w_filial,
                    @i_oficina      = @w_oficina,
                    @i_pit	    = @i_pit,
      	    	    @i_paquete      = @w_paquete, --CLE 11042006
                    @o_valor_total  = @w_comision out

               if @w_return <> 0
                  return @w_return                           

		if isnull(@w_comision, 0) > 0
		begin
               /* Debito a la cuenta por el valor de la comision mas el iva */
               exec @w_return = cob_cuentas..sp_ccndc_automatica
                    @s_srv       = @s_srv,
                    @s_ssn       = @s_ssn,
                    @s_ofi       = @s_ofi,
                    @s_ssn_branch= @s_ssn_branch,
                    @s_user      = @s_user,
                    @t_trn       = 50,
                  --II VMA 21-02-2001
                    @i_alt	 = 1,
		  --FI VMA 21-02-2001
                    @i_cta       = @i_cta,
                    @i_cau       = '52',  --POR COMISION TRAN NACIONAL  -- Adriana Rodriguez Agosto 01 de 2002
                    @i_mon       = @i_mon,
                    @i_fecha     = @i_fecha,
                    @i_val	 = @w_comision, -- ARV ABRIL/05/2001
-- ARV ABRIL/05/2001  @i_comision  = @w_comision,  
                    @i_cobiva    = 'S',
                    @i_pit	 = @i_pit,
                    @o_clase_clte = @w_clase_clte out,
                    @o_prod_banc  = @w_prod_banc  out,
                    @o_valiva     = @w_valor_cobro out

               if @w_return <> 0
                  return @w_return                               

	      select @w_valor_cobro = round(@w_valor_cobro, @w_numdeciimp)

              select @w_cobro_total =  @w_valor_cobro + @w_comision

               /* Grabar registro de comision en cc_fecha_valor para  */
               /* manejo de reverso*/

               insert into cob_cuentas..cc_fecha_valor
                      (fv_transaccion, fv_cuenta, fv_referencia,
                       fv_rubro, fv_costo)
               values (@t_trn, @i_cuenta, convert(varchar(24), @s_ssn_branch),
                       '1', @w_comision)
               if @@error != 0
               begin
                    /* Error de insercion */
                    exec cobis..sp_cerror1
                         @t_debug    = @t_debug,
                         @t_file     = @t_file,
                         @t_from     = @w_sp_name,
                         @i_num      = 601161,
                         @i_pit	     = @i_pit
                         
                    return 601161
               end                                    
	       end
	       
	       if isnull(@w_valor_cobro,0) > 0
	       begin
               /* Grabar registro de iva a cc_fecha_valor para manejar reverso*/
               insert into cob_cuentas..cc_fecha_valor
                      (fv_transaccion, fv_cuenta, fv_referencia,
                       fv_rubro, fv_costo)
               values (@t_trn, @i_cuenta, convert(varchar(24), @s_ssn_branch),
                       '2', @w_valor_cobro)
               if @@error != 0
               begin
                    /* Error */
                    exec cobis..sp_cerror1
                         @t_debug    = @t_debug,
                         @t_file     = @t_file,
                         @t_from     = @w_sp_name,
                         @i_num      = 601161,
                         @i_pit	     = @i_pit
                         
                    return 601161
               end
               end
          end
          else
          begin                                         
               /* La transaccion va a ser reversada */

	      select @w_com_rev = 0

              select @w_com_rev = fv_costo
                 from cob_cuentas..cc_fecha_valor
                where fv_transaccion = convert(smallint,@t_trn)
                  and fv_cuenta      = @i_cuenta
                  and fv_referencia  =  convert(varchar(24), @t_ssn_corr )
                  and fv_rubro       = '1'
               /*if @@rowcount = 0
               begin
               	
                    /* No existe transaccion a reversar */
                    exec cobis..sp_cerror1
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 208052,
                         @i_pit   = @i_pit
                         
                    return 208052
               end */                                

		select @w_val_cob_rev = 0
		
               select @w_val_cob_rev = fv_costo
                 from cob_cuentas..cc_fecha_valor
                where fv_transaccion = convert(smallint,@t_trn)
                  and fv_cuenta      = @i_cuenta
                  and fv_referencia  =  convert(varchar(24), @t_ssn_corr)
                  and fv_rubro       = '2'
               /*if @@rowcount = 0
               begin
                    /* No existe transaccion a reversar */
                    exec cobis..sp_cerror1
                         @t_debug = @t_debug,
                         @t_file  = @t_file,
                         @t_from  = @w_sp_name,
                         @i_num   = 208052,
                         @i_pit   = @i_pit
                         
                    return 208052
               end*/
                                                    
	       if isnull(@w_com_rev,0) > 0 
		begin
                /* Credito a la cuenta por el valor de la comision */
                exec @w_return = cob_cuentas..sp_ccndc_automatica
                     @s_srv       = @s_srv,
                     @s_ssn       = @s_ssn,
                     @s_ofi       = @s_ofi,
                     @s_ssn_branch= @s_ssn_branch,
                     @s_user      = @s_user,
                     @t_trn       = 48,
                     @i_cta       = @i_cta,
                     @i_val       = @w_com_rev,
                     @i_cau       = '20', --POR DEVOLUCION COMISION TRAN NAL
                     @i_mon       = @i_mon,
                     @i_fecha     = @i_fecha,
                     @i_interes   = 0,
                     @i_impuesto  = 0,
		     @i_comision  = @w_com_rev,
                     @i_solca     = 0,
                     @i_mora      = 0,
                     @i_timpuesto = 0,
                     @i_tcomision = 0,
                     @i_tsolca    = 0,
                     @i_tmora     = 0,
                     @i_pit	  = @i_pit,
                     @o_clase_clte = @w_clase_clte out,       
                     @o_prod_banc  = @w_prod_banc  out

                 if @w_return <> 0
                    return @w_return                             

	               delete from cob_cuentas..cc_fecha_valor
        	        where fv_transaccion = convert(smallint,@t_trn)
                          and fv_cuenta      = @i_cuenta
                	  and fv_referencia  =  convert(varchar(24), @s_ssn_branch)
	                  and fv_rubro in ('1')
	               if @@error != 0
        	       begin
                	    /* Error en la eliminacion */
	                    exec cobis..sp_cerror1
        	                 @t_debug = @t_debug,
                	         @t_file  = @t_file,
                        	 @t_from  = @w_sp_name,
	                         @i_num   = 208052,
	                         @i_pit	  = @i_pit
	                         
        	            return 208052
               		end


		end

		if isnull(@w_val_cob_rev,0) > 0
		begin
               	  /* Credito a la cuenta por el valor del iva */
                   exec @w_return = cob_cuentas..sp_ccndc_automatica
                    	@s_srv       = @s_srv,
                    	@s_ssn       = @s_ssn,
                    	@s_ssn_branch= @s_ssn_branch,
                    	@s_ofi       = @s_ofi,
                    	@s_user      = @s_user,
                    	@t_trn       = 48,
                    	@i_cta       = @i_cta,
                    	@i_val       = @w_val_cob_rev,
                    	@i_cau       = '21',  --POR DEVOLUCION IMPUESTO
	                @i_mon       = @i_mon,
       	            	@i_fecha     = @i_fecha,
                    	@i_interes   = 0,
		    	@i_impuesto  = @w_val_cob_rev,
                    	@i_comision  = 0,
                    	@i_solca     = 0,
                    	@i_mora      = 0,
                    	@i_timpuesto = 0,
                    	@i_tcomision = 0,
                    	@i_tsolca    = 0,
                    	@i_tmora     = 0,
                    	@i_alt       = 1,
                    	@i_pit	     = @i_pit,
                    	@o_clase_clte = @w_clase_clte out,       
                    	@o_prod_banc  = @w_prod_banc  out

               	  if @w_return <> 0
                     	return @w_return
                     	
               /*Actualiza movimiento Original */
     	       update cob_cuentas..cc_tran_monet
		  set tm_estado = 'R'
               where tm_oficina = @s_ofi
                 and tm_ssn_branch =@t_ssn_corr
		 and tm_cta_banco= @i_cta
		 and tm_tipo_tran = 50
		 and tm_cod_alterno= 1
		 and tm_estado =null
--		 and tm_secuencial = @t_ssn_corr

	       if @@error != 0
	           begin
	           /* Error en la eliminacion */
	              	exec cobis..sp_cerror1
	      	         @t_debug = @t_debug,
	       	         @t_file  = @t_file,
	       	         @t_from  = @w_sp_name,
	       	         @i_num   = 208052,
	       	         @i_pit   = @i_pit 
	              return 208052
                  end    		 

               /*Actualiza movimiento Reverso */
     	       update cob_cuentas..cc_tran_monet
		  set tm_estado = 'R',
		      tm_correccion = 'S',
		      tm_sec_correccion = @t_ssn_corr
               where tm_oficina = @s_ofi
                 and tm_ssn_branch =@s_ssn_branch
		 and tm_cta_banco= @i_cta  
		 and tm_tipo_tran = 48
		 and tm_estado =null
--		 and tm_cod_alterno= 15
--		 and tm_secuencial = @s_ssn

	      if @@error != 0
	         begin
	           /* Error en la eliminacion */
	              exec cobis..sp_cerror1
	      	         @t_debug = @t_debug,
	       	         @t_file  = @t_file,
	       	         @t_from  = @w_sp_name,
	       	         @i_num   = 208052,
	       	         @i_pit   = @i_pit
	       	          
	              return 208052
                 end                      
                     	                                   

	               delete from cob_cuentas..cc_fecha_valor
        	        where fv_transaccion = convert(smallint,@t_trn)
                          and fv_cuenta      = @i_cuenta
                	  and fv_referencia  =  convert(varchar(24), @s_ssn_branch)
	                  and fv_rubro in ('2')
	               if @@error != 0
        	       begin
                	    /* Error en la eliminacion */
	                    exec cobis..sp_cerror1
        	                 @t_debug = @t_debug,
                	         @t_file  = @t_file,
                        	 @t_from  = @w_sp_name,
	                         @i_num   = 208052,
	                         @i_pit   = @i_pit
	                         
        	            return 208052
               		end


		end		


          end
end                                            


select @w_saldo_para_girar = @w_saldo_para_girar + @w_val_total *
                                                   @i_factor * @w_factor
select @o_sldcont = @w_saldo_contable + @w_val_total * @i_factor * @w_factor
select @o_slddisp = @w_disponible
select @o_val_mon = @w_val_total
select @o_sus_flag = 0
select @o_prod_banc = @w_prod_banc
select @o_clase_clte = @w_clase_clte

/*RQU: Personalizaci¢n Branch II 30-Nov-98*/
/* SP que devuelve resultados para Branch II */
if @t_ejec = 'R' 
begin
   exec @w_return = cob_cuentas..sp_resultados_branch_cc
			@s_ssn_host    = @s_ssn, 	--RAN: Migracion COBIS Explorer
                        @i_cuenta       = @i_cuenta,
                        @i_fecha        = @s_date,
                        @i_ofi          = @s_ofi,
                        @i_tipo_cuenta  = 'O'
   if @w_return != 0
    return @w_return
end

commit tran 
return 0
go
IF OBJECT_ID('dbo.sp_nota_credito_debito') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_nota_credito_debito >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_nota_credito_debito >>>'
go

go
use cob_cuentas
go
