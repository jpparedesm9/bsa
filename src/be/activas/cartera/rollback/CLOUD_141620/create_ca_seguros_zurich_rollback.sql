/*
*   Archivo para creat tabla de trabajo requerimiento 141620
*   Johan castro
*   04/09/2020
*/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'ca_seguros_zurich') 
begin
   drop table ca_seguros_zurich
end
