/************************************************************************/
/*    ARCHIVO:         carga_cl_provincia.sql                           */
/*    NOMBRE LOGICO:   carga_cl_provincia.sql                           */
/*    PRODUCTO:        AHORROS                                          */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de carga de estados para México                             */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */
/*																		*/  
/************************************************************************/

use cobis
go

--select * from cobis..cl_provincia

truncate table cl_provincia

--ini----------------
insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (1, 'Aguascalientes', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (2, 'Baja California', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (3, 'Baja California Sur', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (4, 'Campeche', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (5, 'Coahuila de Zaragoza', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (6, 'Colima', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (7, 'Chiapas', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (8, 'Chihuahua', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (9, 'Ciudad de México', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (10, 'Durango', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (11, 'Guanajuato', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (12, 'Guerrero', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (13, 'Hidalgo', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (14, 'Jalisco', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (15, 'México', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (16, 'Michoacán de Ocampo', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (17, 'Morelos', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (18, 'Nayarit', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (19, 'Nuevo León', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (20, 'Oaxaca', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (21, 'Puebla', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (22, 'Querétaro', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (23, 'Quintana Roo', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (24, 'San Luis Potosí', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (25, 'Sinaloa', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (26, 'Sonora', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (27, 'Tabasco', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (28, 'Tamaulipas', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (29, 'Tlaxcala', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (30, 'Veracruz de Ignacio de la Llave', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (31, 'Yucatán', 'MX', 'MX', 484, 'V', '1')
go

insert into dbo.cl_provincia (pv_provincia, pv_descripcion, pv_region_nat, pv_region_ope, pv_pais, pv_estado, pv_depart_pais)
values (32, 'Zacatecas', 'MX', 'MX', 484, 'V', '1')
go
--fin
