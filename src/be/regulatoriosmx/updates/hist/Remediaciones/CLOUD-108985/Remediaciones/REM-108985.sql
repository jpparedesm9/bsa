--Remediacion caso 108985
--Cliente 54913

USE cobis
GO

update cobis..cl_ente
set en_nomlar = 'PAOLA ELISA RAMIREZ DE ARELLANO GUADARRAMA'
where en_ente = 54913

update cob_cartera..ca_operacion
set op_nombre = 'RAMIREZ DE ARELLANO GUADARRAMA PAOLA ELISA'
where op_operacion = 127350


go
