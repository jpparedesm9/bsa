use cobis
go

if exists (select * from sysobjects where name = "sp_qr_rol_tr")
	drop proc sp_qr_rol_tr
go

create proc sp_qr_rol_tr (
        @i_modo             smallint,
        @i_rol              tinyint,
        @i_producto         tinyint,
        @i_tipo             char(1),
        @i_moneda           tinyint,
	@i_transaccion	    int = null
)
as
if @i_modo = 0
begin
        set rowcount 20
        select  
                'Cod. transaccion' = ta_transaccion,
                'Transaccion' = tn_descripcion
	 from	ad_tr_autorizada, cl_ttransaccion
	where	ta_transaccion = tn_trn_code
	  and	ta_producto = @i_producto
          and   ta_tipo = @i_tipo
          and   ta_moneda = @i_moneda
          and   ta_rol = @i_rol
          and   ta_estado = 'V'
	order	by ta_transaccion
end
else
if @i_modo = 1
begin
	set rowcount 20
	select
                'Cod. transaccion' = ta_transaccion,
                'Transaccion' = tn_descripcion
	 from	ad_tr_autorizada, cl_ttransaccion
	where	ta_transaccion = tn_trn_code
	  and	ta_producto = @i_producto
          and   ta_tipo = @i_tipo
          and   ta_moneda = @i_moneda
	  and	ta_rol = @i_rol
          and   ta_transaccion > @i_transaccion
          and   ta_estado = 'V'
	order	by ta_transaccion
end
return 0
go
