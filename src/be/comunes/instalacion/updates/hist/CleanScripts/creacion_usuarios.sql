USE cobis
GO
declare @w_codigo int
if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'ASESOR MOVIL')
begin
	select @w_codigo = siguiente from cobis..cl_seqnos
	where tabla = 'ad_rol' and bdatos = 'cobis'

	INSERT INTO [cobis].[dbo].[ad_rol]([ro_rol], [ro_filial], [ro_descripcion], [ro_fecha_crea], [ro_creador], [ro_estado], [ro_fecha_ult_mod], [ro_time_out], [ro_admin_seg], [ro_departamento], [ro_oficina])
	VALUES(@w_codigo, 1, 'ASESOR MOVIL', '20171001 20:08:41.0', 1, 'V', '20171001 20:08:41.0', 900, NULL, NULL, NULL)

	update cobis..cl_seqnos set siguiente = (select isnull(max(ro_rol),0) from cobis..ad_rol) + 1 where tabla = 'ad_rol' and bdatos = 'cobis'
end
else
begin
	select @w_codigo = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR MOVIL'
end

update cobis..cl_parametro
set pa_int = @w_codigo
where pa_nemonico = 'MOBROL'

GO






delete cl_funcionario where fu_funcionario > 3
GO

update cobis..cl_seqnos set siguiente = (select isnull(max(fu_funcionario),0) from cobis..cl_funcionario) + 1 where tabla = 'cl_funcionario' and bdatos = 'cobis'
go

declare @w_codigo int
select @w_codigo = siguiente from cobis..cl_seqnos
where tabla = 'cl_funcionario' and bdatos = 'cobis'

