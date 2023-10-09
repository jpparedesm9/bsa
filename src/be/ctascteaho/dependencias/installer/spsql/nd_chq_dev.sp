use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_nd_chq_dev') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_nd_chq_dev
    IF OBJECT_ID('dbo.sp_nd_chq_dev') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_nd_chq_dev >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_nd_chq_dev >>>'
END
go

create proc sp_nd_chq_dev (
	@t_debug		char(1) = 'N',
	@t_file	        	varchar(14) = null,
	@t_from	        	varchar(30) = null,
        @t_trn                  int,
        @t_rty                  char(1),
        @t_corr                 char(1),
        @s_ssn_branch           int = null,   /*RQU personalizacion branch II 15-12-98*/
        @s_ofi                  smallint,
        @s_rol                  smallint,
        @s_org                  char(1),
        @s_user                 varchar(30),
        @s_srv                  varchar(30),
        @s_lsrv                 varchar(30),
        @s_term                 varchar(10),
        @s_ssn                  int,
        @s_date                 datetime = null, /*RQU Personalizacion Branch II 1-Dic-1998*/
        @t_ssn_corr             int,
        @t_ejec                 char(1) = null, /* FVE: 06/Oct/99 resultados solo para BRANCH */
        @p_rssn_corr            int,
        @p_lssn                 int,
	@i_producto		tinyint,
	@i_cta_int              int, 
	@i_ctadb	        cuenta,
        @i_bco                  smallint,
        @i_ofi                  smallint,
        @i_ciu                  int,
	@i_ctachq	        cuenta,
        @i_nchq 		int,
        @i_valch                money,
        @i_tipchq     		varchar(1),
        @i_dpto                 smallint,
	@i_mon	        	tinyint,
        @i_cau	        	varchar(3),
	@i_factor		smallint,	/* 1=Normal, -1=Correccion */
	@i_fecha		datetime,
        @i_filial               tinyint,
        @i_oficina              smallint,
        @i_pit                  char(1) = 'N',
        @i_num_titulo           varchar(10) = null,
        @i_titulo               char(1) = 'N',
        @i_rechazo              char(1), 
	@o_sldcont		money out,
	@o_slddisp		money out,
	@o_nombre		varchar(30) out,
	@o_val_deb		money out,
	@o_ind    		tinyint out,
	@o_comision		money out,
        @o_flag                 float out,
	@o_clase_clte		char(1) = null out,
        @o_prod_banc            tinyint = null out,
        @o_cliente              int     = null out
)
as
declare	@w_return		int,
       	@w_ssn_corr             int,
	@w_sp_name		varchar(30),
        @w_alicuota             numeric(11,10),
	@w_alic 		money,
        @w_disponible           money,
        @w_promedio1            money,
        @w_prom_disp            money,
        @w_12h                  money,
        @w_flag                 float,
        @w_valor                money,
        @w_numdeci              tinyint,
	@w_mensaje		mensaje,
	@w_tipo_bloqueo		varchar(3),
        @w_saldo_para_girar     money,
        @w_saldo_contable       money,
	@w_tipo_prom		char(1),
	@w_fldeci		char(1),
        @w_categoria            char(1),
        @w_tipo_ente            char(1),
        @w_rol_ente             char(1),
        @w_tipo_def             char(1),
        @w_prod_banc            smallint,
        @w_producto             tinyint,
        @w_tipo                 char(1),
        @w_codigo               int,
        @w_personaliza          char(1),
	@w_numreg		int,
	@w_comision		money,
	@w_debmes		money,
	@w_debhoy		money,
        @w_sldcont              money,
        @w_slddisp              money,
        @w_nombre               varchar(30),
        @w_val_mon              money,
        @w_val_ser              money,
        @w_sus_flag             tinyint,
        @w_estado 		char(1),
        --ICC EMO dic-14-1999
        @w_cliente		int,
        @w_tasa_icc		float,
        @w_reg_icc		char(1),
        @w_val_icc 		money,
        @w_cta_bco_int          cuenta,
        @w_bco                tinyint,
	@w_oficial		smallint, --ARV DIC/26/00
        @w_ofi 			varchar(4),
	@w_sec 			varchar(7),
	@w_apli	 		char(1),
 	@w_numchq		varchar(8),
	@w_val	 		varchar(14),
	@w_pos 			tinyint 

