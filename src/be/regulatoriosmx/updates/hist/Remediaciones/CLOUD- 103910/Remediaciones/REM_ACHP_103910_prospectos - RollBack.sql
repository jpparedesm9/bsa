--Buen dia , se solicita la reasignacion el siguiente prospecto:
--
--Cliente: #13055 Maria Soledad Villalobos
--
--Asesor actual: Edgar Sanchez Rivera ESANCHEZRI
--Asesor para reasignacion: Iris Rubi Ortega Ayala IRORTEGA.
--
--Gracias.

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'esanchezri'
select @w_oficial_cod = 148
select @w_oficina = 1481

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (13055)
go
