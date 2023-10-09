use cobis
go
/**********************************************
LGU:
Script que crea las transacciones faltantes en
sustaining, fueron tomadas desde produccion

***********************************************/

delete cobis..ad_tr_autorizada where ta_producto =  8 and ta_transaccion =  1502 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  4 and ta_transaccion =  1564 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  5 and ta_transaccion =  3010 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7003 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7015 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7033 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7034 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7049 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7050 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7055 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7058 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7059 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7065 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7077 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7078 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7079 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7084 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7085 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7086 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7087 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7132 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7135 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7149 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7179 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7222 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7232 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7235 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7274 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7276 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7281 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7282 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7300 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto =  7 and ta_transaccion =  7306 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto = 17 and ta_transaccion = 15222 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto = 21 and ta_transaccion = 21365 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto = 21 and ta_transaccion = 21366 and ta_rol = 3
delete cobis..ad_tr_autorizada where ta_producto = 21 and ta_transaccion = 21610 and ta_rol = 3


-------------------
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (8,'R',0, 1502, 3, getdate(),3,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4,'R',0, 1564, 3, getdate(),1,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (5,'R',0, 3010, 3, getdate(),1,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (7,'R',0, 7003, 3, getdate(),3,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (7,'R',0, 7015, 3, getdate(),3,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (7,'R',0, 7033, 3, getdate(),3,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (7,'R',0, 7034, 3, getdate(),3,'V', getdate())

INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7049, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7050, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7055, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7058, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7059, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7065, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7077, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7078, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7079, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7084, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7085, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7086, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7087, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7132, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7135, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7149, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7179, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7222, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7232, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7235, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7274, 3, getdate(), 1, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7276, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7281, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7282, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7300, 3, getdate(), 3, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values ( 7, 'R', 0,  7306, 3, getdate(), 1, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (17, 'R', 0, 15222, 3, getdate(), 1, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (21, 'R', 0, 21365, 3, getdate(), 1, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (21, 'R', 0, 21366, 3, getdate(), 1, 'V', getdate())
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (21, 'R', 0, 21610, 3, getdate(), 1, 'V', getdate())

go



