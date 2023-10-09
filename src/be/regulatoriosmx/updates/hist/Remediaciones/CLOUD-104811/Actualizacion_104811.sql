
/*
ID 33458 Guadalupe Anahi Olivares Verdiguel
ID 33563 Brenda Viviana Aguilar Rivera
ID 33518 Adriana Pelenco Garcia
ID 33566 Elvira Horcasitas Tepenohaya
ID 33455 Rosalva Xochimanca Peña 
ID 33536 Matilde Torres Salazar
ID 33233 Alicia Martinez Mendoza
ID 33460 Maria Fernanda Pascual Miguel

ASESOR ACTUAL
KARLA LIZETH ESTRADA SOTELO USUARIO CLESTRADA -> 250

ASESOR PARA REASIGNAR
ANGELICA ARANDA VAZQUEZ USUARIO aarandava -> 266

*/

use cobis 
go

--1--
update cobis..cl_ente 
set   en_oficial    = 266,
      c_funcionario ='aarandava'	
where en_ente in (33458,33563, 33518, 33566,
                  33455,33536, 33233, 33460)
go       