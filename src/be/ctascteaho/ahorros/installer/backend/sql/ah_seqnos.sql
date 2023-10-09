/************************************************************************/
/*      Archivo:            ah_seqnos.sql                               */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de secuenciales               */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cobis
go

/************/
/*  SEQNOS  */
/************/

delete cl_seqnos
where bdatos = 'cob_ahorros'
go

delete cl_seqnos
where bdatos = 'cob_ahorros_his'
go



print 'Insercion:  cl_seqnos'

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_beneficiario_cta', 0, 'bc_beneficiario')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_boc', 0, 'ah_boc')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_control', 0, 'ah_control')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_ctabloqueada', 0, 'cb_secuencial')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_cuenta', 0, 'ah_cuenta')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_embargo', 0, 'he_secuencial')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_his_bloqueo', 0, 'hb_secuencial')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_his_cierre', 0, 'hc_secuencial')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_lpendiente', 0, 'lp_linea')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_servicio', 0, 'se_servicio')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_solicitud_cuenta', 0, 'sc_numsol')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_tran_monet', 0, 'tm_secuencial')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_tran_servicio', 0, 'ts_secuencial')

insert into cl_seqnos   (bdatos, tabla, siguiente, pkey) 
        values  ('cob_ahorros', 'ah_val_suspenso', 0, 'vs_secuencial')

go
