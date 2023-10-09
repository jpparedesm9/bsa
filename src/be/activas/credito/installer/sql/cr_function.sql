USE cob_credito
GO

IF OBJECT_ID ('dbo.Codigo_Sib') IS NOT NULL
	DROP FUNCTION dbo.Codigo_Sib
GO

IF OBJECT_ID ('dbo.detalle_declar_jur') IS NOT NULL
	DROP FUNCTION dbo.detalle_declar_jur
GO

IF OBJECT_ID ('dbo.fn_concatena_desc') IS NOT NULL
	DROP FUNCTION dbo.fn_concatena_desc
GO

IF OBJECT_ID ('dbo.fn_diagramobjects') IS NOT NULL
	DROP FUNCTION dbo.fn_diagramobjects
GO

IF OBJECT_ID ('dbo.fn_retorno_suma') IS NOT NULL
	DROP FUNCTION dbo.fn_retorno_suma
GO

IF OBJECT_ID ('dbo.RetornoFecha') IS NOT NULL
	DROP FUNCTION dbo.RetornoFecha
GO

IF OBJECT_ID ('dbo.RetornoSumaTableB') IS NOT NULL
	DROP FUNCTION dbo.RetornoSumaTableB
GO

IF OBJECT_ID ('dbo.Suma_Provision') IS NOT NULL
	DROP FUNCTION dbo.Suma_Provision
GO

IF OBJECT_ID ('dbo.Suma_Recuperacion') IS NOT NULL
	DROP FUNCTION dbo.Suma_Recuperacion
GO

IF OBJECT_ID ('dbo.Tr_Incentivo') IS NOT NULL
	DROP FUNCTION dbo.Tr_Incentivo
GO

IF OBJECT_ID ('dbo.fn_CalculaDistancia') IS NOT NULL
	DROP FUNCTION dbo.fn_CalculaDistancia
GO

CREATE FUNCTION dbo.Codigo_Sib(@w_re_ciudad_inversion int) RETURNS varchar(max)
BEGIN
	DECLARE @ret varchar(max)

	select @ret = codigo_sib 
    from cr_corresp_sib --,cr_archivo_redescuento 
    where tabla = "T11" 
    and codigo = convert(varchar,@w_re_ciudad_inversion)

RETURN @ret
END

GO

create function detalle_declar_jur (@w_tramite int)
returns varchar(60)
as
begin
   declare 
      @w_detalle_dec_jur    varchar(60),
      @w_secuencial         int
      
   select @w_secuencial = 0
   
   while 1 = 1
   begin      
      select 
         @w_detalle_dec_jur = case 
                                 when @w_detalle_dec_jur is null then
                                    left(replace(
                                         replace(
                                         replace(
                                         replace(
                                         replace(dj_descripcion, char(10), ' '), 
                                                                 char(13), ' '),
                                                                 char(9),  ' '),
                                                                 'º',      ' '),
                                                                 ';',      ' '), 15)
                                 else
                                    @w_detalle_dec_jur + '-' + 
                                    left(replace(
                                         replace(
                                         replace(
                                         replace(
                                         replace(dj_descripcion, char(10), ' '), 
                                                                 char(13), ' '),
                                                                 char(9),  ' '),
                                                                 'º',      ' '),
                                                                 ';',      ' '), 15)
                              end,
         @w_secuencial      = dj_secuencial
      from cr_microempresa with (nolock), cr_dec_jurada with (nolock)
      where mi_tramite    = @w_tramite
      and   dj_codigo_mic = mi_secuencial
      and   dj_secuencial > @w_secuencial
      order by dj_secuencial desc
      
      if @@rowcount = 0
         break
   end
   
   return @w_detalle_dec_jur
end

GO

