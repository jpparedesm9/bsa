use cob_fpm
go
insert into fp_nodetypeproduct values(1,null,'Grupo Financiero','Corresponde al banco matriz','N','N')
insert into fp_nodetypeproduct values(2,1,'Familia de Productos','Categoría de productos en base al tipo contable (Activos Pasivos)','N','N')
insert into fp_nodetypeproduct values(3,2,'Grupo de Productos','Productos que pertenecen a una categoría (Prestamos, A la vista)','S','N')
insert into fp_nodetypeproduct values(4,3,'Tipo de Banca','Agrupadores (Hipotecarios, Cuentas de Cheques)','N','N')
insert into fp_nodetypeproduct values(5,4,'Productos Finales','Productos ofertados a los clientes','N','S')
go
