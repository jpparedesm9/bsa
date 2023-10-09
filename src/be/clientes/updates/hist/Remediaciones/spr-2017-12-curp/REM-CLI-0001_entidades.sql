/***********************************************************************/
--No Bug:
--Título del Bug: creacion de indices
--Fecha:2017-06-15
--Descripción del Problema:
--Parametrizacion de equivalencias para Estados o Entidades federativas
--Descripción de la Solución: crear los indices
--Autor:LGU
/***********************************************************************/

use cob_conta_super
go
--ENTIDADES FEDERATIVAS  COBIS VS REGULATORIO
delete cob_conta_super..sb_equivalencias where eq_catalogo = 'ENT_FED'
go
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '1','01','AGUASCALIENTES','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '2','02','BAJA CALIFORNIA NTE.','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '3','03','BAJA CALIFORNIA SUR','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '4','04','CAMPECHE','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '5','05','COAHUILA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '6','06','COLIMA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '7','07','CHIAPAS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '8','08','CHIHUAHUA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '9','09','DISTRITO FEDERAL','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '10','10','DURANGO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '11','11','GUANAJUATO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '12','12','GUERRERO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '13','13','HIDALGO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '14','14','JALISCO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '15','15','MEXICO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '16','16','MICHOACAN','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '17','17','MORELOS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '18','18','NAYARIT','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '19','19','NUEVO LEON','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '20','20','OAXACA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '21','21','PUEBLA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '22','22','QUERETARO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '23','23','QUINTANA ROO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '24','24','SAN LUIS POTOSI','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '25','25','SINALOA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '26','26','SONORA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '27','27','TABASCO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '28','28','TAMAULIPAS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '29','29','TLAXCALA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '30','30','VERACRUZ','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '31','31','YUCATAN','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '32','32','ZACATECAS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '101','101','SERV. EXTERIOR MEXICANO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_FED', '102','102','NACIDO EN EL EXTRANJERO','V')
GO

--ENTIDADES FEDERATIVAS REGULATORIO VS CURP
delete cob_conta_super..sb_equivalencias where eq_catalogo = 'ENT_CURP'
go
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '01','AS', 'AGUASCALIENTES','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '02','BC', 'BAJA CALIFORNIA NTE.','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '03','BS', 'BAJA CALIFORNIA SUR','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '04','CC', 'CAMPECHE','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '05','CL', 'COAHUILA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '06','CM', 'COLIMA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '07','CS', 'CHIAPAS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '08','CH', 'CHIHUAHUA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '09','DF', 'DISTRITO FEDERAL','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '10','DG', 'DURANGO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '11','GT', 'GUANAJUATO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '12','GR', 'GUERRERO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '13','HG', 'HIDALGO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '14','JC', 'JALISCO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '15','MC', 'MEXICO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '16','MN', 'MICHOACAN','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '17','MS', 'MORELOS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '18','NT', 'NAYARIT','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '19','NL', 'NUEVO LEON','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '20','OC', 'OAXACA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '21','PL', 'PUEBLA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '22','QT', 'QUERETARO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '23','QR', 'QUINTANA ROO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '24','SP', 'SAN LUIS POTOSI','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '25','SL', 'SINALOA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '26','SR', 'SONORA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '27','TC', 'TABASCO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '28','TS', 'TAMAULIPAS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '29','TL', 'TLAXCALA','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '30','VZ', 'VERACRUZ','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '31','YN', 'YUCATAN','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '32','ZS', 'ZACATECAS','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '101','SM', 'SERV. EXTERIOR MEXICANO','V')
insert into cob_conta_super..sb_equivalencias values('ENT_CURP', '102','NE', 'NACIDO EN EL EXTRANJERO','V')

go



