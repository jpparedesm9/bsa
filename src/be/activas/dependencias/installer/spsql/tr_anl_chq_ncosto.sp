use cob_cuentas
go

SET ANSI_NULLS OFF
go
IF OBJECT_ID('dbo.sp_tr_anl_chq_ncosto') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_tr_anl_chq_ncosto
END
go
create proc sp_tr_anl_chq_ncosto (
	@s_ssn		      int,
    @s_ssn_branch     int = 0,
	@s_srv		      varchar(30),
	@s_lsrv		      varchar(30),
	@s_user		      varchar(30),
	@s_sesn		      int,
	@s_term		      varchar(10),
	@s_date		      datetime,
	@s_ofi		      smallint,  /* Localidad origen transaccion */
	@s_rol		      smallint = 1,
	@s_org_err	      char(1)  = null,	/* Origen de error: [A], [S] */
	@s_error	      int      = null,
	@s_sev		      tinyint  = null,
	@s_msg		      varchar(240)  = null,
	@s_org		      char(1),
	@t_debug	      char(1) = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(32) = null,
	@t_rty		      char(1) = 'N',
      @t_ejec		char(1) = null,
	@t_trn		      smallint,
	@i_cta		      varchar(24),
	@i_mon		      tinyint,
	@i_desde	      int,
	@i_hasta	      int,
	@i_clase	      char(1),
	@i_causa	      char(1),
	@i_valor	      money = null,
	@i_aut		      varchar(64),
        @i_alt		      int = 0, /*CHM 08-mar-2000*/
        @i_pit                char(1) = 'N',
        @i_tipo               char(3) = "SBA", 
	@o_ssn_host 	int = null out
)
as
declare	@w_return	      int,
	@w_sp_name	      varchar(30),
	@w_rpc		      varchar(64),
	@w_filial	      tinyint,
	@w_oficina	      smallint,
	@w_producto	      tinyint,
	@w_srv_rem	      varchar(64),
	@w_srv_local	      varchar(64),
	@w_tipo		      char(1),
	@w_oficial	      smallint -- ARV DIC/27/00
	
/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_tr_anl_chq_ncosto'

-- ini ARV DIC/27/00
select @w_oficial=cc_oficial
from cob_cuentas..cc_ctacte
where cc_cta_banco=@i_cta
-- fin ARV DIC/27/00

/*  Modo de debug  */

/* Chequeo de errores generados remotamente */
if @s_org_err is not null     /* Error del Sistema */
begin
        exec cobis..sp_cerror1
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = @s_error,
               @i_sev          = @s_sev,
               @i_msg          = @s_msg,
               @i_pit          = @i_pit
        return @s_error
end

/*  Captura de parametros de la oficina  */
exec @w_return = cobis..sp_parametros 
			@t_debug	= @t_debug,
			@t_file	        = @t_file,
			@t_from	        = @w_sp_name,
			@s_lsrv		= @s_lsrv,
                        @i_nom_producto = 'CUENTA CORRIENTE',
			@o_oficina 	= @w_oficina out,
			@o_producto 	= @w_producto out
			
if @w_return != 0
	return @w_return

/*  Determinacion de condicion de local o remoto  */
exec @w_return = cob_cuentas..sp_cta_origen 
			@t_debug	= @t_debug,
			@t_file	        = @t_file,
			@t_from	        = @w_sp_name,
			@i_cta		= @i_cta,
			@i_producto	= @w_producto,
		 	@i_mon	        = @i_mon, 
			@i_oficina	= @w_oficina,
                        @i_pit          = @i_pit,
 		 	@o_tipo		= @w_tipo out, 
			@o_srv_local	= @w_srv_local out,
			@o_srv_rem	= @w_srv_rem out
if @w_return != 0
    return @w_return


select   @w_srv_local = @s_lsrv

select @w_rpc = 'sp_anl_chq_ncosto_cc'
if @w_tipo = 'L'
	select @w_rpc = 'cob_cuentas..' + @w_rpc