INSERT INTO [cobis].[dbo].[cl_funcionario](
[fu_funcionario], [fu_nombre],              [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ERVIN JOSE PRADO LOPEZ', 'M',        'N',                 2,                 9002,          11,          1,               1, getdate(), 'ejprado', getdate(), getdate(), 'V', 'PALE790910', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ENRIQUE RUMOROSO RODRIGUEZ', 'M', 'N', 3, 9002, 6, 1, 1, getdate(), 'erumoroso', getdate(), getdate(), 'V', 'RURE840725JT8', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'KARLA MAYELI CAMPOS PEREZ', 'F', 'N', 3, 9002, 5, 1, 1, getdate(), 'kmcampos', getdate(), getdate(), 'V', 'CAPK8206189PA', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'HUGO SUASTEGUI CERVANTES', 'M', 'N', 3, 9002, 7, 1, 1, getdate(), 'hsuastegui', getdate(), getdate(), 'V', 'SUCH7410226T5', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MARIA GUADALUPE FRANCO RAMIREZ', 'F', 'N', 3, 9002, 9, 1, 1, getdate(), 'mgfrancora', getdate(), getdate(), 'V', 'FARG6703162P3', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'CLAUDIA CARAZAS SALMALVIDES', 'F', 'N', 4, 9002, 8, 1, 1, getdate(), 'ccarazas', getdate(), getdate(), 'V', 'CASC7811217E6', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MANUEL GONZALEZ CULEBRO', 'M', 'N', 1, 9002, 14, 1, 1, getdate(), 'mgonzalezcu', getdate(), getdate(), 'V', 'GOCM7709184T2', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JORGE GARCIA RAMIREZ', 'M', 'N', 1, 9002, 3, 1, 1, getdate(), 'jgarciara', getdate(), getdate(), 'V', 'GARJ740423L8A', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'YARENI THALIA MONGE PEREZ', 'F', 'N', 3, 9002, 17, 1, 1, getdate(), 'ypmonge', getdate(), getdate(), 'V', 'MOPY890302BQ6', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'KARLA JOSEFINA ESPIRITU GOMEZ', 'F', 'N', 3, 9002, 18, 1, 1, getdate(), 'kjespiritu', getdate(), getdate(), 'V', 'EIJK850319AJA ', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'SILVESTRE RAMIREZ MARTINEZ', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'sramirezm', getdate(), getdate(), 'V', 'RAMS751230', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JUAN MANUEL TORRES MERCADO', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'juatorres', getdate(), getdate(), 'V', 'TOMJ600810', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ENRIQUE ARGUELLO AGUIRRE', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'earguelloag', getdate(), getdate(), 'V', 'AUAE920129', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'GABRIEL DE JESUS GARCIA GONZALEZ', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'ggarciago', getdate(), getdate(), 'V', 'GAGG890922 ', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'RAUL MUNOZ LOPEZ', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'rmunoz2', getdate(), getdate(), 'V', 'MULR900109', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'DIEGO ARTURO GARCIA CEDILLO', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'dagarcia', getdate(), getdate(), 'V', 'GACD920320', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JORGE EDUARDO SIMON SALMERON', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'jesimon', getdate(), getdate(), 'V', 'SISJ921007', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ALDO GERARDO CABRERA RAMOS', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'agcabrera', getdate(), getdate(), 'V', 'CARA911213', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ALEJANDRO ESCOTO TORRES', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'aescoto', getdate(), getdate(), 'V', 'EOTA771212TG3', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'RENE HERNANDEZ RIVERA', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'rhernandezri', getdate(), getdate(), 'V', 'HERR680929986', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'GABRIELA ROJAS OROPEZA', 'F', 'N', 6, 9002, 15, 1, 1, getdate(), 'grojasorop', getdate(), getdate(), 'V', 'ROOG8608171H5', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MARIBEL CHAVEZ MARTINEZ', 'F', 'N', 6, 9002, 15, 1, 1, getdate(), 'mchavezma', getdate(), getdate(), 'V', 'CAMM870719R08', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MARIA ANTONIETA OROZCO RAMIREZ', 'F', 'N', 6, 9002, 15, 1, 1, getdate(), 'maorozco', getdate(), getdate(), 'V', 'OORA901129UL2', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MARIA DE JESUS SANCHEZ ALVARADO', 'F', 'N', 6, 9002, 15, 1, 1, getdate(), 'msancheza', getdate(), getdate(), 'V', 'SAAJ8301071S2', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'HECTOR HUGO MORENO REBOLLEDO', 'M', 'N', 6, 9002, 15, 1, 1, getdate(), 'hhmoreno', getdate(), getdate(), 'V', 'MORH9108262G3', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ALEJANDRA PAZ GARCIA', 'F', 'N', 6, 9002, 15, 1, 1, getdate(), 'apazga', getdate(), getdate(), 'V', 'PAGA861127K2A', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'LORIAN CORDERO PEREGRINA', 'F', 'N', 6, 9002, 15, 1, 1, getdate(), 'lcordero', getdate(), getdate(), 'V', 'EOTA771212TG3', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JEIMY MIJANGOS DOMINGUEZ', 'F', 'N', 3, 3351, 3, 1, 1, getdate(), 'jmijangos', getdate(), getdate(), 'V', 'MIDJ900106K14', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ALBERTO MAXIMINO BARRANCO FLORES', 'M', 'N', 3, 3348, 16, 1, 1, getdate(), 'ambarranco', getdate(), getdate(), 'V', 'BAFA740303IS5', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'LUCIA FEBE BERNABE RODRIGUEZ', 'F', 'N', 3, 3348, 4, 1, 1, getdate(), 'lfbernabe', getdate(), getdate(), 'V', 'BERL800924IS7', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'FRANCISCO JAVIER GARCIA LORENZO', 'M', 'N', 3, 3345, 3, 1, 1, getdate(), 'fjgarcialo', getdate(), getdate(), 'V', 'GALF751003FW4', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'SERGIO CRUZ GOMEZ', 'M', 'N', 3, 3348, 3, 1, 1, getdate(), 'scruzgo', getdate(), getdate(), 'V', 'CUGS880103R35', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'NALLELY DIAS ESTRADA', 'F', 'N', 3, 3348, 2, 1, 1, getdate(), 'ndiazes', getdate(), getdate(), 'V', 'DIEN890424RP1', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JORGE ISLAS JUAREZ', 'M', 'N', 3, 3345, 2, 1, 1, getdate(), 'jjuarezis', getdate(), getdate(), 'V', 'JUIJ800307TF9', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MARIA ANTONIETA GIJON SALAZAR', 'F', 'N', 2, 3348, 3, 1, 1, getdate(), 'magijon', getdate(), getdate(), 'V', 'GISA680407CH6', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MONSERRAT ADALUZ MORALES ORTEGA', 'F', 'N', 2, 3345, 3, 1, 1, getdate(), 'mamorales', getdate(), getdate(), 'V', 'MOOM940122DK1', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JULIO GEOVANNY SOTO NUNEZ', 'M', 'N', 2, 3345, 3, 1, 1, getdate(), 'jgsoto', getdate(), getdate(), 'V', 'SONJ910609KA3', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JUAN PABLO SANCHEZ HUERTA', 'M', 'N', 2, 3345, 1, 1, 1, getdate(), 'jpsanchez', getdate(), getdate(), 'V', 'SAHJ700526KF9', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'RODOLFO TAPIA MUNJICA', 'M', 'N', 2, 3348, 1, 1, 1, getdate(), 'rtapiamu', getdate(), getdate(), 'V', 'TAMR7811073R0', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'JESSICA CORONA MARTINEZ', 'F', 'N', 2, 3348, 3, 1, 1, getdate(), 'jcorona', getdate(), getdate(), 'V', 'COMJ9328093M2', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'HECTOR EDUARDO OLVERA RAMIREZ', 'M', 'N', 2, 3348, 2, 1, 1, getdate(), 'heolvera', getdate(), getdate(), 'V', 'OERH621013CY6', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo,'CARLOS OREA TENORIO', 'M', 'N', 2, 3345, 2, 1, 1, getdate(), 'corea', getdate(), getdate(), 'V', 'OETC820213HD7', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'PAOLA MARTINEZ RODRIGUEZ', 'F', 'N', 2, 3354, 1, 1, 1, getdate(), 'pmartinezro', getdate(), getdate(), 'V', 'MARP780921636', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'OSCAR AGUSTIN MENDOZA VILCHIS', 'F', 'N', 2, 3348, 3, 1, 1, getdate(), 'oamendozavi', getdate(), getdate(), 'V', 'MEVO96030441A', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'NATANAEL CASTILLO RAMOS', 'F', 'N', 2, 3348, 3, 1, 1, getdate(), 'ncastillora', getdate(), getdate(), 'V', 'CARN900727UWA', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'KARINA ELIZABETH JIMENEZ GOMEZ', 'M', 'N', 2, 3345, 3, 1, 1, getdate(), 'kejimenez', getdate(), getdate(), 'V', 'JIGK850618F41', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'DANTE VASQUEZ SAAVEDRA', 'M', 'N', 2, 3348, 3, 1, 1, getdate(), 'davazquezsa', getdate(), getdate(), 'V', 'VASD960717VC0', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ZAIRA TURINCIO PASCUAL', 'M', 'N', 2, 3348, 3, 1, 1, getdate(), 'zturincio', getdate(), getdate(), 'V', 'TUPZ940221SH4', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'ARIADNA MIL', 'F', 'N', 2, 3345, 3, 1, 1, getdate(), 'amil', getdate(), getdate(), 'V', 'MIMA8509134T1', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo, 'MOISES ADAN SERRANO GALINDO', 'M', 'N', 2, 3348, 3, 1, 1, getdate(), 'maserrano', getdate(), getdate(), 'V', 'SEGM6811265M1', getdate())

select @w_codigo = @w_codigo  + 1
INSERT INTO [cobis].[dbo].[cl_funcionario]([fu_funcionario], [fu_nombre], [fu_sexo], [fu_dinero], [fu_departamento], [fu_oficina], [fu_cargo], [fu_secuencial], [fu_jefe], [fu_fecha_ing], [fu_login], [fu_fec_inicio], [fu_fec_final], [fu_estado], [fu_cedruc], [fu_fecha_cargo])
VALUES(@w_codigo,'JAVIER RAMIREZ CHOPIN', 'M', 'N', 2, 3345, 3, 1, 1, getdate(), 'fjramirez', getdate(), getdate(), 'V', 'RACF820806RX0', getdate())

select @w_codigo = @w_codigo  + 1
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_codigo, 'MARIBEL LOPEZ VILLASENOR', 'F', 'N', 3, 3345, 4, 1, 1, getdate(), 'mlopezvi', getdate(), getdate(), 'V', 'RURE840725JT8', getdate())


