use cobis
go

set nocount on
go


/************/
/*  SEQNOS  */
/************/
delete cl_seqnos
 where bdatos = 'cob_remesas'
   and tabla in ('pe_pro_bancario', 'pe_mercado', 'pe_pro_final',
                 'pe_servicio_dis', 'pe_tipo_rango', 'pe_servicio_per',
                 'pe_costo', 'pe_cambio_costo', 'pe_val_contratado',
                 'pe_cambio_val_contr')
go
print 'Insercion:  cl_seqnos'
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_pro_bancario',0,'pb_pro_bancario')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_cambio_costo',0,'cc_secuencial')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_val_contratado',0,'vc_secuencial')
insert into cl_seqnos   (bdatos, tabla, siguiente, pkey)
                values  ('cob_remesas', 'pe_cambio_val_contr',0,'vv_secuencial')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_mercado', 0, 'me_mercado')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_pro_final', 0, 'pf_pro_final')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_servicio_dis', 0,'sd_servicio_dis')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_tipo_rango', 0,'tr_tipo_rango' )
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_servicio_per', 0,'sp_servicio_per')
insert into cl_seqnos	(bdatos, tabla, siguiente, pkey) 
		values  ('cob_remesas', 'pe_costo', 0,'co_secuencial')
go

/*************/
/*   TABLA   */
/*************/
delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('pe_capitalizacion', 
                 'pe_categoria', 
                 'pe_ciclo',
                 'pe_rol_ente',
                 'pe_nat_trn', 
                 'pe_periodicidad', 
                 'pe_rubro', 
                 'pe_tipo_atributo', 
                 'pe_tipo_cobro', 
                 'pe_tipo_dato', 
                 'pe_tipo_ente',
                 'pe_transaccion',
                 'pe_aut_trn_caja',
                 're_plantillas',
                 'cl_est_plantillas_contratos')
   and codigo = cp_tabla
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('pe_capitalizacion', 
                          'pe_categoria', 
                          'pe_ciclo',
                          'pe_rol_ente',
                          'pe_nat_trn', 
                          'pe_periodicidad', 
                          'pe_rubro', 
                          'pe_tipo_atributo', 
                          'pe_tipo_cobro', 
                          'pe_tipo_dato', 
                          'pe_tipo_ente',
                          'pe_transaccion',
                          'pe_aut_trn_caja',
                          're_plantillas',
                          'cl_est_plantillas_contratos')
   and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where cl_tabla.tabla in ('pe_capitalizacion', 
                          'pe_categoria', 
                          'pe_ciclo',
                          'pe_rol_ente',
                          'pe_nat_trn', 
                          'pe_periodicidad', 
                          'pe_rubro', 
                          'pe_tipo_atributo', 
                          'pe_tipo_cobro', 
                          'pe_tipo_dato', 
                          'pe_tipo_ente',
                          'pe_transaccion',
                          'pe_aut_trn_caja',
                          're_plantillas',
                          'cl_est_plantillas_contratos')
go

declare @w_codigo smallint

select @w_codigo = isnull(max(codigo), 0) + 1
from cl_tabla

print 'Tipo Capitalizacion'
insert into cl_tabla values (@w_codigo, 'pe_capitalizacion', 'Tipo Capitalizacion')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'B', 'BIMENSUAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'D', 'DIARIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'E', 'SEMANAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'M', 'MENSUAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'Q', 'QUINCENAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'S', 'SEMESTRAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'T', 'TRIMESTRAL','V')
select @w_codigo = @w_codigo + 1

print 'Categoria de Cuenta'
insert into cl_tabla values (@w_codigo, 'pe_categoria', 'Categoria de Cuenta')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C', 'TIPO CUATRO','E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'D', 'LIBRE DESTINO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'E', 'EDUCACION','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'H', 'HOGAR','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'I', 'VIAJES','E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'M', 'MICROEMPRESA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N', 'NORMAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'O', 'OTROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'P', 'PLAN FINALIZADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'S', 'SALUD','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'T', 'TIPO TRES','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'U', 'TIPO UNO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'V', 'VIVIENDA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'R', 'Aporte Social Ordinario','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A', 'Aporte Social Adicional','V')

select @w_codigo = @w_codigo + 1

print 'Ciclo de cobro de servicio contratado'
insert into cl_tabla values (@w_codigo,'pe_ciclo','Ciclo de Servicio Contratado')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A', 'ANUAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'B', 'BIMENSUAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'M', 'MENSUAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'Q', 'QUINCENAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'S', 'SEMESTRAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'T', 'TRIMESTRAL', 'V')
select @w_codigo = @w_codigo + 1

