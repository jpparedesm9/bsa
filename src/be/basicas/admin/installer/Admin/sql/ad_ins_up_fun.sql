/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      12/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/
use cobis
go
/************************************************************************/
print "cl_departamento"
/************************************************************************/
go

truncate table cl_departamento
go
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (1, 1, 0, "GERENCIA GRAL" ,0, 0)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (2, 1, 0, "REC. HUMANOS" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (3, 1, 0, "TESORERIA" ,0, 4)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (4, 1, 0, "ADMINISTRACION" ,0, 4)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (4, 1, 40, "ADMINISTRACION" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (7, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (9, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (12, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (18, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (19, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (20, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (21, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (22, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (23, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (26, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (27, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 40, "MERCADEO y PUBLICIDAD" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (5, 1, 0, "FINANZAS" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (6, 1, 0, "CONTABILIDAD" ,0, 4)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (7, 1, 0, "MERCADEO Y PUBLICIDAD" ,0, 4)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (8, 1, 0, "SEGURIDAD" ,0, 4)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (9, 1, 0, "ADMINISTRACION DE CREDITO" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (10, 1, 0, "COBROS" ,0, 9)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (11, 1, 0, "ASESORIA LEGAL" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (12, 1, 0, "TECNOLOGIA" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (13, 1, 0, "BANCA ELECTRONICA" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (14, 1, 0, "LEASING" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (15, 1, 0, "OPERACIONES CENTRALIZADAS" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (16, 1, 0, "DEPOSITOS A PLAZO FIJO" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (17, 1, 0, "CUENTAS CORRIENTES Y AHORROS" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (18, 1, 0, "OPERACIONES TESORERIA" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (19, 1, 0, "COMEX" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (20, 1, 0, "OPERACIONES CREDITO CORPORATIVOS" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (21, 1, 0, "OPERACIONES DE BANCA CONSUMO" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (22, 1, 0, "TRANSITO" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (23, 1, 0, "CUENTA X PAGAR" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (24, 1, 0, "ARCHIVO Y MENSAJERIA" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (25, 1, 0, "CUSTODIA" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (26, 1, 0, "PROCEDIMIENTO" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (27, 1, 0, "AUDITORIA INTERNA Y CONTROL INTERNO" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (28, 1, 0, "AUDITORIA DE RIESGO Y CREDITO" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (40, 1, 2, "VICEPRESIDENCIAS DE REGIONES" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (40, 1, 9, "VICEPRESIDENCIAS DE REGIONES" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (40, 1, 0, "VICEPRESIDENCIAS DE REGIONES" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (40, 1, 7, "VICEPRESIDENCIAS DE REGIONES" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (33, 1, 4, "TARJETAS DE CREDITO" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (34, 1, 20, "CALL CENTER" ,0, 0)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (35, 1, 0, "BANCA DE INVERSION" ,0, 4)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (36, 1, 0, "OPERACIONES BANCA DE CONSUMO WORFLOW" ,0, 15)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (37, 1, 0, "FACTOR GLOBAL" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (38, 1, 0, "TRANSPORTE" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 0, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 1, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 2, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 3, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 4, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 5, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 6, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 7, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 8, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 9, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 12, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 13, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 15, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 16, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 17, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 18, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 19, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 20, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 21, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 22, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 23, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 24, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 25, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 26, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 27, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 28, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 29, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 30, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 45, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 47, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (29, 1, 50, "OPERACIONES SUCURSALES" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 0, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 1, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 2, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 3, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 4, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 5, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 6, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 7, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 8, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 9, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 12, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 13, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 15, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 16, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 17, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 18, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 19, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 20, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 21, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 22, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 23, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 24, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 25, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 26, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 27, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 28, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 29, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 30, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 45, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 47, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (30, 1, 50, "SERVICIO AL CLIENTE (PLATAFORMA)" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 0, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 1, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 2, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 3, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 4, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 5, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 6, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 7, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 8, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 9, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 12, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 13, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 15, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 16, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 17, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 18, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 19, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 20, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 21, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 22, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 23, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 24, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 25, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 26, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 27, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 28, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 29, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 30, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 45, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 47, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (31, 1, 50, "CREDITO SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 0, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 1, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 2, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 3, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 4, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 5, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 6, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 7, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 8, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 9, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 12, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 13, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 15, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 16, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 17, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 18, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 19, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 20, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 21, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 22, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 23, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 24, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 25, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 26, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 27, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 28, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 29, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 30, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 45, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 47, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 48, "CAJA" ,0, 1)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (32, 1, 50, "CAJA" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 0, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 1, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 2, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 3, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 4, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 5, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 6, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 7, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 8, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 9, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 12, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 13, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 15, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 16, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 17, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 18, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 19, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 20, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 21, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 22, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 23, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 24, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 25, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 26, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 27, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 28, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 29, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 30, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 45, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 47, "GERENCIA DE SUCURSAL" ,0, 40)
insert into cl_departamento (de_departamento, de_filial, de_oficina, de_descripcion, de_o_departamento, de_nivel) values (39, 1, 50, "GERENCIA DE SUCURSAL" ,0, 40)

go
/************************************************************************/
print "cl_distributivo"
/************************************************************************/


truncate table cl_distributivo
go

insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 1, 1, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 1, 1, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 1, 14, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 1, 67, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 9, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 41, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 41, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 49, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 119, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 160, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 2, 183, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 3, 44, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 3, 75, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 4, 27, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 4, 58, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 4, 80, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 4, 120, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 4, 144, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 4, 144, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 5, 28, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 5, 29, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 5, 156, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 5, 171, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 6, 20, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 6, 20, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 6, 154, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 40, 173, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 7, 30, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 7, 52, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 7, 52, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 7, 157, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 8, 161, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 5, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 6, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 15, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 15, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 15, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 15, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 15, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 81, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 163, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 9, 175, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 10, 62, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 10, 76, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 10, 76, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 10, 76, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 10, 76, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 10, 76, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 10, 76, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 10, 76, 7, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 10, 76, 8, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 10, 76, 9, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 10, 78, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 10, 78, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 10, 90, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 10, 90, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 10, 90, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 11, 1, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 11, 2, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 11, 11, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 11, 122, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 11, 122, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 11, 122, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 11, 122, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 11, 146, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 3, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 4, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 12, 8, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 12, 8, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 12, 8, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 12, 8, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 12, 8, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 8, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 10, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 12, 13, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 13, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 48, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 54, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 66, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 72, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 74, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 116, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 142, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 142, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 142, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 7, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 150, 8, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 151, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 151, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 12, 174, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 13, 86, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 13, 86, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 13, 152, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 14, 83, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 15, 68, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 15, 112, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 15, 172, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 16, 110, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 16, 134, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 16, 134, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 16, 134, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 16, 134, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 18, 106, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 18, 136, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 18, 137, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 19, 91, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 19, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 19, 131, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 20, 70, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 20, 111, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 20, 135, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 32, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 32, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 32, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 32, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 69, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 79, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 79, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 108, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 108, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 131, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 7, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 8, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 9, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 10, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 133, 11, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 166, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 21, 166, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 33, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 33, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 7, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 8, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 131, 9, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 22, 158, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 23, 109, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 23, 132, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 23, 132, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 24, 82, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 25, 55, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 25, 55, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 25, 171, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 7, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 7, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 71, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 140, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 140, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 153, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 26, 168, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 12, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 16, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 16, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 16, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 16, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 21, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 21, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 45, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 85, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 85, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 85, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 92, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 27, 169, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 28, 42, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 28, 84, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 28, 99, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 28, 123, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 28, 176, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 35, 39, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 35, 59, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 35, 101, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 35, 103, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 35, 159, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 36, 133, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 38, 22, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 38, 56, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 38, 76, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 38, 95, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 38, 178, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 57, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 60, 18, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 60, 179, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 0, 90, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 29, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 29, 107, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 29, 107, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 29, 107, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 30, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 30, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 30, 131, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 30, 144, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 30, 162, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 32, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 32, 35, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 32, 46, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 1, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 29, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 23, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 23, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 24, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 76, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 93, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 93, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 31, 162, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 32, 46, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 32, 46, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 32, 46, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 2, 40, 184, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 29, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 30, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 31, 127, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 3, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 25, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 31, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 36, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 38, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 98, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 105, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 115, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 129, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 129, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 141, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 141, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 167, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 4, 33, 181, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 31, 23, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 5, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 6, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 30, 138, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 30, 143, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 31, 23, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 31, 63, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 31, 76, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 31, 97, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 31, 162, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 7, 40, 173, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 29, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 30, 138, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 31, 23, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 31, 93, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 8, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 10, 76, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 29, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 30, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 31, 93, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 31, 97, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 9, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 31, 97, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 31, 128, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 12, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 13, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 30, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 31, 23, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 31, 23, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 31, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 31, 93, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 15, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 16, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 16, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 16, 31, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 16, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 16, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 16, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 31, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 31, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 31, 162, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 32, 46, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 32, 46, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 32, 46, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 17, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 31, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 32, 23, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 18, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 30, 138, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 19, 39, 63, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 53, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 56, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 56, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 56, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 56, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 56, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 30, 114, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 51, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 61, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 100, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 124, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 124, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 139, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 139, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 139, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 33, 182, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 17, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 37, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 53, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 88, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 7, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 8, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 124, 9, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 139, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 144, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 20, 34, 164, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 21, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 21, 29, 107, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 21, 30, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 21, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 21, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 21, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 30, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 30, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 30, 144, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 31, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 22, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 23, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 24, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 24, 30, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 24, 31, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 24, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 24, 39, 155, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 29, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 31, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 32, 46, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 25, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 30, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 30, 143, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 26, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 30, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 32, 46, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 32, 138, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 27, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 28, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 28, 31, 128, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 28, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 29, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 29, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 29, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 29, 31, 96, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 29, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 29, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 29, 107, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 31, 24, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 31, 139, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 31, 65, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 31, 113, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 32, 34, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 32, 46, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 32, 46, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 32, 46, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 32, 46, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 30, 39, 73, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 22, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 22, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 22, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 22, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 22, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 26, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 64, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 64, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 64, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 94, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 126, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 147, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 170, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 177, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 45, 31, 177, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 4, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 7, 125, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 9, 15, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 8, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 8, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 8, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 8, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 8, 5, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 8, 6, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 50, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 148, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 12, 150, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 18, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 19, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 20, 33, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 20, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 20, 131, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 21, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 21, 131, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 22, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 23, 131, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 26, 140, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 26, 140, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 26, 140, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 26, 140, 4, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 27, 16, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 27, 16, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 40, 30, 35, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 13, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 13, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 13, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 20, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 47, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 57, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 57, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 77, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 77, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 77, 3, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 78, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 78, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 102, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 117, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 130, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 148, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 47, 37, 165, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 48, 32, 46, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 50, 31, 19, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 50, 31, 19, 2, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 50, 31, 59, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 50, 31, 89, 1, getdate(), "V", "S")
insert into cl_distributivo (ds_filial, ds_oficina, ds_departamento, ds_cargo, ds_secuencial, ds_fecha, ds_estado, ds_vacante) values ( 1, 50, 31, 180, 1, getdate(), "V", "S")

go
/************************************************************************/
print "cl_funcionario"
/************************************************************************/


delete cl_funcionario where fu_funcionario > 2
go


insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 3, "RITA GRIMALDO", "F", "N", 0, 11, 1, 1, 1, 0, getdate(), "rgrimald", null, 848,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 4, "MARIA SOFIA CARRANZA", "F", "N", 0, 11, 2, 1, 1, 0, getdate(), "mscarran", null, 897,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 5, "JOSE FERNANDEZ", "M", "N", 0, 12, 3, 1, 1, 0, getdate(), "jfernand", null, 1030,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 6, "YONEL ALFONSO RODRIGUEZ", "M", "N", 0, 12, 4, 1, 1, 0, getdate(), "yarodrig", null, 739,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 7, "GRACE RIVAS", "F", "N", 0, 9, 5, 1, 1, 0, getdate(), "grarivas", null, 992,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 8, "SUSANA MARICRUZ CEDEÑO", "F", "N", 0, 9, 6, 1, 1, 0, getdate(), "smcedeño", null, 724,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 9, "KERIMA KERUBE FRANCO", "F", "N", 0, 26, 7, 1, 1, 0, getdate(), "kafranco", null, 691,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 10, "YANICHEL RAMIREZ", "F", "N", 0, 26, 7, 2, 1, 0, getdate(), "yramirez", null, 970,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 11, "GIOCONDA JANETH MCLEOD", "F", "N", 0, 12, 8, 1, 1, 0, getdate(), "gjmcleod", null, 99,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 12, "KARLA ELISA ELLIS", "F", "N", 0, 12, 8, 2, 1, 0, getdate(), "kaeellis", null, 180,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 13, "VICTOR MANUEL VARELA", "M", "N", 0, 12, 8, 3, 1, 0, getdate(), "vmvarela", null, 471,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 14, "OLIVER BOTACIO", "M", "N", 0, 12, 8, 4, 1, 0, getdate(), "obotacio", null, 815,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 15, "CAROL JANETH CETINA", "F", "N", 0, 12, 8, 5, 1, 0, getdate(), "cjcetina", null, 966,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 16, "ERIC MOJICA", "M", "N", 0, 12, 8, 6, 1, 0, getdate(), "ermojica", null, 1010,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 17, "MARIO ARDINES", "M", "N", 40, 12, 8, 1, 1, 0, getdate(), "mardines", null, 1022,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 18, "HERNANDO PANG", "M", "N", 40, 12, 8, 2, 1, 0, getdate(), "hernpang", null, 1029,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 19, "HUMBERTO AYARZA", "M", "N", 40, 12, 8, 3, 1, 0, getdate(), "huayarza", null, 1049,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 20, "GUSTAVO ADOLFO GUTIERREZ", "M", "N", 40, 12, 8, 4, 1, 0, getdate(), "gagutier", null, 1050,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 21, "ROLANDO EDWIN LINARES", "M", "N", 40, 12, 8, 5, 1, 0, getdate(), "relinare", null, 1051,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 22, "ANAYANSI ITZEL RIGGS", "F", "N", 40, 12, 8, 6, 1, 0, getdate(), "aniriggs", null, 1081,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 23, "BERNADETTE BOAVENTURA", "F", "N", 0, 2, 9, 1, 1, 0, getdate(), "bboavent", null, 1007,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 24, "ROBERTO SZOBOTKA", "M", "N", 0, 12, 10, 1, 1, 0, getdate(), "rszobotk", null, 83,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 25, "ROGELIO BIENDICHO", "M", "N", 0, 11, 11, 1, 1, 0, getdate(), "rbiendic", null, 443,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 26, "ANDRES GALLARDO", "M", "N", 0, 27, 12, 1, 1, 0, getdate(), "agallard", null, 1028,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 27, "LILIA ENITH DUCREUX", "F", "N", 47, 37, 13, 1, 1, 0, getdate(), "leducreu", null, 698,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 28, "DIANA DELGADO", "F", "N", 0, 12, 13, 1, 1, 0, getdate(), "ddelgado", null, 871,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 29, "MARIBEL ARZE CARTER", "F", "N", 47, 37, 13, 2, 1, 0, getdate(), "macarter", null, 908,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 30, "MARISOL PALMA", "F", "N", 47, 37, 13, 3, 1, 0, getdate(), "marpalma", null, 962,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 31, "ALICIA EVELIA GONZALEZ", "F", "N", 0, 5, 13, 1, 1, 0, getdate(), "aegonzal", null, 1037,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 32, "CRISTINA M. HERNANDEZ ROBINSON", "F", "N", 0, 1, 14, 1, 1, 0, getdate(), "cmhernan", null, 413,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 33, "DESIREE G. SAENZ", "F", "N", 0, 9, 15, 1, 1, 0, getdate(), "degsaenz", null, 570,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 34, "LARISA BOLT", "F", "N", 0, 9, 15, 2, 1, 0, getdate(), "laribolt", null, 741,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 35, "ALEXANDER CASTILLO", "M", "N", 0, 9, 15, 3, 1, 0, getdate(), "acastill", null, 907,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 36, "IOANA THEOKTISTO", "F", "N", 0, 9, 15, 4, 1, 0, getdate(), "itheokti", null, 912,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 37, "RODERICK AVILA", "M", "N", 0, 9, 15, 5, 1, 0, getdate(), "rodavila", null, 942,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 38, "AQUILINO JOSE ORTIZ", "M", "N", 40, 9, 15, 1, 1, 0, getdate(), "aqjortiz", null, 1062,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 39, "ELIZABETH DEL C CONTRERAS CAROPRESSO", "F", "N", 0, 27, 16, 1, 1, 0, getdate(), "edccont", null, 150,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 40, "RENE GILBERTO BERMUDEZ", "M", "N", 0, 27, 16, 2, 1, 0, getdate(), "rgbermud", null, 713,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 41, "JUAN MANUEL ATENCIO", "M", "N", 0, 27, 16, 3, 1, 0, getdate(), "jmatenci", null, 1025,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 42, "DAYRO AMETH ROSAS", "M", "N", 40, 27, 16, 1, 1, 0, getdate(), "daarosas", null, 1036,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 43, "LARRY ADAIR TRUJILLO", "M", "N", 0, 27, 16, 4, 1, 0, getdate(), "latrujil", null, 1068,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 44, "VERHUSKA TURCY", "F", "N", 40, 27, 16, 2, 1, 0, getdate(), "verturcy", null, 1100,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 45, "EGLANTINA NORATO", "F", "N", 20, 34, 17, 1, 1, 0, getdate(), "egnorato", null, 875,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 46, "YENNY AGUILAR", "F", "N", 0, 60, 18, 1, 1, 0, getdate(), "yaguilar", null, 1003,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 47, "MARIA DEL PILAR ARJONA", "F", "N", 50, 31, 19, 1, 1, 0, getdate(), "mdpilar", null, 850,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 48, "MALENA DE OBARRIO", "F", "N", 50, 31, 19, 2, 1, 0, getdate(), "mdobarri", null, 894,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 49, "MAYBOL SHEILA CARRILLO SMITH", "F", "N", 0, 6, 20, 1, 1, 0, getdate(), "mscarril", null, 477,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 50, "CELIA MARIA VALDES", "F", "N", 0, 6, 20, 2, 1, 0, getdate(), "cmvaldes", null, 1088,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 51, "DIANETH MUNOZ DE GUERRA", "F", "N", 47, 37, 20, 1, 1, 0, getdate(), "dmdegue", null, 689,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 52, "ISBETH GISEL ROMERO BARRIOS", "F", "N", 0, 27, 21, 1, 1, 0, getdate(), "igromero", null, 760,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 53, "JOSE MERCEDES MAITIN", "M", "N", 0, 27, 21, 2, 1, 0, getdate(), "jmmaitin", null, 1083,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 54, "ELVIA DEL C. FERNANDEZ", "F", "N", 45, 31, 22, 1, 1, 0, getdate(), "elviafer", null, 89,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 55, "CAROLINA YU", "F", "N", 45, 31, 22, 2, 1, 0, getdate(), "caroliyu", null, 212,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 56, "SARIAH ESTHER SANDOVAL", "F", "N", 45, 31, 22, 3, 1, 0, getdate(), "sesandov", null, 224,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 57, "DALINDA DEL C. HERNANDEZ", "F", "N", 45, 31, 22, 4, 1, 0, getdate(), "ddcher", null, 287,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 58, "PATRICIA V. ESPANO", "F", "N", 45, 31, 22, 5, 1, 0, getdate(), "pvespano", null, 607,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 59, "TIANA SANG", "F", "N", 0, 38, 22, 1, 1, 0, getdate(), "tiansang", null, 853,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 60, "DEYRIS ORIELA REYES", "F", "N", 5, 31, 23, 1, 1, 0, getdate(), "deoreyes", null, 292,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 61, "LIRABETH SAENZ ABREGO", "F", "N", 8, 31, 23, 1, 1, 0, getdate(), "lsabrego", null, 320,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 62, "LIBRADA YARISSA CALIPOLITTI", "F", "N", 15, 31, 23, 1, 1, 0, getdate(), "lycalipo", null, 522,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 63, "KAYRA JESSEMAR DELGADO BONILLA", "F", "N", 7, 31, 23, 1, 1, 0, getdate(), "kjdelgad", null, 563,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 64, "GIOVANNA ISABEL MENDEZ", "F", "N", 2, 31, 23, 1, 1, 0, getdate(), "gimendez", null, 588,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 65, "SIMEON ALEXIS AMAYA", "M", "N", 18, 32, 23, 1, 1, 0, getdate(), "siaamaya", null, 904,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 66, "LUZGARDITH MELGAR", "F", "N", 2, 31, 23, 2, 1, 0, getdate(), "lumelgar", null, 954,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 67, "LUIS JAVIER CACERES", "M", "N", 15, 31, 23, 2, 1, 0, getdate(), "ljcacere", null, 1085,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 68, "YUSETT BARINA RUIZ CORDOBA", "F", "N", 18, 31, 24, 1, 1, 0, getdate(), "ybruizc", null, 211,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 69, "ISYBYR K. AMADOR", "F", "N", 2, 31, 24, 1, 1, 0, getdate(), "ikamador", null, 267,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 70, "SOFIA GUADALUPE EVANS VILLARREAL", "F", "N", 3, 30, 24, 1, 1, 0, getdate(), "sgevans", null, 281,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 71, "ANAYANSI MEDINA FERRER", "F", "N", 27, 30, 24, 1, 1, 0, getdate(), "amferrer", null, 288,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 72, "EVELIS ANAYS VERGARA MONTENEGRO", "F", "N", 19, 31, 24, 1, 1, 0, getdate(), "eavergar", null, 307,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 73, "YICEL DEL C. RUIZ CARDOZE", "F", "N", 9, 30, 24, 1, 1, 0, getdate(), "ydcrui", null, 334,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 74, "IVETH ITZEL CABALLERO", "F", "N", 13, 31, 24, 1, 1, 0, getdate(), "iicaball", null, 354,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 75, "HAYDEE GRACIELA IBARRA", "F", "N", 26, 31, 24, 1, 1, 0, getdate(), "hgibarra", null, 441,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 76, "YULIMA MYLETH COCHERAN", "F", "N", 2, 31, 24, 2, 1, 0, getdate(), "ymcocher", null, 509,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 77, "YAHAIRA MARIE COCO ARAUZ", "F", "N", 6, 31, 24, 1, 1, 0, getdate(), "ymcocoa", null, 639,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 78, "ANAYANSI DE LEON", "F", "N", 8, 31, 24, 1, 1, 0, getdate(), "anadleon", null, 649,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 79, "GRETCHEN C. MANFREDO", "F", "N", 20, 34, 24, 1, 1, 0, getdate(), "gcmanfre", null, 678,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 80, "ODILIA BERBEY", "F", "N", 29, 31, 24, 1, 1, 0, getdate(), "odberbey", null, 783,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 81, "SANDRA DEL R. COELLO", "F", "N", 22, 30, 24, 1, 1, 0, getdate(), "sacoello", null, 789,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 82, "NIXIA YANELL CASTANEDA", "F", "N", 30, 31, 24, 1, 1, 0, getdate(), "nycastan", null, 862,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 83, "JESSICA SUAREZ", "F", "N", 4, 33, 25, 1, 1, 0, getdate(), "jesuarez", null, 906,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 84, "GISELLE A. DIP", "F", "N", 45, 31, 26, 1, 1, 0, getdate(), "giseadip", null, 411,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 85, "EVELIN MARLENI DE GRACIA", "F", "N", 0, 4, 27, 1, 1, 0, getdate(), "emdegra", null, 428,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 86, "LISBETH YARIELA RESTREPO", "F", "N", 0, 5, 28, 1, 1, 0, getdate(), "lyrestre", null, 692,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 87, "ISAGRISEL RODRIGUEZ", "F", "N", 0, 5, 29, 1, 1, 0, getdate(), "irodrigu", null, 969,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 88, "DIANA CLAIRESSE CANIZALEZ", "F", "N", 0, 7, 30, 1, 1, 0, getdate(), "dccaniza", null, 644,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 89, "GINA GABRIELA MAINIERI FERNANDEZ", "F", "N", 4, 33, 31, 1, 1, 0, getdate(), "ggmainie", null, 1082,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 90, "JULIA BOLIVIA MOWATT", "F", "N", 0, 21, 32, 1, 1, 0, getdate(), "jbmowatt", null, 484,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 91, "KATHIA EDISA ESPINOSA", "F", "N", 0, 21, 32, 2, 1, 0, getdate(), "keespino", null, 617,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 92, "LIZBETH V. BARAHONA", "F", "N", 0, 21, 32, 3, 1, 0, getdate(), "lvbaraho", null, 705,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 93, "GISSELLE ANETT KOURUKLIS", "F", "N", 0, 21, 32, 4, 1, 0, getdate(), "gakouruk", null, 842,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 94, "DAFNE ITZELITH ARCIA", "F", "N", 0, 22, 33, 1, 1, 0, getdate(), "daiarcia", null, 151,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 95, "EDILBERTA ARAUZ", "F", "N", 13, 29, 107, 1, 1, 0, getdate(), "ediarauz", null, 532,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 96, "RITA REBECA RIOS", "F", "N", 25, 29, 34, 1, 1, 0, getdate(), "ritrrios", null, 787,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 97, "MARCOS GONZALEZ", "M", "N", 40, 20, 33, 1, 1, 0, getdate(), "marzalez", null, 1011,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 98, "ROBERTO ENRIQUE DIAZ", "M", "N", 2, 29, 34, 1, 1, 0, getdate(), "robediaz", null, 265,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 99, "ROGELIO CAMARGO", "M", "N", 3, 29, 34, 1, 1, 0, getdate(), "rcamargo", null, 275,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 100, "RUFINA BEATRIZ ORTEGA PIMENTEL", "F", "N", 8, 29, 34, 1, 1, 0, getdate(), "rbortega", null, 317,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 101, "BETZY MAGALY CASAS VEGA", "F", "N", 9, 29, 34, 1, 1, 0, getdate(), "bemcasas", null, 328,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 102, "CELIBETH MORENO LAWHEAD", "F", "N", 30, 32, 34, 1, 1, 0, getdate(), "cmlawhea", null, 872,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 103, "IVETH ELISA ESPINO", "F", "N", 0, 20, 33, 1, 1, 0, getdate(), "ieespino", null, 953,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 104, "RAQUEL SANG", "F", "N", 17, 31, 35, 2, 1, 0, getdate(), "raqusang", null, 176,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 105, "ZOSIRE BETZAIDA RIOS", "F", "N", 17, 30, 35, 1, 1, 0, getdate(), "zosbrios", null, 189,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 106, "IVETH ISEL ESPINOSA CEDEÑO", "F", "N", 18, 31, 35, 1, 1, 0, getdate(), "iiespino", null, 209,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 107, "KATIA MARIA SPIEGEL SUAREZ", "F", "N", 6, 30, 35, 1, 1, 0, getdate(), "kmspiege", null, 301,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 108, "ANA GABRIELA ORTIZ WALKER", "F", "N", 16, 31, 35, 1, 1, 0, getdate(), "angortiz", null, 364,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 109, "ELIZABETH A. COSSU DIAZ", "F", "N", 29, 30, 35, 1, 1, 0, getdate(), "elacossu", null, 525,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 110, "OMIDIA MATILDE RODRIGUEZ", "F", "N", 1, 32, 35, 1, 1, 0, getdate(), "omrodrig", null, 575,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 111, "VANESSA Y. HURTADO", "F", "N", 15, 31, 35, 1, 1, 0, getdate(), "vyhurtad", null, 605,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 112, "LISSETTE JOYCE VELIZ", "F", "N", 30, 30, 35, 1, 1, 0, getdate(), "lijveliz", null, 606,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 113, "AMBAR YAMILETH GARCÍA", "F", "N", 25, 30, 35, 1, 1, 0, getdate(), "aygarcía", null, 629,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 114, "AURORA XIOMARA SANCHEZ", "F", "N", 1, 32, 35, 2, 1, 0, getdate(), "axsanche", null, 694,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 115, "TING NU LIAO", "F", "N", 7, 30, 35, 1, 1, 0, getdate(), "tinnliao", null, 1078,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 116, "SILVANIA ITZEL ATENCIO", "F", "N", 40, 30, 35, 1, 1, 0, getdate(), "siatenci", null, 1084,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 117, "MARITZELLE J WILLIAMS", "F", "N", 4, 33, 36, 1, 1, 0, getdate(), "mjwillia", null, 1107,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 118, "ALEXANDRA T. BULGIN", "F", "N", 20, 34, 37, 1, 1, 0, getdate(), "atbulgin", null, 677,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 119, "JAVIER GARCIA", "M", "N", 4, 33, 38, 1, 1, 0, getdate(), "jagarcia", null, 1005,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 120, "JOHANN C. RODRIGUEZ", "F", "N", 0, 35, 39, 1, 1, 0, getdate(), "jcrodrig", null, 895,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 121, "JORLENYS JIMENEZ", "F", "N", 0, 2, 41, 1, 1, 0, getdate(), "jjimenez", null, 975,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 122, "MARIANA JUAREZ", "F", "N", 0, 2, 41, 2, 1, 0, getdate(), "majuarez", null, 995,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 123, "MARIA PATRICIA CASTILLO", "F", "N", 0, 28, 42, 1, 1, 0, getdate(), "mpcastil", null, 870,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 124, "NEILA URRIOLA", "F", "N", 0, 3, 44, 1, 1, 0, getdate(), "nurriola", null, 973,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 125, "ALEJANDRO LEE", "M", "N", 0, 27, 45, 1, 1, 0, getdate(), "alejalee", null, 919,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 126, "ROLANDO E. ALVAREZ", "M", "N", 0, 90, 46, 1, 1, 0, getdate(), "realvare", null, 57,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 127, "DANIEL ABRAHAM SUCRE", "M", "N", 19, 32, 46, 1, 1, 0, getdate(), "daasucre", null, 101,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 128, "EURIBIADES BARRIOS", "M", "N", 24, 32, 46, 1, 1, 0, getdate(), "ebarrios", null, 173,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 129, "JULIO TUNON", "M", "N", 6, 32, 46, 1, 1, 0, getdate(), "jultunon", null, 186,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 130, "CESAR AUGUSTO FONG", "M", "N", 29, 32, 46, 1, 1, 0, getdate(), "cesafong", null, 205,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 131, "JORGE LUIS DUTARI", "M", "N", 3, 32, 46, 1, 1, 0, getdate(), "jldutari", null, 207,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 132, "OSCAR ALFREDO ENDARA", "M", "N", 1, 32, 46, 1, 1, 0, getdate(), "oaendara", null, 256,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 133, "MARISEL DEL C. GUERRA", "F", "N", 2, 32, 46, 1, 1, 0, getdate(), "mdcgue", null, 270,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 134, "INDIRA MORENO", "F", "N", 5, 32, 46, 1, 1, 0, getdate(), "inmoreno", null, 296,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 135, "JUSTINO GUEVARA", "M", "N", 8, 32, 46, 1, 1, 0, getdate(), "jguevara", null, 321,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 136, "ROBERTO AUGUSTO SOTO", "M", "N", 9, 32, 46, 1, 1, 0, getdate(), "robasoto", null, 331,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 137, "YAZMIN ELIZABET PINILLA GONZALEZ", "F", "N", 12, 32, 46, 1, 1, 0, getdate(), "yepinill", null, 349,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 138, "TANIA DEL C. CANDANEDO RIVERA", "F", "N", 16, 32, 46, 1, 1, 0, getdate(), "tdccan", null, 366,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 139, "ARACELI DAMARIS GALBRAITH LASSO", "F", "N", 19, 32, 46, 2, 1, 0, getdate(), "adgalbra", null, 481,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 140, "ANA JULIA CENTELLA RODRIGUEZ", "F", "N", 48, 32, 46, 1, 1, 0, getdate(), "ajcentel", null, 496,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 141, "KELVIN JUAREZ", "M", "N", 18, 32, 46, 1, 1, 0, getdate(), "kejuarez", null, 510,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 142, "JUVENAL CHONG", "M", "N", 27, 32, 46, 1, 1, 0, getdate(), "juvchong", null, 524,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 143, "RICARDO JAVIER MELENDEZ", "M", "N", 7, 32, 46, 1, 1, 0, getdate(), "rjmelend", null, 565,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 144, "GLORIA RITA SOSA GONZALEZ", "F", "N", 6, 32, 46, 2, 1, 0, getdate(), "grsosag", null, 604,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 145, "ANABELL JOANNE PEREZ", "F", "N", 9, 32, 46, 2, 1, 0, getdate(), "anjperez", null, 616,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 146, "MARIA DE LOS A. ALMENGOR RIVERA", "F", "N", 2, 32, 46, 2, 1, 0, getdate(), "mdlosa", null, 619,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 147, "SAIDY SELIDETH SALAS", "F", "N", 13, 32, 46, 1, 1, 0, getdate(), "sassalas", null, 633,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 148, "CARMEN MARIA ANTUNEZ", "F", "N", 5, 32, 46, 2, 1, 0, getdate(), "cmantune", null, 638,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 149, "GIOVANNA DEL R. SALAZAR MARTINEZ", "F", "N", 48, 32, 46, 2, 1, 0, getdate(), "gdrsal", null, 666,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 150, "VANESSA EUGENIA RITTER BROUWER", "F", "N", 22, 32, 46, 1, 1, 0, getdate(), "veritter", null, 672,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 151, "CLAUDINO HERNANDEZ", "M", "N", 30, 32, 46, 1, 1, 0, getdate(), "chernand", null, 674,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 152, "YASMIN ESTHER CARVAJAL", "F", "N", 1, 29, 107, 1, 1, 0, getdate(), "yecarvaj", null, 682,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 153, "ALEX ARMANDO LARGAESPADA", "M", "N", 21, 32, 46, 1, 1, 0, getdate(), "aalargae", null, 719,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 154, "XIOMARA LINETH MARTINEZ", "F", "N", 25, 32, 46, 1, 1, 0, getdate(), "xlmartin", null, 727,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 155, "JAIME FRANCISCO GONZALEZ", "M", "N", 26, 32, 46, 1, 1, 0, getdate(), "jfgonzal", null, 762,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 156, "RAUL ENRIQUE VALDERRAMA", "M", "N", 2, 32, 46, 3, 1, 0, getdate(), "revalder", null, 768,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 157, "SUGEY KERUBE COLEY", "F", "N", 27, 30, 46, 1, 1, 0, getdate(), "sukcoley", null, 779,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 158, "JACQUELINE ALVAREZ ACOSTA", "F", "N", 25, 32, 46, 2, 1, 0, getdate(), "jaacosta", null, 785,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 159, "ENRIQUE NAVARRO", "M", "N", 23, 32, 46, 1, 1, 0, getdate(), "enavarro", null, 808,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 160, "BELARMINO R. CARRASCO", "M", "N", 1, 32, 46, 2, 1, 0, getdate(), "brcarras", null, 811,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 161, "IZETH SAMUDIO", "F", "N", 1, 30, 131, 1, 1, 0, getdate(), "isamudio", null, 819,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 162, "KENIA ELIZABETH PINO PINZON", "F", "N", 30, 32, 46, 2, 1, 0, getdate(), "kepinop", null, 820,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 163, "BELINDA CACERES", "F", "N", 15, 32, 46, 1, 1, 0, getdate(), "bcaceres", null, 822,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 164, "ESANDY LONDON", "M", "N", 17, 32, 46, 1, 1, 0, getdate(), "eslondon", null, 825,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 165, "LUIS ALBERTO MARTINEZ", "M", "N", 17, 32, 46, 2, 1, 0, getdate(), "lamartin", null, 835,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 166, "MARELISSA TUNON URRIOLA", "F", "N", 8, 32, 46, 2, 1, 0, getdate(), "mturriol", null, 852,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 167, "SIMON SALAZAR", "M", "N", 6, 32, 46, 3, 1, 0, getdate(), "ssalazar", null, 893,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 168, "ALDO MOJICA", "M", "N", 3, 32, 46, 2, 1, 0, getdate(), "almojica", null, 913,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 169, "JANETH MORHAIM", "F", "N", 2, 32, 46, 4, 1, 0, getdate(), "jmorhaim", null, 928,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 170, "ELEIDA GIL", "F", "N", 18, 32, 46, 2, 1, 0, getdate(), "eleidgil", null, 947,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 171, "GLORIA GARCIA", "F", "N", 16, 32, 46, 2, 1, 0, getdate(), "glgarcia", null, 842,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 172, "THANARA DEL C. GONZALEZ", "F", "N", 27, 32, 46, 2, 1, 0, getdate(), "tdcgon", null, 978,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 173, "VERIKA CASTILLO OSORIO", "F", "N", 17, 32, 46, 3, 1, 0, getdate(), "vcosorio", null, 984,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 174, "RUBEN DARIO APARICIO", "M", "N", 2, 32, 46, 5, 1, 0, getdate(), "rdaparic", null, 985,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 175, "BLADIMIR MEDIANERO", "M", "N", 17, 32, 46, 4, 1, 0, getdate(), "bmediane", null, 990,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 176, "SYDNEY URENA", "M", "N", 7, 32, 46, 2, 1, 0, getdate(), "sydurena", null, 1016,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 177, "CRISTIAN MARIN", "M", "N", 30, 32, 46, 3, 1, 0, getdate(), "crimarin", null, 1053,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 178, "NORIS WONG NG", "F", "N", 17, 32, 46, 5, 1, 0, getdate(), "noriswng", null, 1064,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 179, "ANDRES BEDOYA", "M", "N", 1, 32, 46, 3, 1, 0, getdate(), "anbedoya", null, 1066,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 180, "ALEXANDER MITRE", "M", "N", 30, 32, 46, 4, 1, 0, getdate(), "alemitre", null, 1073,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 181, "EIBEN ALEXANDER GONZALEZ", "M", "N", 17, 32, 46, 6, 1, 0, getdate(), "eagonzal", null, 1079,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 182, "EVARISTO HURTADO", "M", "N", 13, 32, 46, 2, 1, 0, getdate(), "ehurtado", null, 1096,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 183, "MAYTE LORENA TOJEIRO", "F", "N", 1, 32, 46, 4, 1, 0, getdate(), "mltojeir", null, 1098,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 184, "VLADIMIR E ZAMORA", "M", "N", 25, 32, 46, 3, 1, 0, getdate(), "vezamora", null, 1099,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 185, "AROM DAVID VALDES", "M", "N", 25, 32, 46, 4, 1, 0, getdate(), "advaldes", null, 1102,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 186, "IVETTE SINAY ARCE CORDOBA", "F", "N", 22, 32, 46, 2, 1, 0, getdate(), "isarcec", null, 1104,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 187, "NOEMI DEL C ARCIA", "F", "N", 30, 32, 46, 5, 1, 0, getdate(), "ndcarci", null, 1105,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 188, "ANARELYS CORONADO", "F", "N", 5, 32, 46, 3, 1, 0, getdate(), "acoronad", null, 1001,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 189, "CARLOS ALBERTO SANCHEZ", "M", "N", 19, 30, 138, 1, 1, 0, getdate(), "casanche", null, 1114,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 190, "RICARDO ALBERTO QUINTERO", "M", "N", 2, 32, 46, 6, 1, 0, getdate(), "raquinte", null, 974,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 191, "YASNETT CABALLERO", "F", "N", 23, 32, 46, 2, 1, 0, getdate(), "ycaballe", null, 920,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 192, "DAMIAN MONTENEGRO", "M", "N", 23, 32, 46, 3, 1, 0, getdate(), "dmontene", null, 337,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 193, "KEILA ARELIS MANCILLA", "F", "N", 26, 31, 46, 1, 1, 0, getdate(), "kamancil", null, 563,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 194, "DIANA YAISETH JAEN QUINTERO", "F", "N", 47, 37, 47, 1, 1, 0, getdate(), "dyjaenq", null, 689,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 195, "MARISOL ELVIRA PIMENTEL", "F", "N", 0, 12, 48, 1, 1, 0, getdate(), "mepiment", null, 248,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 196, "MIRTA YAZMIN VASQUEZ", "F", "N", 0, 2, 49, 1, 1, 0, getdate(), "myvasque", null, 568,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 197, "EIVILYN DA LUZ", "F", "N", 40, 12, 50, 1, 1, 0, getdate(), "eividluz", null, 1071,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 198, "IVONY CALLES", "F", "N", 20, 33, 51, 1, 1, 0, getdate(), "ivcalles", null, 938,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 199, "JANNETH COLUCHE PALM", "F", "N", 0, 7, 52, 1, 1, 0, getdate(), "jancpalm", null, 927,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 200, "CECILIA HERNANDEZ", "F", "N", 0, 7, 52, 2, 1, 0, getdate(), "cehernan", null, 470,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 201, "NELLY DAMARIS BEITIA MUNAR", "F", "N", 20, 34, 53, 1, 1, 0, getdate(), "ndbeitia", null, 222,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 202, "YADIRA PILAR CABALCETA QUINTERO", "F", "N", 20, 30, 53, 1, 1, 0, getdate(), "ypcabalc", null, 732,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 203, "CASTOR PATRICIO MENENDEZ", "M", "N", 0, 12, 54, 1, 1, 0, getdate(), "cpmenend", null, 470,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 204, "BEATRIZ AMPARO GARCIA", "F", "N", 0, 25, 55, 1, 1, 0, getdate(), "bagarcia", null, 68,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 205, "JOSE JESUS HERNANDEZ", "M", "N", 0, 25, 55, 2, 1, 0, getdate(), "jjhernan", null, 738,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 206, "JUDITH GONZALEZ", "F", "N", 20, 30, 56, 1, 1, 0, getdate(), "jgonzale", null, 961,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 207, "JESSIKA MORENO", "F", "N", 20, 30, 56, 2, 1, 0, getdate(), "jemoreno", null, 987,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 208, "KATHYA E. CASTILLO", "F", "N", 20, 30, 56, 3, 1, 0, getdate(), "kecastil", null, 1019,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 209, "RUBEN JESUS ELLIS", "M", "N", 20, 30, 56, 4, 1, 0, getdate(), "rujellis", null, 1020,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 210, "BLEIXEM VEGA", "F", "N", 20, 30, 56, 5, 1, 0, getdate(), "bleivega", null, 1027,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 211, "CLARISSA ITURRALDE", "F", "N", 0, 38, 56, 1, 1, 0, getdate(), "citurral", null, 1043,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 212, "RUTH EULALIA COELLO", "F", "N", 47, 37, 57, 1, 1, 0, getdate(), "recoello", null, 851,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 213, "DELFILIA ARJONA", "F", "N", 47, 37, 57, 2, 1, 0, getdate(), "dearjona", null, 1036,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 214, "RICAURTE E. BECERRA", "M", "N", 0, 4, 58, 1, 1, 0, getdate(), "rebecerr", null, 602,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 215, "MARCO ANTONIO GARCIA", "M", "N", 0, 35, 59, 1, 1, 0, getdate(), "mararcia", null, 972,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 216, "SONIA MARIA PARDO", "F", "N", 50, 31, 59, 1, 538, 0, getdate(), "sompardo", null, 448,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 217, "DAYRA EDITH TORRES", "F", "N", 20, 33, 61, 1, 1, 0, getdate(), "detorres", null, 531,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 218, "EILEEN LA DUKE CHAMBONET", "F", "N", 0, 10, 62, 1, 1, 0, getdate(), "eldukec", null, 451,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 219, "JESSICA GISELLE GARCIA CLEMENT", "F", "N", 7, 31, 63, 1, 530, 0, getdate(), "jggarcia", null, 43,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 220, "RICARDO MENDEZ", "M", "N", 19, 39, 63, 1, 530, 0, getdate(), "rimendez", null, 974,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 221, "MARIA EUGENIA I GRIMALDO WONG", "F", "N", 45, 31, 64, 1, 1, 0, getdate(), "meigrim", null, 408,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 222, "LOLITA PORRAS", "F", "N", 45, 31, 64, 2, 526, 0, getdate(), "loporras", null, 836,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 223, "JOSE GERARDO ALVARADO", "M", "N", 45, 31, 64, 3, 1, 0, getdate(), "jgalvara", null, 930,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 224, "ALICIA MARIA PORRAS", "F", "N", 30, 31, 65, 1, 543, 0, getdate(), "amporras", null, 4,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 225, "RAMIRO DIAZ", "M", "N", 0, 12, 66, 1, 1, 0, getdate(), "ramidiaz", null, 102,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 226, "JORGE ENRIQUE VALLARINO", "M", "N", 0, 1, 67, 1, 1, 0, getdate(), "jevallar", null, 16,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 227, "MARISIN DE L. VALDES AVILA", "F", "N", 0, 15, 68, 1, 1, 0, getdate(), "mdlval", null, 479,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 228, "MARISIN ARANGO HERRERA", "F", "N", 0, 21, 69, 1, 1, 0, getdate(), "maherrer", null, 10,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 229, "ROSA ISABEL ABRAHAMS", "F", "N", 0, 20, 70, 1, 1, 0, getdate(), "riabraha", null, 112,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 230, "CAROLINA GUTIERREZ", "F", "N", 0, 26, 71, 1, 1, 0, getdate(), "cgutierr", null, 577,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 231, "YANISELLY CUETO", "F", "N", 0, 12, 72, 1, 1, 0, getdate(), "yancueto", null, 1004,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 232, "YESENIA VARGAS VERGARA", "F", "N", 8, 39, 73, 1, 536, 0, getdate(), "yvvergar", null, 37,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 233, "MARIANELA REYNA MARTINEZ", "F", "N", 17, 39, 73, 1, 543, 0, getdate(), "mrmartin", null, 49,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 234, "ELVIRA MARIA DUNCAN AGUIRRE", "F", "N", 7, 39, 73, 1, 530, 0, getdate(), "emduncan", null, 59,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 235, "EDWIN JOEL HERRERA", "M", "N", 15, 39, 73, 1, 527, 0, getdate(), "ejherrer", null, 86,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 236, "BENJAMIN QUINTERO", "M", "N", 5, 39, 73, 1, 530, 0, getdate(), "bquinter", null, 197,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 237, "ANNABELLE G. CHIARI ORILLAC", "F", "N", 28, 39, 73, 1, 543, 0, getdate(), "agchiari", null, 251,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 238, "KATYA IVET POSCHL MANFREDO", "F", "N", 21, 39, 73, 1, 530, 0, getdate(), "kiposchl", null, 254,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 239, "SARA GRACIELA PEREZ MONTENEGRO", "F", "N", 2, 39, 73, 1, 502, 0, getdate(), "sagperez", null, 261,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 240, "JUAN ANTONIO GUEVARA", "M", "N", 3, 39, 73, 1, 536, 0, getdate(), "jaguevar", null, 274,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 241, "MARY ANN GUARDIA", "F", "N", 6, 39, 73, 1, 536, 0, getdate(), "maguardi", null, 297,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 242, "JUAN ALBERTO RODRIGUEZ", "M", "N", 9, 39, 73, 1, 536, 0, getdate(), "jarodrig", null, 330,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 243, "DAMARIS MARITZA AMAYA DELGADO", "F", "N", 18, 39, 73, 1, 536, 0, getdate(), "damamaya", null, 337,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 244, "ALEJANDRO E. SANCHEZ-GALAN", "M", "N", 29, 39, 73, 1, 1, 0, getdate(), "aesanche", null, 343,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 245, "OLIVIA HAYDEE PAREDES", "F", "N", 23, 39, 73, 1, 530, 0, getdate(), "ohparede", null, 356,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 246, "CASTA RAQUEL CARLES CASTILLO", "F", "N", 16, 39, 73, 1, 542, 0, getdate(), "crcarles", null, 367,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 247, "ODETTE GISELLE POSCHL GRIMALDO", "F", "N", 30, 39, 73, 1, 543, 0, getdate(), "ogposchl", null, 458,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 248, "NELSON GIOVANI", "M", "N", 12, 39, 73, 1, 542, 0, getdate(), "ngiovani", null, 501,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 249, "LOURDES IGLESIAS MARULANDA", "F", "N", 27, 39, 73, 1, 530, 0, getdate(), "limarula", null, 581,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 250, "MAUDY AMERICA SAIED OTHON", "F", "N", 1, 39, 73, 1, 543, 0, getdate(), "maasaied", null, 685,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 251, "FLOR DE MARIA MEDINA NUNEZ", "F", "N", 25, 39, 73, 1, 543, 0, getdate(), "fdmedina", null, 802,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 252, "ILLEANA FONT ORTIZ", "F", "N", 26, 39, 73, 1, 530, 0, getdate(), "ilfortiz", null, 823,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 253, "FRANCISCO VILLALOBOS", "M", "N", 13, 39, 73, 1, 542, 0, getdate(), "fvillalo", null, 891,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 254, "CINTHIA SANTAMARIA", "F", "N", 22, 39, 73, 1, 543, 0, getdate(), "csantama", null, 200,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 255, "ALEXIS C. GONZALEZ", "M", "N", 0, 12, 74, 1, 1, 0, getdate(), "acgonzal", null, 564,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 256, "LUIS CARLOS CASTILLERO", "M", "N", 0, 3, 75, 1, 1, 0, getdate(), "lccastil", null, 129,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 257, "HECTOR ALEXIS MADRID", "M", "N", 0, 10, 76, 1, 1, 0, getdate(), "hamadrid", null, 121,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 258, "ANDREI ANTONIO JUSTINIANI", "M", "N", 0, 10, 76, 2, 1, 0, getdate(), "aajustin", null, 137,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 259, "ERIC ALBERTO RODRIGUEZ", "M", "N", 9, 10, 76, 1, 1, 0, getdate(), "earodrig", null, 332,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 260, "CELSA MARIA SOLIS", "F", "N", 0, 10, 76, 3, 1, 0, getdate(), "cemsolis", null, 580,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 261, "LUIS BALTAZAR LAWSON", "M", "N", 7, 31, 76, 1, 1, 0, getdate(), "lblawson", null, 627,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 262, "MISAEL ANTONIO SOBERON", "M", "N", 2, 31, 76, 1, 1, 0, getdate(), "masobero", null, 636,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 263, "JULIA VARGAS", "F", "N", 0, 10, 76, 4, 1, 0, getdate(), "juvargas", null, 675,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 264, "MISAEL ANTONIO MENDIETA", "M", "N", 0, 38, 76, 1, 1, 0, getdate(), "mamendie", null, 858,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 265, "DORIS GARRIDO ESCUDERO", "F", "N", 0, 10, 76, 5, 1, 0, getdate(), "dgescude", null, 900,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 266, "IDAYRA MURGAS", "F", "N", 0, 10, 76, 6, 1, 0, getdate(), "idmurgas", null, 960,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 267, "JOVANA REYES", "F", "N", 0, 10, 76, 7, 1, 0, getdate(), "jovreyes", null, 976,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 268, "DIGNA RIVERA", "F", "N", 0, 10, 76, 8, 1, 0, getdate(), "dirivera", null, 1067,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 269, "LLENEIRA ESPINOSA", "F", "N", 0, 10, 76, 9, 1, 0, getdate(), "lespinos", null, 1072,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 270, "INGRID MARIA JOSE CAMPBELL", "F", "N", 47, 37, 77, 1, 1, 0, getdate(), "imjosec", null, 834,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 271, "ANGELA CRUZ", "F", "N", 47, 37, 77, 2, 1, 0, getdate(), "angecruz", null, 940,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 272, "NATALIA NOEMI HERRERA", "F", "N", 47, 37, 77, 3, 1, 0, getdate(), "nnherrer", null, 973,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 273, "JOSE MIGUEL YANEZ", "M", "N", 47, 37, 78, 1, 1, 0, getdate(), "jomyanez", null, 171,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 274, "ERIC AUGUSTO ORTEGA", "M", "N", 0, 10, 78, 10, 1, 0, getdate(), "eaortega", null, 454,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 275, "ARTURO MORALES", "M", "N", 0, 10, 78, 11, 1, 0, getdate(), "amorales", null, 631,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 276, "RODRIGO RODRIGUEZ", "M", "N", 47, 37, 78, 2, 1, 0, getdate(), "rodriguez", null, 721,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 277, "ERNESTO BARSALLO", "M", "N", 0, 21, 79, 1, 1, 0, getdate(), "ebarsall", null, 1063,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 278, "JOSE DE LA ROSA DOMINGUEZ", "M", "N", 0, 21, 79, 2, 1, 0, getdate(), "jdlaros", null, 1030,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 279, "DAYANARA E. JOHNSON", "F", "N", 0, 4, 80, 1, 1, 0, getdate(), "dejohnso", null, 124,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 280, "JOSE REYNIER CASTILLO", "M", "N", 0, 9, 81, 1, 1, 0, getdate(), "jrcastil", null, 178,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 281, "EDUVIGES VASQUEZ", "F", "N", 0, 24, 82, 1, 1, 0, getdate(), "evasquez", null, 168,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 282, "CRISTINA P. PEREZ VARGAS", "F", "N", 0, 14, 83, 1, 1, 0, getdate(), "crpperez", null, 154,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 283, "ROSA MARIA HIDROGO", "F", "N", 0, 28, 84, 1, 1, 0, getdate(), "rmhidrog", null, 986,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 284, "JORGE LUIS PEREZ", "M", "N", 0, 27, 85, 1, 1, 0, getdate(), "jolperez", null, 51,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 285, "ANDRES DEL C. CAMPOS", "M", "N", 0, 27, 85, 2, 1, 0, getdate(), "adccam", null, 111,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 286, "CESAR ALEXIS SAMANIEGO", "M", "N", 0, 27, 85, 3, 1, 0, getdate(), "casamani", null, 1113,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 287, "LAIRA MABEL GUERRA CORREA", "F", "N", 0, 13, 86, 1, 1, 0, getdate(), "lmguerra", null, 715,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 288, "KATHIA GISELA GALLIMORE", "F", "N", 0, 13, 86, 2, 1, 0, getdate(), "kggallim", null, 1032,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 289, "ANOUK AIMEE PENATE", "F", "N", 20, 34, 88, 1, 1, 0, getdate(), "aapenate", null, 559,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 290, "BEATRIZ RAMONA RIOS", "F", "N", 50, 31, 89, 1, 1, 0, getdate(), "bearrios", null, 114,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 291, "NOEL QUINTERO", "M", "N", 0, 10, 90, 1, 1, 0, getdate(), "nquinter", null, 90,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 292, "BLANCA NOEMI NIETO", "F", "N", 0, 10, 90, 2, 1, 0, getdate(), "blnnieto", null, 163,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 293, "EMILIA VILLARREAL JIMENEZ", "F", "N", 0, 10, 90, 3, 1, 0, getdate(), "evjimene", null, 452,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 294, "JOSE FELIX GOMEZ", "M", "N", 0, 19, 91, 1, 1, 0, getdate(), "jofgomez", null, 29,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 295, "LUIS ALBERTO GONZALEZ", "M", "N", 0, 27, 92, 1, 1, 0, getdate(), "lgonzale", null, 466,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 296, "RODERICK HENOC SALCEDO", "M", "N", 8, 31, 93, 1, 1, 0, getdate(), "rhsalced", null, 213,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 297, "REYNALDO MANUEL PAZ", "M", "N", 9, 31, 93, 1, 1, 0, getdate(), "reynmpaz", null, 806,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 298, "CARLOS GEOVANI GIBBS", "M", "N", 15, 31, 93, 1, 1, 0, getdate(), "caggibbs", null, 1089,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 299, "MODESTO ELIECER LEZCANO", "M", "N", 2, 31, 93, 1, 1, 0, getdate(), "melezcan", null, 1097,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 300, "ALEX LEONARDO YANGUEZ", "M", "N", 2, 31, 93, 2, 1, 0, getdate(), "alyangue", null, 719,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 301, "LUIS RUBEN SANTAMARIA", "M", "N", 45, 31, 94, 1, 526, 0, getdate(), "lrsantam", null, 1023,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 302, "LOURDES MARIELA GONZALEZ", "F", "N", 0, 38, 95, 1, 1, 0, getdate(), "lmgonzal", null, 87,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 303, "LOURDES DEL C. CABALLERO ROMAN", "F", "N", 9, 31, 96, 1, 1, 0, getdate(), "ldccab", null, 273,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 304, "KATHIA MINNETTE HIM", "F", "N", 15, 31, 96, 1, 530, 0, getdate(), "kathmhim", null, 293,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 305, "LILIA INDIRA MONTEZA", "F", "N", 6, 31, 96, 1, 241, 0, getdate(), "limontez", null, 298,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 306, "ZULEYKA YASMIN ZEBALLOS", "F", "N", 27, 31, 96, 1, 1, 0, getdate(), "zyzeball", null, 419,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 307, "JORGE LUIS ALFARO", "M", "N", 29, 31, 96, 1, 244, 0, getdate(), "jlalfaro", null, 554,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 308, "GISELA GONZALEZ", "F", "N", 23, 31, 96, 1, 1, 0, getdate(), "ggonzale", null, 589,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 309, "ARACELIS ENEIDA GONZALEZ", "F", "N", 21, 31, 96, 1, 1, 0, getdate(), "aergonza", null, 798,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 310, "EDUARDO ANTONIO MUNOZ", "M", "N", 3, 31, 96, 1, 1, 0, getdate(), "edamunoz", null, 890,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 311, "BOLIVAR VASQUEZ", "M", "N", 26, 31, 96, 1, 1, 0, getdate(), "bvasquez", null, 957,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 312, "YOLANDA CECILIA HERNANDEZ", "F", "N", 7, 31, 97, 1, 1, 0, getdate(), "ychernan", null, 217,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 313, "SHEILA P. HERRERA", "F", "N", 9, 31, 97, 1, 1, 0, getdate(), "spherrer", null, 333,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 314, "ALMA ITZEL MENDEZ HERNANDEZ", "F", "N", 12, 31, 97, 1, 1, 0, getdate(), "aimendez", null, 350,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 315, "YOVANY ESTHER HERNANDEZ HERRERA", "F", "N", 4, 33, 98, 1, 1, 0, getdate(), "yehernan", null, 187,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 316, "ESTEBAN CANTO", "M", "N", 0, 28, 99, 1, 1, 0, getdate(), "estcanto", null, 499,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 317, "RAUL ABEL SARMIENTO", "M", "N", 20, 33, 100, 1, 1, 0, getdate(), "rasarmie", null, 1106,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 318, "MANUEL GONZALEZ", "M", "N", 0, 35, 101, 1, 1, 0, getdate(), "mgonzale", null, 1014,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 319, "MARISEL QUIROS", "F", "N", 47, 37, 102, 1, 1, 0, getdate(), "maquiros", null, 797,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 320, "YURIKO UNO VILLARREAL", "F", "N", 0, 35, 103, 1, 1, 0, getdate(), "yuvillar", null, 509,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 321, "SHANIDA ISABEL BERNAL", "F", "N", 4, 33, 105, 1, 1, 0, getdate(), "sibernal", null, 289,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 322, "JULISSA LIZBETH CHANG", "F", "N", 0, 18, 106, 1, 1, 0, getdate(), "julchang", null, 130,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 323, "IVETTE ESTHER COHEN", "F", "N", 27, 29, 107, 1, 1, 0, getdate(), "ivecohen", null, 23,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 324, "MILCIADES APOLAYO", "M", "N", 1, 29, 107, 2, 1, 0, getdate(), "mapolayo", null, 36,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 325, "CAROLINA V. MARTINS", "F", "N", 7, 29, 107, 1, 1, 0, getdate(), "cvmartin", null, 50,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 326, "KATHYA EMILIA COCHEZ", "F", "N", 1, 29, 107, 3, 1, 0, getdate(), "kecochez", null, 58,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 327, "JUAN CARLOS SANCHEZ", "M", "N", 25, 29, 107, 1, 1, 0, getdate(), "jcsanche", null, 95,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 328, "ODERAY DIAZ", "F", "N", 23, 29, 107, 1, 1, 0, getdate(), "oderdiaz", null, 113,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 329, "MELZY SONIA ARAUZ", "F", "N", 21, 29, 107, 1, 1, 0, getdate(), "mesarauz", null, 120,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 330, "ZOILA MARIA DIAZ RAMPOLLA", "F", "N", 24, 29, 107, 1, 1, 0, getdate(), "zmdiazr", null, 135,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 331, "YALIDETH Y. GONZALEZ", "F", "N", 28, 29, 107, 1, 1, 0, getdate(), "yygonzal", null, 170,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 332, "BIONEL WIGBERTO DOMINGUEZ", "M", "N", 18, 29, 107, 1, 1, 0, getdate(), "bwdoming", null, 219,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 333, "MARIA ATENCIO MOSCOSO", "F", "N", 29, 29, 107, 1, 1, 0, getdate(), "mamoscos", null, 257,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 334, "GLORIA ALICIA ALMENGOR", "F", "N", 2, 29, 107, 1, 1, 0, getdate(), "gaalmeng", null, 263,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 335, "CAMILO OLIER TRONCOSO", "M", "N", 3, 29, 107, 1, 1, 0, getdate(), "cotronco", null, 279,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 336, "FANNY MARIBEL CASTRO", "F", "N", 5, 29, 107, 1, 1, 0, getdate(), "fmcastro", null, 294,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 337, "ISBEL ANETH SOLE", "F", "N", 6, 29, 107, 1, 1, 0, getdate(), "isbasole", null, 299,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 338, "ABNER ISAAC APOLAYO", "M", "N", 21, 29, 107, 2, 1, 0, getdate(), "aiapolay", null, 314,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 339, "RUBEN ALFONSO LAM", "M", "N", 8, 29, 107, 1, 1, 0, getdate(), "rubealam", null, 316,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 340, "MYRTA ONELIA SANCHEZ POLO", "F", "N", 9, 29, 107, 1, 1, 0, getdate(), "mosanche", null, 329,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 341, "JOSE FRANCISCO MUNOZ", "M", "N", 15, 29, 107, 1, 1, 0, getdate(), "jofmunoz", null, 345,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 342, "MARTIN ERADIO CABALLERO", "M", "N", 16, 29, 107, 1, 1, 0, getdate(), "mecaball", null, 365,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 343, "JAVIER ANTONIO SANCHEZ", "M", "N", 17, 29, 107, 1, 1, 0, getdate(), "jasanche", null, 465,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 344, "MARIO ALBERTO FIGUEROA", "M", "N", 22, 29, 107, 1, 1, 0, getdate(), "mafiguer", null, 468,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 345, "ANTONIO VELASCO", "M", "N", 19, 29, 107, 1, 1, 0, getdate(), "avelasco", null, 576,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 346, "YUSELFY YAHURIN ALVAREZ", "F", "N", 30, 29, 107, 1, 1, 0, getdate(), "yyalvare", null, 613,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 347, "ERICK DIONISIO ARAUZ", "M", "N", 12, 29, 107, 1, 1, 0, getdate(), "erdarauz", null, 645,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 348, "JUAN MIGUEL PAYARES", "M", "N", 26, 29, 107, 1, 1, 0, getdate(), "jmpayare", null, 659,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 349, "HAN YUEN WAN", "F", "N", 0, 21, 108, 1, 1, 0, getdate(), "hanyuwan", null, 110,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 350, "DALLYS FELICIA PEREZ TOVAR", "F", "N", 0, 21, 108, 2, 1, 0, getdate(), "daftovar", null, 578,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 351, "DOADY ZULEIKA RODRIGUEZ", "F", "N", 0, 23, 109, 1, 1, 0, getdate(), "dzrodrig", null, 9,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 352, "NADYUSKA ZULIMA PEREZ", "F", "N", 0, 16, 110, 1, 1, 0, getdate(), "nazperez", null, 203,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 353, "LUIS FERNANDO BARRAGAN", "M", "N", 0, 20, 111, 1, 1, 0, getdate(), "lfbarrag", null, 133,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 354, "WALTER LAND ARAUZ", "M", "N", 0, 15, 112, 1, 1, 0, getdate(), "walarauz", null, 142,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 355, "JULISSA EUGENIA CORREA", "F", "N", 21, 30, 113, 1, 1, 0, getdate(), "jecorrea", null, 253,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 356, "SUGEY YAMILET MORALES", "F", "N", 24, 30, 113, 1, 1, 0, getdate(), "symorale", null, 310,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 357, "TERESA E. LOPOLITO", "F", "N", 1, 30, 113, 1, 1, 0, getdate(), "telopoli", null, 445,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 358, "TOMAS GABRIEL PINEDA", "M", "N", 25, 31, 113, 1, 1, 0, getdate(), "tgpineda", null, 498,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 359, "JESKA YAMILETH KILLINGBECK", "F", "N", 20, 30, 113, 1, 1, 0, getdate(), "jykillin", null, 526,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 360, "LORENA IVETT BATISTA", "F", "N", 22, 31, 113, 1, 254, 0, getdate(), "libatist", null, 626,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 361, "MELISSA RUMIA", "F", "N", 30, 31, 113, 1, 247, 0, getdate(), "melrumia", null, 1034,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 362, "BERNA AROSEMENA DE DE LOS SANTO", "M", "N", 17, 31, 113, 1, 1, 0, getdate(), "badede", null, 197,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 363, "MICHELLE DEL C. BUSTAMANTE", "F", "N", 20, 30, 114, 1, 1, 0, getdate(), "mdcbus", null, 653,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 364, "JORGE ENRIQUE FORBES", "M", "N", 4, 33, 115, 1, 1, 0, getdate(), "jeforbes", null, 571,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 365, "ALEXIS ENRIQUE GARCIA", "M", "N", 0, 12, 116, 1, 1, 0, getdate(), "aegarcia", null, 469,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 366, "IVETTE GISELA CARDENAS", "F", "N", 47, 37, 117, 1, 1, 0, getdate(), "igcarden", null, 1111,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 367, "PABLO VACCARO", "M", "N", 1, 29, 107, 4, 1, 0, getdate(), "pvaccaro", null, 39,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 368, "DIANETH SALAZAR", "F", "N", 0, 2, 119, 1, 1, 0, getdate(), "dsalazar", null, 949,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 369, "JOHANNA KRISTEL MONTERO", "M", "N", 0, 4, 120, 1, 1, 0, getdate(), "jkmonter", null, 520,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 370, "VERONICA MARIA ECHAVERRY ACEVEDO", "F", "N", 0, 11, 122, 1, 1, 0, getdate(), "vmechave", null, 697,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 371, "ABDIEL ELOY ALVARADO", "M", "N", 0, 11, 122, 2, 1, 0, getdate(), "aealvara", null, 756,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 372, "MIREYA CHANIS", "F", "N", 0, 11, 122, 3, 1, 0, getdate(), "michanis", null, 887,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 373, "KIURENIA ARRIETA", "F", "N", 0, 11, 122, 4, 1, 0, getdate(), "karrieta", null, 952,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 374, "YADILKA VALDES", "F", "N", 0, 28, 123, 1, 1, 0, getdate(), "yavaldes", null, 988,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 375, "AYLEEN GRACIELA SUGAR", "F", "N", 20, 34, 124, 1, 1, 0, getdate(), "aygsugar", null, 765,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 376, "ROSALIA RODRIGUEZ", "F", "N", 20, 34, 124, 2, 1, 0, getdate(), "rrodrigu", null, 882,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 377, "KAREM MELENDEZ", "F", "N", 20, 34, 124, 3, 1, 0, getdate(), "kmelende", null, 931,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 378, "GILZA CORDOBA", "F", "N", 20, 34, 124, 4, 1, 0, getdate(), "gcordoba", null, 943,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 379, "INES VEGA", "F", "N", 20, 33, 124, 1, 1, 0, getdate(), "inesvega", null, 1040,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 380, "MINERVA E HERRERA", "F", "N", 20, 33, 124, 2, 1, 0, getdate(), "meherrer", null, 1059,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 381, "JONATHAN JAIR BATISTA", "M", "N", 20, 34, 124, 5, 1, 0, getdate(), "jjbatist", null, 1091,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 382, "BELISSA VANESSA GUIZADO", "F", "N", 20, 34, 124, 6, 1, 0, getdate(), "bvguizad", null, 1093,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 383, "MADELAINNE Z KAM", "F", "N", 20, 34, 124, 7, 1, 0, getdate(), "madezkam", null, 1094,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 384, "ANGIE MAHITSY RODRIGUEZ", "F", "N", 20, 34, 124, 8, 1, 0, getdate(), "amrodrig", null, 940,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 385, "KELLY ESTHER ARAUZ", "F", "N", 20, 34, 124, 9, 1, 0, getdate(), "keearauz", null, 563,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 386, "GUADALUPE DEL R RODRIGUEZ", "F", "N", 40, 7, 125, 1, 1, 0, getdate(), "gdrrodr", null, 1070,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 387, "ERIC RICARDO CASTILLO", "M", "N", 45, 31, 126, 1, 1, 0, getdate(), "ercastil", null, 1031,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 388, "DANIA VICTORIA GOMEZ", "F", "N", 3, 31, 127, 1, 1, 0, getdate(), "davgomez", null, 1038,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 389, "DIANA ROSA DIAZ", "F", "N", 15, 30, 128, 1, 1, 0, getdate(), "diardiaz", null, 363,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 390, "ERIC IVAN HERRERA", "M", "N", 1, 31, 128, 1, 1, 0, getdate(), "eiherrer", null, 615,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 391, "OSIRIS MARIELA MARTINEZ", "F", "N", 12, 31, 128, 1, 1, 0, getdate(), "ommartin", null, 709,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 392, "YOEL DAMIAN CHAVEZ", "M", "N", 23, 31, 128, 1, 1, 0, getdate(), "ydchavez", null, 860,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 393, "MELISSA DE LOS RIOS", "F", "N", 25, 31, 128, 1, 1, 0, getdate(), "mdlosri", null, 911,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 394, "JEANNETTE TORRAZZA", "F", "N", 28, 31, 128, 1, 1, 0, getdate(), "jtorrazz", null, 939,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 395, "MARIA CERDA", "F", "N", 13, 31, 128, 1, 1, 0, getdate(), "marcerda", null, 971,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 396, "NIDIA GLADYS HERRERA", "F", "N", 26, 31, 128, 1, 1, 0, getdate(), "ngherrer", null, 1087,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 397, "JANETH SALDANA", "F", "N", 12, 31, 128, 2, 1, 0, getdate(), "jsaldana", null, 928,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 398, "JESSICA DEL C. SAENZ", "F", "N", 4, 33, 129, 1, 1, 0, getdate(), "jdcsae", null, 731,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 399, "JULIO SEVILLANO", "F", "N", 4, 33, 129, 2, 1, 0, getdate(), "jsevilla", null, 1041,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 400, "MARILEN DEL C. DE LEON", "F", "N", 47, 37, 130, 1, 1, 0, getdate(), "mdcde", null, 507,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 401, "ORIS NADIA RODRIGUEZ GASCON", "M", "N", 0, 22, 131, 1, 1, 0, getdate(), "onrodrig", null, 204,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 402, "RICARDO GARCIA", "M", "N", 0, 22, 131, 2, 1, 0, getdate(), "rigarcia", null, 424,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 403, "RUFINO ANTONIO PIZARRO", "M", "N", 0, 22, 131, 3, 1, 0, getdate(), "rapizarr", null, 433,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 404, "ALBERTO CASTREJO", "M", "N", 0, 22, 131, 4, 1, 0, getdate(), "acastrej", null, 628,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 405, "JACKELINE JANET GUERRA", "F", "N", 0, 22, 131, 5, 1, 0, getdate(), "jjguerra", null, 634,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 406, "DALIS OLIVIA NAVARRO", "F", "N", 1, 29, 34, 1, 1, 0, getdate(), "donavarr", null, 710,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 407, "PATRICIA LORENA DE YCAZA", "M", "N", 0, 22, 131, 6, 1, 0, getdate(), "pldeyca", null, 764,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 408, "IVONNE OLACIREGUI", "F", "N", 1, 30, 131, 2, 1, 0, getdate(), "iolacire", null, 782,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 409, "ITZY DIDIETH RIVERA", "F", "N", 22, 30, 131, 1, 1, 0, getdate(), "idrivera", null, 786,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 410, "ARGELIS ALVAREZ MENDOZA", "F", "N", 0, 22, 131, 7, 1, 0, getdate(), "aamendoz", null, 807,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 411, "YOLANDA MENDOZA GONZALEZ", "F", "N", 0, 19, 131, 1, 1, 0, getdate(), "ymgonzal", null, 876,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 412, "ANA REBECA MORALES", "F", "N", 40, 18, 131, 1, 1, 0, getdate(), "armorale", null, 951,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 413, "ARIADNE CECILIA MONG", "F", "N", 40, 21, 131, 1, 1, 0, getdate(), "aricmong", null, 1006,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 414, "EIDYS ESPINO", "F", "N", 40, 21, 131, 2, 1, 0, getdate(), "eiespino", null, 1009,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 415, "LUIS RAMIREZ", "M", "N", 40, 4, 131, 1, 1, 0, getdate(), "lramirez", null, 1013,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 416, "YENY VALLEJO", "F", "N", 0, 57, 131, 1, 1, 0, getdate(), "yvallejo", null, 1015,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 417, "JENNIFER YAU", "F", "N", 0, 19, 131, 2, 1, 0, getdate(), "jenniyau", null, 1026,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 418, "ANGEE RAQUELL GONZALEZ", "F", "N", 40, 20, 131, 1, 1, 0, getdate(), "argonzal", null, 1055,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 419, "ESTEFANI CASASOLA", "M", "N", 40, 20, 131, 2, 1, 0, getdate(), "ecasasol", null, 1057,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 420, "KENIA ELIZABETH GONZALEZ", "F", "N", 0, 21, 131, 1, 1, 0, getdate(), "kegonzal", null, 1075,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 421, "LIZBETH JOANNA APARICIO", "F", "N", 40, 22, 131, 1, 1, 0, getdate(), "ljaparic", null, 1101,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 422, "RICARDO BOLIVAR JURADO", "M", "N", 0, 22, 131, 8, 1, 0, getdate(), "rbjurado", null, 1103,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 423, "HERENIA EDITH VACA", "F", "N", 0, 21, 131, 2, 1, 0, getdate(), "herevaca", null, 1108,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 424, "JESIKA IVETTE RIOS", "F", "N", 40, 23, 131, 1, 1, 0, getdate(), "jesirios", null, 1109,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 425, "CARLOS ESPINOZA", "F", "N", 0, 22, 131, 9, 1, 0, getdate(), "cespinoz", null, 1114,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 426, "EDGAR ENRIQUE AGURTO", "M", "N", 40, 19, 131, 1, 1, 0, getdate(), "eeagurto", null, 996,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 427, "CRISTINA MOREIRA", "F", "N", 0, 23, 132, 1, 1, 0, getdate(), "cmoreira", null, 932,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 428, "MICHELLE ARALIS RODRIGUEZ", "F", "N", 0, 23, 132, 2, 1, 0, getdate(), "marodrig", null, 1056,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 429, "GLORIA ESTELA CONCEPCION", "F", "N", 0, 21, 133, 1, 1, 0, getdate(), "geconcep", null, 149,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 430, "JESSICA ARGELIS GARIBALDO BARSALLO", "F", "N", 0, 21, 133, 2, 1, 0, getdate(), "jagariba", null, 195,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 431, "DAVID GONZALO SOLIS", "M", "N", 0, 21, 133, 3, 1, 0, getdate(), "dagsolis", null, 245,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 432, "XIAOMEI WU", "F", "N", 0, 36, 133, 1, 1, 0, getdate(), "xiaomewu", null, 637,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 433, "ZULEIKA EDID PEREA", "F", "N", 0, 21, 133, 4, 1, 0, getdate(), "zueperea", null, 740,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 434, "ROCIO EMILCE ISAACS", "F", "N", 0, 21, 133, 5, 1, 0, getdate(), "reisaacs", null, 742,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 435, "NADIA WILLIAMS", "F", "N", 0, 21, 133, 6, 1, 0, getdate(), "nwilliam", null, 885,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 436, "YANELLYS VILLANERO", "F", "N", 0, 21, 133, 7, 1, 0, getdate(), "yvillane", null, 922,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 437, "LIZETH CHIARI", "F", "N", 0, 21, 133, 8, 1, 0, getdate(), "lichiari", null, 993,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 438, "YERITZA MARIN", "F", "N", 0, 21, 133, 9, 1, 0, getdate(), "yermarin", null, 1065,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 439, "KARINA CECILIA BARRIOS", "F", "N", 0, 21, 133, 10, 1, 0, getdate(), "kcbarrio", null, 1092,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 440, "MARVIN MONTENEGRO", "M", "N", 0, 21, 133, 11, 1, 0, getdate(), "mmontene", null, 534,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 441, "JAVIER ARTURO LEVINE", "M", "N", 0, 16, 134, 1, 1, 0, getdate(), "jalevine", null, 523,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 442, "DENIS EDITH RODRIGUEZ", "F", "N", 0, 16, 134, 2, 1, 0, getdate(), "derodrig", null, 704,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 443, "JOYCE SHANTELL ANDRADE", "F", "N", 0, 16, 134, 3, 1, 0, getdate(), "jsandrad", null, 780,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 444, "DORIS POVEDA", "F", "N", 0, 16, 134, 4, 1, 0, getdate(), "dopoveda", null, 996,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 445, "JEANNE DEL C. ALVAREZ", "F", "N", 0, 20, 135, 1, 1, 0, getdate(), "jdcalv", null, 601,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 446, "GLORIA MERCEDES VEGA", "F", "N", 0, 18, 136, 1, 1, 0, getdate(), "glomvega", null, 431,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 447, "CHARLENE ITZEL ORTEGA", "F", "N", 0, 18, 137, 1, 1, 0, getdate(), "ciortega", null, 200,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 448, "LIZBETH AMALIA DAVIDSON", "F", "N", 26, 30, 138, 1, 1, 0, getdate(), "ladavids", null, 179,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 449, "ESTELVIA DEL C. CASTILLO", "F", "N", 8, 30, 138, 1, 1, 0, getdate(), "edccas", null, 323,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 450, "ANABEL CASTILLO", "F", "N", 8, 30, 138, 2, 1, 0, getdate(), "ancastill", null, 325,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 451, "RUBY EMILIA MULINO RAMIREZ", "F", "N", 12, 30, 138, 1, 1, 0, getdate(), "remulino", null, 347,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 452, "YANELA MAYTE TEJADA", "F", "N", 5, 30, 138, 1, 1, 0, getdate(), "ymtejada", null, 492,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 453, "MARUQUEL A. RIERA", "F", "N", 19, 30, 138, 2, 1, 0, getdate(), "maariera", null, 534,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 454, "XIOMARA L. ANTUNEZ", "F", "N", 7, 30, 138, 1, 1, 0, getdate(), "xlantune", null, 536,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 455, "JILMA ELIZABETH BATISTA", "F", "N", 9, 30, 138, 1, 1, 0, getdate(), "jebatist", null, 651,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 456, "NELVIS MARLENIS MELGAR", "F", "N", 2, 30, 138, 1, 1, 0, getdate(), "nmmelgar", null, 855,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 457, "JESSICA IVONNE BAQUE", "F", "N", 23, 30, 138, 1, 1, 0, getdate(), "jeibaque", null, 863,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 458, "ZENAIDA MARTINEZ", "F", "N", 13, 30, 138, 1, 1, 0, getdate(), "zmartine", null, 867,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 459, "SILKA MARISSA ESPINO", "F", "N", 18, 30, 138, 1, 1, 0, getdate(), "smespino", null, 878,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 460, "DELIA SANCHEZ", "F", "N", 24, 31, 138, 1, 1, 0, getdate(), "dsanchez", null, 881,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 461, "ANA MARIA BATISTA", "F", "N", 3, 30, 138, 1, 1, 0, getdate(), "ambatist", null, 959,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 462, "MEYLIN CHAN", "F", "N", 27, 32, 138, 1, 1, 0, getdate(), "meylchan", null, 1000,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 463, "CARMEN TERESA DEJUD", "F", "N", 16, 30, 138, 1, 1, 0, getdate(), "catdejud", null, 1077,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 464, "FUNG YING CHUNG", "F", "N", 15, 30, 138, 1, 1, 0, getdate(), "fuychung", null, 1086,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 465, "MICHELLE DENISE GRIMALDO", "F", "N", 7, 30, 138, 2, 1, 0, getdate(), "mdgrimal", null, 1112,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 466, "YANUZEY DEL C. GONZALEZ", "F", "N", 20, 33, 139, 1, 1, 0, getdate(), "ydcgon", null, 537,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 467, "MARNIE NEREIDA CORDOBA", "F", "N", 20, 34, 139, 1, 1, 0, getdate(), "mncordob", null, 743,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 468, "MARIANELA ARANGO ROMERO", "F", "N", 30, 31, 139, 1, 1, 0, getdate(), "maromero", null, 751,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 469, "FARAH PORTUGAL", "F", "N", 20, 30, 139, 1, 1, 0, getdate(), "fportuga", null, 950,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 470, "YENITZA LIZBETH BETHANCOURT", "F", "N", 20, 33, 139, 2, 1, 0, getdate(), "ylbethan", null, 977,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 471, "YENISTER FRANCO", "F", "N", 0, 26, 140, 1, 1, 0, getdate(), "yefranco", null, 910,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 472, "KEYRA AGUILAR", "F", "N", 40, 26, 140, 1, 1, 0, getdate(), "kaguilar", null, 1008,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 473, "SHARON CHRIS GONZALEZ", "F", "N", 40, 26, 140, 2, 1, 0, getdate(), "scgonzal", null, 1017,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 474, "BERTALIA URIBE", "F", "N", 40, 26, 140, 3, 1, 0, getdate(), "beruribe", null, 1039,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 475, "EYMINE AYASSEL GUERRA", "F", "N", 40, 26, 140, 4, 1, 0, getdate(), "eaguerra", null, 1042,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 476, "MANUEL DE GRACIA", "M", "N", 0, 26, 140, 2, 1, 0, getdate(), "magracia", null, 894,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 477, "SANTIAGO RODRIGUEZ", "M", "N", 4, 33, 141, 1, 1, 0, getdate(), "srodrigu", null, 801,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 478, "NAIR ARELIS PINZON", "F", "N", 4, 33, 141, 2, 1, 0, getdate(), "napinzon", null, 1061,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 479, "RAUL ADOLFO LABRADOR", "M", "N", 0, 12, 142, 1, 1, 0, getdate(), "ralabrad", null, 661,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 480, "EDILBERTO TAPIERO", "M", "N", 0, 12, 142, 2, 1, 0, getdate(), "etapiero", null, 777,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 481, "SERGIO CORTEZ", "M", "N", 0, 12, 142, 3, 1, 0, getdate(), "secortez", null, 980,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 482, "CARMEN LAW", "F", "N", 7, 30, 143, 1, 1, 0, getdate(), "carmelaw", null, 983,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 483, "NELSON CHAN", "M", "N", 26, 30, 143, 1, 1, 0, getdate(), "nelschan", null, 1080,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 484, "VANESSA YORLETH LARA", "F", "N", 0, 4, 144, 1, 1, 0, getdate(), "vanylara", null, 664,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 485, "GISSELLE CAMANO", "F", "N", 0, 4, 144, 2, 1, 0, getdate(), "gicamano", null, 830,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 486, "RAYSA MILENA ITURRALDE", "F", "N", 22, 30, 144, 1, 1, 0, getdate(), "rmiturra", null, 877,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 487, "YALIZ NICOLE VELAZQUEZ", "F", "N", 20, 34, 144, 1, 1, 0, getdate(), "ynvelazq", null, 1095,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 488, "BLEXY NIETO RODRIGUEZ", "F", "N", 1, 30, 144, 1, 1, 0, getdate(), "bnrodrig", null, 1012,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 489, "GEOVANA IVETH BUENDIA", "F", "N", 0, 11, 146, 1, 1, 0, getdate(), "gibuendi", null, 981,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 490, "TAMARA NADJA GONZALEZ UCROS", "F", "N", 45, 31, 147, 1, 1, 0, getdate(), "tngonzal", null, 574,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 491, "SUSANA DE PUY TORRES", "F", "N", 47, 37, 148, 1, 1, 0, getdate(), "sdpuyto", null, 967,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 492, "MIRNA ITZEL SERRANO", "F", "N", 40, 12, 148, 1, 1, 0, getdate(), "miserran", null, 1076,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 493, "LUIS ALBERTO SANCHEZ", "M", "N", 0, 12, 150, 1, 1, 0, getdate(), "lasanche", null, 641,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 494, "GUILLERMO TEJADA", "M", "N", 0, 12, 150, 2, 1, 0, getdate(), "gutejada", null, 687,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 495, "GERARDO ANTONIO GUANTI", "M", "N", 0, 12, 150, 3, 1, 0, getdate(), "gaguanti", null, 688,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 496, "JULIO MENACHO", "M", "N", 0, 12, 150, 4, 1, 0, getdate(), "jmenacho", null, 723,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 497, "ADOLFO OMAR CALDERON", "M", "N", 0, 12, 150, 5, 1, 0, getdate(), "aocalder", null, 809,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 498, "RAQUEL ELENA MELENDEZ", "F", "N", 0, 12, 150, 6, 1, 0, getdate(), "remelend", null, 896,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 499, "FRANCISCO CRUZ", "M", "N", 0, 12, 150, 7, 1, 0, getdate(), "francruz", null, 915,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 500, "DENIS CASTILLO", "M", "N", 40, 12, 150, 1, 1, 0, getdate(), "dcastill", null, 1046,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 501, "ALVARO ENRIQUE ECHEVERRIA", "M", "N", 0, 12, 150, 8, 1, 0, getdate(), "aeecheve", null, 1060,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 502, "FRANK SANTANA", "M", "N", 0, 12, 151, 1, 1, 0, getdate(), "fsantana", null, 916,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 503, "DANERYS ENITH GONZALEZ", "F", "N", 0, 12, 151, 2, 1, 0, getdate(), "degonzal", null, 1047,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 504, "MARIA DEL PILAR DE GRACIA JAEN", "F", "N", 0, 13, 152, 1, 1, 0, getdate(), "mdgracia", null, 530,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 505, "FELIX ANTONIO GOMEZ", "M", "N", 0, 26, 153, 1, 1, 0, getdate(), "feagomez", null, 903,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 506, "JORGE LUIS SANJUR", "M", "N", 0, 6, 154, 1, 1, 0, getdate(), "jlsanjur", null, 595,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 507, "FANITA CARLES VIGNA", "F", "N", 24, 39, 155, 1, 543, 0, getdate(), "facvigna", null, 242,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 508, "JOAQUIN RODRIGUEZ", "M", "N", 0, 5, 156, 1, 1, 0, getdate(), "jrodrigu", null, 1058,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 509, "INDRA TAMARA ORTEGA", "F", "N", 0, 7, 157, 1, 1, 0, getdate(), "itortega", null, 460,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 510, "JADDE MITZY NAVARRETE REYES", "F", "N", 0, 22, 158, 1, 1, 0, getdate(), "jmnavarr", null, 71,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 511, "ABEL HERRERA", "M", "N", 0, 35, 159, 1, 1, 0, getdate(), "aherrera", null, 821,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 512, "BETZY LINETH URRIBARRI MORENO", "F", "N", 0, 2, 160, 1, 1, 0, getdate(), "blurriba", null, 6,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 513, "ALEJANDRO MELO", "M", "N", 0, 8, 161, 1, 1, 0, getdate(), "alejmelo", null, 593,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 514, "ELIDIA LINELIS SAAVEDRA", "F", "N", 7, 31, 162, 1, 234, 0, getdate(), "elsaaved", null, 45,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 515, "MARTA CECILIA CARNEY", "F", "N", 1, 30, 162, 1, 250, 0, getdate(), "mccarney", null, 146,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 516, "MAYLENE C. ALTUNA", "F", "N", 2, 31, 162, 1, 239, 0, getdate(), "mcaltuna", null, 169,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 517, "ELMA CELESTE ESPINO ALBEROLA", "F", "N", 17, 31, 162, 1, 233, 0, getdate(), "ecespino", null, 1048,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 518, "INDIRA MARISOL MUNOZ", "F", "N", 0, 9, 163, 1, 1, 0, getdate(), "inmmunoz", null, 514,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 519, "ISOLINA BATISTA RAMIREZ", "F", "N", 20, 34, 164, 1, 1, 0, getdate(), "ibramire", null, 718,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 520, "ANDY SANJUR", "M", "N", 47, 37, 165, 1, 1, 0, getdate(), "ansanjur", null, 62,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 521, "HILDAURA SUAZO APARICIO", "F", "N", 0, 21, 166, 1, 1, 0, getdate(), "hsaparic", null, 109,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 522, "ANAYANSI DIAZ", "F", "N", 0, 21, 166, 2, 1, 0, getdate(), "anaydiaz", null, 548,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 523, "YORDANA ITZEL ORTEGA MORA", "F", "N", 4, 33, 167, 1, 1, 0, getdate(), "yiortega", null, 603,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 524, "YANITSI E. PALACIOS", "F", "N", 0, 26, 168, 1, 1, 0, getdate(), "yepalaci", null, 690,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 525, "LUPO GONZALEZ", "M", "N", 0, 27, 169, 1, 1, 0, getdate(), "lupozale", null, 20,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 526, "RICCARDO FRANCOLINI", "M", "N", 45, 31, 170, 1, 527, 0, getdate(), "rfrancol", null, 21,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 527, "OTTO OSWALD WOLFSCHOON", "M", "N", 0, 25, 171, 1, 226, 0, getdate(), "oowolfsc", null, 14,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 528, "DARIO ERNESTO BERBEY DE LA RO", "M", "N", 0, 5, 171, 1, 1, 0, getdate(), "deberbey", null, 508,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 529, "MARIANELA GARCIA", "F", "N", 0, 15, 172, 1, 1, 0, getdate(), "magarcia", null, 7,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 530, "OSVALDO BORRELL", "M", "N", 7, 40, 173, 1, 527, 0, getdate(), "oborrell", null, 97,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 531, "MIGUEL ANGEL GASCON", "M", "N", 0, 12, 174, 1, 1, 0, getdate(), "magascon", null, 5,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 532, "JORGE ENRIQUE JAEN", "M", "N", 0, 9, 175, 1, 1, 0, getdate(), "jorejaen", null, 438,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 533, "HERNAN H. HERNANDEZ", "M", "N", 0, 28, 176, 1, 1, 0, getdate(), "hhhernan", null, 650,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 534, "BETZAIDA ARELIS RODRIGUEZ DELGADO", "F", "N", 45, 31, 177, 1, 527, 0, getdate(), "barodrig", null, 407,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 535, "DEMETRIO SERRACIN", "M", "N", 45, 31, 177, 2, 1, 0, getdate(), "dserraci", null, 410,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 536, "ROGER ESTEBAN CASTILLERO", "M", "N", 0, 38, 178, 1, 527, 0, getdate(), "recastil", null, 516,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 537, "NURI GISELA Q. DE SOSA", "F", "N", 0, 60, 179, 1, 1, 0, getdate(), "nurgsosa", null, 902,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 538, "MARCIAL MANUEL DIAZ", "M", "N", 50, 31, 180, 1, 527, 0, getdate(), "marmdiaz", null, 35,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 539, "ANA MARIA GARCIA", "F", "N", 4, 33, 181, 1, 1, 0, getdate(), "amgarcia", null, 286,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 540, "RICARDO GAGO", "M", "N", 20, 33, 182, 1, 1, 0, getdate(), "ricagago", null, 139,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 541, "IRENE PEDRESCHI CHANIS", "F", "N", 0, 2, 183, 1, 1, 0, getdate(), "ipchanis", null, 812,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 542, "ERICK DOMINGO LEZCANO", "M", "N", 2, 40, 184, 1, 527, 0, getdate(), "edlezcan", null, 260,"V", "ZxZ@p0D{" )
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero,fu_oficina,fu_departamento, fu_cargo, fu_secuencial,fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave) values ( 543, "ALFONSO GUEVARA", "M", "N", 0, 40, 173, 1, 527, 0, getdate(), "aguevara", null, 1000,"V", "ZxZ@p0D{" )
go

update	cl_seqnos
set	siguiente = 543
where 	tabla = "cl_funcionario"
go

go
/************************************************************************/
print "cl_distributivo"
/************************************************************************/
go



update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 1 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 2 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 3 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 4 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 5 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 6 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 7 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 7 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 8 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 9 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 10 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 11 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 12 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 13 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 13 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 13 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 13 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 5 and ds_cargo = 13 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 1 and ds_cargo = 14 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 15 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 15 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 15 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 15 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 15 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 9 and ds_cargo = 15 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 16 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 16 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 16 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 27 and ds_cargo = 16 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 16 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 27 and ds_cargo = 16 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 17 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 60 and ds_cargo = 18 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 50 and ds_departamento = 31 and ds_cargo = 19 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 50 and ds_departamento = 31 and ds_cargo = 19 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 6 and ds_cargo = 20 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 6 and ds_cargo = 20 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 20 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 21 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 21 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 22 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 22 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 22 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 22 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 22 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 38 and ds_cargo = 22 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 32 and ds_cargo = 23 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 31 and ds_cargo = 23 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 30 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 30 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 30 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 29 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 30 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 31 and ds_cargo = 24 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 25 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 26 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 4 and ds_cargo = 27 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 5 and ds_cargo = 28 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 5 and ds_cargo = 29 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 7 and ds_cargo = 30 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 31 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 32 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 32 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 32 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 32 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 33 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 29 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 20 and ds_cargo = 33 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 29 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 29 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 29 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 29 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 32 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 20 and ds_cargo = 33 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 31 and ds_cargo = 35 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 31 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 16 and ds_departamento = 31 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 29 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 32 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 31 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 32 and ds_cargo = 35 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 30 and ds_cargo = 35 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 36 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 37 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 38 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 35 and ds_cargo = 39 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 41 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 41 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 28 and ds_cargo = 42 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 3 and ds_cargo = 44 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 45 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 90 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 24 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 29 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 16 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 48 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 48 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 21 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 30 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 30 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 16 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 32 and ds_cargo = 46 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 31 and ds_cargo = 46 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 47 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 48 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 49 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 50 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 51 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 7 and ds_cargo = 52 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 7 and ds_cargo = 52 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 53 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 53 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 54 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 25 and ds_cargo = 55 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 25 and ds_cargo = 55 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 56 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 56 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 56 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 56 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 56 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 38 and ds_cargo = 56 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 57 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 57 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 4 and ds_cargo = 58 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 35 and ds_cargo = 59 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 50 and ds_departamento = 31 and ds_cargo = 59 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 61 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 62 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 31 and ds_cargo = 63 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 39 and ds_cargo = 63 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 64 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 64 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 64 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 31 and ds_cargo = 65 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 66 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 1 and ds_cargo = 67 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 15 and ds_cargo = 68 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 69 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 20 and ds_cargo = 70 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 71 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 72 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 28 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 21 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 29 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 16 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 39 and ds_cargo = 73 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 74 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 3 and ds_cargo = 75 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 31 and ds_cargo = 76 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 76 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 38 and ds_cargo = 76 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 7
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 8
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 76 and ds_secuencial = 9
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 77 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 77 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 77 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 78 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 78 and ds_secuencial = 10
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 78 and ds_secuencial = 11
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 78 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 79 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 79 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 4 and ds_cargo = 80 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 81 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 24 and ds_cargo = 82 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 14 and ds_cargo = 83 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 28 and ds_cargo = 84 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 85 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 85 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 85 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 13 and ds_cargo = 86 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 13 and ds_cargo = 86 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 88 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 50 and ds_departamento = 31 and ds_cargo = 89 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 90 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 90 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 10 and ds_cargo = 90 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 19 and ds_cargo = 91 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 92 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 31 and ds_cargo = 93 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 31 and ds_cargo = 93 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 31 and ds_cargo = 93 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 93 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 93 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 94 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 38 and ds_cargo = 95 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 29 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 21 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 31 and ds_cargo = 96 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 31 and ds_cargo = 97 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 31 and ds_cargo = 97 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 31 and ds_cargo = 97 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 98 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 28 and ds_cargo = 99 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 100 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 35 and ds_cargo = 101 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 102 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 35 and ds_cargo = 103 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 105 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 18 and ds_cargo = 106 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 21 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 24 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 28 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 29 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 6 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 21 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 16 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 108 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 108 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 23 and ds_cargo = 109 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 16 and ds_cargo = 110 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 20 and ds_cargo = 111 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 15 and ds_cargo = 112 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 21 and ds_departamento = 30 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 24 and ds_departamento = 30 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 30 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 31 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 31 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 31 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 31 and ds_cargo = 113 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 114 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 115 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 116 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 117 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 29 and ds_cargo = 107 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 119 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 4 and ds_cargo = 120 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 122 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 122 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 122 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 122 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 28 and ds_cargo = 123 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 124 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 124 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 7
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 8
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 124 and ds_secuencial = 9
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 7 and ds_cargo = 125 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 126 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 31 and ds_cargo = 127 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 30 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 25 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 28 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 31 and ds_cargo = 128 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 129 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 129 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 130 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 29 and ds_cargo = 34 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 30 and ds_cargo = 131 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 30 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 7
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 19 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 18 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 21 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 21 and ds_cargo = 131 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 4 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 57 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 19 and ds_cargo = 131 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 20 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 20 and ds_cargo = 131 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 8
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 131 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 23 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 131 and ds_secuencial = 9
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 19 and ds_cargo = 131 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 23 and ds_cargo = 132 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 23 and ds_cargo = 132 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 36 and ds_cargo = 133 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 7
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 8
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 9
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 10
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 133 and ds_secuencial = 11
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 16 and ds_cargo = 134 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 16 and ds_cargo = 134 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 16 and ds_cargo = 134 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 16 and ds_cargo = 134 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 20 and ds_cargo = 135 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 18 and ds_cargo = 136 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 18 and ds_cargo = 137 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 8 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 12 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 5 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 19 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 9 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 23 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 13 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 18 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 24 and ds_departamento = 31 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 3 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 27 and ds_departamento = 32 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 16 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 15 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 30 and ds_cargo = 138 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 139 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 139 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 30 and ds_departamento = 31 and ds_cargo = 139 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 30 and ds_cargo = 139 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 139 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 140 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 26 and ds_cargo = 140 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 26 and ds_cargo = 140 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 26 and ds_cargo = 140 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 26 and ds_cargo = 140 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 140 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 141 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 141 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 142 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 142 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 142 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 30 and ds_cargo = 143 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 26 and ds_departamento = 30 and ds_cargo = 143 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 4 and ds_cargo = 144 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 4 and ds_cargo = 144 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 22 and ds_departamento = 30 and ds_cargo = 144 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 144 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 30 and ds_cargo = 144 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 11 and ds_cargo = 146 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 147 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 148 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 148 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 3
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 4
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 5
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 6
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 7
update cl_distributivo set ds_vacante = "N" where ds_oficina = 40 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 150 and ds_secuencial = 8
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 151 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 151 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 13 and ds_cargo = 152 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 153 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 6 and ds_cargo = 154 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 24 and ds_departamento = 39 and ds_cargo = 155 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 5 and ds_cargo = 156 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 7 and ds_cargo = 157 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 22 and ds_cargo = 158 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 35 and ds_cargo = 159 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 160 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 8 and ds_cargo = 161 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 31 and ds_cargo = 162 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 1 and ds_departamento = 30 and ds_cargo = 162 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 31 and ds_cargo = 162 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 17 and ds_departamento = 31 and ds_cargo = 162 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 163 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 34 and ds_cargo = 164 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 47 and ds_departamento = 37 and ds_cargo = 165 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 166 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 21 and ds_cargo = 166 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 167 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 26 and ds_cargo = 168 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 27 and ds_cargo = 169 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 170 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 25 and ds_cargo = 171 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 5 and ds_cargo = 171 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 15 and ds_cargo = 172 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 7 and ds_departamento = 40 and ds_cargo = 173 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 12 and ds_cargo = 174 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 9 and ds_cargo = 175 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 28 and ds_cargo = 176 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 177 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 45 and ds_departamento = 31 and ds_cargo = 177 and ds_secuencial = 2
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 38 and ds_cargo = 178 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 60 and ds_cargo = 179 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 50 and ds_departamento = 31 and ds_cargo = 180 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 4 and ds_departamento = 33 and ds_cargo = 181 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 20 and ds_departamento = 33 and ds_cargo = 182 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 2 and ds_cargo = 183 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 2 and ds_departamento = 40 and ds_cargo = 184 and ds_secuencial = 1
update cl_distributivo set ds_vacante = "N" where ds_oficina = 0 and ds_departamento = 40 and ds_cargo = 173 and ds_secuencial = 1
go




/************************************************************************/
print "cl_dis_seqnos"
/************************************************************************/
go
truncate table cl_dis_seqnos
go
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 1, 14, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 1, 67, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 2, 9, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 2, 41, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 2, 49, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 2, 119, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 2, 160, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 2, 183, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 3, 44, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 3, 75, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 4, 27, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 4, 58, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 4, 80, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 4, 120, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 4, 144, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 5, 28, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 5, 29, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 5, 156, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 5, 171, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 6, 20, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 6, 154, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 40, 173, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 7, 30, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 7, 52, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 7, 157, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 8, 161, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 9, 5, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 9, 6, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 9, 15, 6 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 9, 81, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 9, 163, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 9, 175, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 10, 62, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 10, 76, 10 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 10, 78, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 10, 90, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 11, 1, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 11, 2, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 11, 11, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 11, 122, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 11, 146, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 3, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 4, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 8, 7 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 10, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 13, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 48, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 54, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 66, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 72, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 74, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 116, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 142, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 150, 9 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 151, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 12, 174, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 13, 86, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 13, 152, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 14, 83, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 15, 68, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 15, 112, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 15, 172, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 16, 110, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 16, 134, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 18, 106, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 18, 136, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 18, 137, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 19, 91, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 19, 131, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 20, 70, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 20, 111, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 20, 135, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 32, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 69, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 79, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 108, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 131, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 133, 12 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 21, 166, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 22, 33, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 22, 131, 10 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 22, 158, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 23, 109, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 23, 132, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 24, 82, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 25, 55, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 25, 171, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 26, 7, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 26, 71, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 26, 140, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 26, 153, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 26, 168, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 12, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 16, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 21, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 45, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 85, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 92, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 27, 169, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 28, 42, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 28, 84, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 28, 99, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 28, 123, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 28, 176, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 35, 39, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 35, 59, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 35, 101, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 35, 103, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 35, 159, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 36, 133, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 38, 22, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 38, 56, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 38, 76, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 38, 95, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 38, 178, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 57, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 60, 18, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 60, 179, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 0, 90, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 29, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 29, 107, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 30, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 30, 131, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 30, 144, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 30, 162, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 31, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 32, 35, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 32, 46, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 1, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 29, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 31, 23, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 31, 24, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 31, 76, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 31, 93, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 31, 162, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 32, 46, 7 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 2, 40, 184, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 29, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 30, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 31, 127, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 3, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 25, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 31, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 36, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 38, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 98, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 105, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 115, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 129, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 141, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 167, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 4, 33, 181, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 5, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 5, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 5, 31, 23, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 5, 32, 46, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 5, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 6, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 6, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 6, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 6, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 6, 32, 46, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 6, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 30, 138, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 30, 143, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 31, 23, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 31, 63, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 31, 76, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 31, 97, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 31, 162, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 7, 40, 173, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 29, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 30, 138, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 31, 23, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 31, 93, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 8, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 10, 76, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 29, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 30, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 31, 93, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 31, 97, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 9, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 12, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 12, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 12, 31, 97, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 12, 31, 128, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 12, 32, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 12, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 13, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 13, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 13, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 13, 31, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 13, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 13, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 30, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 31, 23, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 31, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 31, 93, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 32, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 15, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 16, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 16, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 16, 31, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 16, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 16, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 31, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 31, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 31, 162, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 32, 46, 7 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 17, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 31, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 32, 23, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 18, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 19, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 19, 30, 138, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 19, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 19, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 19, 39, 63, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 30, 53, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 30, 56, 6 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 30, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 30, 114, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 33, 51, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 33, 61, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 33, 100, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 33, 124, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 33, 139, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 33, 182, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 17, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 37, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 53, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 88, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 124, 10 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 139, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 144, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 20, 34, 164, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 21, 29, 107, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 21, 30, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 21, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 21, 32, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 21, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 30, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 30, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 30, 144, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 31, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 22, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 23, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 23, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 23, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 23, 31, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 23, 32, 46, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 23, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 24, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 24, 30, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 24, 31, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 24, 32, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 24, 39, 155, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 29, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 31, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 31, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 32, 46, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 25, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 30, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 30, 143, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 31, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 32, 46, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 26, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 27, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 27, 30, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 27, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 27, 32, 46, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 27, 32, 138, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 27, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 28, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 28, 31, 128, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 28, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 29, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 29, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 29, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 29, 31, 96, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 29, 32, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 29, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 29, 107, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 31, 24, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 31, 139, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 31, 65, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 31, 113, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 32, 34, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 32, 46, 6 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 30, 39, 73, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 22, 6 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 26, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 64, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 94, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 126, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 147, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 170, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 45, 31, 177, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 4, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 7, 125, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 9, 15, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 12, 8, 7 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 12, 50, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 12, 148, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 12, 150, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 18, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 19, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 20, 33, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 20, 131, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 21, 131, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 22, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 23, 131, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 26, 140, 5 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 27, 16, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 40, 30, 35, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 13, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 20, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 47, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 57, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 77, 4 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 78, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 102, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 117, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 130, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 148, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 47, 37, 165, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 48, 32, 46, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 50, 31, 19, 3 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 50, 31, 59, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 50, 31, 89, 2 )
insert into cl_dis_seqnos (dq_oficina,dq_departamento,dq_cargo, dq_siguiente) values ( 50, 31, 180, 2 )
go

/************************************************************************/
print "ad_nodo"
/************************************************************************/
go
truncate table ad_nodo
go

insert into ad_nodo values (0,'AIX','RS6000','1','00-00000',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (1,'IBM','REGATE 630','1','00-00001',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (2,'IBM','REGATE 630','1','00-00002',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (3,'IBM','REGATE 630','1','00-00003',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (4,'IBM','REGATE 630','1','00-00004',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (5,'IBM','REGATE 630','1','00-00005',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (6,'IBM','REGATE 630','1','00-00006',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (7,'IBM','REGATE 630','1','00-00007',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (8,'IBM','REGATE 630','1','00-00008',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (9,'IBM','REGATE 630','1','00-00009',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (10,'IBM','REGATE 630','1','00-00010',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (11,'IBM','REGATE 630','1','00-00011',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (12,'IBM','REGATE 630','1','00-00012',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (13,'IBM','REGATE 630','1','00-00013',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (14,'IBM','REGATE 630','1','00-00014',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (15,'IBM','REGATE 630','1','00-00015',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (16,'IBM','REGATE 630','1','00-00016',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (17,'IBM','REGATE 630','1','00-00017',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (18,'IBM','REGATE 630','1','00-00018',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (19,'IBM','REGATE 630','1','00-00019',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (20,'IBM','REGATE 630','1','00-00020',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (21,'IBM','REGATE 630','1','00-00021',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (22,'IBM','REGATE 630','1','00-00022',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (23,'IBM','REGATE 630','1','00-00023',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (24,'IBM','REGATE 630','1','00-00024',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (25,'IBM','REGATE 630','1','00-00025',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (26,'IBM','REGATE 630','1','00-00026',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (27,'IBM','REGATE 630','1','00-00027',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (28,'IBM','REGATE 630','1','00-00028',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (29,'IBM','REGATE 630','1','00-00029',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (30,'IBM','REGATE 630','1','00-00030',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (31,'IBM','REGATE 630','1','00-00031',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (32,'IBM','REGATE 630','1','00-00032',getdate(),getdate(),1,1,'V',getdate())
insert into ad_nodo values (33,'IBM','REGATE 630','1','00-00033',getdate(),getdate(),1,1,'V',getdate())
go

update cl_seqnos set siguiente=33 where tabla='ad_nodo'
go

/************************************************************************/
print "ad_nodo_oficina"
/************************************************************************/
go
truncate table ad_nodo_oficina
go

insert into ad_nodo_oficina values (1,0,0,1,'GLOBAL_COBIS',getdate(),1,getdate(),1,0,'V',0,getdate(),0,0)
insert into ad_nodo_oficina values (1,0,1,2,'NTBRANCH1',getdate(),1,getdate(),1,0,'V',1,getdate(),0,0)
insert into ad_nodo_oficina values (1,40,2,2,'NTBRANCH1',getdate(),1,getdate(),1,0,'V',2,getdate(),0,0)
insert into ad_nodo_oficina values (1,1,3,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',3,getdate(),0,0)
insert into ad_nodo_oficina values (1,4,4,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',4,getdate(),0,0)
insert into ad_nodo_oficina values (1,17,5,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',5,getdate(),0,0)
insert into ad_nodo_oficina values (1,20,6,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',6,getdate(),0,0)
insert into ad_nodo_oficina values (1,22,7,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',7,getdate(),0,0)
insert into ad_nodo_oficina values (1,24,8,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',8,getdate(),0,0)
insert into ad_nodo_oficina values (1,25,9,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',9,getdate(),0,0)
insert into ad_nodo_oficina values (1,28,10,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',10,getdate(),0,0)
insert into ad_nodo_oficina values (1,47,11,2,'NTBRANCH2',getdate(),1,getdate(),1,0,'V',11,getdate(),0,0)
insert into ad_nodo_oficina values (1,45,12,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',12,getdate(),0,0)
insert into ad_nodo_oficina values (1,50,13,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',13,getdate(),0,0)
insert into ad_nodo_oficina values (1,30,14,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',14,getdate(),0,0)
insert into ad_nodo_oficina values (1,7,15,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',15,getdate(),0,0)
insert into ad_nodo_oficina values (1,15,16,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',16,getdate(),0,0)
insert into ad_nodo_oficina values (1,19,17,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',17,getdate(),0,0)
insert into ad_nodo_oficina values (1,21,18,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',18,getdate(),0,0)
insert into ad_nodo_oficina values (1,23,19,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',19,getdate(),0,0)
insert into ad_nodo_oficina values (1,26,20,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',20,getdate(),0,0)
insert into ad_nodo_oficina values (1,27,21,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',21,getdate(),0,0)
insert into ad_nodo_oficina values (1,29,22,2,'NTBRANCH3',getdate(),1,getdate(),1,0,'V',22,getdate(),0,0)
insert into ad_nodo_oficina values (1,48,23,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',23,getdate(),0,0)
insert into ad_nodo_oficina values (1,3,24,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',24,getdate(),0,0)
insert into ad_nodo_oficina values (1,6,25,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',25,getdate(),0,0)
insert into ad_nodo_oficina values (1,8,26,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',26,getdate(),0,0)
insert into ad_nodo_oficina values (1,9,27,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',27,getdate(),0,0)
insert into ad_nodo_oficina values (1,18,28,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',28,getdate(),0,0)
insert into ad_nodo_oficina values (1,2,29,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',29,getdate(),0,0)
insert into ad_nodo_oficina values (1,12,30,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',30,getdate(),0,0)
insert into ad_nodo_oficina values (1,13,31,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',31,getdate(),0,0)
insert into ad_nodo_oficina values (1,16,32,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',32,getdate(),0,0)
insert into ad_nodo_oficina values (1,5,33,2,'NTBRANCH4',getdate(),1,getdate(),1,0,'V',33,getdate(),0,0)
go

update cl_seqnos set siguiente=33 where tabla='ad_nodo_oficina'
go

/************************************************************************/
print "ad_usuario"
/************************************************************************/
go
truncate table ad_usuario
go

insert into ad_usuario
select nl_filial, nl_oficina, nl_nodo, fu_login, getdate(), 1, getdate(), getdate(), 'V' from cl_funcionario, ad_nodo_oficina where nl_oficina=fu_oficina and nl_nodo<>0
go
insert into ad_usuario
select nl_filial, nl_oficina, nl_nodo, fu_login, getdate(), 1, getdate(), getdate(), 'V' from cl_funcionario, ad_nodo_oficina where nl_nodo=0 and (fu_login='lgonzale' or fu_login='jfernand')
go



/************************************************************************/
print "ad_usuario_rol"
/************************************************************************/
go
truncate table ad_usuario_rol
insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,
				 ur_autorizante, ur_estado, ur_fecha_ult_mod,
				 ur_tipo_horario)
			values	("sa", 1, getdate(),
				 1, "V", getdate(),
				 1)

insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,
				 ur_autorizante, ur_estado, ur_fecha_ult_mod,
				 ur_tipo_horario)
			values	("reentry", 1, getdate(),
				 1, "V", getdate(),
				 1)

insert into ad_usuario_rol	(ur_login, ur_rol, ur_fecha_aut,
				 ur_autorizante, ur_estado, ur_fecha_ult_mod,
				 ur_tipo_horario)
			values	("lgonzale", 1, getdate(),
				 1, "V", getdate(),
				 1)
go



/************************************************************************/
print "cc_oficial"
/************************************************************************/
go

truncate table cc_oficial
go

insert into cc_oficial values(0,0,'A','0',null,null,'01')
go



insert into cc_oficial values( 200, 307, 'P',  NULL, 412,  NULL, '2' )
insert into cc_oficial values( 201, 304, 'P',  NULL, 602,  NULL, '2' )
insert into cc_oficial values( 202, 360, 'P',  NULL, 403,  NULL, '2' )
insert into cc_oficial values( 203, 361, 'P',  NULL, 420,  NULL, '2' )
insert into cc_oficial values( 204, 309, 'P',  NULL, 415,  NULL, '2' )
insert into cc_oficial values( 300, 514, 'P',  NULL, 410,  NULL, '3' )
insert into cc_oficial values( 301, 517, 'P',  NULL, 417,  NULL, '3' )
insert into cc_oficial values( 302, 507, 'P',  NULL, 603,  NULL, '3' )
insert into cc_oficial values( 303, 305, 'P',  NULL, 418,  NULL, '3' )
insert into cc_oficial values( 304, 515, 'P',  NULL, 419,  NULL, '3' )
insert into cc_oficial values( 305, 516, 'P',  NULL, 407,  NULL, '3' )
insert into cc_oficial values( 400, 224, 'P',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 401, 237, 'P',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 402, 251, 'C',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 403, 254, 'P',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 404, 246, 'P',  NULL, 502,  NULL, '4' )
insert into cc_oficial values( 405, 253, 'P',  NULL, 502,  NULL, '4' )
insert into cc_oficial values( 406, 248, 'P',  NULL, 502,  NULL, '4' )
insert into cc_oficial values( 407, 239, 'P',  NULL, 502,  NULL, '4' )
insert into cc_oficial values( 408, 216, 'P',  NULL, 601,  NULL, '4' )
insert into cc_oficial values( 409, 219, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 410, 234, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 411, 236, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 412, 244, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 413, 242, 'P',  NULL, 503,  NULL, '4' )
insert into cc_oficial values( 414, 240, 'P',  NULL, 503,  NULL, '4' )
insert into cc_oficial values( 415, 238, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 416, 249, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 417, 233, 'P',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 418, 241, 'P',  NULL, 503,  NULL, '4' )
insert into cc_oficial values( 419, 250, 'P',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 420, 247, 'P',  NULL, 603,  NULL, '4' )
insert into cc_oficial values( 421, 220, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 422, 232, 'P',  NULL, 503,  NULL, '4' )
insert into cc_oficial values( 423, 252, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 424, 243, 'P',  NULL, 503,  NULL, '4' )
insert into cc_oficial values( 425, 235, 'P',  NULL, 700,  NULL, '4' )
insert into cc_oficial values( 426, 245, 'P',  NULL, 602,  NULL, '4' )
insert into cc_oficial values( 427, 222, 'C',  NULL, 604,  NULL, '4' )
insert into cc_oficial values( 428, 301, 'C',  NULL, 604,  NULL, '4' )
insert into cc_oficial values( 500, 534, 'P',  NULL, 700,  NULL, '5' )
insert into cc_oficial values( 501, 535, 'P',  NULL, 700,  NULL, '5' )
insert into cc_oficial values( 502, 542, 'P',  NULL, 700,  NULL, '5' )
insert into cc_oficial values( 503, 536, 'P',  NULL, 700,  NULL, '5' )
insert into cc_oficial values( 601, 538, 'P',  NULL, 700,  NULL, '6' )
insert into cc_oficial values( 602, 530, 'P',  NULL, 700,  NULL, '6' )
insert into cc_oficial values( 603, 543, 'C',  NULL, 700,  NULL, '6' )
insert into cc_oficial values( 604, 526, 'P',  NULL, 700,  NULL, '6' )
insert into cc_oficial values( 700, 527, 'C',  NULL, 800,  NULL, '7' )
insert into cc_oficial values( 800, 226, 'C',  NULL, 32001,  NULL, '8' )

go
