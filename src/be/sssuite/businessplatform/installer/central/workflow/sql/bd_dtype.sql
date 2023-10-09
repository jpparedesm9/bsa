/*	
**	Script de creacion de los tipos de datos de usuario para la base model
*/
use model
go

print 'Tipo de dato:  mensaje'
if not exists (select * from systypes where name = 'mensaje')
    exec sp_addtype mensaje, 'varchar(255)', 'null'
go

print 'Tipo de dato:  sexo'
if not exists (select * from systypes where name = 'sexo')
    exec sp_addtype sexo, 'char(1)', 'null'
go

if exists (select * from sysobjects where name = 'sexo')
        drop rule sexo
go
    create rule sexo as @var_sexo in ('F', 'M')
go

print 'Tipo de dato:  numero'
if not exists (select * from systypes where name = 'numero')
    exec sp_addtype numero, 'varchar(30)', 'null'
go

print 'Tipo de dato:  descripcion'
if not exists (select * from systypes where name = 'descripcion')
    exec sp_addtype descripcion, 'varchar(64)', 'null'
go
    
print 'Tipo de dato:  direccion'
if not exists (select * from systypes where name = 'direccion')
    exec sp_addtype direccion, 'varchar(255)', 'null'

print 'Tipo de dato:  estado'
if not exists (select * from systypes where name = 'estado')
    exec sp_addtype estado, 'char(1)', 'null'
go

if exists (select * from sysobjects where name = 'r_estado')
        drop rule r_estado
go
    create rule r_estado as @var_estado in ('V', 'E', 'C','B')
go

print 'Tipo de dato:  login'
if not exists (select * from systypes where name = 'login')
    exec sp_addtype login, 'varchar(14)', 'null'
go

print 'Tipo de dato:  catalogo'
if not exists (select * from systypes where name = 'catalogo')
    exec sp_addtype catalogo, 'varchar(10)', 'null'
go

print 'Tipo de dato:  cuenta'
if not exists (select * from systypes where name = 'cuenta')
    exec sp_addtype cuenta, 'varchar(24)', 'null'
go

print 'Tipo de dato: url'
if not exists (select * from systypes where name = 'url')
    exec sp_addtype url, 'varchar(255)', 'null'
go


/*==============================================================*/
/* Domain: udt_account_number                                   */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_account_number')
	execute sp_addtype udt_account_number, 'varchar(30)', 'null'
go

/*==============================================================*/
/* Domain: udt_ach_field                                        */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_ach_field')
	execute sp_addtype udt_ach_field, 'varchar(64)', 'null'
go


/*==============================================================*/
/* Domain: udt_address                                          */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_address')
	execute sp_addtype udt_address, 'varchar(100)', 'null'
go


/*==============================================================*/
/* Domain: udt_alpha_numeric_code                               */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_alpha_numeric_code')
	execute sp_addtype udt_alpha_numeric_code, 'varchar(30)', 'null'
go


/*==============================================================*/
/* Domain: udt_amount                                           */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_amount')
	execute sp_addtype udt_amount, 'money', 'null'
go


/*==============================================================*/
/* Domain: udt_boolean                                          */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_boolean')
	execute sp_addtype udt_boolean, 'bit', 'not null'
go


/*==============================================================*/
/* Domain: udt_card_number                                      */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_card_number')
	execute sp_addtype udt_card_number, 'varchar(16)', 'null'
go


/*==============================================================*/
/* Domain: udt_catalog                                          */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_catalog')
	execute sp_addtype udt_catalog, 'varchar(10)', 'null'
go


/*==============================================================*/
/* Domain: udt_date                                             */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_date')
	execute sp_addtype udt_date, 'date', 'null'
go


/*==============================================================*/
/* Domain: udt_date_time                                        */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_date_time')
	execute sp_addtype udt_date_time, 'datetime', 'null'
go


/*==============================================================*/
/* Domain: udt_description                                      */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_description')
	execute sp_addtype udt_description, 'varchar(255)', 'null'
go


/*==============================================================*/
/* Domain: udt_display_format                                   */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_display_format')
	execute sp_addtype udt_display_format, 'varchar(100)', 'null'
go


/*==============================================================*/
/* Domain: udt_email                                            */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_email')
	execute sp_addtype udt_email, 'varchar(100)', 'null'
go


/*==============================================================*/
/* Domain: udt_external_code                                    */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_external_code')
	execute sp_addtype udt_external_code, 'varchar(60)', 'null'
go


/*==============================================================*/
/* Domain: udt_external_error_code                              */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_external_error_code')
	execute sp_addtype udt_external_error_code, 'varchar(10)', 'null'
go


/*==============================================================*/
/* Domain: udt_fx_rate                                          */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_fx_rate')
	execute sp_addtype udt_fx_rate, 'decimal(18,8)', 'null'
go


/*==============================================================*/
/* Domain: udt_level                                            */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_level')
	execute sp_addtype udt_level, 'smallint', 'null'
go


/*==============================================================*/
/* Domain: udt_long_text                                        */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_long_text')
	execute sp_addtype udt_long_text, 'varchar(1000)', 'null'
go


/*==============================================================*/
/* Domain: udt_name                                             */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_name')
	execute sp_addtype udt_name, 'varchar(100)', 'null'
go


/*==============================================================*/
/* Domain: udt_number                                           */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_number')
	execute sp_addtype udt_number, 'int', 'null'
go


/*==============================================================*/
/* Domain: udt_numeric_code                                     */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_numeric_code')
	execute sp_addtype udt_numeric_code, 'int', 'null'
go


/*==============================================================*/
/* Domain: udt_percentage                                       */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_percentage')
	execute sp_addtype udt_percentage, 'money', 'null'
go


/*==============================================================*/
/* Domain: udt_sequential                                       */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_sequential')
	execute sp_addtype udt_sequential, 'int', 'null'
go


/*==============================================================*/
/* Domain: udt_software_version                                 */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_software_version')
	execute sp_addtype udt_software_version, 'varchar(30)', 'null'
go


/*==============================================================*/
/* Domain: udt_telephone                                        */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_telephone')
	execute sp_addtype udt_telephone, 'varchar(30)', 'null'
go


/*==============================================================*/
/* Domain: udt_time                                             */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_time')
	execute sp_addtype udt_time, 'time', 'null'
go


/*==============================================================*/
/* Domain: udt_trx_code                                         */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_trx_code')
	execute sp_addtype udt_trx_code, 'int', 'null'
go


/*==============================================================*/
/* Domain: udt_url                                              */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_url')
	execute sp_addtype udt_url, 'varchar(255)', 'null'
go


/*==============================================================*/
/* Domain: udt_user                                             */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_user')
	execute sp_addtype udt_user, 'varchar(30)', 'null'
go


/*==============================================================*/
/* Domain: udt_zip_code                                         */
/*==============================================================*/
if not exists(select 1 from systypes where name='udt_zip_code')
	execute sp_addtype udt_zip_code, 'varchar(30)', 'null'
go
