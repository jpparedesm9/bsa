use cobis
go

declare @w_tabla int

select @w_tabla = max(codigo) + 1 from cl_tabla

if exists(select 1 from cl_tabla where tabla = 'bpl_rule_type')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'bpl_rule_type')
	delete cl_tabla where tabla = 'bpl_rule_type'
end
INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla, 'bpl_rule_type', 'Tabla de tipo de reglas' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla, 'P', 'Políticas', 'V' ) 
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla, 'R', 'Reglas', 'V' )

if exists(select 1 from cl_tabla where tabla = 'bpl_rule_subtype')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'bpl_rule_subtype')
	delete cl_tabla where tabla = 'bpl_rule_subtype'
end
INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla + 1, 'bpl_rule_subtype', 'Tabla de subtipo de reglas' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 1, 'CRE', 'Producto de crédito', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 1, 'CCA', 'Producto de cartera', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 1, 'BDG', 'Bodega', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 1, 'SVCC', 'Segmentación VCC', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 1, 'APF', 'Rubros y Parámetros APF', 'V' )

if exists(select 1 from cl_tabla where tabla = 'bpl_rule_status')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'bpl_rule_status')
	delete cl_tabla where tabla = 'bpl_rule_status'
end
INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla + 2, 'bpl_rule_status', 'Tabla para el estado de las reglas' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 2, 'DIS', 'Diseño', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 2, 'PRO', 'Produccion', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 2, 'ANT', 'Anterior', 'V' )

if exists(select 1 from cl_tabla where tabla = 'wf_type_variable')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'wf_type_variable')
	delete cl_tabla where tabla = 'wf_type_variable'
end

INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla + 3, 'wf_type_variable', 'Tabla de tipo de variables' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 3, 'C', 'Cartera', 'V' ) 
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 3, 'CR', 'Crédito', 'V' ) 
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 3, 'BD', 'Bodega', 'V' ) 



if exists(select 1 from cl_tabla where tabla = 'wf_subType_variable')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'wf_subType_variable')
	delete cl_tabla where tabla = 'wf_subType_variable'
end

INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla + 4, 'wf_subType_variable', 'Tabla de subtipos de variables' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 4, 'CCA', 'Variables de Cartera', 'V' ) 
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 4, 'CRE', 'Variables de Crédito', 'V' ) 
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 4, 'BDG', 'Variables de Bodega', 'V' ) 


if exists(select 1 from cl_tabla where tabla = 'bpl_status')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'bpl_status')
	delete cl_tabla where tabla = 'bpl_status'
end
INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla + 5, 'bpl_status', 'Tabla de estado de Reglas' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 5, 'V', 'vigente', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 5, 'C', 'Cancelado', 'V' )

if exists(select 1 from cl_tabla where tabla = 'bpl_type_dependence')
begin
	delete cl_catalogo where tabla = (select codigo from cl_tabla where tabla = 'bpl_type_dependence')
	delete cl_tabla where tabla = 'bpl_type_dependence'
end
INSERT INTO cl_tabla ( codigo, tabla, descripcion ) VALUES ( @w_tabla + 6, 'bpl_type_dependence', 'Dependencias de Reglas' ) 

INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 6, '01', 'Proceso', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 6, '02', 'Producto', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 6, '03', 'Orquestación', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 6, '04', 'Funcionalidad', 'V' )
INSERT INTO cl_catalogo ( tabla, codigo, valor, estado ) VALUES ( @w_tabla + 6, '05', 'Otra', 'V' )

go

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_rule', 3, 'rl_id' ) 

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_version')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_version'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_rule_version', 3, 'rv_id' )

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_condition')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_condition'
end 
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_condition', 1, 'cr_id' )
 
if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_process_ejec')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_process_ejec'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_rule_process_ejec', 1, 'pr_id' ) 

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_variable_process_ejec')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_variable_process_ejec'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_variable_process_ejec', 1, 'vp_id' ) 

if exists(select 1 from cl_seqnos where bdatos = 'cob_workflow' and tabla = 'wf_rule_process')
begin
    delete cl_seqnos where bdatos = 'cob_workflow' and tabla = 'wf_rule_process'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_workflow', 'wf_rule_process', 1, 'rp_id' ) 

if exists(select 1 from cobis..cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_system_rule')
begin
delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_system_rule'
end
insert into cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES( 'cob_pac', 'bpl_system_rule' , 1, 'sr_id')

if exists(select 1 from cobis..cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_subtype_rule')
begin
DELETE cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_subtype_rule'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES( 'cob_pac', 'bpl_subtype_rule', 1, 'su_id') 

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_dependence')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_dependence'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_rule_dependence', 1, 'pr_id' ) 

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_process')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_process'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_rule_process', 1, 'pr_id' ) 

if exists(select 1 from cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_process_ejec')
begin
    delete cl_seqnos where bdatos = 'cob_pac' and tabla = 'bpl_rule_process_ejec'
end
INSERT INTO cl_seqnos ( bdatos, tabla, siguiente, pkey ) VALUES ( 'cob_pac', 'bpl_rule_process_ejec', 1, 'pr_id' ) 

go
