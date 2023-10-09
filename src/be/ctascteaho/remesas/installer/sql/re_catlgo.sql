use cobis
go
/*************/
/*   TABLA   */
/*************/
delete cl_catalogo_pro from cl_tabla
where  cl_tabla.tabla in ('re_trn_ofiorig',     're_canales',
                          're_titularidad',     're_canal_enroll',     're_canal_act',         're_id_enroll',      're_equivalencias', 
                          're_eq_tabla',        're_novedades_enroll', 're_mes',               're_tipo_transfer', 're_marca_servicio',
						  're_estado_servicio', 're_naturaleza_trn',   're_concepto_contable', 're_campo_totaliza', 're_signo_ndc',
                          're_pro_banc_cb',     're_origen_cheque',    're_producto_chq',      're_echeque')
  and  codigo = cp_tabla

delete cl_catalogo from cl_tabla
where  cl_tabla.tabla in ('re_trn_ofiorig',     're_canales',
                          're_titularidad',     're_canal_enroll',     're_canal_act',         're_id_enroll',      're_equivalencias', 
                          're_eq_tabla',        're_novedades_enroll', 're_mes',               're_tipo_transfer',  're_marca_servicio',
						  're_estado_servicio', 're_naturaleza_trn',   're_concepto_contable', 're_campo_totaliza', 're_signo_ndc',
                          're_pro_banc_cb',     're_origen_cheque',    're_producto_chq',      're_echeque')
  and  cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where  cl_tabla.tabla in ('re_trn_ofiorig',     're_canales',
                          're_titularidad',     're_canal_enroll',     're_canal_act',         're_id_enroll',      're_equivalencias', 
                          're_eq_tabla',        're_novedades_enroll', 're_mes',               're_tipo_transfer',  're_marca_servicio',
						  're_estado_servicio', 're_naturaleza_trn',   're_concepto_contable', 're_campo_totaliza', 're_signo_ndc',
                          're_pro_banc_cb',     're_origen_cheque',    're_producto_chq',      're_echeque')
go

---------------------------------------------------------------------------------------------------
declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

---------------------------------------------------------------------------------------------------

print 'Transacciones propia de la Oficina'
insert into cl_tabla values (@w_codigo, 're_trn_ofiorig', 'Transacciones propia de la Oficina')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '201', 'APERTURA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '202', 'ACTUALIZACION DE CUENTAS DE AHORROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '203', 'REACTIVACION DE CUENTAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '212', 'LEVANTAMIENTO DE BLOQUEO DE MOVIMIENTOS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '214', 'CANCELACI0N DE CUENTAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '218', 'LEVANTAMIENTO DE BLOQUEO DE VALORES EN CUENTA DE AHORROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '354', 'AUTORIZACION DE SOLICITUD','V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1

print 'CANALES'
insert into cl_tabla values (@w_codigo, 're_canales', 'CANALES')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '1','INTERNET', 'V') 
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '10','BANCA MOVIL', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '2','IVR', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '3','CAJERO AUTOMATICO', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '4','BRANCH', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '5','KIOSKOS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '6','WAP', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '7','CORRESPONSAL BANCARIO', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '8','COMERCIO', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values(@w_codigo, '9','RED POSICIONADA', 'V')