create function fn_concatena_desc (@w_codigos varchar(64), @w_catalogo varchar(30))
returns varchar(100)
as
begin
   declare 
   @w_descripcion     varchar(100),
   @w_codigo          varchar(10)
      
   while 1 = 1
   begin
      
      if isnull(rtrim(ltrim(@w_codigos)), '') = ''
         break

      if charindex(';', @w_codigos) > 0
      begin
         select @w_codigo  = substring(@w_codigos, 1, charindex(';', @w_codigos) - 1)
         select @w_codigos = substring(@w_codigos, charindex(';', @w_codigos) + 1, len(@w_codigos))
      end
      else
      begin
         select @w_codigo  = rtrim(ltrim(@w_codigos))
         select @w_codigos = ''
      end
         
      select @w_descripcion = case when @w_descripcion is null then B.valor else @w_descripcion + '-' + B.valor end
      from cobis..cl_tabla A, cobis..cl_catalogo B
      where A.codigo = B.tabla
      and   A.tabla  = @w_catalogo
      and   B.codigo = @w_codigo

   end
   
   return @w_descripcion
end

GO

CREATE FUNCTION dbo.fn_diagramobjects() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO

CREATE FUNCTION dbo.fn_retorno_suma(@w_date datetime) RETURNS money
BEGIN

	DECLARE @ret money

	select @ret= do_saldo * cv_valor
	from cob_credito..cr_dato_operacion d, cob_conta..cb_vcotizacion,cob_cartera..ca_operacion
	where do_numero_operacion_banco = cob_cartera..ca_operacion.op_banco
	      and do_tipo_reg = 'D'
	      and do_codigo_producto = 7
	      and do_estado_contable in (1,2)
	      and cv_moneda = d.do_moneda
	      and cv_fecha = (select max(cv_fecha)
			      from cob_conta..cb_vcotizacion
			      where cv_moneda = d.do_moneda and cv_fecha <= @w_date)

	RETURN @ret

END

GO

CREATE FUNCTION dbo.RetornoFecha(@vlr_rt_tramite int,@vlr_w_etapa tinyint) RETURNS datetime
BEGIN
	DECLARE @ret datetime

	select @ret= min(rt_llegada) 
	from cob_credito..cr_ruta_tramite 
	where rt_tramite = @vlr_rt_tramite and rt_etapa = @vlr_w_etapa	

RETURN @ret
END

GO

create function dbo.RetornoSumaTableB() RETURNS int
BEGIN
	DECLARE @ret int

	SELECT @ret=sum(idB) from TableB

	RETURN @ret
END

GO

CREATE FUNCTION dbo.Suma_Provision() RETURNS money
BEGIN
	DECLARE @ret money

	select @ret= sum(provision) 
	from cr_prov_recu 
	
RETURN @ret
END

GO

CREATE FUNCTION dbo.Suma_Recuperacion() RETURNS money
BEGIN
	DECLARE @ret money
	select @ret= sum(recuperacion) 
	from cr_prov_recu 
	
RETURN @ret
END

GO

CREATE FUNCTION dbo.Tr_Incentivo() RETURNS varchar(max)
BEGIN
	DECLARE @ret varchar(max)

	select @ret= tr_incentivo 
	from cr_tramite,cr_archivo_redescuento 
	where  tr_tramite = re_tramite

RETURN @ret
END

GO

CREATE FUNCTION fn_CalculaDistancia(
@latitud1 float,
@longitud1 float,
@latitud2 float,
@longitud2 float
)
RETURNS float
AS
BEGIN
  --Unidad Metrica: K=kilometros  M=metros 
  DECLARE @distancia float
  
  --Radio de la tierra según WGS84
  DECLARE @radius float
  SET @radius = 6378.137 
  DECLARE @deg2radMultiplier float 
  SET @deg2radMultiplier = PI() / 180
  
  SET @latitud1 = @latitud1 * @deg2radMultiplier
  SET @longitud1 = @longitud1 * @deg2radMultiplier
  SET @latitud2 = @latitud2 * @deg2radMultiplier
  SET @longitud2 = @longitud2 * @deg2radMultiplier
    
  DECLARE @dlongitud float
  SET @dlongitud = @longitud2 - @longitud1
    
  SET @distancia = ACOS(SIN(@latitud1) * SIN(@latitud2) + COS(@latitud1) *
                         COS(@latitud2) * COS(@dlongitud)) * @radius
  
  -- Retorna distancia en Metros o Kilómetros  
  RETURN @distancia
END
GO

