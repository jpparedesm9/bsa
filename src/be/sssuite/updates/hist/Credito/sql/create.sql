use cob_credito
go

if not exists(select 1 from sysobjects where name = 'cr_clientes_tmp' and type = 'U')
exec('
    CREATE TABLE dbo.cr_clientes_tmp  ( 
        spid          	smallint NOT NULL,
        ct_tramite    	int NULL,
        ct_usuario    	login NULL,
        ct_ssn        	int NULL,
        ct_tipo_con   	char(1) NULL,
        ct_cliente_con	int NULL,
        ct_cliente    	int NULL,
        ct_relacion   	char(1) NULL,
        ct_identico   	int NULL 
        )
')

if not exists(select 1 from sysobjects where name = 'cr_situacion_inversiones' and type = 'U')
exec('
CREATE TABLE dbo.cr_situacion_inversiones  ( 
	si_cliente          	int NULL,
	si_tramite          	int NULL,
	si_usuario          	login NULL,
	si_secuencia        	int NULL,
	si_tipo_con         	char(1) NULL,
	si_cliente_con      	int NULL,
	si_identico         	int NULL,
	si_categoria        	catalogo NULL,
	si_desc_categoria   	varchar(64) NULL,
	si_producto         	catalogo NULL,
	si_tipo_op          	catalogo NULL,
	si_desc_tipo_op     	varchar(64) NULL,
	si_numero_operacion 	cuenta NULL,
	si_tasa             	float NULL,
	si_fecha_apt        	datetime NULL,
	si_fecha_vct        	datetime NULL,
	si_moneda           	tinyint NULL,
	si_saldo            	money NULL,
	si_saldo_ml         	money NULL,
	si_saldo_promedio   	money NULL,
	si_interes_acumulado	money NULL,
	si_valor_garantia   	money NULL,
	si_fecha_ult_mov    	datetime NULL,
	si_fecha_prox_p_int 	datetime NULL,
	si_fecha_utl_p_int  	datetime NULL,
	si_val_nominal      	float NULL,
	si_precio_mercado   	float NULL,
	si_valor_mercado    	float NULL,
	si_monto_prendado   	float NULL,
	si_precio_compra    	float NULL,
	si_monto_compra     	float NULL,
	si_valor_mercado_ml 	float NULL,
	si_operacion        	int NULL,
	si_estado           	catalogo NULL,
	si_desc_estado      	descripcion NULL,
	si_login            	login NULL,
	si_rol              	char(1) NULL,
	si_bloqueos         	money NULL,
	si_plazo            	int NULL,
	si_fecha_can        	datetime NULL,
	si_oficina          	smallint NULL,
	si_desc_oficina     	descripcion NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'cr_situacion_otras' and type = 'U')
exec('
CREATE TABLE dbo.cr_situacion_otras  ( 
	so_cliente         	int NULL,
	so_usuario         	login NULL,
	so_secuencia       	int NULL,
	so_tipo_con        	char(1) NULL,
	so_cliente_con     	int NULL,
	so_identico        	int NULL,
	so_categoria       	catalogo NULL,
	so_desc_categoria  	varchar(64) NULL,
	so_producto        	catalogo NULL,
	so_tipo_op         	catalogo NULL,
	so_desc_tipo_op    	varchar(64) NULL,
	so_tramite         	int NULL,
	so_numero_operacion	cuenta NULL,
	so_operacion       	int NULL,
	so_tasa            	float NULL,
	so_fecha_apr       	datetime NULL,
	so_fecha_vct       	datetime NULL,
	so_monto           	money NULL,
	so_saldo_vencido   	money NULL,
	so_saldo_x_vencer  	money NULL,
	so_monto_ml        	money NULL,
	so_moneda          	tinyint NULL,
	so_prox_pag_int    	datetime NULL,
	so_ult_fecha_pg    	datetime NULL,
	so_val_utilizado   	money NULL,
	so_val_utilizado_ml	money NULL,
	so_limite_credito  	money NULL,
	so_total_cargos    	money NULL,
	so_saldo_promedio  	money NULL,
	so_ult_fecha_mov   	datetime NULL,
	so_aprobado        	char(1) NULL,
	so_tarjeta_visa    	cuenta NULL,
	so_tramite_d       	int NULL,
	so_subtipo         	catalogo NULL,
	so_tipo_deuda      	char(1) NULL,
	so_calificacion    	descripcion NULL,
	so_estado          	descripcion NULL,
	so_fechas_embarque 	descripcion NULL,
	so_monto_riesgo    	money NULL,
	so_beneficiario    	descripcion NULL,
	so_clase_garantia  	varchar(10) NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'cr_cotiz3_tmp' and type = 'U')
exec('
	CREATE TABLE dbo.cr_cotiz3_tmp  ( 
	spid      	smallint NOT NULL,
	moneda    	tinyint NULL,
	cotizacion	float NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'cr_soli_rechazadas_tmp' and type = 'U')
exec('
CREATE TABLE dbo.cr_soli_rechazadas_tmp  ( 
	spid            	smallint NOT NULL,
	numero_id       	varchar(35) NOT NULL,
	fecha_carga     	varchar(35) NOT NULL,
	numero_operacion	varchar(24) NULL,
	fecha_rechazo   	varchar(35) NULL,
	motivo          	varchar(150) NULL,
	usuario         	varchar(150) NOT NULL,
	modulo          	varchar(10) NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'abono_tmp' and type = 'U')
exec('
CREATE TABLE dbo.abono_tmp  ( 
	spid       	smallint NOT NULL,
	valor      	money NULL,
	operacion  	int NULL,
	negociacion	int NULL,
	forma_pago 	tinyint NULL,
	plazo      	char(1) NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'ri_comext_tmp' and type = 'U')
exec('
CREATE TABLE dbo.ri_comext_tmp  ( 
	spid       	smallint NOT NULL,
	valor      	money NULL,
	moneda     	tinyint NULL,
	vencida    	char(1) NULL,
	tramite    	int NULL,
	tipo_riesgo	catalogo NULL,
	tipo_oper  	varchar(13) NULL,
	etapa      	varchar(3) NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'cr_ope1_tmp' and type = 'U')
exec('
CREATE TABLE cr_ope1_tmp  ( 
	spid           	smallint NOT NULL,
	cliente        	int NULL,
	tramite        	int NULL,
	numero_op      	int NULL,
	numero_op_banco	varchar(24) NULL,
	producto       	varchar(10) NULL,
	tipo_riesgo    	varchar(16) NULL,
	tipo_tr        	char(1) NULL,
	estado         	char(1) NULL,
	monto          	money NULL,
	moneda         	tinyint NULL,
	toperacion     	varchar(10) NULL,
	opestado       	tinyint NULL,
	monto_des      	money NULL,
	tipoop         	char(1) NULL,
	usuario        	login NULL,
	secuencia      	int NULL,
	tipo_con       	char(1) NULL,
	cliente_con    	int NULL,
	identico       	int NULL,
	tramite_d      	int NULL,
	fecha_nip      	datetime NULL,
	fecha_lip      	datetime NULL,
	linea          	cuenta NULL,
	mrc            	money NULL,
	fecha_apt      	datetime NULL,
	anticipo       	int NULL,
	rol            	char(1) NULL,
	plazo          	int NULL,
	frecuencia_pago	varchar(50) NULL,
	motivo_credito 	varchar(64) NULL 
	)
')

if not exists(select 1 from sysobjects where name = 'cr_deud1_tmp' and type = 'U')
exec('
CREATE TABLE cr_deud1_tmp  ( 
	spid              	smallint NULL,
	cliente           	int NOT NULL,
	producto          	varchar(10) NOT NULL,
	tipo_operacion    	varchar(10) NOT NULL,
	desc_tipo_op      	varchar(64) NULL,
	operacion         	varchar(24) NOT NULL,
	linea             	varchar(24) NULL,
	tramite           	int NOT NULL,
	fecha_apt        	char(10) NOT NULL,
	fecha_vto         	char(10) NOT NULL,
	desc_moneda       	varchar(10) NOT NULL,
	monto_orig        	money NOT NULL,
	saldo_vencido     	money NOT NULL,
	saldo_cuota       	money NOT NULL,
	subtotal          	money NOT NULL,
	saldo_capital     	money NOT NULL,
	valorcontrato     	money NOT NULL,
	saldo_total      	money NOT NULL,
	saldo_ml          	money NOT NULL,
	tasa              	varchar(12) NOT NULL,
	refinanciamiento  	char(2) NULL,
	prox_fecha_pag_int	char(10) NULL,
	ult_fecha_pg      	char(10) NULL,
	estado_conta      	varchar(64) NOT NULL,
	clasificacion     	varchar(64) NULL,
	estado            	varchar(64) NOT NULL,
	tipocar           	char(1) NOT NULL,
	moneda            	tinyint NULL,
	rol               	char(1) NOT NULL,
	cod_estado        	varchar(10) NULL,
	nombre_cliente    	varchar(254) NOT NULL,
	tipo_deuda        	char(1) NOT NULL,
	dias_atraso       	int NOT NULL,
	plazo             	int NOT NULL,
	motivo_credito    	varchar(64) NULL,
	tipo_plazo        	varchar(64) NULL,
	restructuracion   	char(1) NOT NULL,
	fecha_cancelacion 	datetime NULL,
	refinanciado      	char(1) NOT NULL,
	calificacion      	char(1) NULL,
	etapa_act         	varchar(255) NULL,
	id_inst_act       	int NULL,
	codigo_alterno    	varchar(50) NULL 
	)
')


go
