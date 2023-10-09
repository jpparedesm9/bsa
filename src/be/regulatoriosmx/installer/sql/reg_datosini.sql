/************************************************************************/
/*    ARCHIVO:         reg_datosini.sql                                 */
/*    NOMBRE LOGICO:   reg_datosini.sql                                 */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*  Creacion de datos iniciales de regulatorios                         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA           AUTOR                   RAZON                       */
/*  25/08/2016      Jorge Salazar            Emision Inicial            */
/************************************************************************/
use cob_conta_super
go

--Unidades de atraso
truncate table sb_factor_atr

insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(180,6)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(90,3)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(60,2)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(30,1)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(15,0.5)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(14,0.46)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(10,0.33)
insert into sb_factor_atr(fa_periodo_cuota, fa_atr) values(7,0.23)
go


--Sumandos Valor de Z de Formula PI: Probabilidad Incumplimiento
truncate table sb_sumando_z

insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',0,-1.2924)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',1,0.8074)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',2,0.3155)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',3,-0.8247)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',4,0.4404)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',5,0.0405)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',6,-0.4809)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',7,-0.0540)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('INDIVIDUAL',8,-0.0282)

insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('GRUPAL',0,0)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('GRUPAL',1,0.6297)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('GRUPAL',2,-4.1889)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('GRUPAL',3,0.8470)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('GRUPAL',4,0.2320)
insert into sb_sumando_z(sz_toperacion,sz_sumando,sz_valor) values('GRUPAL',5,-1.0790)
go

--Factores Defecto
truncate table sb_cuota_p_pago

insert into sb_cuota_p_pago(pp_toperacion,pp_periodo_cuota,pp_cuotas) values('INDIVIDUAL',30,4)
insert into sb_cuota_p_pago(pp_toperacion,pp_periodo_cuota,pp_cuotas) values('INDIVIDUAL',15,7)
insert into sb_cuota_p_pago(pp_toperacion,pp_periodo_cuota,pp_cuotas) values('INDIVIDUAL',7,14)

insert into sb_cuota_p_pago(pp_toperacion,pp_periodo_cuota,pp_cuotas) values('GRUPAL',30,1)
insert into sb_cuota_p_pago(pp_toperacion,pp_periodo_cuota,pp_cuotas) values('GRUPAL',15,2)
insert into sb_cuota_p_pago(pp_toperacion,pp_periodo_cuota,pp_cuotas) values('GRUPAL',7,3)


--Severidad Perdida
truncate table sb_severidad_perdida

insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',0,4,71)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',4,5,73)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',5,6,78)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',6,7,82)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',7,8,85)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',8,9,87)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',9,10,89)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',10,11,90)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',11,12,92)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',12,14,93)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',14,15,94)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',15,17,95)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',17,19,96)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('INDIVIDUAL',19,999999,100)

insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',0,4,78)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',4,5,86)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',5,6,91)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',6,7,94)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',7,8,96)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',8,9,98)
insert into sb_severidad_perdida(sp_toperacion,sp_atr_minimo,sp_atr_maximo,sp_severidad) values('GRUPAL',9,999999,100)
go

