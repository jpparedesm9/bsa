/************************************************************************/
/*      Archivo:            param_pf_tranperfil.sql                     */
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
/*  en la tabla pf_tranperfil para el modulo de plazo fijo.             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_pfijo
go
--parametria pf_tranperfil
truncate table  pf_tranperfil 
go

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14149, 'N', 'END_DPF', 'END', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14155, 'N', 'CAN_DPF', 'CAN', 'CAN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14165, 'N', 'CAN_DPF', 'REN', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14165, 'R', 'CAN_DPF', 'REN', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14168, 'N', 'ENJ_DPF', 'ENJ', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14168, 'R', 'ENJ_DPF', 'ENJ', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14201, 'N', 'TOP_DPF', 'TOP', 'TOP')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14543, 'N', 'CAN_DPF', 'CAN', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14543, 'R', 'CAN_DPF', 'CAN', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14545, 'N', 'APE_DPF', 'APE', 'APE')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14545, 'R', 'APE_DPF', 'APE', 'APE')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14901, 'N', 'APE_DPF', 'APE', 'APE')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14901, 'R', 'APE_DPF', 'APE', 'APE')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14903, 'N', 'CAN_DPF', 'CAN', 'CAN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14903, 'R', 'CAN_DPF', 'CAN', 'CAN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14905, 'N', 'CAN_DPF', 'CAN', 'CAN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14905, 'R', 'CAN_DPF', 'CAN', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14919, 'N', 'CAN_DPF', 'REN', 'REN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14919, 'R', 'CAN_DPF', 'REN', 'REN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14926, 'N', 'CAU_DPF', 'CAU', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14926, 'R', 'CAU_DPF', 'CAU', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14943, 'N', 'ORD_DPF', 'EOP', 'CAN')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14947, 'N', 'CAN_DPF', 'REN', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14952, 'N', 'CAN_DPF', 'FFR', 'APE')

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14989, 'N', 'APE_DPF', 'APE', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14990, 'N', 'APE_DPF', 'APE', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14995, 'N', 'APE_DPF', 'APE', NULL)

INSERT INTO pf_tranperfil (tp_tran, tp_estado, tp_perfil, tp_tipo_trn, tp_trn_rec)
VALUES (14995, 'R', 'APE_DPF', 'APE', NULL)

go