print 'Roles de personas en companias'
insert into cl_tabla values (@w_codigo,'pe_rol_ente','Roles de personas en companias')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A', 'ACCIONISTA', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'E', 'EJECUTIVO', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'T', 'EMPLEADO', 'V') 
select @w_codigo = @w_codigo + 1

print 'NATURALEZA COBRO TRANSACCIONES'
insert into cl_tabla values (@w_codigo, 'pe_nat_trn', 'NATURALEZA COBRO TRANSACCIONES')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N230', 'CON','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N237', 'DEB','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N252', 'CRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N253', 'CRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N263', 'DEB','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N264', 'DEB','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N300', 'CRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'N380', 'DEB','V')
select @w_codigo = @w_codigo + 1

print 'Periodicidad Cuentas Especiales'
insert into cl_tabla values (@w_codigo, 'pe_periodicidad', 'Periodicidad Cuentas Especiales')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, 'M','MENSUAL', 'V')
select @w_codigo = @w_codigo + 1

print 'Rubro del servicio'
insert into cl_tabla values (@w_codigo, 'pe_rubro', 'Rubro del servicio')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '1', 'INTERES','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '10', 'MULTA POR CHQ ADICIONAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '11', 'COMISION POR CHEQUE DEVUELTO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '12', 'COMISION POR REVOCATORIA DE CHQ','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '13', 'COSTO POR PUBLI. DE REVOCATORIA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '14', 'COSTO POR CERTIFICACION DE CHQ.','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '15', 'COSTO POR SOLICITUD EST.CTA.','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '16', 'COSTO POR PUBLICACION DE ANU.CHQ','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '17', 'INTERES SOBRE EL CONTABLE','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '18', 'INTERES','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '19', 'IMPUESTO SOBRE EL INT.GANADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '2', 'IMPUESTO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '20', 'COMISION MINIMA POR PROTESTO DE CHEQUE','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '21', 'COSTO POR ENVIO DE ESTADO DE CTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '22', 'MULTA POR GASTOS DE MANEJO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '23', 'INTERES POR CIERRE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '24', 'COSTO DEL MANT. DE CUENTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '25', 'COMISION POR ANULACION DE LIBRETA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '26', 'PUBLICACION POR ANULACION DE LIBRETA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '27', 'COSTO POR COMISION ANULAC. CHQ.','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '28', 'TASA CERTIFICACION CHEQUE','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '29', 'COSTO EMISION ESTADO DE CUENTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '3', 'COMISION','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '30', 'COSTO EMISION TARJETA PRINCIPAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '31', 'COSTO EMISION TARJETA ADICIONAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '310', 'COMISION RETIRO CHQ GERENCIA NACIONAL','C')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '311', 'COMISION CONSULTA SALDO EN CAJA NACIONAL','C')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '312', 'COMISION DEPOSITO CTA AHORROS NACIONAL','C')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '313', 'COMISION RETIRO EFECTIVO CTA AHORROS NACIONAL','C')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '314', 'COMISION RETIRO EFECTIVO CTA AHORROS NACIONAL','C')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '315', 'COMISION TRANSFERENCIA ENTRE CUENTAS NACIONAL','C')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '316', 'COMISION NOTA CR AHORROS NACIONAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '317', 'COMISION NOTA DB AHORROS NACIONAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '32', 'COSTO REPOSICION TARJETA PRINCIPAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '33', 'COSTO REPOSICION TARJETA ADICIONAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '34', 'COMISION ENVIO AL COBRO CHQ REMESA-VIA INTERNA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '35', 'TASA DE COMISION POR PROTESTO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '36', 'INTERES TASA2 SOBREGIROS','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '37', 'COMISION POR REMESA NEGOCIADA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '38', 'PORTES','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '39', 'MONTO MINIMO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '4', 'SOLCA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '40', 'SALDO MINIMO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '41', 'CARGO CIERRE CUENTA ANTES DE TIEMPO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '43', 'COMISION ENVIO AL COBRO CHQ REMESA-CORRESPONSAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '44', 'COMISION ENVIO AL COBRO CHQ REMESA-BCO AGRARIO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '45', 'COMISION POR CHEQUES OTRAS PLAZAS DEVUELTOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '46', 'COMISION POR LIBERACION DE CANJE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '48', 'PORTES DEVOLUCION CHEQUES REMESAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '5', 'INTERES POR MORA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '6', 'COSTO MANTENIMIENTO TARJETA PRINCIPAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '60', 'COMISION TRANS. MONETARIA CREDITO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '61', 'COMISION TRANS. MONETARIA DEBITO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '62', 'COMISION TRANS. PRENOTIFICACION CREDITO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '63', 'COMISION TRANS. INSCRIPCION DEBITO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '64', 'COMISION TRANS. ENROLAMIENTO CREDITO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '65', 'COMISION TRANS. ENROLAMIENTO DEBITO','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '66', 'RECARGO A COMISION TRANS. ESPECIAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '67', 'COMISION TRANS. MONETARIA CREDITO PF','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '68', 'COMISION TRANS. MONETARIA DEBITO PF','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '69', 'COMISION TRANS. MONETARIA CREDITO BV','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '7', 'COSTO MANTENIMIENTO TARJETA ADICIONAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '70', 'COMISION TRANS. MONETARIA DEBITO BV','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '71', 'COMISION TRANS. MONETARIA CREDITO CA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '72', 'COMISION TRANS. MONETARIA DEBITO CA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '73', 'COMISION TRANS. MONERATIA CREDITO CMX','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '74', 'COMISION TRANS. MONETARIA DEBITO CMX','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '75', 'COMISION TRANS. MONETARIA CREDITO SB','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '76', 'COMISION TRANS. MONETARIA DEBITO SB','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '77', 'COMISION TRANS, MONETARIA CREDITO BN','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '78', 'COMISION TRANS. MONETARIA DEBITO BN','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '79', 'COMISION TRANS. MONETARIA CREDITO SID','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '8', 'INTERES SOBRE CHQ LOCAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '80', 'COMISION TRANS. MONETARIA DEBITO SID','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '9', 'INTERES SOBRE CHQ REMESA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A1', 'CHEQUERA NORMAL','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A2', 'CHEQUERA EMPLEADOS','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A3', 'CHEQUERA FORMA CONTINUA BANCO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A4', 'CHEQUERA FORMA CONTINUA CLIENTE','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A5', 'CHEQUERA DE EMERGENCIA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A6', 'CHEQUERA EMERGENCIA EMPLEADOS','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'B09C', 'CHQ. BOLSILLO C/C - WILDLIFE PORTRAITS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C2', 'CHEQUERA DE CORTESIA','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C230', 'COMIS. TIPO C CONSULTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C237', 'COMIS. TIPO C TRANSFERENCIA AA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C239', 'COMIS. TIPO C TRANSFERENCIA AC','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C2519', 'COMIS. TIPO C TRANSFERENCIA CC','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C252', 'COMIS. TIPO C DEPOSITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C2520', 'COMIS. TIPO C TRANSFERENCIA CA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C253', 'COMIS. TIPO C N. CREDITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C2626', 'COMIS. TIPO C TRANSFERENCIA CC','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C2627', 'COMIS. TIPO C TRANSFERENCIA CA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C263', 'COMIS. TIPO C RETIRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C264', 'COMIS. TIPO C N. DEBITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C294', 'COMIS. TIPO C TRANSFERENCIA AC','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C300', 'COMIS. TIPO C TRANSFERENCIA AA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C380', 'COMIS. TIPO C RET. CHQ. GERENCIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'CMTR', 'TRANSFERENCIA DE ALIANZA CORMECIAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'D1', 'COSTO DE CHQ DOLARES','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'M', 'COMISION TIPO COBRO MENSUAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'SMA', 'SALDO MAXIMO DE LA CUENTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'SMI', 'SALDO MINIMO DE LA CUENTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'T', 'COMISION TIPO COBRO CONTADOR GENERAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W230', 'COMIS. TIPO W CONSULTA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W237', 'COMIS. TIPO W TRANSFERENCIA AA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W239', 'COMIS. TIPO W TRANSFERENCIA CA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W2519', 'COMIS. TIPO W TRANSFERENCIA CC','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W252', 'COMIS. TIPO W DEPOSITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W2520', 'COMIS. TIPO W TRANSFERENCIA CA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W253', 'COMIS. TIPO W N. CREDITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W2626', 'COMIS. TIPO W TRANSFERENCIA CC','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W2627', 'COMIS. TIPO W TRANSFERENCIA CA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W263', 'COMIS. TIPO W RETIRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W264', 'COMIS. TIPO W N. DEBITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W294', 'COMIS. TIPO W TRANSFERENCIA CA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W300', 'COMIS. TIPO W TRANSFERENCIA AA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'W380', 'COMIS. TIPO W RET. CHQ. GERENCIA','V')
select @w_codigo = @w_codigo + 1

