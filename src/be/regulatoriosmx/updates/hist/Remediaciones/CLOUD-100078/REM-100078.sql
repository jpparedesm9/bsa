--ucvelasco--URIEL CALIXTO VELASCO RUIZ--2403-OFICINA NEZAHUALCOYOTL--122
--amgutierrez--ANYULI MICHELLE GUTIERREZ GOMEZ--2403-OFICINA NEZAHUALCOYOTL--130

USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=130,
c_funcionario='amgutierrez'
 WHERE en_ente 
 IN (7658 ,7643 ,7641 ,7630 ,7622 ,7620)

go