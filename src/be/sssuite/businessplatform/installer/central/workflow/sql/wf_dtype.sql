/* Creación de los tipos de datos. */
use cob_workflow
go


/*==============================================================*/
/* Domain: BOOLEANO                                             */
/*==============================================================*/
print 'Tipo de dato:  BOOLEANO'
if exists (select 1
             from systypes
            where name = 'BOOLEANO')
    exec sp_droptype BOOLEANO
go

/*==============================================================*/
/* Domain: CONDICION                                            */
/*==============================================================*/
print 'Tipo de dato:  CONDICION'
if exists (select 1
             from systypes
            where name = 'CONDICION')
    exec sp_droptype CONDICION
go

/*==============================================================*/
/* Domain: DESCRIPCION                                          */
/*==============================================================*/
print 'Tipo de dato:  DESCRIPCION'
if exists (select 1
             from systypes
            where name = 'DESCRIPCION')
    exec sp_droptype DESCRIPCION
go

/*==============================================================*/
/* Domain: descripcion                                          */
/*==============================================================*/
print 'Tipo de dato:  descripcion'
if exists (select 1
             from systypes
            where name = 'descripcion')
    exec sp_droptype descripcion
go


/*==============================================================*/
/* Domain: LOGIN                                                */
/*==============================================================*/
print 'Tipo de dato:  LOGIN'
if exists (select 1
             from systypes
            where name = 'LOGIN')
    exec sp_droptype LOGIN
go

/*==============================================================*/
/* Domain: login                                                */
/*==============================================================*/
print 'Tipo de dato:  login'
if exists (select 1
             from systypes
            where name = 'login')
    exec sp_droptype login
go

/*==============================================================*/
/* Domain: MONTO                                                */
/*==============================================================*/
print 'Tipo de dato:  MONTO'
if exists (select 1
             from systypes
            where name = 'MONTO')
    exec sp_droptype MONTO
go

/*==============================================================*/
/* Domain: NOMBRE                                               */
/*==============================================================*/
print 'Tipo de dato:  NOMBRE'
if exists (select 1
             from systypes
            where name = 'NOMBRE')
    exec sp_droptype NOMBRE
go

/*==============================================================*/
/* Domain: VALOR_VARIABLE                                       */
/*==============================================================*/
print 'Tipo de dato:  VALOR_VARIABLE'
if exists (select 1
             from systypes
            where name = 'VALOR_VARIABLE')
    exec sp_droptype VALOR_VARIABLE
go


/*==============================================================*/
/* Domain: catalogo                                             */
/*==============================================================*/
print 'Tipo de dato:  catalogo'
if exists (select 1
             from systypes
            where name = 'catalogo')
    exec sp_droptype catalogo
go

/*==============================================================*/
/* Domain: catalogo                                             */
/*==============================================================*/
print 'Tipo de dato:  cuenta'
if exists (select 1
             from systypes
            where name = 'cuenta')
    exec sp_droptype cuenta
go


