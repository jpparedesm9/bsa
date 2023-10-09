use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla like 'cu%'
   and codigo = cp_tabla
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla like 'cu%'
   and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where tabla like 'cu%'
go
      
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
  from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_est_custodia', 'ESTADO CONTABLE DE LA GARANTIA') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', ' ANULADA'                          , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', ' CANCELADA(LIBERACION DE GARANTIA)', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'F', ' VIGENTE FUTUROS CREDITOS'         , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'K', ' CASTIGADA'                        , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', ' PROPUESTA'                        , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'V', ' VIGENTE CON OBLIGACION'           , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'X', ' VIGENTE POR CANCELAR'             , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_fuente_valor', 'FUENTES DE VALOR') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N',      'MIGRACION'                        , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRACUS', 'VALOR DE CUSTODIA'                , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRAVAL', 'VALOR AVALUO COMERCIAL'           , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRCERT', 'VALOR CERTIFICADO FIDUCIARIO'     , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRCONT', 'VALOR CONTRATO DE PRENDA'         , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRDEGR', 'VALOR DE AGOTAMIENTO'             , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRDOCU', 'VALOR DEL DOCUMENTO'              , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRESCR', 'VALOR DE LA ESCRITURA PUBLICA'    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRFACT', 'VALOR FACTURA'                    , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRINTS', 'VALOR INTRINSECO SIN VALORIZACION', 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRLIBR', 'VALOR EN BOLSA DE VALORES'        , 'B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRPORC', 'VALOR PORCENTAJE AVALUO'          , 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VRSEGU', 'VALOR POLIZA DE SEGURO'           , 'B')

go
             
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_cob_poliza', 'RIESGOS CUBIERTOS POR POLIZA') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AUTOS','R.C. EXTRACONTRACTUAL, PERDIDA TOTAL Y PARCIAL POR DANOSPERDIDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'EQUIPOYMAQ','INCENDIO O RAYO, COLISION, VOLCAMIENTO, HUNDIMIENTO DEL TERRENO,','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'INCENDIO','INCENDIO TODO RIESGO, TERREMOTO, AMIT Y OTROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ROTURAMAQ','IMPERICIA, SABOTAJE, CORTO CIRCUITOS, ERRORES EN DISENO, ROTURA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'SUSTRACC','SUSTRACCION CON VIOLENCIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'VIDA','VIDA E INCAPACIDAD TOTAL Y PERMANENTE','E')
go
     
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_clase_custodia', 'ADMISIBILIDAD') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'I', 'IDONEA'   , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'O', 'NO IDONEA', 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_tipo_asig', 'TIPO DE ASIGNACION') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'AMPLIACION DE HIPOTECA'           , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'CANCELACION'                      , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'CONSTITUCION DE GARANTIAS'        , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'CUSTODIA'                         , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '05', 'ESTUDIO DE TITULOS'               , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '06', 'INICIAR COBRO JURIDICO'           , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '07', 'LIBERACION PARCIAL DE GARANTIA'   , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '08', 'REESTRUCTURACION DE LA OBLIGACION', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '09', 'SUSTITUCION DE GARANTIAS'         , 'B') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_tipo_garante', 'TIPO DE GARANTE') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'AMPARADO O GARANTIZADO'     , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CONSTITUYENTE O PROPIETARIO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'J', 'PROPIETARIO/GARANTIZADO'    , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_grado_gtia', 'GRADO GTIA COMPARTIDA') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B' ,'BUENA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M' ,'MALA' , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_entidad_garantias', 'ENTIDAD EMISORA DE GARANTIAS') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'FAG'     , 'FONDO AGROPECUARIO DE GARANTIAS' , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'FNG'     , 'FONDO NACIONAL DE GARANTIAS'     , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'FOGACAFE', 'FEDERACION NACIONAL DE CAFETEROS', 'B') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_tipo_tran', 'TRANSACCIONES') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EGR', 'CANCELACION (LIBERACION DE GTIA)', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EST', 'CAMBIO DE ESTADO CONTABLE'       , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ING', 'CAMBIO DE VALOR'                 , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_perfil', 'PERFILES') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CCC', 'CAMBIO CLASE DE CARTERA' , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CCG', 'CAMBIO CLASE DE GARANTIA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EGR', 'EGRESO'                  , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EST', 'CAMBIO DE ESTADO'        , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ING', 'INGRESO'                 , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_tipo_bien', 'TIPO DE BIEN                                                     ') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'EQUIPARABLES A GARANTIAS IDONEAS', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'I', 'BIENES INMUEBLES'                , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'VALORES MOBILIARIOS'             , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'OTRAS GARANTIAS NO IDONEAS'      , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'O', 'OTROS VALORES MOBILIARIOS'       , 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', 'PRENDARIAS'                      , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_servicio', 'TIPO DE TRANSACCIONES DE SERVICIO') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ACTUALIZACION', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'ELIMINACION'  , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'INSERCION'    , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_caracter', 'CARACTER') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ABIERTA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CERRADA', 'V') 
go
       
