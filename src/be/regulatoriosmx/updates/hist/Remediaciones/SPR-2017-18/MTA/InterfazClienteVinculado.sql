/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S131855
--Fecha                      : 12/09/2017
--Descripción del Problema   : Agregar nuevo registro al catalogo
--Descripción de la Solución : Agregar nuevo registro al catalogo
--Autor                      : Maria Jose Taco
--Instalador                 : 
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_insnv.sql
/**********************************************************************************************************************/
USE cobis
GO

declare @w_catalogo varchar(30)

select @w_catalogo = codigo FROM cobis..cl_tabla WHERE tabla ='cl_relacion_banco'

IF NOT exists (SELECT 1 FROM cobis..cl_catalogo WHERE tabla = 5182 AND codigo = '013')
begin
	INSERT INTO cobis..cl_catalogo VALUES(@w_catalogo, '013', 'FUNCIONARIO DEL BANCO', 'V', NULL, NULL, NULL )
end

go