/*  Captura nombre de Stored Procedure  */
select 	@w_sp_name = 'sp_nd_chq_dev'

/*  Modo de debug  */

if @s_org = 'S'
   select @w_ssn_corr = @p_rssn_corr
else
   select @w_ssn_corr = @t_ssn_corr

if @i_factor = -1
  select @w_estado = 'R'

/* Encuentra los decimales a utilizar */
select @w_fldeci = mo_decimales
  from cobis..cl_moneda
 where mo_moneda = @i_mon

if @w_fldeci = 'S'
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
           @i_pit       = @i_pit
      return 201196
   end
end
else
   select @w_numdeci = 0




/*  Determinacion de bloqueo de cuenta  */
select	@w_tipo_bloqueo = cb_tipo_bloqueo
  from 	cob_cuentas..cc_ctabloqueada
 where 	cb_cuenta = @i_cta_int
   and  cb_estado = 'V'
   and  (cb_tipo_bloqueo = '2'
    or  cb_tipo_bloqueo = '3')
if @@rowcount != 0
begin
   	select @w_mensaje = rtrim (valor)
     	from cobis..cl_catalogo
     	where tabla = (select codigo from cobis..cl_tabla
     			where tabla = 'cc_tbloqueo')
     	and codigo = @w_tipo_bloqueo
     	select @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
     	exec cobis..sp_cerror1 
     		@t_debug	= @t_debug,
     		@t_file	        = @t_file,
     		@t_from	        = @w_sp_name,
     		@i_num	        = 201008, 
     		@i_sev	        = 1, 
     		@i_msg	        = @w_mensaje,
                @i_pit          = @i_pit
     	return 201008
end

   /* Calcular el saldo */
   exec @w_return = cob_cuentas..sp_calcula_saldo
		@t_debug            = @t_debug,
		@t_file             = @t_file,
		@t_from             = @w_sp_name, 
                @i_cuenta           = @i_cta_int,
                @i_fecha            = @i_fecha,
                @i_ofi              = @s_ofi,
		@o_saldo_para_girar = @w_saldo_para_girar out,
		@o_saldo_contable   = @w_saldo_contable out
   if @w_return != 0
      return @w_return

   /* Encuentra datos de trabajo de la cuenta */
   select	@w_tipo_prom     = cc_tipo_promedio,
         	@o_nombre        = substring(cc_nombre,1,30),
         	@w_12h           = cc_12h,
         	@w_disponible    = cc_disponible,
         	@w_promedio1     = cc_promedio1,
         	@w_prom_disp     = cc_prom_disponible,
                @w_categoria     = cc_categoria,
                @w_tipo_ente     = cc_tipocta,
                @w_rol_ente      = cc_rol_ente,
                @w_tipo_def      = cc_tipo_def,
                @w_prod_banc     = cc_prod_banc,
                @w_producto      = cc_producto,
                @w_tipo          = cc_tipo,
                @w_codigo        = cc_default,
                @w_personaliza   = cc_personalizada,
		@w_debmes	 = cc_debitos_mes,
		@w_debhoy	 = cc_debitos_hoy,
                @o_cliente       = cc_cliente,   -- EMO ICC 14-dic-1999
                @w_cta_bco_int   = cc_cta_banco,
		@w_oficial	= cc_oficial, --ARV DIC/26/00
		@o_clase_clte	= cc_clase_clte,
                @o_prod_banc    = cc_prod_banc
     from  cob_cuentas..cc_ctacte
    where  cc_ctacte = @i_cta_int
      and  cc_estado != 'G'		/* Cuenta de Gerencia */


   /* Encuentra alicuota del promedio */
   select  @w_alicuota      = fp_alicuota
     from  cob_cuentas..cc_fecha_promedio
    where  fp_tipo_promedio = @w_tipo_prom
      and  fp_fecha_inicio  = convert(smalldatetime,@i_fecha)
   if @@rowcount = 0
   begin
        exec cobis..sp_cerror1
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201060,
            @i_pit          = @i_pit
        return 201060
   end


   if @i_factor = 1
   begin

       if @i_titulo = 'N' 
       begin 
           if  @i_rechazo = 'N'
           begin 
              if exists ( select 1 from cob_remesas..re_cheque_rec
                         where cr_cta_depositada = @i_cta_int
                           and cr_fecha_ing      = @i_fecha
                           and cr_banco_p        = @i_bco
                           and cr_num_cheque     = @i_nchq
                           and cr_cta_girada     = @i_ctachq)
              begin
                  exec cobis..sp_cerror1
                       @t_debug     = @t_debug,
                       @t_file      = @t_file,
                       @t_from      = @w_sp_name,
                       @i_num       = 201238,
                       @i_pit       = @i_pit
                  return 201238
             end
          end 
      end
      else
      begin
          if exists ( select 1 from cob_remesas..re_cheque_rec
                         where cr_cta_depositada = @i_cta_int
                           and cr_fecha_ing      = @i_fecha
                           and cr_banco_p        = @i_bco
                           and cr_num_titulo     = @i_num_titulo
                           and cr_cta_girada     = @i_ctachq)
           begin
                  exec cobis..sp_cerror1
                       @t_debug     = @t_debug,
                       @t_file      = @t_file,
                       @t_from      = @w_sp_name,
                       @i_num       = 201238,
                       @i_pit       = @i_pit
                  return 201238
           end
      end 
  end


   /* Validar Fondos */

