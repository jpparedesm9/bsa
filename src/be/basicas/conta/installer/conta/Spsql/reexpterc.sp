use cob_conta
go

DROP procedure spreprt
go

create procedure spreprt
(
   @i_moneda     tinyint  = NULL,
   @i_fecha        datetime = NULL,
   @i_ciudad       int      = NULL,
   @i_fecha1       datetime = NULL,
   @i_operacion    char(1),
   @o_promediomes  money    = NULL out,
   @o_encontro     char(1)  = NULL out,
   @o_numdias      int      = NULL out,
   @o_acumulado    money    = NULL out,
   @o_diahabil     char(10) = NULL out
)
as
if @i_operacion = 'B'
begin
    Select 
    @o_promediomes = avg(ct_valor)
    from cb_cotizacion
    where ct_moneda = convert(tinyint, @i_moneda)
    and ct_fecha not in (select df_fecha from cobis..cl_dias_feriados
	                     where df_ciudad = @i_ciudad)
    and datepart(mm,ct_fecha) = datepart(mm,@i_fecha)
    and datepart(yy,ct_fecha) = datepart(yy,@i_fecha)

    if @@rowcount > 0
       select @o_encontro = 'S'

end

if @i_operacion = 'D'
begin
    Select 
    @o_numdias = count(1)
    from cb_cotizacion
    where ct_moneda = convert(tinyint, @i_moneda)
    and ct_fecha not in (select df_fecha from cobis..cl_dias_feriados
	                     where df_ciudad = @i_ciudad)
    and datepart(mm,ct_fecha) = datepart(mm,@i_fecha)
    and datepart(yy,ct_fecha) = datepart(yy,@i_fecha)

    Select 
	@o_acumulado = ct_valor * ct_factor1 
    from cb_cotizacion
    where ct_moneda = convert(tinyint, @i_moneda)
    and ct_fecha not in (select df_fecha from cobis..cl_dias_feriados
	                     where df_ciudad = @i_ciudad)
    and datepart(mm,ct_fecha) = datepart(mm,@i_fecha)
    and datepart(yy,ct_fecha) = datepart(yy,@i_fecha)
    

    if @o_numdias > 0
       select @o_encontro = 'S'
end

if @i_operacion = 'F'
begin
   
    Select 
        @o_diahabil = convert(varchar(10),dateadd(dd,1,@i_fecha), 101)
    from cobis..cl_dias_feriados
    left outer join cob_conta..cb_cotizacion on
         ct_fecha = df_fecha
    where ct_moneda = convert(tinyint, @i_moneda)
    and ct_fecha = @i_fecha1
    and datepart(mm,ct_fecha) = datepart(mm,@i_fecha1)
    and df_ciudad = @i_ciudad
end

return 0
go