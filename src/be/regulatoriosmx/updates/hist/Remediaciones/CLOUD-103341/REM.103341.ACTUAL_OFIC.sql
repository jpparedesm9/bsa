use cobis 
go 


--oficial origen  70	GUADALUPE CASTRO CEDILLO

--oficial destino 66	JUAN JOSE MONDRAGON MARTINEZ

select 'antes', * from cobis..cl_ente      where en_ente = 603


update cobis..cl_ente set  en_oficial = 66  where en_ente = 603



select 'despues', * from cobis..cl_ente     where en_ente = 603