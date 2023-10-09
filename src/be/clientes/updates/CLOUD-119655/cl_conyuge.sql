use cobis 
go

if object_id('cl_conyuge') is not null 
begin
	drop table cobis..cl_conyuge
end
else
	begin
		create table cobis..cl_conyuge
		(
			co_secuencia int,
			co_ente int,
			co_nombre descripcion null,
			co_snombre varchar(50) null,
			co_p_apellido descripcion null,
			co_s_apellido descripcion null,
			co_telefono varchar(10) null,
			co_fecha_nacimiento datetime null,
			co_fecha_crea datetime null
		)
	end

CREATE INDEX IDX_CONYUGE_SECUENCIAL ON cobis..cl_conyuge(co_secuencia);
CREATE INDEX IDX_CONYUGE_ENTE ON cobis..cl_conyuge(co_ente);

--secuencia cl_conyuge
DELETE FROM cobis..cl_seqnos WHERE tabla ='cl_conyuge' AND bdatos = 'cobis';
INSERT INTO cobis..cl_seqnos (bdatos,tabla,siguiente,pkey) VALUES ('cobis','cl_conyuge',1,'co_secuencia');

go
