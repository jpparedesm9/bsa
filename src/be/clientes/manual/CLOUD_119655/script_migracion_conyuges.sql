
use cobis
begin
--Migracion de los conyuges relacionados en la cl_ente a la cl_conyugue en estado activos
insert into cobis..cl_conyuge 
select  
inst.in_ente_i, 
ente.en_ente,
ente2.en_nombre,
ente2.p_s_nombre,
ente2.p_p_apellido,
ente2.p_s_apellido,
null as telefono,
ente2.p_fecha_nac,
getdate() as p_fecha_crea
 from cobis..cl_ente as ente
left join cobis..cl_instancia as inst on inst.in_ente_d = ente.en_ente
left join cobis..cl_ente as ente2 on inst.in_ente_i = ente2.en_ente
where inst.in_relacion = 209 and  ente.en_cliente='S';


--Borra la relacion entre conuyuges
delete from cobis..cl_instancia where in_relacion = 209 

end