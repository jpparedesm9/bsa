/************************************************************************/
/*      Archivo:            param_pf_plazo_contable.sql                 */
/*      Base de datos:      cob_pfijo                                   */
/*      Producto:           Plazo Fijo                                  */
/*      Disenado por:       Karen Meza                                  */
/*      Fecha de escritura: 22/Sept/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la creación de la parametrización contable    */
/*  en la tabla pf_plazo_contable para el módulo de plazo fijo.         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_pfijo
go
--PARAMETRIA pf_plazo_contable
delete pf_plazo_contable where pc_plazo_cont in ('-180D','-360D','-540D','+540D')
go
                                             
INSERT INTO pf_plazo_contable (pc_plazo_cont, pc_plazo_min, pc_plazo_max, pc_descripcion)
VALUES ('-180D', 1, 179, 'MENOR A 180 DIAS')

INSERT INTO pf_plazo_contable (pc_plazo_cont, pc_plazo_min, pc_plazo_max, pc_descripcion)
VALUES ('-360D', 180, 359, 'IGUAL A 180 DIAS Y MENOR A 360 DIAS')

INSERT INTO pf_plazo_contable (pc_plazo_cont, pc_plazo_min, pc_plazo_max, pc_descripcion)
VALUES ('-540D', 360, 539, 'IGUAL A 360 DIAS Y MENOR A 540 DIAS')

INSERT INTO pf_plazo_contable (pc_plazo_cont, pc_plazo_min, pc_plazo_max, pc_descripcion)
VALUES ('+540D', 540, 999999, 'IGUAL O SUPERIOR A 540 DIAS')

GO

