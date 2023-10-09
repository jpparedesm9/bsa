/************************************************************************/
/*      Archivo           :  ca_eadmseg.sp                              */
/*      Base de datos     :  cob_cartera                                */
/*      Producto          :  Cartera                                    */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*                                                                      */
/************************************************************************/
/*                                MODIFICACIONES                        */
/*      FECHA                   AUTOR              MODIFICACIONES       */
/*          21/fOct/16      j. Calderon     Emision inicial             */
/************************************************************************/
USE cob_cartera
GO
if object_id('sp_ca_eadmseg_ej') is not null
begin
   drop proc sp_ca_eadmseg_ej
   if    object_id('sp_ca_eadmseg_ej') is not null
   begin
   print 'FAILED DROPPING PROCEDURE ca_eadmseg_ej.sp'
   end
end
go

create proc sp_ca_eadmseg_ej
   @t_show_version bit      =    0,
   @i_param1       datetime =    NULL,
   @i_param2       datetime =    NULL,
   @i_fecha_ini    datetime = null,
   @i_fecha_fin    datetime = null,
   @i_fecha        DATETIME = null,
    @i_filial      INT      = null
as
DECLARE
   @w_s_app      VARCHAR(150),
   @w_date_proceso     varchar(10),
   @w_sp_name          varchar(64),
   @w_retorno          int,
   @w_error            INT,
   @w_retorno_ej       int,
   @w_mensaje          varchar(150),
   @w_tot_records      int,
   @w_fecha_proceso    varchar(10),
   @w_mes              char(2),
   @w_dia              char(2),
   @w_anio             char(4),
   @w_comando          varchar(1000),
   @w_cmd              varchar(224),
   @w_fecha            varchar(30),
   @w_hora_bcp         varchar(2),
   @w_min_bcp          varchar(2),
   @w_path_pro         VARCHAR(200),
   @w_pr_path          VARCHAR(200),
   @w_fecha_tran       varchar(10),
   @w_nombre           VARCHAR(30),
   @w_titulo           VARCHAR(100),
   @w_nombre_fuente    VARCHAR(30),
   @w_archivo_bcp      VARCHAR(150),
   @w_cabecera         CHAR(250),
   @w_campo0           CHAR(36),
   @w_campo1           char(25),
   @w_campo2           char(30),
   @w_campo3           char(80),
   @w_campo4           char(20),
   @w_campo5           char(15),
   @w_campo6           char(20),
   @w_campo7           char(10),
   @w_campo8           char(30),
   @w_campo9           char(20),
   @w_campo10          char(11),
   @w_oficina          varchar(5),
   @w_nombre_listado   VARCHAR(150),
   @w_pr_path_dest     VARCHAR(100),
   @w_fecha_definitiva VARCHAR(30),
   @w_mes_listado      VARCHAR(30),
   @w_dia_listado      VARCHAR(30),
   @w_ani_listado      VARCHAR(30),
   @w_hor_listado      VARCHAR(2),
   @w_min_listado      VARCHAR(2),
   @w_hor              int,
   @w_min              INT,
   @w_campo0_des       VARCHAR(19),
   @w_campo9_des       VARCHAR(19),
   @w_os_producto      TINYINT,
   @w_en_subtipo       CHAR(1),
   @w_en_ced_ruc       varchar(30) ,
   @w_os_operacion     varchar(24),
   @w_os_clase         catalogo,
   @w_os_toperacion    varchar(30),
   @w_os_moneda        TINYINT,
   @w_os_saldo         MONEY,
   @w_os_estado_contable TINYINT,
   @w_espacio          char(80),
   @w_cadena           CHAR(202),
   @w_errores          varchar(124),
   @w_saldo            CHAR(15),
   @w_moneda           CHAR(6),
   @w_titulo1          char(100),
   @w_titulo2          char(100),
   @w_archivo          varchar(255),
   @w_nom_archivo      varchar(100),
   @w_path_s_app       varchar(100),
   @w_msg              varchar(50),
   @w_path             varchar(250),
   @w_return             int,
   @w_nom_archivo_cab1   varchar(250),
   @w_nom_archivo_cab2   varchar(250),
   @w_nom_archivo_cab3   varchar(250),
   @w_nom_archivo_cab4   varchar(250),
   @w_nom_archivo_cab    varchar(250),
   @w_nom_archivo_repa   varchar(250),
   @w_nom_archivo_repb   varchar(250),
   @w_nom_archivo_total_a varchar(250),
   @w_nom_archivo_tot_b  varchar(250),
   @w_nom_archivo_final  varchar(250),
   @w_destino            varchar (255),
   @w_nombrearchivo      varchar(250),
   @w_contador           int

