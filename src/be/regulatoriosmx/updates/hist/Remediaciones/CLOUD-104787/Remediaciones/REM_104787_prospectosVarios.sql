--ASESOR ACTUAL: Juan Carlos Lanche (usuario: Cobis jclanche)--jclanche
--ASESOR PARA REASIGNAR: Moisés Morales Noyola (usuario Cobis: mmoralesno)--mmoralesno
--
--• Elena Hilario Guadalupe, Cobis 32936 (se cambio por que tenia este codigo 32396)--- Prospecto
--• Florentina Saligan Chopin, Cobis: 32902--- Prospecto
--• Ma del Carmen Santiago Perales, Cobis: 32958--- Prospecto
--• Silvia Martínez Benítez, Cobis 32951--- Prospecto
--• Elvira Janet Martínez Flores, Cobis 33286--- Prospecto
--• Idalia Perales Velázquez, Cobis 33302--- Prospecto
--------------------------------------------• Elena Hilario Velázquez, Cobis 32396 (No existe, nota#6)
--• Yolanda Garcia Saligan, Cobis 32923--- Prospecto
--• Dulce María Mejía Luna, Cobis 33338--- Prospecto
--• Sandra García Carmona, Cobis 32498--- Prospecto
--• Virginia Aliz Zarate Bustos, Cobis 32537--- Prospecto
--• Karla Edith Lopez Zarate, Cobis 32545--- Prospecto
--• Cinthia Varela Román, Cobis 33011--- Prospecto
--• Zuleyma Varela Román, Cobis 33038--- Prospecto
--• Sonia Justina Bernardino Anica, Cobis 33041--- Prospecto
--• Mirza Saybeth Jiménez De Jesus, Cobis 33168--- Prospecto
--• Verónica Julieta Mejía Ruiz, Cobis 33183--- Prospecto
--• Marlene Ruiz Gomez, Cobis 33206--- Prospecto
--• Santa De Jesus Carpio, Cobis 33219--- Prospecto
--• Cindy Marlen Jiménez de Jesus, Cobis 33212--- Prospecto

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'mmoralesno' -- antes jclanche
select @w_oficial_cod =  259 -- antes 282

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (32936,32902,32958,32951,33286,33302,32923,33338,32498,32537,32545,33011,33038,33041,33168,33183,33206,33219,33212)
go
