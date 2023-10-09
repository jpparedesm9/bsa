
use cobis
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CRCNB' 
   AND pa_producto = 'MIS'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO RELACION DE CB', 'CRCNB', 'I', NULL, NULL, NULL, 207, NULL, NULL, NULL, 'MIS')

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'TCCNB'
   AND pa_producto = 'MIS'     
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE CLIENTE CB', 'TCCNB', 'C', '005', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'TCCBP'
   AND pa_producto = 'MIS'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO CLIENTE CORRESPONSAL BANCARIO POSICIONADO', 'TCCBP', 'C', '006', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')

delete from cl_parametro 
 where pa_nemonico = 'VAREIN'
   and pa_producto = 'MIS'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char,  pa_producto)
values ('REF. INH. - VALIDACION DEL CLIENTE', 'VAREIN', 'C', 'N',  'MIS')

DELETE FROM cobis..cl_parametro
  WHERE pa_nemonico = 'SRV'
    AND pa_producto = 'MIS'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('SERVIDOR', 'SRV', 'C', '192.168.64.255:81', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')

DELETE FROM cobis..cl_parametro
  WHERE pa_nemonico = 'TTC'
    AND pa_producto = 'MIS'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO TELEFONO CELULAR', 'TTC', 'C', 'C', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')

DELETE FROM cobis..cl_parametro
  WHERE pa_nemonico = 'TTD'
    AND pa_producto = 'MIS'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO TELEFONO DOMICILIO', 'TTD', 'C', 'D', NULL, NULL, NULL, NULL, NULL, NULL, 'MIS')

go

