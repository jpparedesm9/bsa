/************************************************************************/
/*    ARCHIVO:         carga_bancos_mex.sql                             */
/*    NOMBRE LOGICO:   carga_bancos_mex.sql                             */
/*    PRODUCTO:        REMESAS                                          */
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
/*   Script de carga bancos de México.                                  */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      26/08/2016     Karen Meza           Emision Inicial             */  
/************************************************************************/
 use cob_remesas
 go

 truncate table re_banco
 
 INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (0, 'HSBC - MEXICO', 'V', 1, '8598226947', NULL)
 GO
 INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (1, 'BANAMEX', 'V', 1, '1425703029', NULL)
 GO
 
 INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (2, 'BBVA BANCOMER', 'V', 1, '9566301247', NULL)
 GO

  INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (3, 'SANTANDER SERFIN', 'V', 1, '0125887963', NULL)
 GO

   INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (4, 'SCOTIABANK INVERLAT', 'V', 1, '01585693201', NULL)
 GO

    INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (5, 'BANCO AZTECA', 'V', 1, '023698551030', NULL)
 GO
 
    INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (6, 'BANK OF AMERICA - MEXICO', 'V', 1, '9858796000', NULL)
 GO
 
     INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (7, 'GRUPO FINANCIERO BANORTE', 'V', 1, '9874321002', NULL)
 GO

  INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (8, 'BANCO DEL BAJIO', 'V', 1, '9856474410', NULL)
 GO
  INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (9, 'BANCO DE MEXICO', 'V', 1, '0236698525', NULL)
 GO

   INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (10, 'BANSI', 'V', 1, '02558741023', NULL)
 GO
 
    INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (11, 'BANREGIO', 'V', 1, '9865574890', NULL)
 GO
 
     INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (12, 'NACIONAL FINANCIERA - BANCA DE DESARROLLO', 'V', 1, '5203698741', NULL)
 GO
 INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (13, 'BANCO DE COMERCIO EXTERIOR', 'V', 1, '0254869302', NULL)
 GO
 
 INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (14, 'ASOCIACION DE BANQUEROS DE MEXICO', 'V', 1, '7854147896', NULL)
 GO
  INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (15, 'BANCO NACIONAL DE CREDITO RURAL S.N.C.', 'V', 1, '78542697822', NULL)
 GO
 INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (16, 'BANCO NACIONAL DE OBRAS Y SERVICIOS PUBLICOS', 'V', 1, '1585269630', NULL)
 GO
  INSERT INTO re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
 VALUES (17, 'COMISION NACIONAL BANCARIA Y DE VALORES', 'V', 1, '7854125879', NULL)
 GO
 