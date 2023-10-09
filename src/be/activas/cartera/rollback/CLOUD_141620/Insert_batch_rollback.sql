/*
*   Archivo para crear (insertar) batch de proceso requerimiento 141620
*   Johan castro
*   04/09/2020
*/

use cobis
go

if exists (select 1 from cobis..ba_batch where ba_batch = 7975) 
begin
   delete from cobis..ba_batch where ba_batch = 7975		
end
