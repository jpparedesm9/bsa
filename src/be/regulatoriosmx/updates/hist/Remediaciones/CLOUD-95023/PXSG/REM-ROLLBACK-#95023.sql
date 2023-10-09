
USE cobis 
GO

UPDATE cobis..cl_ente SET en_oficial=66,
c_funcionario='jjmondragon' WHERE en_ente IN(1228,1233,1232,1236,1230,1226)

SELECT * FROM cobis..cl_ente WHERE en_ente IN(1228,1233,1232,1236,1230,1226)

go