Use cob_cartera
go

IF exists (select 1 from cob_cartera..sysobjects where name = 'ca_trn_oper')
begin
   --CREACION DE TABLAS TEMPORALES CODIGO VALOR
   declare @Tabla_RelPerfil_Operacion as table 
   (
      id_key		int	identity,
      perfil	   varchar(10),
      operacion   varchar(10)
   )

   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_EST', 'CAS')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_DES', 'DES')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_EST', 'EST')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_CAS', 'ETM')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_IOC', 'IOC')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_PAG', 'PAG')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_PRV', 'PRV')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_RPA', 'RPA')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_FND', 'FND')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_GAR', 'GAR')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_VEN', 'VEN')
   insert into @Tabla_RelPerfil_Operacion (perfil, operacion) values ('CCA_SEG', 'SEG')
   
   delete from cob_cartera..ca_trn_oper
   
   insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil)
   select b.codigo, operacion, perfil
      from cobis..cl_tabla a, cobis..cl_catalogo b, @Tabla_RelPerfil_Operacion c
      where a.codigo = b.tabla
      and a.tabla = 'ca_toperacion'
      and b.estado = 'V'
end
else
    print 'NO EXISTE TABLA ca_trn_oper'

go
