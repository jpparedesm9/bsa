/*
*   Archivo para creat tabla de trabajo requerimiento 141620
*   Johan castro
*   04/09/2020
*/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'ca_seguros_zurich') 
begin
   drop table ca_seguros_zurich
end

CREATE TABLE ca_seguros_zurich (
	sz_nro_poliza varchar(18) NULL,
	sz_anio_poliza int NULL,
	sz_producto varchar(20) NULL,
	sz_id_cliente varchar(8) NULL,
	sz_sucursal varchar(5) NULL,
	sz_nro_prestamo varchar(12) NULL,
	sz_nro_certificado varchar(12) NULL,
	sz_mes_emision varchar(2) NULL,
	sz_fecha_endoso varchar(10) NULL,
	sz_fecha_efectiva varchar(10) NULL,
	sz_fecha_expiracion varchar(10) NULL,
	sz_long_cobertura int NULL,
	sz_pais varchar(6) NULL,
	sz_moneda varchar(3) NULL,
	sz_vendedor varchar(20) NULL,
	sz_nombre_asegurado varchar(20) NULL,
	sz_apellido_paterno varchar(20) NULL,
	sz_apellido_materno varchar(20) NULL,
	sz_direccion1 varchar(40) NULL,
	sz_direccion2 varchar(40) NULL,
	sz_ciudad varchar(40) NULL,
	sz_estado varchar(40) NULL,
	sz_cod_postal varchar(5) NULL,
	sz_telefono varchar(10) NULL,
	sz_email varchar(50) NULL,
	sz_genero varchar(2) NULL,
	sz_rfc varchar(13) NULL,
	sz_edad int NULL,
	sz_fecha_nac varchar(10) NULL,
	sz_nombre_1 varchar(30) NULL,
	sz_rfc_1 varchar(13) NULL,
	sz_fecha_nac_1 varchar(10) NULL,
	sz_sexo_1 varchar(2) NULL,
	sz_porcentaje_1 varchar(2) NULL,
	sz_nombre_2 varchar(30) NULL,
	sz_rfc_2 varchar(13) NULL,
	sz_fecha_nac_2 varchar(10) NULL,
	sz_sexo_2 varchar(2) NULL,
	sz_porcentaje_2 varchar(2) NULL,
	sz_nombre_3 varchar(30) NULL,
	sz_rfc_3 varchar(13) NULL,
	sz_fecha_nac_3 varchar(10) NULL,
	sz_sexo_3 varchar(2) NULL,
	sz_porcentaje_3 varchar(2) NULL,
	sz_cta_banco varchar(45) NULL,
	sz_seguro_vida numeric(10,2) NULL,
	sz_seguro_infarto_cer numeric(10,2) NULL,
	sz_seguro_infarto_mioc numeric(10,2) NULL,
	sz_seguro_cancer numeric(10,2) NULL,
	sz_monto_prima numeric(10,2) NULL,
	sz_comision numeric(6,2) NULL,
	sz_monto_credito numeric(10,2) NULL
)
GO
