/*************************************************/
---No Historia: H83194
---Título de la Historia: MIGRACION DE RELACIONES ENTRE CLIENTES
---Fecha: 22/Sept/2016
--Descripción del la Historia:  Migracion de Clientes del Banco a la BD COBIS
--Descripción de la Solución: Se eliminan los anteriores Registro, 
--                            ya que se cambio el numero de la sarta
--Autor: Walther Toledo
/*************************************************/

USE cobis
go
        
--Sarta
DELETE FROM ba_sarta where sa_sarta = 4000
go
--Batch
DELETE FROM ba_batch WHERE ba_batch IN (5002,5003,5004,5005,5006,5007,5008,5009,5010,5011)
go
--ba_sarta_batch
go
DELETE ba_sarta_batch WHERE sb_sarta = 4000
go
--ba_enlace
DELETE FROM ba_enlace WHERE en_sarta = 4000
go
--ba_parametro
DELETE FROM ba_parametro WHERE pa_batch IN (5002,5003,5004,5005,5006,5007,5008,5009,5010,5011)

go


