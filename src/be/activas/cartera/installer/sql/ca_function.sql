USE cob_cartera
GO

IF OBJECT_ID ('dbo.cadena_zeros') IS NOT NULL
	DROP FUNCTION dbo.cadena_zeros
GO

IF OBJECT_ID ('dbo.SumaNivel') IS NOT NULL
	DROP FUNCTION dbo.SumaNivel
GO

if object_id (N'LlenarD', N'FN') is not null
    drop function LlenarD;  
go

if object_id (N'LlenarI', N'FN') is not null
    drop function LlenarI;  
go

if object_id (N'HashChar', N'FN') is not null
    drop function HashChar;  
go

if object_id (N'CalcularDigitoVerificadorOpenPay', N'FN') is not null
    drop function CalcularDigitoVerificadorOpenPay;  
go

if object_id (N'ConvertFechaString', N'FN') is not null
    drop function ConvertFechaString;  
go

if object_id (N'ConvertMontoString', N'FN') is not null
    drop function ConvertMontoString;  
go

if object_id ('dbo.fn_formatea_texto') is not null
    drop function fn_formatea_texto;  
go

CREATE FUNCTION dbo.cadena_zeros ( @cadena varchar(1024), @long int)
RETURNS varchar(1024)
WITH EXECUTE AS CALLER
AS
BEGIN
   declare @cadena_zeros varchar(1024)
   set @cadena_zeros= rtrim(ltrim(@cadena))
   set @cadena_zeros = replicate('0', @long)+ @cadena_zeros
   set @cadena_zeros = right(@cadena_zeros, @long)
   return (@cadena_zeros) 
end
GO

CREATE FUNCTION dbo.SumaNivel() RETURNS int
AS 
BEGIN
	DECLARE @ret int
	
	SELECT @ret = isnull(sum(amt_cuota+amt_gracia),0)
	FROM ca_amortizacion_tmp 
      
	
	RETURN @ret
END
GO


--FUNCION STRING QUE LLENA UNA CADENA CON ESPACIOS A LA DERECHA
create function LlenarD
(@i_string  varchar(500),
 @i_relleno char(1),
 @i_largo   int)  
 
returns varchar(500)
as
begin
    declare @w_llenarD varchar(500);  
	
	select @w_llenarD = stuff (replicate(@i_relleno, @i_largo), 1, len(@i_string), @i_string);

	return @w_llenarD;
end;  

go


--FUNCION STRING QUE LLENA UNA CADENA CON ESPACIOS A LA IZQUIERDA  
create function LlenarI
(@i_string  varchar(500),
 @i_relleno char(1),
 @i_largo   int)  
 
returns varchar(500)
as
begin
    declare @w_llenarI varchar(500);  
	
	select @w_llenarI = stuff (replicate(@i_relleno, @i_largo), @i_largo-len(@i_string)+1, len(@i_string), @i_string);

	return @w_llenarI;
end;  

go


--FUNCION STRING QUE DEVUELVE UN HASHING EN BASE A UNA CADENA DE CARACTERES  
create function HashChar
(@i_string  varchar(500))  
 
returns varchar(500)
as
begin
    declare @w_hashChar   varchar(500),
            @w_posicion   smallint,
			@w_caracter   char(1),
			@w_val_ascii  smallint,
			@w_suma_ascii int;
			
	select @w_posicion = 1, @w_suma_ascii = 0;
	
	while @w_posicion <= datalength(@i_string)
	begin;
	    select @w_caracter = substring(@i_string, @w_posicion, 1)
		select @w_val_ascii = ascii(@w_caracter)
		select @w_suma_ascii = @w_suma_ascii + @w_val_ascii
	    select @w_posicion = @w_posicion + 1	
	end;
	
	select @w_hashChar = convert(varchar, @w_suma_ascii);
	
	return @w_hashChar;
end;  

go