print 'Tipo de atributo'
insert into cl_tabla values (@w_codigo, 'pe_tipo_atributo', 'Tipo de atributo')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'A', 'SOBRE SALDO DISPONIBLE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'B', 'SOBRE PROMEDIO CONTABLE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C', 'SOBRE SALDO CONTABLE','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'D', 'GENERAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'E', 'SOBRE PROMEDIO DISPONIBLE MENSUAL','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'F', 'PORCENTAJE TIEMPO PERMANENCIA','V')
select @w_codigo = @w_codigo + 1

print 'Tipo de Cobro Cobro Comisiones'
insert into cl_tabla values (@w_codigo, 'pe_tipo_cobro', 'Tipo de Cobro Cobro Comisiones')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, 'C','COBRO CONTADOR TIPO TRN', 'V') 
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, 'M','COBRO MENSUAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, 'T','COBRO CONTADOR GENERAL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, 'W','COBRO CONTADOR TRN', 'V') 
select @w_codigo = @w_codigo + 1

print 'Tipo de datos'
insert into cl_tabla values (@w_codigo, 'pe_tipo_dato', 'Tipo de datos')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'M', 'MONTO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'P', 'PORCENTAJE','V')
select @w_codigo = @w_codigo + 1

print 'Tipo de Ente'
insert into cl_tabla values (@w_codigo,'pe_tipo_ente','Tipo de Ente')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'C', 'COMPANIA', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, 'P', 'PERSONA', 'V') 
select @w_codigo = @w_codigo + 1