select @w_codigo = @w_codigo  + 1
insert into cl_funcionario (fu_funcionario, fu_nombre, fu_sexo, fu_dinero, fu_oficina, fu_departamento, fu_cargo, fu_secuencial, fu_jefe, fu_nivel, fu_fecha_ing, fu_login, fu_telefono, fu_nomina,fu_estado, fu_clave, fu_offset, fu_cedruc)
values	(@w_codigo, 'usrbatch', 'M', 'N', 1, 1, 1, 3, 0, null, getdate(), 'usrbatch', null, null,'V', '11111111', 0x431574CF3D79CFD840884AF3E4DF8F48, '4444444444')



update cobis..cl_seqnos set siguiente = (select isnull(max(fu_funcionario),0) from cobis..cl_funcionario) + 1 where tabla = 'cl_funcionario' and bdatos = 'cobis'
GO
---

delete cobis..ad_usuario
where us_login in (select fu_login from cobis..cl_funcionario where fu_funcionario > 3)
go

delete cobis..ad_usuario 
where us_login not in (select fu_login from cobis..cl_funcionario)
go

insert into ad_usuario	(us_filial, us_oficina, us_nodo, us_login, us_fecha_asig, us_creador, us_estado, us_fecha_ult_mod, us_fecha_ult_pwd)
values	(1, 9001, 1, 'usrbatch', getdate(), 1, 'V', getdate(), getdate())
go
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'ejprado', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'erumoroso', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'kmcampos', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'hsuastegui', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'mgfrancora', getdate(), 3, getdate(), getdate(), 'V')
GO