/* Determina si se cobra o no el ICC  EMO Dic. 22-1999  */
select @w_reg_icc = en_retencion
  from cobis..cl_ente
 where en_ente = @o_cliente

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

   select @w_val_icc = round((@i_valch * @w_tasa_icc)/100,@w_numdeci)
end
else
   select @w_tasa_icc = 0, @w_val_icc  = 0

select @w_valor = @i_valch - @w_val_icc

select @w_bco = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CBCO'
   and pa_producto = 'CTE'

if @w_bco is null
  
select @w_bco = 12

if @i_factor = 1
   begin
	/* Debita del disponible tenga o no fondos suficientes */
    /* Modificar la anterior logica para que no exceda el disponible */
        if @w_valor > @w_12h
        begin
	       if @w_valor > @w_disponible
	       begin
               exec cobis..sp_cerror1
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 201115,
                  @i_pit          = @i_pit
                  return 201115
           end
           else
	         select @w_disponible = @w_disponible - @w_valor,
                      @o_flag = 1
        end
        else
            select @w_12h = @w_12h - @w_valor,
                   @o_flag = 2

        if @i_bco = @w_bco
          select @o_ind = 2,
                 @i_tipchq = 'T'
        else 
          select @o_ind = 3,
                 @i_tipchq = 'L'


        if @i_titulo = 'S'
             select @o_ind = 3

        if @o_flag = 1
           select @o_ind = 1


   end