---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Titularidad '
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_titularidad', 'Titularidad ')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'I', 'INDIVIDUAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'M', 'CONJUNTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'S', 'ALTERNA', 'V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'RELACION CANAL ROL'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_canal_enroll', 'RELACION CANAL ROL')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'TAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'BMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'IVR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'INTERNET', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'INTER', 'V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'ACTUALIZACION DE CANAL PARA ENROLAMIENTO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_canal_act', 'ACTUALIZACION DE CANAL PARA ENROLAMIENTO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CB', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'TAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'BANCAMOVIL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'IVR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'INTERNET', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'INTER', 'E')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'RELACION IDENTIFICACION ROL'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_id_enroll', 'RELACION IDENTIFICACION ROL')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CC', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'N', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'TI', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'PA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'CE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'NU', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'NI', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'U', 'V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'TABLAS DE EQUIVALENCIAS COB_REMESAS'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_equivalencias', 'TABLAS DE EQUIVALENCIAS COB_REMESAS')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CANAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CATPRODUC', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CAUSACIERRE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'DOCPROVCC', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'DOCPROVEEDORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'ROLDEUDOR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'TIPCONCEPT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'TIPTRANS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'RPADEPTO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'RPACARGO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'COMTRNA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'CAUSCOND', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'COMTRNA', 'COMISION TRNA ASOCIACION RUBRO TRX', 'V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'TABLAS DE EQUIVALENCIAS-CATALOGO COB_REMESAS'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_eq_tabla', 'TABLAS DE EQUIVALENCIAS-CATALOGO COB_REMESAS')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'cl_canal', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'cl_categoria', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'ah_causa_cierre', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'cl_tipo_documento', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'cl_tipo_documento', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'cr_rol_deudor', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 're_concepto_contable', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'TIPTRANS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'cl_departamento', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'cl_cargo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'cl_trn_central_local', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'ah_causa_nd', 'V')


---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'RELACION NOVEDAD ROL'
INSERT INTO dbo.cl_tabla (codigo, tabla, descripcion)VALUES (@w_codigo, 're_novedades_enroll', 'RELACION NOVEDAD ROL')
insert into cl_catalogo_pro values ('PER', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '01', 'Asociacion Usuario', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '02', 'Eliminacion de Usuario', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '03', 'Reexpedicion', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '04', 'Bloqueos', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '05', 'Desbloqueos', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '06', 'Actualizacion Datos Usuario', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '07', 'Olvido de Clave', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '14', 'Actualizacion Datos Localizacion', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '15', 'Cambio Numero Celular', 'V')


---------------------------------------------------------------------------------------------------
select @w_codigo= @w_codigo + 1
print 'Codigos de meses'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_mes', 'Codigos de meses')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '01', 'ENERO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '02', 'FEBRERO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '03', 'MARZO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '04', 'ABRIL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '05', 'MAYO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '06', 'JUNIO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '07', 'JULIO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '08', 'AGOSTO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '09', 'SEPTIEMBRE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '10', 'OCTUBRE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '11', 'NOVIEMBRE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '12', 'DICIEMBRE', 'V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Tipos de Transferencias'
INSERT INTO dbo.cl_tabla (codigo, tabla, descripcion) VALUES (@w_codigo, 're_tipo_transfer', 'Tipos de Transferencias')
insert into cl_catalogo_pro values ('PER', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '1', 'PAGO DE PLANILLA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '2', 'TRANSFERENCIA A CTA DE AHORRO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado)VALUES (@w_codigo, '3', 'TRANSFERENCIA A CTA CORRIENTE', 'V')

