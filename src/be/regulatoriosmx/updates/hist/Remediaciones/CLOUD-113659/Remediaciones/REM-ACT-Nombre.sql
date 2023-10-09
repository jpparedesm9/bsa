/****************************************************************************/
/* Soporte #113659:                                                         */
/* SOLICITAMOS DE SU APOYO PARA LA CORRECCION DEL NOMBRE DEL CLIENTE 21178: */
/* NOMBRE INCORRECTO: MA CARMEN CERVANTES MARTINES                          */
/* NOMBRE CORRECTO: MA. CARMEN CERVANTES MARTINEZ                           */
/* SE ANEXAN INE                                                            */
/* GRACIAS Y SALUDOS                                                        */
/****************************************************************************/


UPDATE cobis..cl_ente SET 
en_nomlar = 'MA. CARMEN CERVANTES MARTINEZ',
en_nombre = 'MA.',
p_s_apellido = 'MARTINEZ'
WHERE en_ente = 21178

UPDATE cob_cartera..ca_operacion SET 
op_nombre = 'CERVANTES MARTINEZ MA.'
WHERE op_operacion IN (SELECT tg_operacion 
                       FROM cob_credito..cr_tramite_grupal 
                       WHERE tg_cliente = 21178)
					  
					  
go