select @w_sp_name = 'sp_ca_eadmseg_ej'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1 begin
   print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
   return 0
end

create table #tmp_archivos_intermedios(ai_descripcion varchar(50))

TRUNCATE TABLE rpt_cr_opcns
truncate table rpt_cr_cabc1
truncate table rpt_cr_cabc2
truncate table rpt_cr_cabc3
truncate table rpt_cr_cabc4

truncate table rpt_ca_seg_reporte_a
truncate table rpt_ca_seg_reporte_b
truncate table rpt_ca_seg_total_a
truncate table rpt_Seleccion_total_b

/* OBTIENE RUTA DEL KERNEL */
select @w_s_app    = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

if @@rowcount = 0 begin
   select
   @w_error = 101077,
   @w_mensaje = ' ERROR No existe parametro S_APP'
   goto ERRORFIN
end

select @w_nom_archivo_final = 'ca_eadmseg'

select @i_fecha = @i_param1
select @i_fecha_ini = @i_param1
select @i_fecha_ini = @i_param2

select @i_filial = 1

select @w_date_proceso = convert(VARCHAR(30),@i_fecha,103)
select @w_dia = substring(@w_date_proceso,1,2)
select @w_mes = substring(@w_date_proceso,4,2)
select @w_anio = substring(@w_date_proceso,7,4)
select @w_fecha_tran =  @w_anio +  @w_mes + @w_dia

select @w_hor = datepart(hour,@i_fecha)
select @w_min = datepart(minute,@i_fecha)

if @w_hor < 10 select @w_hor_listado = '0' + convert(CHAR(1),@w_hor)
else           select @w_hor_listado = convert(CHAR(2),@w_hor)

if @w_min < 10 select @w_min_listado = '0' + convert(CHAR(1),@w_min)
else           select @w_min_listado = convert(CHAR(2),@w_min)

select @w_pr_path_dest = ltrim(rtrim(ba_path_destino))
from cobis..ba_batch
where ba_batch = 21056

if @@rowcount = 0 begin
   select @w_error = 101077,
          @w_mensaje = ' ERROR No existe ba_path_destino'
   goto ERRORFIN
end

select @w_nombre_fuente = ba_arch_fuente
from  cobis..ba_batch
where ba_batch = convert(int,21040)

if @@rowcount = 0 begin
   select @w_error = 101077,
          @w_mensaje = ' ERROR No existe nombre del fuente ba_arch_fuente'
   goto ERRORFIN
end

select @w_nombre_fuente = 'ca_eadmseg.sp'

select @w_nombre = fi_nombre
from  cobis..cl_filial
where fi_filial = 1

if @@rowcount = 0 begin
   select
   @w_error = 101077,
   @w_mensaje = ' ERROR No existe nombre del la filial'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_espacio = '                                                                '
select @w_cadena = @w_espacio + '                          ' + @w_nombre

