use cob_bvirtual
go

delete from bv_b2c_banco_preguntas

insert into bv_b2c_banco_preguntas values (1,'NUMERO DE CLIENTE TUIIO (NRO. CLIENTE EN COBIS)',     'N', 'N', 'sp_b2c_pr01_cliente',    'V')
insert into bv_b2c_banco_preguntas values (2,'DIGA CUALES SON LOS 10 PRIMEROS DIGITOS DE SU RFC',                   'A', 'N', 'sp_b2c_pr02_rfc',        'V')
insert into bv_b2c_banco_preguntas values (3,'DIGA SEGUNDO APELLIDO',                               'A', 'S', 'sp_b2c_pr03_apellido2',  'V')
insert into bv_b2c_banco_preguntas values (4,'DIGA SEGUNDO NOMBRE',                                 'A', 'S', 'sp_b2c_pr04_nombre2',    'V')
insert into bv_b2c_banco_preguntas values (5,'DIGA LAS TRES ULTIMAS CIFRAS DE SU TELEFONO CELULAR', 'N', 'S', 'sp_b2c_pr05_celular',    'V')
insert into bv_b2c_banco_preguntas values (6,'DIGA SU CODIGO POSTAL',                               'N', 'N', 'sp_b2c_pr06_postal',     'V')
insert into bv_b2c_banco_preguntas values (7,'DIGA LA FECHA DE SU CUMPLEAÑOS',                      'F', 'N', 'sp_b2c_pr07_nacimiento', 'V')
insert into bv_b2c_banco_preguntas values (8,'DIGA SU CORREO ELECTRONICO',                          'A', 'S', 'sp_b2c_pr08_email',      'V')
go