---------------------------------------------------------------------------------------------------
select @w_codigo = max(codigo) + 1
from cobis..cl_tabla
insert into cobis..cl_tabla values (@w_codigo, 're_estado_servicio', 'Estado Servicio')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cobis..cl_catalogo values (@w_codigo, 'H', 'HABILITADO', 'V', null,null,null)
insert into cobis..cl_catalogo values (@w_codigo, 'N', 'NO HABILITADO', 'V', null,null,null)

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Naturaleza'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_naturaleza_trn','Naturaleza')
insert into cl_catalogo_pro values ('REM', @w_codigo)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'D','DEBITO','V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'C','CREDITO','V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Concepto Contable'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_concepto_contable','Concepto Contable')
insert into cl_catalogo_pro values ('REM', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'AUTRETINE','ND AUTORIZACION RETIRO MMINEMBARGABLE','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CAP','CAPITAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CCCUPOCB','CUENTA POR COBRAR CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CH_LOC','CHEQUE LOCAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CH_OTR','CHEQUE REMESA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CH_PRO','CHEQUE PROPIO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CMPANUPOSN','COMPENSACION ANULACION COMPRA POS NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CMPRETATMI','COMPENSACION RETIRO ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CMPRETATMN','COMPENSACION RETIRO ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CMPRETPOSI','COMPENSACION COMPRA POS INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CMPRETPOSN','COMPENSACION COMPRA POS NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDCOMATMI','CONDONACION COM TRANSACCION ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDCOMATMN','CONDONACION COM TRANSACCION ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDCSAATMI','CONDONACION COM CONSULTA ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDCSAATMN','CONDONACION COM CONSULTA ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDCUOMAN','CONDONACION COM CUOTA DE MANEJO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDFINSU','CONDONACION COM FONDOS INSUFICIENTES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDPDTARJ','CONDONACION COM PERDIDA DETERIORO TARJ DEBITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDPININV','CONDONACION COM PIN INVALIDO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CNDROTARJ','CONDONACION COM RETIRO OFICINA TARJ DEBITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CONCHREM','CONFIR CH REMESAS COB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CORAUCCB','CORRECCION AUMENTO CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CORDICCB','CORRECCION DISMINUCION CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CORRGCCB','CORRECCION REGISTRO CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCAUMCB','CXC AUMENTO CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCMRMOV','CXC COMISION COBRO RECARGA BANCA MOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCMUMOV','CXC COMISION NO USO DEL CANAL BANCA MOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCOMATMI','COMISION ATM INTERNACIONALL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCOMATMN','CXC COMISION ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCSAATMI','COM CONSULTA SALDO ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCSAATMN','COM CONSULTA SALDO ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCCUOMAN','CXC COM CUOTA DE MANEJO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCDICCB','CXC DISMINUCION CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCEXCMONT','COMISION EXCEDE MONTO DIARIO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCEXCNUMU','COMISION EXCEDE NUMERO DE USOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCFINSU','CXC CXCFINSU','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCPDTARJ','CXC COM DETERIORO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCPININV','CXC COM PIN INVALIDO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'CXCROTARJ','CXC CXCROTARJ','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'DEVCOMREM','DEVOLUCION COMISION REMESAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'DEVGMF','DEVOLUCION GMF','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'DEVRTEFTE','DEVOLUCION RETENCION EN LA FUENTE','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'EFECTIVO','EFECTIVO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'GMFCARBCO','GMF SOBRE REND. FINANCIEROS A CARGO DEL BANCO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'INT','INTERES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'INTA','CAPITALIZACION INTERES CTAS ACTIVAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'INTI','CAPITALIZACION INTERES CTAS INACTIVAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCABNOEM','ABONO NOMINA EMPLEADOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCABONOPAG','NOTA CREDITO DEVOLUCION SOBRANTE PAGOS CLIENTES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCABPAVI','ABONO PAGO DE VIATICOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJ50RBM','NOTA DE CREDITO DE AJUSTE 50 RBM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJ56RBM','NOTA DE CREDITO DE AJUSTE 56 RBM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJCOMATM','NOTA CREDITO AJUSTE COMISION ATM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJTRNATM','NOTA CREDITO AJUSTE TRANSACCION ATM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJTRNPOS','NOTA CREDITO AJUSTE TRANSACCION POS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJUSERRT','NOTA CREDITO AJUSTE ERROR TECNICO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCAJUSTGMF','NOTA CREDITO REINTEGRO GMF AJUSTE ERROR TECNICO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCDEVCMTD','NOTA CREDITO DEVOLUCION CUOTA DE MANEJO TD','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCDTN','BENEFICIO MUJERES AHORRADORAS EN ACCCION','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCPAGOINCE','NOTA CREDITO PAGO INCENTIVO AL MICROCREDITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRACH','ACH','B')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRACMMOV','NOTA CREDITO ANULACION DE COMPRA EN COMERCIO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRAUCCB','NC AUMENTO DE CUPO CB ADMIN','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCAMREM','CAMARA Y REMESAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCCCBP','NOTA CREDITO CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCCMMOV','NOTA CREDITO COMPRA EN COMERCIO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCOMCB','NOTA CREDITO COMISION CORRESPONSAL BANCARIO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCONV','ABONO DE CONVENIOS EN LINEA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCORDEP','CORRECCION DE DEPOSITOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRCTAEMP','NOTA CREDITO CAMPAÑA AHORRO EMPLEADOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDEPCB','DEPOSITO A CUENTA POR CANAL CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDEPPCO','DEPTO PRESTAMOS CONSUMO','E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDEPRH','DEPTO RECURSOS HUMANOS','E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDEPTRA','DEPTO. TRANSITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDESEMB','DESEMBOLSO DE CREDITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDESPRE','DESEMBOLSO PRESTAMO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDPF','DEPOSITOS PLAZO FIJO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDPTCON','DEPTO CONTABILIDAD','E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRDPTTES','DEPTO TESORERIA','E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCREINPAGC','REINTEGRO PAGO DE CARTERA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRENTMMI','ENTREGA DE FONDOS DE MONTO MINIMO INEMBARGABLE','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRGMFCBCO','NC REINTEGRO GMF','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRINTMAN','ABONO MANUAL DE INTERESES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRINTREC','ABONO INTERESES RECALCULADOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRMANOPE','ENTRADA MANUAL OPERACIONES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRPAGMOV','NOTA CREDITO PAGO PRESTAMO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRPAGPROV','PAGO A PROVEEDORES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRRCMMOV','NOTA CREDITO RETIRO EN COMERCIO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRREACTA','REAPERTURA DE CUENTA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRRECMOV','NOTA CREDITO RECARGA CELULAR BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRREFERI','NC REDENCION DE PUNTOS REFERIDOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRREICHG','REINTEGRO VENTA CHEQUE DE GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRRETPOS','ANULACION COMPRA POS NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRRETPOSI','ANULACION COMPRA POS INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRRGCCB','NC REGISTRO DE CUPO CB ADMIN','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRRVAPDPF','REVERSO DE APERTURA DPF','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRTRANS','TRANSFERENCIA LOCAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRTRNSLD','TRANSFERENCIA DE SALDOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRTRSMOV','NC TRANSFERENCIA BANCAMOVIL PARTE CREDITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCRWU','ABONO REMESAS WU','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NCTRDCTOB','NOTA CREDITO TRANSFERENCIA DE CUENTAS OTROS BANCOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDAJ51RBM','NOTA DE DEBITO DE AJUSTE 51 RBM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDAJ57RBM','NOTA DE DEBITO DE AJUSTE 57 RBM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDAJTRNATM','NOTA DEBITO AJUSTE TRANSACCION ATM','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDAJTRNPOS','NOTA DEBITO AJUSTE TRANSACCION POS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDCOMDISP','ND COMISION DISPERSION DE FONDOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEACMMOV','NOTA DEBITO ANULACION DE COMPRA EN COMERCIO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEAJUCHL','AJUSTE CHEQUES LOCALES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEAJUCHP','AJUSTE CONSIGNACION CHEQUES PROPIOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEAJUCHR','AJUSTE CONSIGNACION CHEQUES REMESAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEAJUEFE','AJUSTE CONSIGNACION EFECTIVO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEAUMDPF','POR AUMENTO A LA RENOVACION DE DPF','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEAUTFLI','ND RETIRO AUTORIZADO FUERA DE LINEA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECANCIN','DEBITO POR CANCELACION CUENTAS INACTIVAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECCCBP','NOTA DEBITO CUPO CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECCMMOV','NOTA DEBITO COMPRA EN COMERCIO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECCSMOV','ND COMISION CONSULTA SALDO BANCA MOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECGAREM','COMISION GASTO CORRESPONSAL CHEQUE REMESA','B')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECHQGER','VENTA DE CHEQUE DE GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECHQREM','POR COMISION CHEQUE REMESA RECIBIDO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECIECHG','CIERRE DE CUENTA - CH GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECIECON','CIERRE DE CUENTA - CONTABLE','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECIECTA','CIERRE DE CUENTA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECIEEFE','CIERRE DE CUENTA - EFECTIVO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECMOMOV','ND COMISION CONSULTA DE MOVIMIENTOS BANCA MOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECMRMOV','ND COBRO RECARGA BANCA MOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECMUMOV','ND COMISION NO USO DEL CANAL BANCA MOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMATMI','COMISION TRANSACCION ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMATMN','COMISION TRANSACCION ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMCB','NOTA DEBITO COMISION POR USO CANAL CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMCHD','CARGO CHEQUE DEVUELTO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMCHGE','COMISION CHEQUE DE GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMCIE','COMISION CIERRE DE CUENTA','B')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMECT','COMISION SOLICITUD EXTRACTO CUENTA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMGER','COMISION CHEQUE DE GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMOFI','COMISION TRANSACCION EN OFICINA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMPOSI','COMISION DE TRANSACCION POS INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMPOSN','COMISION DE TRANSACCION POS NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMREM','CARGO COMISION CHEQUES REMESAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMRETV','COMISION RETIRO POR VENTANILLA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECOMTRF','COMISION TRANSFERENCIAS AUTOMATICAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECONDPF','PARA APERTURA DE DEPOSITOS PLAZO FIJO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECORDEP','CORRECCION DE DEPOSITOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECSAATMI','COMISION CONSULTA ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECSAATMN','COMISION CONSULTA ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDECUOMAN','CUOTA DE MANEJO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDEVCHEX','CHEQUE DEVUELTO EXTRANJERO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDEVEFE','ND CHQ DEV - DESCONTADO DEL EFECTIVO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDEVLOC','ND CHQ DEV - DESCONTADO DEL CANJE','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDICCB','ND DISMINUCION DEL CUPO CB ADMIN','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDIFDEP','DIFERENCIA EN DEPOSITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDPTCON','DEPTO CONTABILIDAD','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEDPTTES','DEPTO TESORERIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEEMBARG','NOTA DEBITO POR CAUSAL DE EMBARGO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEESTCTA','CARGO SOLICITUD ESTADO DE CUENTA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEFINSU','COMISION FONDOS INSUFICIENTES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEGMF','GMF GRAVAMEN MOVIMIENTO FINANCIERO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEIVA','IVA IMPUESTO A LAS VENTAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEMANOPE','ENTRADA MANUAL OPERACIONES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPAGCAR','PAGO DE PRESTAMOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPAGMOV','NOTA DEBITO PAGO PRESTAMO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPCARMAS','PAGO DE PRESTAMOS - PROCESO MASIVO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPDTARJ','COMISION PERDIDA DETERIORO TARJ DEBITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPININV','COMISION PIN INVALIDO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPORREM','CARGO PORTES CHEQUES REMESAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPORTDEV','PORTES POR DEVOLUCION CHQ. REMESAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEPROVEED','NOTA DEBITO PROVEEDORES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERCMMOV','NOTA DEBITO RETIRO EN COMERCIO BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERECINT','RECALCULO DE INTERESES','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERECMOV','NOTA DEBITO RECARGA CELULAR BANCAMOVIL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEREFBAN','COMISION REFERENCIAS BANCARIAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEREIDES','REINTEGRO DESEMBOLSO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEREIDESC','REINTEGRO DESEMBOLSO CARTERA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEREM','ENVIO DEL CHEQUE AL COBRO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERETATMI','RETIRO ATM INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERETATMN','RETIRO ATM NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERETCB','RETIRO DE CUENTA POR CANAL CB','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERETCHGE','RETIRO EN CHEQUE DE GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERETPOS','COMPRA POS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERETPOSI','COMPRA POS INTERNACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEREVCPF','REVERSO CANCELACION DPF','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDEROTARJ','COMISION RETIRO OFICINA TARJ DEBITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERTEFTE','RETENCION EN LA FUENTE SOBRE RENDIMIENTOS FINANCIEROS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDERTEICA','ICA SOBRE RENDIMIENTOS FINANCIEROS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDESUSDOC','SUSTITUCION DE DOCUMENTOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDETRAEXT','TRANSFERENCIA AL EXTERIOR','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDETRANS','TRANSFERENCIA LOCAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDETRASLD','TRANSFERENCIA DE SALDOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDETRNNAL','TRNA COMISION TRANSACCION NACIONAL','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDETRSMOV','ND TRANSFERENCIA BANCAMOVIL PARTE DEBITO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDRVCANDPF','REVERSO CANCELACION  DPF','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'NDTRACTOB','NOTA DEBITO TRANSFERENCIA A CUENTAS OTROS BANCOS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'RET','RETIRO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'REVCOMCHG','REVERSA COMISION VENTA CHQ GERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'REVCOMEX','N/C REVERSO DEBITO DPTO COMERCIO EXTERIOR','B')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'REVMEMACH','REVERSO MEMBRESIA ACH','B')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'REVPOS','REVERSA TRANSACCION RETIRO Y POS','B')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'REVTRACH','REVERSA TRANSFERENCIA ACH BANCA VIRTUAL','B')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Campo Totaliza'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_campo_totaliza','Campo Totaliza')
insert into cl_catalogo_pro values ('REM', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'N','TOT POR TERCERO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'R','REFERENCIA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'S','TOT POR TRANSAC','V')

