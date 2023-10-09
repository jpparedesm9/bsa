/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento #98704: Descarga de información de forma ofuscada
--Fecha                      : 06/08/2018
--Descripción del Problema   : No existen registros ni campos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Alexander Inca S.
/**********************************************************************************************************************/

-- Eliminacion de registro en cobis..ba_batch

if exists (select 1 from cobis..ba_batch where ba_nombre = 'GENERACION ARCHIVO DRP')

begin

delete from cobis..ba_batch
where ba_nombre = 'GENERACION ARCHIVO DRP'

end

-- Eliminacion de registro en cobis..ba_sarta

if exists (select 1 from cobis..ba_sarta where sa_sarta = 80)
begin

delete from cobis..ba_sarta
where sa_sarta=80

end

-- Eliminacion de registro en cobis..ba_sarta_batch

if not exists (select 1 from cobis..ba_sarta_batch where sb_sarta = 80)
begin

delete from cobis..ba_sarta_batch
where sb_sarta=80

end

-- Eliminacion de registro en cobis..ba_enlace
if not exists(select 1 from cobis..ba_enlace where en_sarta=80)
begin

delete from cobis..ba_enlace
where en_sarta=80

end

