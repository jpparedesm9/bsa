--INCORRECTO:
--46897  - MA GUADALUPE RODRIGUEZ GARCIA
--CORRECTO:
--46897 - MA. GUADALUPE RODRIGUEZ GARCIA

USE cobis 
go

update cobis..cl_ente set
en_nombre     = 'MA.',
en_nomlar     = 'MA. GUADALUPE RODRIGUEZ GARCIA'
where  en_ente in (46897)

