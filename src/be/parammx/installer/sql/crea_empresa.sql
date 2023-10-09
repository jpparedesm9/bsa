/************************************************************************/
/*    ARCHIVO:         crea_empresa.sql                                 */
/*    NOMBRE LOGICO:   crea_empresa.sql                                 */
/*    PRODUCTO:        CONTABILIDAD                                     */
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
/*   Script que crea una empresa en contabilidad                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */  
/************************************************************************/


USE cob_conta
go

if exists (select 1 from cb_empresa where em_empresa=1 and em_ruc ='9002150711')
delete cb_empresa where em_empresa=1 and em_ruc ='9002150711'

INSERT INTO cb_empresa (em_empresa, em_ruc, em_descripcion, em_replegal, em_contgen, em_moneda_base, em_abreviatura, em_direccion, em_matcontgen, em_revisor, em_matrevisor, em_emp_revisor, em_nit_emprev, em_mat_revisor)
VALUES (1, '9002150711', 'BANCO MX', 'COBISCORP', 'COBISCORP', 0, 'BANCO MX', 'COBISCORP', '22016 -T', 'COBISCORP', '88877-T', 'COBISCORP', '8600005813', '2340')
GO