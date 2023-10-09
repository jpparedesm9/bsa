declare
   @w_sp_name       varchar(20),
   @w_s_app         varchar(50),
   @w_path          varchar(100),
   @w_destino       varchar(2500),
   @w_msg           varchar(200),
   @w_error         int,
   @w_errores       varchar(1500),
   @w_comando       varchar(2500),
   -- ----------------------------
   @w_member_code   varchar(20),
   -- ----------------------------
   @w_dia           varchar(2),
   @w_mes           varchar(2),
   @w_ano           varchar(4),
   @w_ext_arch      varchar(6),
   @w_nom_arch      varchar(50),
   @w_nom_log       varchar(50),
   @w_fecha_default datetime,
   @w_hora            varchar(2),
   @w_fecha_proceso   datetime,
   @w_fecha_corte     datetime,
   @w_ciudad_nacional int,
   @w_contador        int =0,
   @w_fecha_proc     datetime,
   @w_fecha_fin          varchar(10)
   
select @w_path = ba_path_destino
from cobis..ba_batch
where ba_batch = 36432

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'

select @w_fecha_proceso=fp_fecha 
from cobis..ba_fecha_proceso


	select 
	@w_dia = right('00'+convert(varchar(2),datepart(dd, @w_fecha_proceso)  ),2),
	@w_mes = right('00'+convert(varchar(2),datepart(mm, @w_fecha_proceso)  ),2),
	@w_ano = convert(varchar(4),datepart(yyyy, @w_fecha_proceso))


select @w_hora = convert(varchar(2),datepart(hh, getdate()))

----------------------- Inicio Poblar data -----------------------
declare @entes table (
	cn_ente		 			varchar(20),
	cn_p_apellido			varchar(50),
	cn_s_apellido 			varchar(50),
	cn_nombres				varchar(50),
	cn_num_sucursal			varchar(10),
	cn_rfc					varchar(20),
	cn_sexo					varchar(10),
	cn_nacionalidad_id     catalogo,	
	cn_edo_civil			varchar(20),
	cn_celular				varchar(20),
	cn_correo_electronico	varchar(100),
	cn_fecha_ingreso		varchar(20),
	cn_oficina_id     		catalogo,
	cn_colonia				varchar(100),
	cn_cod_postal			varchar(10),
	cn_ingreso_men_neto		varchar(50),
	cn_procesado			varchar(1) default 'N',
	cn_nacionalidad			varchar(100),
	cn_oficina				varchar(100)
)

insert into @entes
select
	en_ente,		    															-- Número de Empleado
	p_p_apellido,       															-- Primer Apellido
	p_s_apellido,       															-- Segundo Apellido
	en_nombre,	        															-- Nombre (s)
	'0398' as sucursal, 															-- Número de Sucursal
	en_nit,--en_rfc,																			-- RFC
	case p_sexo when 'M' then 'MASCULINO' else 'FEMENINO' end as sexo, 				-- Sexo
	en_nacionalidad, 										-- Nacionalidad
	case p_estado_civil 
		when 'CA' then case p_sexo when 'M' then 'CASADO' else 'CASADA' end
		when 'DI' then case p_sexo when 'M' then 'DIVORCIADO' else 'DIVORCIADA' end
		when 'SO' then case p_sexo when 'M' then 'SOLTERO' else 'SOLTERA' end
		when 'VI' then case p_sexo when 'M' then 'VIUDO' else 'VIUDA' end
		else 'UNION LIBRE' 															-- Estado Civil
	end as estado_civil, 															-- Sexo
	'' as celular, 																	-- Celular
	'' as correo, 																	-- Correo Electrónico
	CONVERT(VARCHAR(10), en_fecha_crea, 103)as fecha_ingreso, 												-- Fecha de Ingreso a la Empresa
	en_oficina, 																	-- Domicilio de Oficina
	'' as colonia, 																	-- Colonia
	'' as codigo_postal, 															-- Código Postal
	'$17,000.00' as ingreso_men_neto, 												-- Ingreso Mensual Neto
	'N',
	'MEXICO',
	'0'
from cobis..cl_ente_aux 
inner join cobis..cl_ente on ea_ente = en_ente
where ea_cta_banco is null 
and isnull(ea_nivel_riesgo_cg, 'F') <> 'F'

delete from @entes
from cob_conta_super..sb_cuentas_N4 n, @entes e
where n.cn_ente = e.cn_ente

update @entes set
cn_nacionalidad = isnull(pa_descripcion, 'MEXICO')
from cobis..cl_pais
where cn_nacionalidad_id = pa_pais

update @entes set
cn_oficina = of_nombre
from cobis..cl_oficina
where cn_oficina_id = of_oficina

insert into cob_conta_super..sb_cuentas_N4 (
cn_ente,				cn_p_apellido,			cn_s_apellido,
cn_nombres,				cn_num_sucursal,		cn_rfc,
cn_sexo,				cn_edo_civil,			cn_celular,
cn_correo_electronico,	cn_fecha_ingreso,		cn_colonia,
cn_cod_postal,			cn_ingreso_men_neto,	cn_nacionalidad,
cn_oficina
)
select 
cn_ente,				cn_p_apellido,			cn_s_apellido,
cn_nombres,				cn_num_sucursal,		cn_rfc,
cn_sexo,				cn_edo_civil,			cn_celular,
cn_correo_electronico,	cn_fecha_ingreso,		cn_colonia,
cn_cod_postal,			cn_ingreso_men_neto,	cn_nacionalidad,
cn_oficina
from @entes


select @w_fecha_fin=convert(varchar(20),@w_mes)+'/'+convert(varchar(20),@w_dia)+'/'+convert(varchar(20),@w_ano)
select @w_fecha_proc=convert (datetime ,@w_fecha_fin)

	update cob_conta_super..sb_cuentas_N4 set
	cn_procesado = 'S',
	cn_fecha_pro = isnull(@w_fecha_proc,getdate()),
	cn_fecha_real=getdate()
	where cn_procesado = 'N'