print 'TRANSACCIONES COBRO COMISION'
insert into cl_tabla values (@w_codigo, 'pe_transaccion', 'TRANSACCIONES COBRO COMISION')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '230', 'CONSULTA DE SALDO EN CAJA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '237', 'TRN DEBITO CUENTAS AHORRO AHORRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '252', 'DEPOSITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '253', 'NOTA CREDITO AHORROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '263', 'RETIRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '264', 'NOTA DEBITO AHORROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '300', 'TRN CREDITO CUENTAS AHORRO AHORRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '380', 'RETIROS EN CHEQUE DE GERENCIA','V')

select @w_codigo = @w_codigo + 1

print 'AUTORIZACION DE TRANSACCIONES POR CAJA'
insert into cl_tabla values (@w_codigo, 'pe_aut_trn_caja', 'AUTORIZACION DE TRANSACCIONES POR CAJA')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '237', 'DEBITO TRANSF. DE AHO A AHO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '2519', 'TRANSFERENCIA ENTRE CUENTAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '252', 'DEPOSITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '253', 'NOTA DE CREDITO DE AHORROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '263', 'RETIRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '264', 'NOTA DE DEBITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '300', 'CREDITO TRANSF. DE CTE A CTE','V')

select @w_codigo = @w_codigo + 1
--jca
print 'cl_est_plantillas_contratos'

insert into cobis..cl_tabla values(@w_codigo,'cl_est_plantillas_contratos','Estados de Plantillas de Contratos')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado)  values(@w_codigo,'V','VIGENTE','V')
insert into cobis..cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo,'I','INACTIVO','V')
insert into cobis..cl_catalogo_pro values('AHO',@w_codigo)
 
select @w_codigo = @w_codigo + 1

print 're_plantillas'

insert into cobis..cl_tabla values(@w_codigo,'re_plantillas','Plantillas de Contratos')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHO.RPT','CONTRATO AHORROS PERSONA'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONAHJ.RPT','CONTRATO AHORROS JURIDICO'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASA.RPT','CERTIFICADO APORTACION PERSONA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CERASJ.RPT','CERTIFICADO APORTACION JURIDICO'     ,'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AHPROP.RPT','CONTRATO AHORROS CONTRACTUAL PERSONA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AHPROJ.RPT','CONTRATO AHORROS CONTRACTUAL JURIDICO','V')
insert into cobis..cl_catalogo_pro(cp_producto, cp_tabla) values('PER',@w_codigo)
insert into cobis..cl_catalogo_pro(cp_producto, cp_tabla) values('ADM',@w_codigo)
select @w_codigo = @w_codigo + 1

update cl_seqnos set siguiente = @w_codigo
where tabla='cl_tabla'
go