else
	select @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.'
			+ 'cob_cuentas.' + @w_rpc

begin tran
	exec @w_return = @w_rpc
		@s_ssn		 = @s_ssn,
		@s_date		 = @s_date,
		@s_sesn		 = @s_sesn,
		@s_org		 = @s_org,
		@s_srv		 = @s_srv,
		@s_lsrv		 = @s_lsrv,
		@s_user 	 = @s_user,
		@s_term 	 = @s_term,
		@s_ofi		 = @s_ofi,
		@s_rol		 = @s_rol,
		@s_org_err	 = @s_org_err,
		@s_error	 = @s_error,
		@s_sev		 = @s_sev,
		@s_msg		 = @s_msg,
		@t_debug	 = @t_debug,
		@t_file 	 = @t_file,
		@t_from 	 = @t_from,
		@t_rty		 = @t_rty,
		@t_trn		 = @t_trn,
		@i_cta		 = @i_cta,
		@i_mon		 = @i_mon,
		@i_desde	 = @i_desde,
		@i_hasta	 = @i_hasta,
		@i_clase	 = @i_clase,
		@i_causa	 = @i_causa,
		@i_valor	 = @i_valor,
		@i_aut		 = @i_aut,
	        @i_alt		 = @i_alt, /*CHM 08-mar-2000*/
                @i_pit           = @i_pit,
                @i_tipo          = @i_tipo, 
               @o_oficina       = @w_oficina out

if @w_return <> 0
begin
	rollback tran
	return @w_return
end

if @w_tipo = 'R'
begin
    /* Grabar transaccion de servicio local */
       if @t_trn = 2507
       begin
	  /* Creacion de transaccion de servicio */
	  insert into cob_cuentas..cc_tsnopago
		      (secuencial, tipo_transaccion, tsfecha,
		       usuario, terminal, oficina, reentry, origen,
		       cta_banco, cheque_desde, cheque_hasta, estado_actual,
		       estado_anterior, fecha_reg, causa_np, clase_np, moneda,
                       oficina_cta,ssn_branch, oficial)  --ARV
	       values (@s_ssn, @t_trn, @s_date,
		       @s_user, @s_term, @s_ofi, @t_rty, @s_org,
		       @i_cta, @i_desde, @i_hasta, 'A',
		       'N', @s_date, @i_causa, @i_clase, @i_mon,
                       @w_oficina,@s_ssn_branch, @w_oficial)
	  if @@error != 0
	  begin
	     /* Error en creacion de transaccion de servicio */
	     exec cobis..sp_cerror1
		  @t_debug	 = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 203005,
                  @i_pit         = @i_pit
	     return 203005
	  end
       end
       else
	  if @t_trn = 29
	  begin
	      /* Creacion de transaccion de servicio */
	      insert into cob_cuentas..cc_tsnopago
		      (secuencial, tipo_transaccion, tsfecha,
		       usuario, terminal, oficina, reentry, origen,
		       cta_banco, cheque_desde, cheque_hasta, estado_actual,
		       estado_anterior, fecha_reg, causa_np, clase_np, moneda,
                       oficina_cta,ssn_branch, oficial)
	       values (@s_ssn, @t_trn, @s_date,
		       @s_user, @s_term, @s_ofi, @t_rty, @s_org,
		       @i_cta, @i_desde, @i_hasta, 'N',
		       'A', @s_date, @i_causa, @i_clase, @i_mon,
                       @w_oficina,@s_ssn_branch, @w_oficial)
	      if @@error != 0
	      begin
		 /* Error en creacion de transaccion de servicio */
		 exec cobis..sp_cerror1
		      @t_debug	 = @t_debug,
		      @t_file	 = @t_file,
		      @t_from	 = @w_sp_name,
		      @i_num	 = 203005,
                      @i_pit     = @i_pit
		 return 203005
	      end
	  end
end
commit tran
select @o_ssn_host = @s_ssn
go
SET ANSI_NULLS OFF
go
