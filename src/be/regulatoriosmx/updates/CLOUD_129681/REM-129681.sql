--cob_externos
use cob_externos
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'do_banco_padre'
                  AND Object_ID = Object_ID(N'cob_externos..ex_dato_operacion'))
begin
   ALTER TABLE cob_externos..ex_dato_operacion
   add do_banco_padre cuenta NULL
end
go


--cob_conta_super
use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'do_banco_padre'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion'))
begin
   ALTER TABLE cob_conta_super..sb_dato_operacion
   add do_banco_padre cuenta NULL
end
go

use cob_conta_super
go

if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'do_banco_padre'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion_tmp'))
begin
   ALTER TABLE cob_conta_super..sb_dato_operacion_tmp
   add do_banco_padre  cuenta null
end
go


use cob_conta_super
go
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'INDICADOR DE REUNION'
                  AND object_id = Object_ID(N'cob_conta_super..sb_reporte_operativo'))
begin

print 'A'
   ALTER TABLE cob_conta_super..sb_reporte_operativo
   add [INDICADOR DE REUNION] varchar (125)  null
end
go


use cob_conta_super
go

if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'COORDENADAS NEGOCIO'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_reporte_operativo'))
begin
   ALTER TABLE cob_conta_super..sb_reporte_operativo
   add [COORDENADAS NEGOCIO] varchar (100)  null
end
go


use cob_conta_super
go

if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'NRO OPERACION GRUPAL'
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_reporte_operativo'))
begin
   ALTER TABLE cob_conta_super..sb_reporte_operativo
   add [NRO OPERACION GRUPAL]  varchar (24)  null
end
go


use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_rep_oper_mc_collect') IS NOT NULL
	DROP table dbo.sb_rep_oper_mc_collect
go

