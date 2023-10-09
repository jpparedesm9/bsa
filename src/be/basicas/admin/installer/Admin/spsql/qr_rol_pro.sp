use cobis
go

if exists (select * from sysobjects where name = 'sp_qr_rol_pro')
	drop proc sp_qr_rol_pro
go

create proc sp_qr_rol_pro (
        @i_modo         smallint,
        @i_rol          tinyint,
	@i_producto	tinyint = null,
	@i_tipo 	char(1) = null,
	@i_moneda	tinyint = null
)
as
if @i_modo = 0
begin
        set rowcount 20
	select	'Cod. Producto' = pr_producto,
		'Tipo' = pr_tipo,
                'Cod. Moneda' = pr_moneda,
		'Descripcion' = substring(pm_descripcion,1,20)
	from	ad_pro_rol, cl_pro_moneda
	where	pr_producto = pm_producto
	  and	pr_moneda = pm_moneda
	  and	pr_tipo = pm_tipo
	  and	pr_rol = @i_rol
          and   pr_estado = 'V'
	order	by pr_producto, pr_tipo, pr_moneda
       if @@rowcount = 0
       begin
         exec sp_cerror
		@i_num = 151020
		/*'No existe Producto Rol' */
         set rowcount 0
         return 1
       end
       set rowcount 0
end
else
if @i_modo = 1
begin
        set rowcount 20
	select	'Cod. Producto' = pr_producto,
		'Tipo' = pr_tipo,
                'Cod. Moneda' = pr_moneda,
		'Descripcion' = substring(pm_descripcion,1,20)
	from	ad_pro_rol, cl_pro_moneda
	where	pr_producto = pm_producto
	  and	pr_moneda = pm_moneda
	  and	pr_tipo = pm_tipo
	  and	pr_rol = @i_rol
	  and	(
		(pr_producto > @i_producto)
          or    ((pr_producto = @i_producto) and (pr_tipo > @i_tipo))
          or    ((pr_producto = @i_producto) and (pr_tipo = @i_tipo)
                and (pr_moneda > @i_moneda))
		)
          and   pr_estado = 'V'
	order	by pr_producto, pr_tipo, pr_moneda
       if @@rowcount = 0
       begin
         exec sp_cerror
		@i_num = 151020
		/*'No existe Producto Rol' */
         set rowcount 0
         return 1
       end
       set rowcount 0
end
return 0
go
