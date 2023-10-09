USE cobis
go


IF EXISTS (select * from cobis..cl_asoc_clte_serv  where  ac_cliente = 345785 AND ac_secuencial = 91) 
BEGIN
    
DELETE FROM cobis..cl_asoc_clte_serv  where  ac_cliente = 345785 AND ac_secuencial = 91
   
END
  

INSERT INTO cobis..cl_asoc_clte_serv (ac_secuencial, ac_servicio, ac_cliente, ac_codigo, ac_estado, ac_fecha_crea, ac_fecha_mod, ac_usuario, ac_tipo_cb)
VALUES (91, 'CNB', 345785, 8999, 'H', '2016-02-02 05:52:31', '2016-02-02 05:52:37', 'amorales', 'O')

go