create table dbo.sb_rep_oper_mc_collect
	(
	OFICINA                            varchar (64) not null,   --1
	REGION                             varchar (64) not null,   --2
	CC                                 smallint not null,       --3
	CONTRATO                           varchar (24) not null,   --4
	[ID GRUPO]                         int not null,		    --5
	[NOMBRE GRUPO]                     varchar (64) not null,   --6
	[CICLO GRUPAL ]                    varchar (3) not null,    --7
	[NUMERO DE INTEGRANTES]            varchar (4) not null,    --8
	RFC                                varchar (24) not null,   --9
	CURP                               varchar (255) not null,  --10
	[CLIENTE COBIS]                    int not null,		    --11
	[APELLIDO PATERNO]                 varchar (64) not null,   --12
	[APELLIDO MATERNO]                 varchar (64) not null,   --13
	NOMBRE1                            varchar (64) not null,   --14
	NOMBRE2                            varchar (64) not null,   --15
	[CICLO INDIVIDUAL]                 int not null,		    --16
	GENERO                             varchar (10) not null,   --17
	EDAD                               int not null,            --18
	DOM_TELEFONO                       varchar (16) not null,   --19
	DOM_DIRECCION                      varchar (254) not null,  --20
	ESTADO                             varchar (64) not null,   --21
	MUNICIPIO                          varchar (64) not null,   --22
	LOCALIDAD                          varchar (64) not null,   --23
	[C.P.]                             int not null,		    --24
   [COORDENADAS DOMICILIO]            varchar (100) not null,   --25	
	NEG_TELEFONO                       varchar (16) not null,   --26
	NEG_DIRECCION                      varchar (254) not null,  --27
	NEG_ESTADO                         varchar (64) not null,   --28
	NEG_MUNICIPIO                      varchar (64) not null,   --29
	NEG_LOCALIDAD                      varchar (64) not null,   --30
	NEG_CP                             int not null,		    --31
	[NEG_TIPO DE LOCAL]                varchar (64) not null,   --32
	[ACTIVIDAD ECONOMICA]              varchar (200) not null,  --33
	[CORREO ELECTRONICO DEL CLIENTE]   varchar (254) not null,  --34
	[NOMBRE GERENTE]                   varchar (64) not null,   --35
	[NOMBRE COORDINADOR]               varchar (64) not null,   --36
	[NOMBRE DEL ASESOR]                varchar (64) not null,   --37
	[CORREO ELECTRONICO ASESOR]        varchar (64) not null,   --38
	[TELEFONO DEL ASESOR]              varchar (64) not null,   --39
	[ESTATUS ASESOR]                   varchar (64) not null,   --40
	[PRODUCTO DE PRESTAMOS]            varchar (10) not null,   --41
	[SUBPRODUCTO PRESTAMO]             varchar (64) not null,   --42
	[MONTO CREDITO]                    money not null,		    --43
	[FECHA SOLICITUD]                  varchar (30) not null,   --44
	[FECHA APROBACION MONTOS]          varchar (30) not null,   --45
	[FECHA VENCIMIENTO PRESTAMO]       varchar (30) not null,   --46
	[NUMERO DE CONTRATO]               varchar (24) not null,   --47
	PLAZO                              varchar (64) not null,   --48
	[NUMERO CUOTAS]                    smallint not null,	    --49
	[DIA DE PAGO]                      varchar (9) not null,    --50
	[PLAZO DIAS]                       int not null,		    --51
	[PLAZO MES]                        numeric (17, 6) not null,--52
	[VALOR CUOTA]                      money not null,		    --53
	[CAPITAL DE LA CUOTA]              money not null,	        --54
	[INTERESES DE LA CUOTA]            money not null,		    --55
	[IVA DE LA CUOTA]                  money not null,          --56
	[TASA INTERES (ANUAL)]             float not null,          --57
	[CUOTAS PENDIENTES]                smallint not null,       --58
	[CUOTAS VENCIDAS]                  smallint not null,       --59
	[CAPITAL VIGENTE EXIGIBLE]         money not null,		    --60
	[CAPITAL VENCIDO EXIGIBLE]         money not null,		    --61
	[SALDO CAP]                        money not null,		    --62
	[INTERES VIGENTE EXIGIBLE]         money not null,		    --63
	[INTERES SUSPENDIDO]               money not null,		    --64
	[IVA INTERES EXIGIBLE]             money not null,		    --65
	[IVA INTERES NO EXIGIBLE]          money not null,		    --66
	COMISIONES                         money not null,		    --67
	[IVA COMISION]                     money not null,		    --68
	[SALDO INTERESES]                  money not null,		    --69
	[SALDO REAL EXIGIBLE]              money not null,		    --70
	[SALDO TOTAL]                      money not null,		    --71
	[SALDO TOTAL EN MORA]              money not null,		    --72
	[IMPORTE LIQUIDA CON]              money not null,		    --73
	[DIAS MAX ATRASO ACT]              int not null,           --74
	[SEMANAS DE ATRASO]                int,					    --75
	[DIAS MORA]                        int not null,           --76
	[FECHA RECIBO ANTIGUO IMP]         varchar (30) not null,  --77
	[FECHA ULTIMA SITUACION DEUDA]     varchar (30) not null,  --78
	[PORCENTAJE RESERVA]               float not null,         --79
	[CARTERA EN RIESGO]                money not null,         --80
	[NIVEL DE RIESGO]                  char (1) not null,	   --81
	[PUNTAJE DE RIESGO]                char (3) not null,	   --82
	[ROL MESA DIRECTIVA]               varchar (64) not null,  --83
	[INDICADOR DE REUNION]             varchar (125) not null, --84
	[NUMERO DE EMPLEADO DEL ASESOR]    varchar (10) not null,  --85
	[NUMERO DE EMPLEADO DEL COORDINADOR] varchar (10) not null,--86
	[NUMERO DE EMPLEADO DEL GERENTE]   varchar (10) not null, --87
	[DIA DE REUNION SEMANAL]           varchar (10) not null, --88
	[HORA DE REUNION SEMANAL]          varchar (10) not null, --89
	[COORDENADAS NEGOCIO]              varchar (100) not null,--90
	[NRO OPERACION GRUPAL]             varchar (24) not null, --91
	[NVO DOM_DIRECCION]                varchar (255) not null,--92
    [NVO ESTADO]                       varchar (255) not null,--93
    [NVO MUNICIPIO]                    varchar (255) not null,--94
    [NVO LOCALIDAD]                    varchar (255) not null,--95
    [NVO C.P.]                         int not null ,         --96
    [NVAS COORDENADAS DOM]             varchar (255) not null,--97
    [Foto del Domicilio]               varchar (255) not null,--98
    [Entre calle 1 Dom]                varchar (255) not null,--99
    [Entre calle 2 Dom]                varchar (255) not null,--100
    [Entre calle 3 Dom]                varchar (255) not null,--101
    [Entre calle 4 Dom]                varchar (255) not null,--102
    [Foto del Negocio]                 varchar (255) not null,--103
    [Foto del Negocio 2]               varchar (255) not null,--104
    [Entre calle 1 Neg]                varchar (255) not null,--105
    [Entre calle 2 Neg]                varchar (255) not null,--106
    [Entre calle 3 Neg]                varchar (255) not null,--107
    [Entre calle 4 Neg]                varchar (255) not null,--108
    [Foto del Domicilio Alterno]       varchar (255) not null,--109
    [Entre calle 1 Dom Alterno]        varchar (255) not null,--110
    [Entre calle 2 Dom Alterno]        varchar (255) not null,--111
    [Entre calle 3 Dom Alterno]        varchar (255) not null,--112
    [Entre calle 4 Dom Alterno]        varchar (255) not null --113
	)
go


use cobis
go

delete from cobis..ba_batch 
where ba_batch = 287931

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (287931, 'REPORTE OPERATIVO MC COLLECT', 'REPORTE OPERATIVO MC COLLECT', 'SP', '2018-01-19 17:08:08.967', 36, 'P', 1, NULL, 'COBRANZA_INI_', 'cob_conta_super..sp_reporte_operativo', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch1\Regulatorios\Objetos\', 'C:\Cobis\VBatch1\Regulatorios\listados\')
go

use cobis
go
if not exists(select 1 from   cobis..cl_parametro
              where  pa_nemonico='MECMC' and    pa_producto='REC')
begin
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES ELIMINACION MC COLLECT', 'MECMC', 'I', NULL, NULL, NULL, 3, NULL, NULL, NULL, 'REC')
end 
go

use cobis
go		 

if not exists(select  1 from cobis..cl_errores
		        where numero=3600002)	
begin	 

insert into cobis..cl_errores (numero, severidad, mensaje)
values (3600002, 1, 'EL PRESTAMO NO TIENE UN CICLO VIGENTE')

end

if not exists(select  1 from cobis..cl_errores
		        where numero=3600003)	
begin	 

insert into cobis..cl_errores (numero, severidad, mensaje)
values (3600003, 1, 'EL PRESTAMO NO SE ENCUENTRA VIGENTE')

end

go