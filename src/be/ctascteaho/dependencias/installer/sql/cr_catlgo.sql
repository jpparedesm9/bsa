use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cr_sib')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cr_sib')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cr_sib')
go
----------------------------------------------------------------------------------------------

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
 
----------------------------------------------------------------------------------------------
select @w_codigo = @w_codigo + 1
print 'TABLA DE CORRESPONDENCIA Y PROCESOS'
INSERT INTO cl_tabla (codigo, tabla, descripcion)VALUES (@w_codigo, 'cr_sib', 'TABLA DE CORRESPONDENCIA Y PROCESOS')
insert into cl_catalogo_pro values ('CRE', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '102', 'LINEAS DE CREDITO TERRITORIAL CENTRO', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '103', 'LINEAS DE CREDITO TERRITORIAL OCCIDENTE', 'E')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T1', 'CODIS DE GARANTIA HIPOTECARIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T100', 'CODIS DE LAS CUENTAS DE PASIVOS PARA REPLICAR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T1000', 'PERIODOS PARA NORMALIZACION /URBANO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T1001', 'PERIODOS PARA NORMALIZACION /RURAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T101', 'CODIS DE OBLIGACIONES DE LA EMPRESA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T102', 'LINEAS DE CREDITO TERRITORIAL CENTRO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T103', 'LINEAS DE CREDITO TERRITORIAL OCCIDENTE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T104', 'ACTIVOS FIJOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T105', 'ACCIONES DE COBRANZA CORRESPONDIENTES A ACUERDOS DE PA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T106', 'SERVICIOS WEB POR ENTIDAD EXTERNA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T107', 'CORRESPONDENCIA CIUDADES BANCOLDEX - COBIS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T108', 'COSTOS DE COBRANZA PERMITEN VARIOS COBROS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T110', 'CALIFICACIONES DEFINITIVAS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T111', 'CORRESPONDENCIA ORIGEN RECUROS JUSTIFICACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T112', 'CALIFICACION CONSUMO -LINEAS DE CREDITO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T113', 'CALIFICACION CONSUMO -HOMOLOGACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T114', 'LINEAS DE CREDITO EMPLEADOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T115', 'LINEAS DE CREDITO EMPLEADOS: CONSUMO/HIPOTECARIAS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T116', 'MAXIMO PERMITIDO DE CREDITOS ACTIVOS DE UN CLIENTE POR BANCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T118', 'MOTIVOS DE REESTRUCTURACION EXENTOS DE BLOQUEO CUPOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T119', 'PLAZO - PORCENTAJE DE RESPALDO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T12', 'COSTOS VS CONCEPTOS DE CUENTAS POR PAGAR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T120', 'TIPO DE EMPLEO PARA EVALUACION DE MONTO TOPE DE TRAMITE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T121', 'PLAZO - GARANTIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T122', 'MODELO MIR -CALIFICACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T124', 'VARIABLES DE SALIDA GESTOR MIR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T125', 'NUMERO MAXIMO DE REESTRUCTURACIONES POR BANCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T126', 'TIEMPO MINIMO PARA PERMITIR NUEVAS REESTRUCTURACIONES POR BANCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T127', 'VARIABLES DE APROBACION PARA MIR POR BANCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T128', 'ESQUEMA DE RUTEO (MIR / COBIS) POR BANCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T130', 'GARANTIAS - COLATERALES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T131', 'MAXIMO RIES POR BANCA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T132', 'CODIS GARANTIAS PRENDARIAS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T133', 'HOMOLOGATIPO DE IDENTIFICACION PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T134', 'HOMOLOGACION NIVELES DE ESTUDIO PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T135', 'HOMOLOGACION TIPO SOCIEDAD PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T136', 'HOMOLOGACION DESTINOS PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T137', 'HOMOLOGACION DESTINOS AECI PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T138', 'HOMOLOGACION FORMAS DE AMORTIZACION PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T139', 'HOMOLOGACION CLASES DE GARANTIAS  PARa BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T14', 'REFERENCIAS INHIBITORIAS PARA ESTADOS DEL CLIENTE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T140', 'HOMOLOGACION Ciudades para bancoldex', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T141', 'HOMOLOGATIPO DE IDENTIFICACION PAR ANEXO 5 FNG', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T142', 'HOMOLOGA TIPO DE EMPRESA PARA BANCOLDEX', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T143', 'TIPOS DE GARANTIAS QUE EXIGEN RECUPERACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T144', 'FORMAS DE PA QUE NO PERMITEN REVERSO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T145', 'ESTRATOS PARA GARANTIA AUTOMATICA 2236', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T146', 'CONVENIOS PARA GARANTIA AUTOMATICA 2236', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T147', 'TIPOS DE TRAMITES EXCLUYEN GARANTIA AUTOMATICA 2236', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T148', 'FORMAS DE DESEMBOLSO OFICINAS OPI', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T149', 'CORRESPONDENCIA ORIGEN RECUROS JUSTIFICACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T15', 'REFERENCIAS DE MERCADO PARA ESTADOS DEL CLIENTE', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T150', 'INFORMACION DEFAULT ING. MSV TRAMITE ORIGINAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T151', 'INFORMACION DEFAULT ING. MSV TRAMITE DE CUPO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T152', 'INFORMACION DEFAULT ING. MSV TRAMITE DE UTILIZACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T153', 'INFORMACION DEFAULT ING. MSV TRAMITE DE UNIFICACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T154', 'GARANTIAS QUE PERMITEN PORCENTAJE COBERTURA 0', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T155', 'CONCEPTOS ASOCIADOS A TIPOS DE SEGUROS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T156', 'RUBROS DE INTERESES DE MORA ASOCIADOS A TIPOS DE SEGUROS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T157', 'CONCEPTOS ASOCIADOS A LAS INSTANCIAS DE APROBACION DE MIR/COBIS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T158', 'REGLAS DE NORMALIZACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T160', 'REGLAS DE CREDITO CLIENTES ESPECIALES NORM', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T161', 'EXCEPCIONES COMPORTAMIENTO CLIENTES ESPECIALES NORMALIZACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T162', 'REGLAS RUBROS CONDONACIONES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T166', 'PLAZO MAXIMO REESTRUCTURACION DE CREDITOS NO AGROPECUARIOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T167', 'PLAZO MAXIMO REESTRUCTURACION DE CREDITOS AGROPECUARIOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T17', 'LINEAS REDESCUENTO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T19', 'LINEAS DE CREDITO DE CTA. CTE.', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T2', 'LINEAS DE CREDITO PARA CALIFICAR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T20', 'ETAPA CREACION PLANO FINAGRO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T200', 'HOMOLOGACION LINEAS ACTIVA VS PASIVA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T210', 'CONDICIONES EDADES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T211', 'CONDICIONES PERMANENCIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T212', 'EDADES SEGURO PRIMERA PERDIDA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T213', 'PERMANENCIA SEGURO PRIMERA PERDIDA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T214', 'EDADES SEGURO INDIVIDUAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T215', 'PERMANENCIA SEGURO INDIVIDUAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T22', 'ACTIVACION REDESCUENTO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T25', 'COSTOS DE COBRANZA VS RUBROS DE CARTERA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T3', 'LINEAS DE CREDITO PARA PROVISIONAR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T300', 'CARTAS MORA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T301', 'LINEAS DE CREDITO PERTENECIENTES A FINAGRO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T302', 'DIAS DE MORA PARA CADA HERRAMIENTA DE NORMALIZACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T303', 'FORMAS DE RECONOCIMIENTO POR TIPO DE GARANTIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T305', 'MAXIMO DE NORMALIZACIONES POR HERRAMIENTA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T306', 'MAXIMO DE NORMALIZACIONES POR CAMPANA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T307', 'ROLES QUE NO PUEDEN VISUALIZAR NOTA INTERNA - HISTORIAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T37', 'GASTOS JUDICIALES COBRANZA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T38', 'GASTOS HONORARIOS ABOGADO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T4', 'LINEAS DE CREDITO DE CONVENIOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T40', 'TIPO GTIAS QUE NO CONTABILIZAN ESTADO F', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T5', 'TIPOS DE GARANTIAS CON VENCIMIENTO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T6', 'LINEAS DE CREDITO PARA CALCULO DE RIES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T65', 'GARANTIAS ESPECIALES Y AVALES DE LA NACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T72', 'INFORMACION FINANCIERA CUENTAS QUE SUMAN', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T73', 'CIUDADES DE FUENTES', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T74', 'COD DE LAS VARIABLES DE ACT FIJOS DEC JUR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T75', 'OFICINAS DE LA CIUDAD DE MEDELLIN', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T76', 'CODIS DE CUENTAS PARA TOTALES DE MICROEMPRESA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T77', 'LINEAS DE CREDITO PARA PARALELOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T78', 'CODIS DE TIPO DE CARNE CON FACTOR LIBRAS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T79', 'CODIS DE PARAMETROS PARA TIPO CARNICERIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T80', 'CODIS DE ETAPAS DE CALIFICACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T81', 'PALM', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T82', 'PALM', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T83', 'ARCHIVO FNG GENERO DEL DEUDOR', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T84', 'ARCHIVO FNG ESTADO CIVIL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T85', 'ARCHIVO FNG NIVEL DE ESTUDIOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T86', 'ARCHIVO FNG codigo MONEDA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T87', 'ARCHIVO FNG codigo DE PLAZO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T88', 'ARCHIVO FNG codigo TASA INDEXADA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T89', 'ARCHIVO FNG codigo PERIODO DE TASA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T90', 'ARCHIVO FNG MODALIDAD DE TASA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T91', 'ARCHIVO FNG PERIODICIDAD DE AMORTIZACION DE CAPITAL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T92', 'ARCHIVO FNG CALIFICACION DE RIES DE LA OBLIGACION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T93', 'ARCHIVO FNG TIPO DE CARTERA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T94', 'ARCHIVO FNG DESTINO DEL CREDITO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T95', 'ARCHIVO FNG TIPO DE RECURSOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T96', 'ARCHIVO FNG PERIODO DE COBRO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T97', 'ARCHIVO FNG DE LA COMISION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T98', 'ARCHIVO FNG codigo DEL PRODUCTO GARANTIA', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'T99', 'CODIS DE LAS CUENTAS DE PASIVOS', 'V')

----------------------------------------------------------------------------------------------

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

go

