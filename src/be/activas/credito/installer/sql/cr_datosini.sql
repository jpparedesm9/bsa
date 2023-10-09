use cob_credito
go

delete cob_credito..cr_tipo_oficina
 where  to_oficina = 1
go

insert into cob_credito..cr_tipo_oficina
values (1,'CASA MATRIZ','N')
go

delete cr_pregunta_ver_dat
go

/****GRUPAL*****/
insert into cr_pregunta_ver_dat values ('G' ,1 ,'La dirección del  Señor o Señora #NOM_CLIENTE# es: #DIRECCION#?')--6-GEO
insert into cr_pregunta_ver_dat values ('G' ,2 ,'¿Usted sabe cuanto tiempo lleva viviendo el/la Sr/Sra #NOM_CLIENTE#  en la direccion #DIRECCION#? Tiempo: #TIEMPO_VIV#')--7
insert into cr_pregunta_ver_dat values ('G' ,3 ,'¿Conoce a que se dedica el/la Sr/Sra #NOM_CLIENTE#? Actividad: #ACTIVIDAD#')--8
insert into cr_pregunta_ver_dat values ('G' ,4,'¿Usted sabe si el/la Sr/Sra  #NOM_CLIENTE# trabaja en el comercio #COMERCIO#?')--9
insert into cr_pregunta_ver_dat values ('G' ,5,'Usted sabe  si el/la  Sr/Sra #NOM_CLIENTE# es dueño(a) del comercio #COMERCIO#')--10
insert into cr_pregunta_ver_dat values ('G' ,6,'¿Conoce  cuanto tiempo lleva el/la Sr/Sra #NOM_CLIENTE# laborando en el comercio #COMERCIO#? Tiempo: #TIEMPO_TR#')--11
insert into cr_pregunta_ver_dat values ('G' ,7,'¿El local es #LOCAL#?')--12-GEO

insert into cr_pregunta_ver_dat values ('G' ,8 ,'Los Ingresos Totales son de: #SUELDO#')--1
insert into cr_pregunta_ver_dat values ('G' ,9 ,'Los Gastos Totales son de: #GASTOS#')--2

insert into cr_pregunta_ver_dat values ('G' ,10 ,'El grupo se llama: #NOM_GRUPO#')--3
insert into cr_pregunta_ver_dat values ('G' ,11 ,'¿En caso de que no pague algun miembro esta dispuesto  hacer el pago solidario?')--4
insert into cr_pregunta_ver_dat values ('G' ,12 ,'¿El nombre de la presidenta es: #PRESIDENTE#?')--5

insert into cr_pregunta_ver_dat values ('G' ,13, '¿Tiene Correo electrónico?')
insert into cr_pregunta_ver_dat values ('G' ,14, '¿Con que frecuencia utiliza su correo electrónico?')
insert into cr_pregunta_ver_dat values ('G' ,15, '¿Tienes Redes sociales?')
insert into cr_pregunta_ver_dat values ('G' ,16, 'Tipo de celular')
insert into cr_pregunta_ver_dat values ('G' ,17, '¿Cómo paga su teléfono?')
insert into cr_pregunta_ver_dat values ('G' ,18, '¿Tiene hijos?')

insert into cr_pregunta_ver_dat values ('G' ,19, '¿Antes de tener su tarjeta de débito Santander, contaba con una tarjeta de débito en otro banco?')
insert into cr_pregunta_ver_dat values ('G' ,20, '¿Ha utilizado anteriormente cajero?')
insert into cr_pregunta_ver_dat values ('G' ,21, '¿Qué operación realiza con mayor frecuencia en el cajero?')
insert into cr_pregunta_ver_dat values ('G' ,22, '¿Ha utilizado anteriormente un multicajero?')
insert into cr_pregunta_ver_dat values ('G' ,23, '¿Qué operación realiza con mayor frecuencia en el Multicajero?')
insert into cr_pregunta_ver_dat values ('G' ,24, '¿Ha utilizado Banca Móvil?')



/****INDIVIDUAL*****/
insert into cr_pregunta_ver_dat values ('I' ,1 ,'La dirección del  Señor o Señora #NOM_CLIENTE# es: #DIRECCION#?')--3 GEO
insert into cr_pregunta_ver_dat values ('I' ,2 ,'¿Usted sabe cuanto tiempo lleva viviendo el/la Sr/Sra #NOM_CLIENTE#  en la direccion #DIRECCION#? Tiempo: #TIEMPO_VIV#')--4
insert into cr_pregunta_ver_dat values ('I' ,3 ,'¿Conoce a que se dedica el/la Sr/Sra #NOM_CLIENTE#? Actividad: #ACTIVIDAD#')--5
insert into cr_pregunta_ver_dat values ('I' ,4,'¿Usted sabe si el/la Sr/Sra  #NOM_CLIENTE# trabaja en el comercio #COMERCIO#?')--6
insert into cr_pregunta_ver_dat values ('I' ,5,'¿Usted sabe  si el/la  Sr/Sra #NOM_CLIENTE# es dueño(a) del comercio #COMERCIO#?')--7
insert into cr_pregunta_ver_dat values ('I' ,6,'Conoce  cuanto tiempo lleva el/la Sr/Sra #NOM_CLIENTE# laborando en el comercio #COMERCIO#? Tiempo: #TIEMPO_TR#')--8
insert into cr_pregunta_ver_dat values ('I' ,7,'¿El local es #LOCAL#?')--9 GEO

insert into cr_pregunta_ver_dat values ('I' ,8 ,'Los Ingresos Totales son de: #SUELDO#')--1
insert into cr_pregunta_ver_dat values ('I' ,9 ,'Los Gastos Totales son de: #GASTOS#')--2

insert into cr_pregunta_ver_dat values ('I' ,10, '¿Tiene Correo electrónico?')
insert into cr_pregunta_ver_dat values ('I' ,11, '¿Con que frecuencia utiliza su correo electrónico?')
insert into cr_pregunta_ver_dat values ('I' ,12, '¿Tienes Redes sociales?')
insert into cr_pregunta_ver_dat values ('I' ,13, 'Tipo de celular')
insert into cr_pregunta_ver_dat values ('I' ,14, '¿Cómo paga su teléfono?')
insert into cr_pregunta_ver_dat values ('I' ,15, '¿Tiene hijos?')

insert into cr_pregunta_ver_dat values ('I' ,16, '¿Antes de tener su tarjeta de débito Santander, contaba con una tarjeta de débito en otro banco?')
insert into cr_pregunta_ver_dat values ('I' ,17, '¿Ha utilizado anteriormente cajero?')
insert into cr_pregunta_ver_dat values ('I' ,18, '¿Qué operación realiza con mayor frecuencia en el cajero?')
insert into cr_pregunta_ver_dat values ('I' ,19, '¿Ha utilizado anteriormente un multicajero?')
insert into cr_pregunta_ver_dat values ('I' ,20, '¿Qué operación realiza con mayor frecuencia en el Multicajero?')
insert into cr_pregunta_ver_dat values ('I' ,21, '¿Ha utilizado Banca Móvil?')








