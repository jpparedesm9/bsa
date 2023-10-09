
  --Se solicita la reasignación de clientes que tiene el asesor mmlanda MONICA MONSERRAT LANDA ALARCON a la asesora yicedillo YAMIDT ITZEL CEDILLO SANCHEZ.
  --
  --No. Cobis Asesor Apellido_P Apellido_M Nombres 
  --13168 MONTOYA MARTINEZ JUANA
  --13146 GUZMAN MONTOYA MARIA DE JESUS 
  --14784 APONTE ALARCON MARIA ANTONIETA 
  --14777 ISLAS HERNANDEZ THANIA EVELIN

USE cobis 
go
-- 1.-
-- actualización en la cl_ente de mmlanda a yicedillo 
-- *8
UPDATE cobis..cl_ente 
SET en_oficial    = 189,
    c_funcionario = 'yicedillo',
    en_oficina    = 2403
WHERE en_ente in (13146,13168,14777,14784)
go