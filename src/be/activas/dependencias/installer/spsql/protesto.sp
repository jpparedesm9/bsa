use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_protesto') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_protesto
    IF OBJECT_ID('dbo.sp_protesto') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_protesto >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_protesto >>>'
END
go
create proc sp_protesto (
	@i_cuenta	int,
	@i_nchq		int,
	@i_ori		char(1),
	@i_valch	money,
	@i_val		money,
	@i_cobrado	money,
	@i_fecha	datetime,
	@i_factor	smallint,
	@i_oficina	smallint,
	@i_usuario      login,
	@i_causa        varchar(3),
	@i_pit		char(1) = "N",
	@t_trn		int,
	@t_debug	char(1),
	@t_file		varchar(14),
	@t_from		varchar(30)
)
as
declare @w_sp_name	varchar(30),
        @w_estado_anterior  char(1)

/* Captura el nombre del stored procedure */
select  @w_sp_name = 'sp_protesto'

/*  Modo de debug  */

begin tran
select @w_estado_anterior = cq_estado_anterior
from cob_cuentas..cc_cheque
where cq_cuenta = @i_cuenta
and cq_cheque = @i_nchq
if @@rowcount = 0	
begin
     insert into cob_cuentas..cc_cheque
            (cq_cuenta, cq_cheque, cq_estado_actual, cq_estado_anterior,
	     cq_fecha_reg, cq_valor,cq_origen,cq_transferido, pt_valor_multa,
	     pt_valor_cobrado, pt_num_veces, pt_justificado, cq_hora,
             cq_usuario, np_oficina, np_causa)
     values (@i_cuenta, @i_nchq, 'T', 'N', @i_fecha, @i_valch,@i_ori,'N',
	     @i_val, @i_cobrado, 1, 'N', getdate(),
             @i_usuario, @i_oficina, @i_causa)
     if @@error != 0
     begin
          exec cobis..sp_cerror1
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 203002,
               @i_pit	       = @i_pit
               
          return 203002
     end
end
else
begin
      if @i_factor = 1
      begin
       	      update  cob_cuentas..cc_cheque
       	      set cq_estado_anterior = cq_estado_actual,
       		  cq_estado_actual   = 'T',
		  cq_fecha_reg = @i_fecha,
		  cq_origen = @i_ori,
	          cq_valor = @i_valch,
	          np_oficina = @i_oficina,
	          np_causa = @i_causa,
		  pt_valor_multa = @i_val,
		  pt_valor_cobrado = @i_cobrado,
		  pt_num_veces = pt_num_veces + 1,
		  pt_justificado = 'N'
       	      where cq_cuenta = @i_cuenta
       	      and cq_cheque = @i_nchq
              if @@rowcount != 1
              begin
               	      exec cobis..sp_cerror1
               	                @t_debug        = @t_debug,
               	                @t_file         = @t_file,
               	                @t_from         = @w_sp_name,
               	                @i_num          = 205003,
               	                @i_pit		= @i_pit
               	                
               	      return 205003
              end
      end
      else
      begin
       	      update  cob_cuentas..cc_cheque
       	      set cq_estado_actual = cq_estado_anterior,
       		  cq_estado_anterior   = cq_estado_actual,
		  cq_origen = @i_ori,
		  pt_valor_multa = null,
		  pt_valor_cobrado = null,
		  pt_num_veces = pt_num_veces - 1,
		  pt_justificado = null
       	     
where cq_cuenta = @i_cuenta
       	        and cq_cheque = @i_nchq
       	      if @@rowcount != 1
              begin
               	      exec cobis..sp_cerror1
               	                @t_debug        = @t_debug,
               	                @t_file         = @t_file,
               	                @t_from         = @w_sp_name,
               	                @i_num          = 205003,
               	                @i_pit		= @i_pit
               	                
               	      return 205003
              end
      end
end
commit tran
return 0
go
IF OBJECT_ID('dbo.sp_protesto') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_protesto >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_protesto >>>'
go

go
use cob_cuentas
go
