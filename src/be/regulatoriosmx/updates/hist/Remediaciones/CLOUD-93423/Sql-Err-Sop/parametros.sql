use cobis
go

-------------
--PARAMETROS
-------------
--Parametro porcentaje para el calculo de la garantia
delete cobis..cl_parametro  where pa_producto = 'CCA' and pa_nemonico = 'DIPRE'

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS MAXIMO PARA PRECANCELACION', 'DIPRE', 'I', NULL, NULL, NULL, 10, NULL, NULL, NULL, 'CCA')

--Parametro de cuenta de convenio
delete cobis..cl_parametro  where pa_producto = 'CCA' and pa_nemonico = 'CTACON'
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CUENTA CONVENIO PRECAN', 'CTACON', 'C', '9742', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

UPDATE cobis..cl_parametro 
SET pa_parametro = 'SANTANDER',
    pa_char= 'SANTANDER'
WHERE pa_nemonico = 'BANCO'


---------
--TABLAS
---------
use cob_cartera
go


IF OBJECT_ID ('dbo.ca_precancela_refer') IS NOT NULL
    DROP TABLE dbo.ca_precancela_refer
GO

CREATE TABLE dbo.ca_precancela_refer (
    pr_secuencial     int not null,
	pr_operacion      int not null,
	pr_banco          varchar(32) not null,
	pr_cliente        int not null,
	pr_monto_pre      money  not null,
	pr_monto_seg      money  not null,
	pr_grupo          int not null,
	pr_tramite_grupal int not null,
	pr_referencia     varchar (64) not null,
	pr_fecha_pro      datetime not null,
	pr_fecha_ven      datetime     null,
	pr_user           varchar(32) not null,
	pr_term           varchar(32) not null,
	pr_mail           varchar(64) not null,

	pr_fecha_liq      datetime not null,
	pr_nombre_cl      varchar(100) not null,
	pr_num_abono      smallint not null,
	pr_nombre_of      varchar(100) not null,
	pr_nombre_banco   varchar(100) not null,
	pr_convenio       int not null,
	pr_estado         varchar(10) not null
)
go

create index idx_1 on ca_precancela_refer(pr_operacion, pr_secuencial)
go
create index idx_2 on ca_precancela_refer(pr_operacion, pr_referencia)
go

----------
--MENU
----------
use cobis
go
declare @num integer, 
        @w_old_menu integer, 
		@w_menu_desc varchar(50), 
		@w_rol integer, 
		@w_id_parent INT, 
		@w_orden int, 
		@w_producto int

select @w_rol = 1, @w_orden = 1

select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'CARTERA'

select @w_old_menu=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_BACK_OFFICE'


select @w_orden = @w_orden + 1

select @w_old_menu = null, 
       @w_id_parent = null, 
       @num = null, 
       @w_menu_desc = 'MNU_PRECANCELLATION_MANT'

select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_menu_desc

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_id = @w_old_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option, me_description)
values(@num,@w_id_parent,@w_menu_desc,'views/ASSTS/TRNSC/T_ASSTSCXBWUFVI_696/1.0.0/VC_PRECANCETA_713696_TASK.html',@w_producto, 1, @w_orden, 0, 'Referencia Liquidación Anticipada de Préstamos')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

go

