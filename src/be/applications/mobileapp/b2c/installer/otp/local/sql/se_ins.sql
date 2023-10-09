/******************************************************************************/
/*      Stored procedure:       se_ins.sql                                    */
/*      Base de datos:          cobis                                         */
/*      Producto:               Seguridad                                     */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Insercion de prámetros                                                     */
/******************************************************************************/
/*                                                                            */
/******************************************************************************/
/* FECHA        VERSION       AUTOR              RAZON                        */
/******************************************************************************/
/* 26-Oct-2016  1.0.0.0       GRO                Version inicial              */
/******************************************************************************/
use cobis
go

delete from cobis..cl_parametro where pa_nemonico ='TAMT' and pa_producto='BVI'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
values ('TAMANIO TOKEN', 'TAMT', 'I', 4, 'BVI')

go

delete from cobis..cl_parametro where pa_nemonico ='TVT' and pa_producto='BVI'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
values ('TIEMPO VALIDEZ TOKEN', 'TVT', 'I', 5, 'BVI')

go