---------------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'Signo de Causas de ND/NC'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_signo_ndc', 'Signo de Causas de ND/NC')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'C',  'CREDITO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'D', 'DEBITO', 'V')

---------------------------------------------------------------------------------------------------

select @w_codigo = @w_codigo + 1
print 'Marcas de servicios'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_marca_servicio', 'Signo de Causas de ND/NC')
insert into cl_catalogo_pro values ('REM', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'CNB',  'SERVICIO PARA ABONO DE COMISIONES CB', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'COM', 'COMERCIO BANCAMOVIL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'REMWU', 'RECEPCION DE REMESAS WU', 'V')
---------------------------------------------------------------------------------------------------

select @w_codigo = @w_codigo + 1
print 'Productos bancarios Cuenta Corresponsalia'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_pro_banc_cb', 'Catalogo de Productos bancarios Cuenta Corresponsalia')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '0', 'CUENTA CORRESPONSALIA','V')

select @w_codigo = @w_codigo + 1
print 'Tipos de cheques'
insert into cl_tabla values (@w_codigo, 're_origen_cheque', 'Tipos de cheques')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '0', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '1', 'CHEQUES NORMALES - WACHOVIA BANK', 'E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '2', 'CKS EXT VEINTICINCO DIAS', 'E')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '3', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '5', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '7', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '10', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '15', 'CHEQUES EXTRANJEROS', 'V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '25', 'CHEQUES EXTRANJEROS', 'V')
---------------------------------------------------------------------------------------------------

select @w_codigo = @w_codigo + 1
print 'Producto Estados Cheque'
insert into cl_tabla values(@w_codigo, 're_producto_chq', 'PRODUCTO ESTADO CHEQUES')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo values (@w_codigo, '4', 'CUENTA DE AHORROS', 'V', null, null, null)
---------------------------------------------------------------------------------------------------

select @w_codigo = @w_codigo + 1
print 'Estado de Detalle de Cheques de Camara'
insert into cl_tabla values(@w_codigo, 're_echeque', 'ESTADOS DE DETALLE DE CHEQUES DE CAMARA')
insert into cl_catalogo_pro values ('REM', @w_codigo)
insert into cl_catalogo values(@w_codigo,'I','PENDIENTE DE CONFIRMACION','V',null,null,null)
insert into cl_catalogo values(@w_codigo,'C','CONFIRMADO','V',null,null,null)
insert into cl_catalogo values(@w_codigo,'D','DEVUELTO','V',null,null,null)

update cl_seqnos set siguiente = @w_codigo
    where tabla='cl_tabla'
go
