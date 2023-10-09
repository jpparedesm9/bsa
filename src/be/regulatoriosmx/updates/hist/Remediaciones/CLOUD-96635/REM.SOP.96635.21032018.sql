/*************************************************************************************/
--No Historia                : SOP-96635
--Titulo de la Historia      : REPORTE DEL CAT DE TODOS LOS CLIENTES AL 28 DE FEBRERO
--Fecha                      : 20/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : REPORTE DEL CAT DE TODOS LOS CLIENTES AL 28 DE FEBRERO
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
select 'Cod_cliente'  = do_codigo_cliente,
       'Cliente'      = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
       'Operacion'    = do_banco,
       'CAT'          = isnull(op_valor_cat,0)
from  cob_conta_super..sb_dato_operacion,
      cob_cartera..ca_operacion,
      cobis..cl_ente
where do_codigo_cliente = en_ente
and   do_fecha = '02/28/2018'
and   do_banco = op_banco
go

