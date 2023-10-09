/* Creación de los tipos de datos. */
use cob_workflow
go


/*==============================================================*/
/* Domain: BOOLEANO                                             */
/*==============================================================*/
print 'Tipo de dato:  BOOLEANO'
if not exists (select * from systypes where name = 'BOOLEANO')
    exec sp_addtype BOOLEANO, 'tinyint', 'not null'
go

/*==============================================================*/
/* Domain: CONDICION                                            */
/*==============================================================*/
print 'Tipo de dato:  CONDICION'
if not exists (select * from systypes where name = 'CONDICION')
    exec sp_addtype CONDICION, 'varchar(255)', 'not null'
go

/*==============================================================*/
/* Domain: DESCRIPCION                                          */
/*==============================================================*/
print 'Tipo de dato:  DESCRIPCION'
if not exists (select * from systypes where name = 'DESCRIPCION')
    exec sp_addtype DESCRIPCION, 'varchar(255)', 'null'
go

/*==============================================================*/
/* Domain: descripcion                                          */
/*==============================================================*/
print 'Tipo de dato:  descripcion'
if not exists (select * from systypes where name = 'descripcion')
    exec sp_addtype descripcion, 'varchar(64)', 'not null'
go

/*==============================================================*/
/* Domain: LOGIN                                                */
/*==============================================================*/
print 'Tipo de dato:  LOGIN'
if not exists (select * from systypes where name = 'LOGIN')
    exec sp_addtype LOGIN, 'varchar(30)', 'not null'
go

/*==============================================================*/
/* Domain: login                                                */
/*==============================================================*/
print 'Tipo de dato:  login'
if not exists (select * from systypes where name = 'login')
    exec sp_addtype login, 'varchar(30)', 'not null'
go

/*==============================================================*/
/* Domain: MONTO                                                */
/*==============================================================*/
print 'Tipo de dato:  MONTO'
if not exists (select * from systypes where name = 'MONTO')
    exec sp_addtype MONTO, 'money', 'not null'
go

/*==============================================================*/
/* Domain: NOMBRE                                               */
/*==============================================================*/
print 'Tipo de dato:  NOMBRE'
if not exists (select * from systypes where name = 'NOMBRE')
    exec sp_addtype NOMBRE, 'varchar(30)', 'not null'
go

/*==============================================================*/
/* Domain: VALOR_VARIABLE                                       */
/*==============================================================*/
print 'Tipo de dato:  VALOR_VARIABLE'
if not exists (select * from systypes where name = 'VALOR_VARIABLE')
    exec sp_addtype VALOR_VARIABLE, 'varchar(255)', 'null'
go

/*==============================================================*/
/* Domain: catalogo                                             */
/*==============================================================*/
print 'Tipo de dato:  catalogo'
if not exists (select * from systypes where name = 'catalogo')
    exec sp_addtype catalogo, 'varchar(10)', 'not null'
go

/*==============================================================*/
/* Domain: catalogo                                             */
/*==============================================================*/
print 'Tipo de dato:  cuenta'
if not exists (select * from systypes where name = 'cuenta')
    exec sp_addtype cuenta, 'char(24)', 'not null'
go