declare @w_tabla smallint
   select @w_tabla = max(codigo)+1 from cl_tabla

   insert into cl_tabla values (@w_tabla, 'cu_cuantia', 'CUANTIA') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DETERMINADA'  , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'I', 'INDETERMINADA', 'V') 
go
       
      
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_motivo_sol', 'MOTIVO SOLICITUD') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CAN', 'CANCELACION'                      , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CUS', 'CUSTODIA'                         , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'FOT', 'FOTOCOPIAS'                       , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'HIP', 'AMPLIACION DE HIPOTECA'           , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'JUR', 'COBRO JURIDICO'                   , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'LIB', 'LIBERACION PARCIAL'               , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PET', 'DERECHO DE PETICION'              , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'REE', 'PARA REESTRUCTURACION DE CREDITOS', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'REN', 'RENOVACION                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SB' , 'REQUERIMIENTO SUPERBANCARIA      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TER', 'COBRO A TERCEROS                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TUT', 'TUTELA                           ', 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_estado_doc', 'ESTADO DOCUMENTO') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NOR', 'NORMAL'                             , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NOU', 'NO UBICADO'                         , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NRE', 'NO RECIBIDO POR CENTRAL DE CUSTODIA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PER', 'PERDIDO'                            , 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_ubicacion_doc', 'UBICACION DEL DOCUMENTO') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','COORDINACION REGIONAL DE DESEMBOLSOS','B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','CENTRAL DE CUSTODIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','GERENCIA DE COBRANZA ESPECIALIZADA','B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','GERENCIA REGIONAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'5','OFICINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'6','TARJETAS BANCARIAS','B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'7','UNIDAD DE GARANTIAS','B')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'8','JUZGADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'9','EXPEDIENTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'NA','NO APLICA','B')

go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_causal_nexp', 'CAUSAL DE NO EXPEDICION') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'EPG102607','EPGP','E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESO5207','RECHAZADA SIN GARANTIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5200','RECHAZADAS EXT RADICACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5201','RECHAZADA INFORMACION ERRADA DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5202','RECHAZADA PREP DESPUES DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5203','RECHAZADA RED VIGENTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5204','RECHAZADA EXT DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5205','RECHAZADA SIN AVISO SINIESTRO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5206','RECHAZADA LLAVE ERRADA EN AVISO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5207','RECHAZADA CAMBIO CONDICIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5208','RECHAZADA SIN GARANTIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5209','INADMITIDA DOCUMENTOS INCOMPLETOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5210','INADMITIDA DEMANDA SIN FECHA PRESENTACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5211','INADMITIDA INF ERRADA EN DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESP5212','INADMITIDA INF ERRADA OTROS DOCUMENTOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ESPE5201','RECHAZADA INFORMACION ERRADA DEMANDA','V')
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_estrato_ciudad', 'Estratos por ciudad') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_gar_solicitud', 'SOLICITUD DE GARANTIAS A CUSTODIA') 
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CAN', ' CANCELACION'   , 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CJU', ' COBRO JURIDICO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CON', ' CONSULTA'      , 'V') 
go

declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla
 
insert into cobis..cl_tabla values(@w_tabla,'cu_motivo_noinspeccion','MOTIVOS DE NO VISITA')
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into  cobis..cl_catalogo values (@w_tabla,'99','NO APLICA','V',null,null,null)
go

declare @w_tabla smallint

select @w_tabla = max(codigo) + 1
 from cl_tabla
 
insert into cobis..cl_tabla values(@w_tabla,'cu_des_periodicidad','Periodicidad de la Garantia')
insert into cl_catalogo_pro values ('GAR', @w_tabla) 
insert into  cobis..cl_catalogo values (@w_tabla,'A','AÑO(S)','V',null,null,null)
insert into  cobis..cl_catalogo values (@w_tabla,'B','BIMESTRE(S)','V',null,null,null)
insert into  cobis..cl_catalogo values (@w_tabla,'D','DIA(S)','V',null,null,null)
insert into  cobis..cl_catalogo values (@w_tabla,'M','MES(ES)','V',null,null,null)
insert into  cobis..cl_catalogo values (@w_tabla,'S','SEMESTRE(S)','V',null,null,null)
insert into  cobis..cl_catalogo values (@w_tabla,'T','TRIMESTRE(S)','V',null,null,null)
insert into  cobis..cl_catalogo values (@w_tabla,'W','SEMANAL','V',null,null,null)
go