INSERT INTO [cobis].[dbo].[ad_usuario](
      [us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1,          9002,          1,        'ccarazas', getdate(),        3,           getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'mgonzalezcu', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'jgarciara', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'ypmonge', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'kjespiritu', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'sramirezm', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'juatorres', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'earguelloag', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'ggarciago', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'rmunoz2', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'dagarcia', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'jesimon', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'agcabrera', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'aescoto', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'rhernandezri', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'grojasorop', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'mchavezma', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'maorozco', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'msancheza', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'hhmoreno', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'apazga', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9002, 1, 'lcordero', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3351, 1, 'jmijangos', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'ambarranco', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'lfbernabe', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'mlopezvi', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'fjgarcialo', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'scruzgo', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'ndiazes', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'jjuarezis', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'magijon', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'mamorales', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'jgsoto', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'jpsanchez', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'rtapiamu', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'jcorona', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'heolvera', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'corea', getdate(), 3, getdate(), getdate(), 'V')
GO

INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3354, 1, 'pmartinezro', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'oamendozavi', getdate(), 3, getdate(), getdate(), 'V')
GO

INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'ncastillora', getdate(), 3, getdate(), getdate(), 'V')
GO

INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'kejimenez', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'davazquezsa', getdate(), 3, getdate(), getdate(), 'V')
GO

INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'zturincio', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'amil', getdate(), 3, getdate(), getdate(), 'V')
GO

INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3348, 1, 'maserrano', getdate(), 3, getdate(), getdate(), 'V')
GO


INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 3345, 1, 'fjramirez', getdate(), 3, getdate(), getdate(), 'V')
GO


INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'ambarranco', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'lfbernabe', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'mlopezvi', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'fjgarcialo', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'scruzgo', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'ndiazes', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'jjuarezis', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'magijon', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'mamorales', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'jgsoto', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'jpsanchez', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'rtapiamu', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'jcorona', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'heolvera', getdate(), 3, getdate(), getdate(), 'V')
GO
INSERT INTO [cobis].[dbo].[ad_usuario]([us_filial], [us_oficina], [us_nodo], [us_login], [us_fecha_asig], [us_creador], [us_fecha_ult_mod], [us_fecha_ult_pwd], [us_estado])
VALUES(1, 9001, 1, 'corea', getdate(), 3, getdate(), getdate(), 'V')
GO

delete cobis..ad_usuario_rol
where ur_login in (select fu_login from cobis..cl_funcionario where fu_funcionario > 3)

delete cobis..ad_usuario_rol 
where ur_login not in (select fu_login from cobis..cl_funcionario)
go


INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('usrbatch', 2, getdate(), 3, 'V', getdate(), 1)
GO

INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('ejprado', 3, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('erumoroso', 13, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('kmcampos', 3, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('hsuastegui', 13, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('mgfrancora', 13, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('ccarazas', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('mgonzalezcu', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jgarciara', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('ypmonge', 13, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('kjespiritu', 13, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('sramirezm', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('juatorres', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('earguelloag', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('ggarciago', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('rmunoz2', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('dagarcia', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jesimon', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('agcabrera', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('aescoto', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('rhernandezri', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('grojasorop', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('mchavezma', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('maorozco', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('msancheza', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('hhmoreno', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('apazga', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('aescoto', 3, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('lcordero', 3, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jmijangos', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('ambarranco', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('lfbernabe', 10, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('mlopezvi', 10, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('fjgarcialo', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('scruzgo', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('ndiazes', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jjuarezis', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('magijon', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('mamorales', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jgsoto', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jpsanchez', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('rtapiamu', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('jcorona', 12, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('heolvera', 11, getdate(), 3, 'V', getdate(), 1)
GO
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
VALUES('corea', 11, getdate(), 3, 'V', getdate(), 1)
GO
declare @w_codigo int
select @w_codigo = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR MOVIL'
INSERT INTO [cobis].[dbo].[ad_usuario_rol]([ur_login], [ur_rol], [ur_fecha_aut], [ur_autorizante], [ur_estado], [ur_fecha_ult_mod], [ur_tipo_horario])
select fu_login, @w_codigo, getdate(), 3, 'V', getdate(), 1
from cobis..cl_funcionario
where fu_login in ('jmijangos','fjgarcialo','scruzgo','ndiazes','jjuarezis','magijon','mamorales','jgsoto','jcorona','heolvera','corea','oamendozavi','ncastillora','kejimenez','davazquezsa','zturincio','amil','maserrano','fjramirez')
go


update cobis..cl_funcionario set fu_offset =	0xFCFD2ABA19A088BBA7624E1845B89A6A	where fu_login = 'ejprado'
update cobis..cl_funcionario set fu_offset =	0xEF980E4990A7DD38965A29A5E1C28133	where fu_login = 'erumoroso'
update cobis..cl_funcionario set fu_offset =	0x906D84BF2AA01C0CC3B009A4459A86CA	where fu_login = 'kmcampos'
update cobis..cl_funcionario set fu_offset =	0xEB281CA5637FB3B2712FEA382C97CD13	where fu_login = 'hsuastegui'
update cobis..cl_funcionario set fu_offset =	0x66440FCC160C2A62D2E3224D12BBED0A	where fu_login = 'mgfrancora'
update cobis..cl_funcionario set fu_offset =	0xB1370D50B6FF1A278A530CCA74FD2EE3	where fu_login = 'ccarazas'
update cobis..cl_funcionario set fu_offset =	0xAFD2BA05D939218FDD23C0F7E5AFF6CA	where fu_login = 'mgonzalezcu'
update cobis..cl_funcionario set fu_offset =	0xD91EA8E0D3DD26B6ACC51ED6E62D0EC8	where fu_login = 'jgarciara'
update cobis..cl_funcionario set fu_offset =	0x28BC18F0007558A3CC57DA6924595AEB	where fu_login = 'ypmonge'
update cobis..cl_funcionario set fu_offset =	0x46E8BE00E92BC1A9357E495FD5D096C6	where fu_login = 'kjespiritu'
update cobis..cl_funcionario set fu_offset =	0x4C60437DA225AF66597DBCF051908E1B	where fu_login = 'sramirezm'
update cobis..cl_funcionario set fu_offset =	0x90AA667AAE2D8951A29D7303FB507272	where fu_login = 'juatorres'
update cobis..cl_funcionario set fu_offset =	0x1DC32555F6806AAB55B931ACA69AC49A	where fu_login = 'earguelloag'
update cobis..cl_funcionario set fu_offset =	0x154249FCECEBCDDE22A9CF2623BD77B6	where fu_login = 'ggarciago'
update cobis..cl_funcionario set fu_offset =	0x458C9F3D39FB5EC90F0F2C6E4BB051AA	where fu_login = 'rmunoz2'
update cobis..cl_funcionario set fu_offset =	0x20E1DCB8CA05561E74DAE985BAD93663	where fu_login = 'dagarcia'
update cobis..cl_funcionario set fu_offset =	0x9792304B683C3A380EF7CDF231D5FC2A	where fu_login = 'jesimon'
update cobis..cl_funcionario set fu_offset =	0x34EA9FCB7D98760B5E7018727732C497	where fu_login = 'agcabrera'
update cobis..cl_funcionario set fu_offset =	0x5274CC1D905497B7CAD667D0FD418025	where fu_login = 'aescoto'
update cobis..cl_funcionario set fu_offset =	0x98C700326064167E4C0C378E81C9D575	where fu_login = 'rhernandezri'
update cobis..cl_funcionario set fu_offset =	0x9AF12590974ADA216BF8D44AAFC8D623	where fu_login = 'grojasorop'
update cobis..cl_funcionario set fu_offset =	0xC25C5CC7B76A6CFCE5949ACDA1768BC3	where fu_login = 'mchavezma'
update cobis..cl_funcionario set fu_offset =	0xB159315AE40FBD7FA4477AC87C994FB9	where fu_login = 'maorozco'
update cobis..cl_funcionario set fu_offset =	0x7567FE1C88CF93185817F1A7922371FA	where fu_login = 'msancheza'
update cobis..cl_funcionario set fu_offset =	0xFF726C6937993DFF8DB4D951996B1091	where fu_login = 'hhmoreno'
update cobis..cl_funcionario set fu_offset =	0x9313D62E7D366BDA69B4F9978D135F3A	where fu_login = 'apazga'
update cobis..cl_funcionario set fu_offset =	0xA8B06615B1D9612FD85FD9C170EBCF6D	where fu_login = 'lcordero'
update cobis..cl_funcionario set fu_offset =	0xB9D6E2401AD4499A3DD464C55E5F6EDB	where fu_login = 'jmijangos'
update cobis..cl_funcionario set fu_offset =	0xD61174D7D6F5DEA6D50E0ECE8AE43B4D	where fu_login = 'ambarranco'
update cobis..cl_funcionario set fu_offset =	0x4E9252F379CA300E23EBA74F65DFD1A0	where fu_login = 'lfbernabe'
update cobis..cl_funcionario set fu_offset =	0xC2FF809A4F4A985C241F9F3E7007690F	where fu_login = 'fjgarcialo'
update cobis..cl_funcionario set fu_offset =	0xDEF609F949F1820F39915D2D9D9B3D3A	where fu_login = 'scruzgo'
update cobis..cl_funcionario set fu_offset =	0xC041412F4B00E79898667505B99777F8	where fu_login = 'ndiazes'
update cobis..cl_funcionario set fu_offset =	0xF5736076F059D79F1188E3955A9E77AB	where fu_login = 'jjuarezis'
update cobis..cl_funcionario set fu_offset =	0x2AA9C2700C17849AD31EB2961B2CFB75	where fu_login = 'magijon'
update cobis..cl_funcionario set fu_offset =	0x68CBC259047C32DEFF83E945F28C4E1C	where fu_login = 'mamorales'
update cobis..cl_funcionario set fu_offset =	0x372F9BE420F7E1B927CF5CA120D66CC8	where fu_login = 'jgsoto'
update cobis..cl_funcionario set fu_offset =	0x14EEC5D9B7C8DB026B74E11D5B219440	where fu_login = 'jpsanchez'
update cobis..cl_funcionario set fu_offset =	0xF43B4B8D6D857F402A9694295283B7BA	where fu_login = 'rtapiamu'
update cobis..cl_funcionario set fu_offset =	0x2E4A1D6F308662C2A87BB3ECD89AF7CA	where fu_login = 'jcorona'
update cobis..cl_funcionario set fu_offset =	0x7EC4F1C3B908CAB9357F42616135ACDC	where fu_login = 'heolvera'
update cobis..cl_funcionario set fu_offset =	0xF1A9B1FC3F2146699D7623DD5C10AD3F	where fu_login = 'corea'
update cobis..cl_funcionario set fu_offset =	0x7B782FCBFA611E5D20BFD0BDB69D38B2	where fu_login = 'mlopezvi'

go
update cobis..ad_usuario
set us_fecha_ult_mod = dateadd(month,-1,getdate()),
us_fecha_ult_pwd = dateadd(month,-1,getdate())
where us_login in (select fu_login from cl_funcionario where fu_funcionario > 3)

go

delete cobis..cc_oficial where oc_funcionario > 3
go
insert into cobis..cc_oficial
select distinct fu_funcionario, fu_funcionario, 'P',null,3,null,1,null,null,null from cobis..cl_funcionario
where fu_login in ('ambarranco','rtapiamu','heolvera','scruzgo','oamendozavi','ncastillora','maserrano','ndiazes','magijon','jcorona','zturincio','lfbernabe','mlopezvi','jpsanchez','jjuarezis','fjramirez','fjgarcialo','corea','mamorales','jgsoto','amil','kejimenez','davazquezsa')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('ambarranco'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('rtapiamu', 'jpsanchez')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('rtapiamu'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('heolvera', 'ndiazes')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('heolvera'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('scruzgo', 'oamendozavi','ncastillora','maserrano')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('ndiazes'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('magijon', 'jcorona','zturincio','lfbernabe')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('jpsanchez'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('jjuarezis', 'corea')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('jjuarezis'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('fjramirez', 'fjgarcialo')


update cobis..cc_oficial
set oc_ofi_nsuperior = (select oc_oficial from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('corea'))
from cobis..cc_oficial
inner join cobis..cl_funcionario on oc_funcionario = fu_funcionario
where fu_login in ('mamorales', 'jgsoto','amil', 'kejimenez','davazquezsa')

update cobis..cc_oficial
set oc_ofi_nsuperior = 32001
where oc_ofi_nsuperior = 3
go



delete cob_workflow..wf_usuario
go

update cobis..cl_seqnos set siguiente = (select isnull(max(us_id_usuario),0) from cob_workflow..wf_usuario) + 1 where tabla = 'wf_usuario' and bdatos = 'cob_workflow'
go

declare @w_codigo int
select @w_codigo = siguiente from cobis..cl_seqnos
where tabla = 'wf_usuario' and bdatos = 'cob_workflow'

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo, 'ejprado', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 1, 'erumoroso', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 2, 'kmcampos', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 3, 'hsuastegui', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 4, 'mgfrancora', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 5, 'ccarazas', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 6, 'mgonzalezcu', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 7, 'jgarciara', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 8, 'ypmonge', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 9, 'kjespiritu', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 10, 'sramirezm', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 11, 'juatorres', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 12, 'earguelloag', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 13, 'ggarciago', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 14, 'rmunoz2', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 15, 'dagarcia', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 16, 'jesimon', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 17, 'agcabrera', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 18, 'rhernandezri', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 19, 'grojasorop', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 20, 'mchavezma', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 21, 'maorozco', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 22, 'msancheza', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 23, 'hhmoreno', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 24, 'apazga', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 25, 'aescoto', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 26, 'lcordero', 1, 'ACT', '20170622 00:00:00.0', 0, 9002, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 27, 'jmijangos', 1, 'ACT', '20170622 00:00:00.0', 0, 3351, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 28, 'ambarranco', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 29, 'lfbernabe', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 30, 'fjgarcialo', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 31, 'scruzgo', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 32, 'ndiazes', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 33, 'jjuarezis', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 34, 'magijon', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 35, 'mamorales', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 36, 'jgsoto', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 37, 'jpsanchez', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 38, 'rtapiamu', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 39, 'jcorona', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 40, 'heolvera', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 41, 'corea', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 42, 'pmartinezro', 1, 'ACT', '20170622 00:00:00.0', 0, 3354, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 43, 'oamendozavi', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 44, 'ncastillora', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 45, 'kejimenez', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 46, 'davazquezsa', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 47, 'zturincio', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 48, 'amil', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 49, 'maserrano', 1, 'ACT', '20170622 00:00:00.0', 0, 3348, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 50, 'fjramirez', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)

INSERT INTO [cob_workflow].[dbo].[wf_usuario]([us_id_usuario], [us_login], [us_codigo_empresa], [us_estado_usuario], [us_fecha_creacion_usr], [us_id_usuario_sustituto], [us_oficina], [us_tiempo_asignado], [us_num_act_asignadas])
VALUES(@w_codigo + 51, 'mlopezvi', 1, 'ACT', '20170622 00:00:00.0', 0, 3345, 0, 0)


GO
update cobis..cl_seqnos set siguiente = (select isnull(max(us_id_usuario),0) from cob_workflow..wf_usuario) + 1 where tabla = 'wf_usuario' and bdatos = 'cob_workflow'
go

delete cob_workflow..wf_usuario_rol
where ur_id_rol in (select ro_id_rol from cob_workflow..wf_rol where ro_nombre_rol in ('ASESOR','COORDINADOR', 'GERENTE OFICINA','ANALISTA ADMINISTRATIVO'))

insert into cob_workflow..wf_usuario_rol
select us_id_usuario, (select ro_id_rol from cob_workflow..wf_rol where ro_nombre_rol = 'ASESOR'),'LOU',0 from cob_workflow..wf_usuario
where us_login in ('scruzgo','oamendozavi','ncastillora','maserrano','magijon','jcorona','zturincio','jmijangos','fjramirez','fjgarcialo','mamorales','jgsoto','amil','kejimenez','davazquezsa')
go
insert into cob_workflow..wf_usuario_rol
select us_id_usuario, (select ro_id_rol from cob_workflow..wf_rol where ro_nombre_rol = 'COORDINADOR'),'LOU',0 from cob_workflow..wf_usuario
where us_login in ('heolvera','ndiazes','jjuarezis','corea')
go
insert into cob_workflow..wf_usuario_rol
select us_id_usuario, (select ro_id_rol from cob_workflow..wf_rol where ro_nombre_rol = 'GERENTE OFICINA'),'LOU',0 from cob_workflow..wf_usuario
where us_login in ('ambarranco','jpsanchez','rtapiamu')
go
insert into cob_workflow..wf_usuario_rol
select us_id_usuario, (select ro_id_rol from cob_workflow..wf_rol where ro_nombre_rol = 'ANALISTA ADMINISTRATIVO'),'LOU',0 from cob_workflow..wf_usuario
where us_login in ('lfbernabe','mlopezvi')
go


insert into cobis..ad_servicio_autorizado
select sa.ts_servicio, r.ro_rol, sa.ts_producto, sa.ts_tipo, sa.ts_moneda, sa.ts_fecha_aut, sa.ts_estado, sa.ts_fecha_ult_mod from cobis..ad_servicio_autorizado sa,cobis..ad_rol r where ts_rol = 3 and ro_rol <> 3 and ts_servicio not in (select ts_servicio from cobis..ad_servicio_autorizado sa2 where sa2.ts_rol = r.ro_rol and sa.ts_servicio = sa2.ts_servicio)
go


delete cob_sincroniza..si_dispositivo where di_login in (select fu_login from cl_funcionario)

update cobis..cl_seqnos set siguiente = (select isnull(max(di_codigo),0) from cob_sincroniza..si_dispositivo) + 1 where tabla = 'si_dispositivo' and bdatos = 'cob_sincroniza'
go

declare @w_codigo int
select @w_codigo = siguiente from cobis..cl_seqnos
where tabla = 'si_dispositivo' and bdatos = 'cob_sincroniza'


INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081043317', 'D4:AE:05:2A:DF:6B', '1', 'jmijangos', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081043507', 'D4:AE:05:2A:DF:91', '1', 'ambarranco', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081042509', 'D4:AE:05:2A:DE:C9', '1', 'fjgarcialo', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081042491', 'D4:AE:05:2A:DE:C7', '1', 'scruzgo', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '359270078920176', 'DC:66:72:D9:B2:79', '1', 'ndiazes', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '359270078920044', 'DC:66:72:D9:B2:5F', '1', 'jjuarezis', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '359270078920184', 'DC:66:72:D9:B2:7B', '1', 'magijon', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081044083', 'D4:AE:05:2A:E0:05', '1', 'mamorales', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081043168', 'D4:AE:05:2A:DF:4D', '1', 'jgsoto', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081042418', 'D4:AE:05:2A:DE:B7', '1', 'jpsanchez', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '359270078919913', 'DC:66:72:D9:B2:45', '1', 'rtapiamu', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081043861', 'D4:AE:05:2A:DF:D9', '1', 'jcorona', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '359270078920093', 'DC:66:72:D9:B2:69', '1', 'heolvera', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081044059', 'D4:AE:05:2A:DF:FF', '1', 'corea', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617083399097', 'F0:EE:10:42:99:A2', '1', 'pmartinezro', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617084658400', '90:06:28:C5:96:A5', '1', 'oamendozavi', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617083416982', 'F0:EE:10:42:A7:9C', '1', 'ncastillora', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617083398669', 'F0:EE:10:42:99:4C', '1', 'kejimenez', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617083398859', '', '1', 'davazquezsa', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617084626993', '', '1', 'zturincio', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617081048456', '', '1', 'amil', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617083398974', '', '1', 'maserrano', 'P', '20171220 00:00:00.0', 'admuser')

select @w_codigo = @w_codigo  + 1
INSERT INTO [cob_sincroniza].[dbo].[si_dispositivo]([di_codigo], [di_tipo], [di_imei], [di_macaddress], [di_oficial], [di_login], [di_estado], [di_fecha_reg], [di_usuario_reg])
VALUES(@w_codigo, 'AD', '357617083398784', '', '1', 'fjramirez', 'P', '20171220 00:00:00.0', 'admuser')
GO

update cobis..cl_seqnos set siguiente = (select isnull(max(di_codigo),0) from cob_sincroniza..si_dispositivo) + 1 where tabla = 'si_dispositivo' and bdatos = 'cob_sincroniza'
go

update cob_sincroniza..si_dispositivo
set di_oficial = convert(varchar,oc_oficial)
from cob_sincroniza..si_dispositivo
inner join cobis..cl_funcionario on di_login = fu_login
inner join cobis..cc_oficial on fu_funcionario =  oc_funcionario
go

delete cob_sincroniza..si_dispositivo where di_oficial = '1'
go