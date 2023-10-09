/*************************************************/
-- No Bug: Historia AHO-H81677
-- Título de la Historia: ELIMINAR CONTROLES Y FUNCIONALIDADES APLICADOS A COLOMBIA
-- Fecha: 17/08/2016
-- Descripción del la Historia:  Como usuario del modulo de Ahorros, no de tener funcionalidades de Remesas, 
--                              Impuesto GMF, consignacion por oficina.
-- Descripción de la Solución: Se inserta el parametro de la moneda
-- Autor: Walther Toledo
/*************************************************/

USE cob_cuentas
go
---> ah_datosini.sql
DELETE FROM cob_cuentas..cc_ofi_centro WHERE oc_oficina=1 AND oc_centro=4 AND oc_ciudad=5154 AND oc_ruta=157
INSERT INTO cc_ofi_centro (oc_oficina, oc_centro, oc_ciudad, oc_ruta)
VALUES (1, 4, 5154, 157)