INSERT INTO rpt_cr_opcns (cadena) VALUES    (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro en la tabla cob_cartera..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_titulo1 = '                                                            REPORTE PARA ADMINISTRACION DE SEGUROS'

INSERT INTO rpt_cr_opcns (cadena) VALUES    (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro la tabla cob_cartera..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cadena = ''
select @w_titulo2 = 'DEL: ' + convert(varchar ,@i_fecha_ini) + '      AL: ' + convert(varchar,@i_fecha_fin)
select @w_cadena = @w_titulo2

INSERT INTO rpt_cr_opcns (cadena) VALUES (@w_cadena)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear registro la tabla cob_cartera..rpt_cr_opcns'
   goto ERRORFIN
end

select @w_cabecera = ''
select @w_date_proceso
select @w_campo0 = 'OFICINA'
select @w_campo1 = 'CONCEPTO'
select @w_campo2 = 'VALOR'

select @w_cabecera = @w_campo0 + @w_campo1 + @w_campo2

INSERT INTO rpt_cr_opcns (cadena) VALUES (@w_cabecera)

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

execute @w_error = sp_administracion_seg
@i_fecha_ini = @i_param1,
@i_fecha_fin = @i_param2

If @w_error <> 0 begin
   select @w_mensaje ='No se pudo EJECUTAR EL SP sp_administracion_seg'
   goto ERRORFIN
End

insert into rpt_cr_cabc1 values ('TOTALES SEGUROS POR CONCEPTO')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_cr_cabc1 values ('==============================')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_ca_seg_reporte_a
select tr_ofi_oper_a  ,dtr_concepto_a ,valor_a
from   ca_seg_reporte_a

if @@error <> 0 begin
   select @w_mensaje ='No se pudo llenar la tabla rpt_ca_seg_reporte_a'
   goto ERRORFIN
end

insert into rpt_cr_cabc2 values ('VALORES DEVOLUCION POR OFICINA')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_cr_cabc2 values ('==============================')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_ca_seg_reporte_b
select tr_ofi_oper_b + '                                ' ,dtr_concepto_b + '             ',valor_b
from ca_seg_reporte_b

if @@error <> 0 begin
   select @w_mensaje ='No se pudo llenar la tabla rpt_ca_seg_reporte_b'
   goto ERRORFIN
end

insert into rpt_cr_cabc3 values ('TOTALES SEGUROS POR CONCEPTO')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_cr_cabc3 values ('==============================')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_ca_seg_total_a
select dtr_concepto_ta,total_ta
from ca_seg_total_a

if @@error <> 0 begin
   select @w_mensaje ='No se pudo llenar la tabla rpt_ca_seg_total_a'
   goto ERRORFIN
end

insert into rpt_cr_cabc4 values ('TOTALES DEVOLUCIONES POR CONCEPTO')

if @@error <> 0 begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_cr_cabc4 values ('==============================')

if @@error <> 0
begin
   select @w_mensaje ='No se pudo crear la cabecera del reporte'
   goto ERRORFIN
end

insert into rpt_Seleccion_total_b
select dtr_concepto_tb,total_tb
from ca_seg_total_b

if @@error <> 0 begin
   select @w_mensaje ='No se pudo llenar la tabla ca_seg_total_b'
   goto ERRORFIN
end

  --CABECERA GENERAL
select @w_path = 'C:\Cobis\vbatch\cartera\listados\'

select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

select @w_nom_archivo_cab = 'rpt_cr_opcns'+ '.txt'

select @w_archivo = @w_path + @w_nom_archivo_cab

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_cr_opcns out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +' -t"|" -config '
                    + @w_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

---************************* rpt_cr_cabc1***********************------------------------------
select @w_nom_archivo_cab1 = 'rpt_cr_cabc1'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_cab1

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_cr_cabc1 out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

---*****************************rpt_ca_seg_reporte_a***********************------------------
select @w_nom_archivo_repa = 'rpt_ca_seg_reporte_a'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_repa

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_ca_seg_reporte_a out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando


---*****************************rpt_cr_cabc2***********************------------------
select @w_nom_archivo_cab2 = 'rpt_cr_cabc2'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_cab2

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_cr_cabc2 out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

---**********************************rpt_ca_seg_reporte_b*************************--------
select @w_nom_archivo_repb = 'rpt_ca_seg_reporte_b'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_repb

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_ca_seg_reporte_b out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

---*********************************rpt_cr_cabc3************************-------------
select @w_nom_archivo_cab3 = 'rpt_cr_cabc3'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_cab3

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_cr_cabc3 out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando


---***************************rpt_ca_seg_total_a************-------------------
   select @w_nom_archivo_total_a = 'rpt_ca_seg_total_a'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_total_a

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_ca_seg_total_a out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

------------------**************rpt_cr_cabc4************--------------------------
   select @w_nom_archivo_cab4 = 'rpt_cr_cabc4'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_cab4

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_cr_cabc4 out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

-----------------**********rpt_Seleccion_total_b*****-------------------
select @w_nom_archivo_tot_b = 'rpt_Seleccion_total_b'+ '.txt'
select @w_archivo = @w_path + @w_nom_archivo_tot_b

select @w_cmd = @w_s_app + 's_app bcp -auto -login cob_cartera..rpt_Seleccion_total_b out '

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e ' +  @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_s_app
                    + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

--UNIFICACION DE ARCHIVOS---
-- elimina archivo errores de no existir
select @w_comando = 'del ' + @w_path + @w_destino
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'EJECUCION comando bcp FALLIDA (Eliminacion temp .err). REVISAR ARCHIVOS DE LOG GENERADOS. '
   goto ERRORFIN
end

select @w_destino = @w_path + @w_nom_archivo_final + '.txt'
select @w_comando = 'echo ' +  ' > '  +  @w_destino
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

select @w_comando = 'copy ' + @w_destino + ' + ' + @w_path + @w_nom_archivo_cab + ' +' + @w_path + @w_nom_archivo_cab1 + ' + ' + @w_path + @w_nom_archivo_repa +
                   '+' + @w_path + @w_nom_archivo_cab2 + '+' + @w_path +@w_nom_archivo_repb + '+' + @w_path + @w_nom_archivo_cab3 + ' + ' + @w_path + @w_nom_archivo_total_a + ' + ' + @w_path + @w_nom_archivo_cab4 + ' + ' + @w_path + @w_nom_archivo_tot_b  +  ' ' + @w_destino
select @w_comando
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
   goto ERRORFIN
end

-- BORRADO DE ARCHIVOS INTERMEDIOS
select
   @w_comando = 'del ' +
   @w_path + @w_nom_archivo_cab     + ' ' + @w_path + @w_nom_archivo_cab1 + ' ' + @w_path + @w_nom_archivo_repa  + ' ' +
   @w_path + @w_nom_archivo_cab2    + ' ' + @w_path + @w_nom_archivo_repb + ' ' + @w_path + @w_nom_archivo_cab3  + ' ' +
   @w_path + @w_nom_archivo_total_a + ' ' + @w_path + @w_nom_archivo_cab4 + ' ' + @w_path + @w_nom_archivo_tot_b
exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
   select @w_msg = 'EJECUCION comando bcp FALLIDA (Eliminacion de Archivos intermedios .txt). REVISAR ARCHIVOS DE LOG GENERADOS. '
   goto ERRORFIN
end

select @w_contador = 1
insert into #tmp_archivos_intermedios(ai_descripcion) values
(@w_nom_archivo_cab     ), (@w_nom_archivo_cab1    ), (@w_nom_archivo_repa    ),
(@w_nom_archivo_cab2    ), (@w_nom_archivo_repb    ), (@w_nom_archivo_cab3    ),
(@w_nom_archivo_total_a ), (@w_nom_archivo_cab4    ), (@w_nom_archivo_tot_b   )

WHILE @w_contador != 0
BEGIN
   select top 1 @w_nombrearchivo = ai_descripcion from #tmp_archivos_intermedios
   select @w_comando = 'FOR /F "usebackq" %A IN (''"'+@w_path + @w_nombrearchivo+'.err"'') DO if %~zA EQU 0 del %A'
   exec @w_error = xp_cmdshell @w_comando
   
   if @w_error <> 0 begin
      select @w_msg = 'EJECUCION comando bcp FALLIDA (Eliminacion de Archivos intermedios .err). REVISAR ARCHIVOS DE LOG GENERADOS. '
      goto ERRORFIN
   end
   
   delete from #tmp_archivos_intermedios where ai_descripcion = @w_nombrearchivo
   
   if @@error <> 0 begin
      select @w_msg = 'Eliminacion: No se pudo borrar registros de la tabla #tmp_archivos_intermedios. '
      goto ERRORFIN
   end
   
   select @w_contador = count(1) from #tmp_archivos_intermedios
END

RETURN 0

ERRORFIN:
   exec sp_errorlog
   @i_fecha       = @i_fecha,
   @i_error       = @w_error,
   @i_usuario     = 'admuser',
   @i_tran_name   = @w_mensaje,
   @i_rollback    = 'N',
   @i_tran        = null,
   @i_descripcion = @w_mensaje

   return @w_error

go

