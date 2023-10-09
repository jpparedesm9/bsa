use cobis
go

/* Antes de ejecutar el script favor     */
/* reemplazar los siguientes TOKENS 	 */
/* [IP_CTS] = PROTOCOLO E IP del servidor CTS  		 */
/* [PORT_CTS] = Puerto del servidor CTS  */
/* Ejemplo. '192.168.1.2:8080'           */

update an_component set 
co_namespace = convert (varchar(255), isnull(str_replace (co_namespace,'[cts_servername]','[IP_CTS]:[PORT_CTS]'),'')) 
where co_prod_name in ('M-MENUPRIN','M-VCC', 'M-CRM','M-MCH','M-WKF','M-IBX', 'M-POL','M-APF' )
go
