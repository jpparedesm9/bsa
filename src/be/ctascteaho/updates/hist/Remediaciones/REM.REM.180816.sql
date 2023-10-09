

use cob_remesas
go
delete from cob_remesas..re_equivalencias where eq_tabla  ='ROLDEUDOR' and eq_val_cfijo in ('C','T','F','U')

insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','C','C','CODEUDOR')
insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','T','T','TITULAR DE LA CUENTA a DEPOSITO')
insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','F','F','FIRMA AUTORIZADA')
insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
values(4,36,'ROLDEUDOR','U','U','TUTOR')


delete from cob_remesas..re_equivalencias where eq_tabla  ='CATPRODUC' and eq_descripcion ='ORDINARIO'

insert into cob_remesas..re_equivalencias (eq_modulo,eq_mod_int,eq_tabla,eq_val_cfijo,eq_val_interfaz,eq_descripcion)
select 4,36,'CATPRODUC',pb_pro_bancario,'ORD','ORDINARIO' from cob_remesas..pe_pro_bancario 