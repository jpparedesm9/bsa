/*************************************************/
---No Bug: AHO-B86140
---Título del bug: Migración de Ahorros
---Fecha: 11/Oct/2016
--Descripción del la Historia: Errores al migrar cuentas
--Descripción de la Solución: Se modifica el campo ah_ced_ruc de la tabla ah_cuenta
--Autor: Tania Baidal
/*************************************************/

--ah_table
use cob_ahorros
go


alter table ah_cuenta alter column ah_ced_ruc CHAR (30) NOT NULL

go

alter table ah_cuenta_tmp alter column ah_ced_ruc CHAR (30) NOT NULL

go
