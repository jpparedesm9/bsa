
--Se solicita el cambio asesor a los intehgrantes en mencion, 
--actualmente se encuentran con Humberto Vale Ceron (Usuario: hvalle) 
--el cambio es al Asesor Juan José Mondragón Martínez(Usuario: jjmondragon).

--Los clientes son:
--Ana María Bernal Mejía; Id 4560880 -- 45160880(este es el numero correcto para ese cliente)
--Lizeth Rivera Huerta; Id 45160771

USE cobis 
go

--actualizacion en la cl_ente de hvalle a jjmondragon 
UPDATE cobis..cl_ente 
SET en_oficial    = 66,
    c_funcionario = 'jjmondragon',
    en_oficina    = 3354
WHERE en_ente in (12791,12958)
go