/************************************************************************/
/*    ARCHIVO:         03_catalogo.sql                                  */
/*    NOMBRE LOGICO:   03_catalogo.sql                                  */
/*    PRODUCTO:        REGULATORIOS                                     */
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
/*   Script de creacion de catálogo y actualización de cl_seqnos        */
/*   para el reporte de COBIS_CATAL_MOTV                                */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      02/02/2023      Daniel Berrio           Emision Inicial         */
/************************************************************************/

use cob_cartera
GO

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('DES1','FORMALIZACION DESEMBOLSO-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('DES10','FORMALIZACION REVERSO (afectación inversa)- Iva de la comisión de desembolso')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('DES2','FORMALIZACION DESEMBOLSO-Comisión de desembolso')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('DES3','FORMALIZACION REVERSO (afectación inversa)-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('DES4','FORMALIZACION REVERSO (afectación inversa)-Comisión de desembolso')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('DES9','FORMALIZACION DESEMBOLSO-Iva de la comisión de desembolso')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('FACT1','FACTURACION-Interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('FACT2','FACTURACION (afectación inversa)-Interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('FACT3','FACTURACION-Iva de Interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('FACT4','FACTURACION-(afectación inversa) Iva de Interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('FACT5','FACTURACION-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('FACT6','FACTURACION-(afectación inversa) Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG1','PAGOS (TRADICIONAL Y LIQUIDACION ANTICIPADA)-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG10','PAGOS (TRADICIONAL Y LIQUIDACION ANTICIPADA)- Iva de la Mora')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG11','PAGOS (ADELANTADOS)-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG12','PAGOS (ADELANTADOS)-Interes')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG13','PAGOS (ADELANTADOS)-Iva de Interes')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG2','PAGOS (TRADICIONAL Y LIQUIDACION ANTICIPADA)-Intereses')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG21','PAGOS (Cancelar)-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG22','PAGOS (Cancelar)-Interes')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG23','PAGOS (Cancelar)-Iva de Interes')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG3','PAGOS (TRADICIONAL Y LIQUIDACION ANTICIPADA)-IVA del interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG4','PAGOS (TRADICIONAL Y LIQUIDACION ANTICIPADA)-IVA del interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG5','PAGOS (TRADICIONAL Y LIQUIDACION ANTICIPADA)-IVA de la comisión')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG6','PAGOS REVERSO (afectación inversa)-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG7','PAGOS REVERSO (afectación inversa)-Intereses')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG8','PAGOS REVERSO (afectación inversa)-IVA del interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PAG9','PAGOS REVERSO (afectación inversa)-Comisión')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PRV1','PROVISIÓN DE INTERESES (DEVENGO DE INTERESES)-interés (1301)')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PRV2','PROVISIÓN DE INTERESES (DEVENGO DE INTERESES)-Interés (5105)')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PRV3','PROVISIÓN REVERSO (afectación inversa)-Interés (1301)')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('PRV4','PROVISIÓN REVERSO (afectación inversa)-Interés (5105)')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('EST1','PASO DEL CRÉDITO VIGENTE A VENCIDO-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('EST2','PASO DEL CRÉDITO VIGENTE A VENCIDO-Interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('EST3','PASO DEL CRÉDITO VIGENTE A VENCIDO-Mora')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('EST4','PASO DEL CRÉDITO VENCIDO A CASTIGADO-Capital')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('EST5','PASO DEL CRÉDITO VENCIDO A CASTIGADO-Interés')

INSERT INTO cob_cartera..cl_catalogo_motv (cm_codigo, cm_descripcion) 
VALUES('EST6','PASO DEL CRÉDITO VENCIDO A CASTIGADO-Mora')
