
--SCRIPT DATOS INICIALES POSTERIOR A LA INSTALACION DE ADMIN.ADMIN CEN 

use cobis
go 

declare @w_valor int ,
        @w_offclickonce varchar(30),
        @w_serv  varchar(20)  


select  @w_offclickonce = '192.168.64.58:81',
        @w_serv     = 'CLOUDSRVN2'




---Manejo de llaves

INSERT INTO ad_llave (ll_nombre, ll_tipo, ll_estado, ll_llave)
VALUES ('KPV', 'C', '1', 0x17553503F4328F6E17553503F4328F6E)


INSERT INTO ad_llave (ll_nombre, ll_tipo, ll_estado, ll_llave)
VALUES ('KPE', 'C', '1', 0x8FF9E6D9A51A26D9FE4CCC523E3F6FF2)


--ba_secuencial


exec @w_valor = ADMIN...rp_ssn
insert into cobis..ba_secuencial values (@w_valor)


--fecha Proceso

insert into cobis..ba_fecha_proceso  values (convert(varchar, getdate(),103))


--Oficinas Click Onces

INSERT INTO an_office_srv (os_office_id, os_srv_name)
VALUES (1, @w_offclickonce)


INSERT INTO an_office_srv (os_office_id, os_srv_name)
VALUES (7020, @w_offclickonce)



update cobis..cl_funcionario
  set fu_offset = 0xa187fa4b53fb9e54315b62925bcec4c7
  where fu_login = 'admuser' 



update cobis..ba_batch 
set ba_serv_destino = @w_serv

UPDATE cobis..cl_default
SET srv = @w_serv

GO 