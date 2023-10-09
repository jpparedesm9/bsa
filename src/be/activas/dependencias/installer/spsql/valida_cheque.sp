use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_valida_cheque') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_valida_cheque
    IF OBJECT_ID('dbo.sp_valida_cheque') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_valida_cheque >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_valida_cheque >>>'
END
go
create proc sp_valida_cheque (
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_cuenta		int = null,
	@i_moneda		tinyint = null,
	@i_cheque		int,
	@i_val_cta		char(1) = 'S',
	@i_cta_banco		varchar(24)  = null,
	@i_chequeras		smallint = null,
	@i_cheque_ini		int = null,
        @i_cau                  varchar(10) = null,    /*lor12dic95*/
        @i_valchq               char(1) = 'S',  --ERP 03/02/2002
        @i_pit                  char(1) = 'N',  --Parametro usado por la interface PIT
	@o_estado_actual	char(1) 		out,
	@o_estado_anterior	char(1) 		out,
	@o_clase_np		char(1)			out,
	@o_clase_desc		varchar(64) = null	out,
	@o_causa_np		char(1)			out,
	@o_causa_desc		varchar(64) = null	out,
        @o_valor                money       = null      out,
        @o_fecha_reg            datetime    = null      out,
        @o_acreditado           char(1)     = null      out
)
as
declare	@w_return		int,
	@w_sp_name		varchar(30),
	@w_cuenta		int,
	@w_filial		tinyint,
	@w_oficina		tinyint,
	@w_tpromedio		char(1),
        @w_ch_estado            char(1),
        @w_val_cheq             char(1),
        @w_ch_inicial           int,
        @w_ch_numero            int, /*smallint*/
	@w_oficial		smallint,
	@w_mensaje              varchar(240)

/*  Captura nombre de Stored Procedure  */
select	@w_sp_name = 'sp_valida_cheque',
        @w_val_cheq = 'S'
	
/*  Modo de debug  */

/*  Unificacion de variables  */
select	@w_cuenta = @i_cuenta

/*  Validacion de la cuenta corriente  */
if @i_val_cta = 'S' 
begin
	exec @w_return = cob_cuentas..sp_cta_vigente 
	 	@t_debug	= @t_debug,
		@t_file		= @t_file,
		@s_ofi		= @w_oficina,
		@s_srv		= 'IRIS',
		@i_ver_nodo	= 'N',
		@t_from		= @w_sp_name,
		@i_cta_banco	= @i_cta_banco,
		@i_moneda	= @i_moneda,
                @i_cau          = @i_cau,          /*lor12dic95*/
                @i_pit          = @i_pit,  -- GEB Interface PIT
		@o_cuenta	= @w_cuenta,
		@o_filial	= @w_filial,
		@o_oficina	= @w_oficina,
		@o_tpromedio 	= @w_tpromedio,
		@o_oficial	= @w_oficial
	if @w_return != 0
		return @w_return
end

if @i_valchq = 'S' and @i_pit = 'N' --II ERP 03/04/2002 EAA/06/04  pit no valida chequera
begin
   /*  Comprobacion de existencia del cheque  */
   select @w_ch_estado  = ch_estado,
          @w_ch_inicial = ch_inicial,
          @w_ch_numero  = ch_numero
     from cob_cuentas..cc_chequera
    where ch_cuenta = @i_cuenta
      and ch_inicial <= @i_cheque
      and (ch_inicial + ch_numero) > @i_cheque

   if @@rowcount = 0 
   begin

     select @w_val_cheq = 'N'
     print "No Existe chequera para la Cuenta"
     /*  No Existe chequera para la Cuenta */
    
         select @w_mensaje = 'CHEQUE NO CORRESPONDE A CUENTA CORRIENTE'
         exec cobis..sp_cerror1 
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_msg    = @w_mensaje,
             @i_pit    = @i_pit, --Evita hacer Rollback
             @i_num    = 201006 
     
     return 201006 /* GEB: Interface PIT */

     /* CAMBIO TEMPORAL POR LA NO MIGRACION DE CHEQUERAS

     insert into cob_cuentas..cc_chequera_error
            (ce_cuenta, sc_cheque)
     values (@w_cuenta , @i_cheque)

     if @@error != 0
     begin
        exec cobis..sp_cerror1 
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 201006,
             @i_pit    = @i_pit
        return 201006 /* GEB: Interface PIT */
     end

     FIN DEL COMENTARIO DE MIGRACION DE CHEQUERAS */

   end

   if @w_ch_estado != 'E' and @w_ch_estado!='C' and @w_val_cheq = 'S'
   begin
     /* Chequera no Emitida */
     
         select @w_mensaje = 'CHEQUERA NO ENTREGADA A CLIENTE'
         exec cobis..sp_cerror1
	      @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_msg    = @w_mensaje,
              @i_pit    = @i_pit, --Evita hacer Rollback
              @i_num    = 201110
    
     return 201110
   end

   /*
   if (@i_cheque < @i_cheque_ini or @i_cheque >= @w_ch_inicial + @w_ch_numero)
       and (@w_val_cheq = 'S')
   begin
       print "Cheque no corresponde a cuenta corriente"
       --Cheque no corresponde a cuenta corriente
       exec cobis..sp_cerror1 
	    @t_debug= @t_debug,
	    @t_file	= @t_file,
	    @t_from	= @w_sp_name,
	    @i_num	= 201006,
            @i_pit      = @i_pit
       return 201006
   end
   */
end --FI ERP 03/04/2002

/*  Determinacion del estado del cheque  */
select	@o_estado_actual 	= cq_estado_actual,
	@o_estado_anterior	= cq_estado_anterior,
	@o_causa_np		= np_causa,
	@o_clase_np		= np_clase,
        @o_valor                = cq_valor,
        @o_fecha_reg            = cq_fecha_reg,
        @o_acreditado           = np_acreditado
  from	cob_cuentas..cc_cheque
 where  cq_cuenta = @w_cuenta
   and  cq_cheque = @i_cheque

if @@rowcount = 0
begin
	select	@o_estado_actual	= 'N',
		@o_estado_anterior	= null,
		@o_causa_np		= null,
		@o_clase_np		= null
end

if (@o_causa_np  is not null) and (@o_clase_np is not null)
begin
       	select @o_causa_desc = valor from cobis..cl_catalogo
       	where  cobis..cl_catalogo.tabla =
         	(select cobis..cl_tabla.codigo
          	 from cobis..cl_tabla
          	 where tabla = 'cc_causa_np'
          	 and cobis..cl_catalogo.codigo = @o_causa_np)

       	select @o_clase_desc = valor from cobis..cl_catalogo
       	where  cobis..cl_catalogo.tabla =
         	(select cobis..cl_tabla.codigo
          	 from cobis..cl_tabla
          	 where tabla = 'cc_clase_np'
          	 and cobis..cl_catalogo.codigo = @o_clase_np)
end

/*  Modo de debug, campos de output  */
go
IF OBJECT_ID('dbo.sp_valida_cheque') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_valida_cheque >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_valida_cheque >>>'
go

go
use cob_cuentas
go