create function CalcularDigitoVerificadorOpenPay
(
	@i_referencia  varchar(40)
) 
returns varchar(40)
as
begin
	declare @w_num_generado	varchar(40),
			@w_caracter		char(1),
			@w_num_caracter int,
			@w_posicion		int,
			@w_contador		int,
			@w_acumulador	int,
			@w_valor		int,
			@w_valor_temp	int,
			@w_factor		int,
			@w_verificador	int 

	select @w_num_generado = @i_referencia
	
	select @w_num_caracter = len(@w_num_generado)
	select @w_posicion = 1, @w_acumulador = 0

	declare @TablaRefCaracteres as table 
	(
		caracter	char(1) PRIMARY KEY CLUSTERED,
		valor		int 
	)
	
	insert into @TablaRefCaracteres (caracter, valor) values ('0', 0)
	insert into @TablaRefCaracteres (caracter, valor) values ('1', 1)
	insert into @TablaRefCaracteres (caracter, valor) values ('2', 2)
	insert into @TablaRefCaracteres (caracter, valor) values ('3', 3)
	insert into @TablaRefCaracteres (caracter, valor) values ('4', 4)
	insert into @TablaRefCaracteres (caracter, valor) values ('5', 5)
	insert into @TablaRefCaracteres (caracter, valor) values ('6', 6)
	insert into @TablaRefCaracteres (caracter, valor) values ('7', 7)
	insert into @TablaRefCaracteres (caracter, valor) values ('8', 8)
	insert into @TablaRefCaracteres (caracter, valor) values ('9', 9)

	insert into @TablaRefCaracteres (caracter, valor) values ('A', 1)
	insert into @TablaRefCaracteres (caracter, valor) values ('B', 2)
	insert into @TablaRefCaracteres (caracter, valor) values ('C', 3)
	insert into @TablaRefCaracteres (caracter, valor) values ('D', 4)
	insert into @TablaRefCaracteres (caracter, valor) values ('E', 5)
	insert into @TablaRefCaracteres (caracter, valor) values ('F', 6)
	insert into @TablaRefCaracteres (caracter, valor) values ('G', 7)
	insert into @TablaRefCaracteres (caracter, valor) values ('H', 8)
	insert into @TablaRefCaracteres (caracter, valor) values ('I', 9)
	insert into @TablaRefCaracteres (caracter, valor) values ('J', 1)
	insert into @TablaRefCaracteres (caracter, valor) values ('K', 2)
	insert into @TablaRefCaracteres (caracter, valor) values ('L', 3)
	insert into @TablaRefCaracteres (caracter, valor) values ('M', 4)
	insert into @TablaRefCaracteres (caracter, valor) values ('N', 5)
	insert into @TablaRefCaracteres (caracter, valor) values ('O', 6)
	insert into @TablaRefCaracteres (caracter, valor) values ('P', 7)
	insert into @TablaRefCaracteres (caracter, valor) values ('Q', 8)
	insert into @TablaRefCaracteres (caracter, valor) values ('R', 9)
	insert into @TablaRefCaracteres (caracter, valor) values ('S', 2)
	insert into @TablaRefCaracteres (caracter, valor) values ('T', 3)
	insert into @TablaRefCaracteres (caracter, valor) values ('U', 4)
	insert into @TablaRefCaracteres (caracter, valor) values ('V', 5)
	insert into @TablaRefCaracteres (caracter, valor) values ('W', 6)
	insert into @TablaRefCaracteres (caracter, valor) values ('X', 7)
	insert into @TablaRefCaracteres (caracter, valor) values ('Y', 8)
	insert into @TablaRefCaracteres (caracter, valor) values ('Z', 9)

	select @w_posicion = len(@w_num_generado), @w_contador = 1

	while @w_posicion >= 1
	begin
		select @w_caracter = substring(@w_num_generado, @w_posicion, 1)
		
		select @w_valor_temp = isnull(valor, 0) from @TablaRefCaracteres where upper(caracter) = upper(@w_caracter)
		
		if (@w_contador % 2) > 0
		begin
			--CARACTER IMPAR
			select @w_factor = 2
		end
		else
		begin
			--CARACTER PAR
			select @w_factor = 1
		end

		select @w_valor = convert(int, @w_valor_temp) * @w_factor
	
		if (@w_valor >= 10)
		begin
			select @w_valor = (@w_valor / 10) + (@w_valor - 10)
		end
	
		select @w_acumulador = @w_acumulador + @w_valor
		select @w_posicion = @w_posicion - 1, @w_contador = @w_contador + 1
	end
	
	select @w_acumulador = @w_acumulador - (10 * convert(int, (@w_acumulador / 10)))

	if (@w_acumulador < 10 and @w_acumulador > 0)
	begin
		select @w_verificador = 10 - substring(convert(varchar, @w_acumulador), len(@w_acumulador), 1)
	end
	else
	begin
		select @w_verificador = 0 --@w_acumulador
	end
	
	return @w_num_generado + convert(varchar, @w_verificador)
end
go



create function ConvertFechaString
(
	@i_fecha	datetime,
	@i_formato  varchar(10)
) 
returns varchar(10)
as
begin
	return format(@i_fecha, @i_formato)
end
go

create function ConvertMontoString
(
	@i_monto	money
) 
returns varchar(10)
as
begin
	declare @w_lon_monto	tinyint
		
	select @w_lon_monto = pa_tinyint
		from cobis..cl_parametro 
		where pa_nemonico = 'LMOPA' 
		and pa_producto = 'CCA'

	return cob_cartera.dbo.LlenarI(replace(replace(convert(varchar, @i_monto),'.',''), ',',''), '0', @w_lon_monto)
end
go

