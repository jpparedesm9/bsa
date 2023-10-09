use cob_workflow
go

IF OBJECT_ID ('wf_asig_actividad_tmp_156189') IS NOT NULL
	DROP TABLE wf_asig_actividad_tmp_156189
GO

CREATE TABLE wf_asig_actividad_tmp_156189
	(
	tmp_aa_id_asig_act       INT NOT NULL,
	tmp_aa_id_inst_act       INT NOT NULL,
	tmp_aa_codigo_res        SMALLINT,
	tmp_aa_id_destinatario   INT NOT NULL,
	tmp_aa_id_rol            INT,
	tmp_aa_secuencia         SMALLINT NOT NULL,
	tmp_aa_fecha_asig        DATETIME NOT NULL,
	tmp_aa_fecha_fin         DATETIME,
	tmp_aa_estado            VARCHAR (10) NOT NULL,
	tmp_aa_id_usr_reasigno   INT,
	tmp_aa_id_rol_reasigno   INT,
	tmp_aa_id_usr_reasignado INT,
	tmp_aa_id_rol_reasignado INT,
	tmp_aa_id_usr_sustituto  INT,
	tmp_aa_id_rol_sustituto  INT,
	tmp_aa_id_usr_sustituido INT,
	tmp_aa_id_rol_sustituido INT,
	tmp_aa_oficina_asig      SMALLINT NOT NULL,
	tmp_aa_manual            TINYINT,
	tmp_aa_claim             CHAR (1),
	tmp_aa_act_regreso       CHAR (1),
	tmp_aa_id_item_jerarquia INT,
	tmp_aa_oficina_login     INT,
	tmp_aa_canal             INT
	)
GO

INSERT wf_asig_actividad_tmp_156189
SELECT 
tmp_aa_id_asig_act       	=	aa_id_asig_act       	,
tmp_aa_id_inst_act       	=	aa_id_inst_act       	,
tmp_aa_codigo_res        	=	aa_codigo_res        	,
tmp_aa_id_destinatario   	=	aa_id_destinatario   	,
tmp_aa_id_rol            	=	aa_id_rol            	,
tmp_aa_secuencia         	=	aa_secuencia         	,
tmp_aa_fecha_asig        	=	aa_fecha_asig        	,
tmp_aa_fecha_fin         	=	aa_fecha_fin         	,
tmp_aa_estado            	=	aa_estado            	,
tmp_aa_id_usr_reasigno   	=	aa_id_usr_reasigno   	,
tmp_aa_id_rol_reasigno   	=	aa_id_rol_reasigno   	,
tmp_aa_id_usr_reasignado 	=	aa_id_usr_reasignado 	,
tmp_aa_id_rol_reasignado 	=	aa_id_rol_reasignado 	,
tmp_aa_id_usr_sustituto  	=	aa_id_usr_sustituto  	,
tmp_aa_id_rol_sustituto  	=	aa_id_rol_sustituto  	,
tmp_aa_id_usr_sustituido 	=	aa_id_usr_sustituido 	,
tmp_aa_id_rol_sustituido 	=	aa_id_rol_sustituido 	,
tmp_aa_oficina_asig      	=	aa_oficina_asig      	,
tmp_aa_manual            	=	aa_manual            	,
tmp_aa_claim             	=	aa_claim             	,
tmp_aa_act_regreso       	=	aa_act_regreso       	,
tmp_aa_id_item_jerarquia 	=	aa_id_item_jerarquia 	,
tmp_aa_oficina_login     	=	aa_oficina_login     	,
tmp_aa_canal             	=	aa_canal             	
FROM wf_asig_actividad
GO
