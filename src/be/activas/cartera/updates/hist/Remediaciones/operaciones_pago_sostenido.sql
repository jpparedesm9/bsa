use cob_cartera
go

-------------------------------------------------------------------
update cob_cartera..ca_operacion
set op_estado = 2
WHERE op_estado = 9 -- las susppensas las vuelve canceladas
-------------------------------------------------------------------

set nocount on
declare @w_operacion_revisada integer
declare @w_salida varchar(5)
select @w_operacion_revisada = -1

while (1=1)
begin
	set rowcount 1
	select
	@w_operacion_revisada = op_operacion
	from ca_operacion, ca_estado
	where op_operacion > @w_operacion_revisada
	and op_estado = es_codigo
	and es_procesa = 'S' 
	order by op_operacion

	if @@rowcount =0
	Break
	set rowcount 0

	----------------------
	exec sp_verifica_pago_sostenido_op 
	@i_operacion = @w_operacion_revisada,
	@i_fecha_proceso = '2013/12/01',
	@o_psostenido = @w_salida out

	if (@w_salida = 'S')
	begin
		print 'Operación : ' + cast ( @w_operacion_revisada as varchar) + ' --> TIENE PAGO SOSTENIDO'
	end

	----------------------
end
set rowcount 0

-------------------------------------------------------------------
update cob_cartera..ca_operacion
set op_estado = 9
WHERE op_estado = 2 
and op_operacion not in (12,13)-- las susppensas las vuelve canceladas
-------------------------------------------------------------------

go