else
   begin
        select @w_flag = round(tmora,0)
          from cc_notcredeb
         where ssn_branch = @w_ssn_corr
           and alterno    = 0
        if @@rowcount = 0
        begin
            exec cobis..sp_cerror1
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 208019,
                @i_pit          = @i_pit
            return 208019
        end

        if @w_flag = 1
           select @w_disponible = @w_disponible + @w_valor
        else
           select @w_12h = @w_12h + @w_valor
   end 

   /* Actualizacion de tabla de cuentas corrientes */
   select @w_alic = convert (money , round(((@i_valch-@w_val_icc) * @w_alicuota), @w_numdeci))  /*  alicuota */
   select @w_promedio1 = @w_promedio1 - @w_alic * @i_factor 
   if @w_flag = 1
      select @w_prom_disp = @w_prom_disp -  @w_alic * @i_factor

   select @w_debmes = @w_debmes + @w_valor * @i_factor,
	  @w_debhoy = @w_debhoy + @w_valor * @i_factor

   begin tran
   update cob_cuentas..cc_ctacte
      set cc_disponible    = @w_disponible, 
          cc_promedio1     = @w_promedio1,
          cc_prom_disponible = @w_prom_disp,
          cc_12h           = @w_12h,
          cc_fecha_ult_mov = @i_fecha,
          cc_contador_trx  = cc_contador_trx + @i_factor, 
          cc_debitos_mes   = @w_debmes,
	  cc_debitos_hoy   = @w_debhoy
   where cc_ctacte = @i_cta_int
   if @@rowcount != 1
   begin
      exec cobis..sp_cerror1
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 205001,
                @i_pit          = @i_pit
      return 205001
   end
   select @o_sldcont = @w_saldo_contable - (@i_valch-@w_val_icc) * @i_factor
   select @o_slddisp = @w_disponible
   select @o_val_deb = @i_valch - @w_val_icc



  if @i_factor = 1 and @i_rechazo = 'N'
  begin
      /* Insert en tabla re_cheque_rec */
      exec @w_return = cobis..sp_cseqnos
		@t_debug            = @t_debug,
		@t_file             = @t_file,
		@t_from             = @w_sp_name, 
                @i_tabla            = 're_cheque_rec',
		@o_siguiente        = @w_numreg out
      if @w_return != 0
         return @w_return

       
         if @i_titulo = 'S'          
            select @i_tipchq     = 'J',
                   @i_nchq       =  0


      /* Genera registro de cheque devuelto en tabla re_cheque_rec */
      insert into cob_remesas..re_cheque_rec
		(cr_cheque_rec, cr_fecha_ing, cr_status, cr_cta_depositada,
		 cr_valor, cr_banco_p, cr_oficina_p, cr_ciudad_p,
                 cr_cta_girada, cr_num_cheque, cr_oficina, cr_procedencia,
		 cr_producto, cr_moneda, cr_cau_devolucion, cr_tipo_cheque,
                 cr_estado, cr_num_titulo)
	values  (@w_numreg, @i_fecha, 'D', @i_cta_int, 
		 @i_valch, @i_bco, @i_ofi, @i_ciu,
                 @i_ctachq, @i_nchq, @s_ofi, 'V',
		 @i_producto, @i_mon, @i_cau, @i_tipchq,
                 'P', @i_num_titulo)

      if @@error != 0
      begin
         exec cobis..sp_cerror1
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 203000,
                @i_pit          = @i_pit
         return 203000
      end
    end
    else
    begin

        if @i_titulo = 'N' 
        begin 
           if  @i_rechazo = 'N' 
           begin 
                delete cob_remesas..re_cheque_rec
                 where cr_cta_depositada = @i_cta_int
                   and cr_fecha_ing      = @i_fecha
                   and cr_banco_p        = @i_bco
                   and cr_num_cheque     = @i_nchq
                   and cr_cta_girada     = @i_ctachq
 
               if @@error != 0 
               begin
                  exec cobis..sp_cerror1
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 201238,
                    @i_pit          = @i_pit
                 return 201238
              end
          end 
        end
        else
        begin
            delete cob_remesas..re_cheque_rec
            where cr_cta_depositada = @i_cta_int
         and cr_fecha_ing      = @i_fecha
              and cr_banco_p        = @i_bco
              and cr_num_titulo     = @i_num_titulo
              and cr_cta_girada     = @i_ctachq

           if @@error != 0 
           begin
               exec cobis..sp_cerror1
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 201238,
                @i_pit          = @i_pit
              return 201238
           end
        end 
    end

   select @w_comision = 0
   select @o_comision = @w_comision
commit tran 
/*RQU Personalizaci¢n Branch II  30-nov-1998*/
/*SP que devuelve datos para Branch II */
if @t_ejec = 'R' 
begin
   exec @w_return = cob_cuentas..sp_resultados_branch_cc
                        @i_cuenta       = @i_cta_int,
                        @i_fecha        = @s_date,
                        @i_ofi          = @s_ofi, 
			@i_tipo_cuenta  = 'O',
                        @i_pit          = @i_pit
   if @w_return != 0
       return @w_return
end

return 0
go
IF OBJECT_ID('dbo.sp_nd_chq_dev') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_nd_chq_dev >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_nd_chq_dev >>>'
go

go
use cob_cuentas
go
