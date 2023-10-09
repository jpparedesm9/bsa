-----------------------------------------------------------------------------------
-- ELIMINACION DE PARAMETRO PARA EL TIEMPO ANTES DE ELIMINAR LA DATA DE SINCRONIZACION
-----------------------------------------------------------------------------------
USE cobis 
GO

IF EXISTS(SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico='TPERDS')
BEGIN
   DELETE FROM cobis..cl_parametro WHERE pa_nemonico='TPERDS'
END
GO

-----------------------------------------------------------------------------------
-- ELIMINACION DEL BATCH - 21991
-----------------------------------------------------------------------------------

--BATCH 
if exists (select 1 from ba_batch where ba_batch =  21991 and ba_nombre = 'LIMPIEZA DE LAS TABLAS DE SINCRONIZACION' )
begin
   delete ba_batch where ba_batch =  21991 and ba_nombre = 'LIMPIEZA DE LAS TABLAS DE SINCRONIZACION'
end
