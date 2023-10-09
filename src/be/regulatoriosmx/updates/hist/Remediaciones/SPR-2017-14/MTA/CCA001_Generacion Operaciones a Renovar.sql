/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S123217 Generación de Operaciones a Renovar
--Descripción del Problema   : Creacion de codigo de error, nuevo campo a tabla y creacion del batch 
--Responsable                : Maria Jose Taco
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/
use cobis
go

--------------------------
--ERRORES
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_error.sql

if not exists(select 1 from cl_errores where numero = 70122)
begin
   INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
   VALUES (70122, 0, 'NO EXISTE PARAMETRO PARA DIAS DE VENCIMIENTO EN LA OPERACION GRUPAL')
end
go

--------------------------
--PARAMETRO
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_parametros.sql
if not exists(select 1 from cl_parametro where pa_nemonico = 'DVOG')
begin
   INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   VALUES ('DIAS VENCIMIENTO OP GRUPAL', 'DVOG', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'CCA')
end
go

--------------------------
--TABLA
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_table.sql
use cob_credito
go
IF NOT EXISTS (select 1 from sysobjects a, syscolumns b where a.name = 'cr_tramite_grupal' and b.name='tg_nueva_op')
begin
   ALTER TABLE cr_tramite_grupal add tg_nueva_op int NULL
end
go


--------------------------
--BATCH
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/Param_Conta_MX
--Nombre Archivo             : cb_batch.sql
--BATCH 7080
USE cobis
go
declare @w_server        varchar(24), 
        @w_path_fuente   varchar(255), 
        @w_path_destino  varchar(255)

select @w_server = pa_char
  from cobis..cl_parametro 
 where pa_producto = 'ADM'
   and pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, 
       @w_path_destino = pp_path_destino
  from ba_path_pro
 where pp_producto = 7

  
--BATCH
delete cobis..ba_batch where ba_batch = 7080
   INSERT INTO dbo.ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   VALUES (7080, 'GENERAR OP A RENOVAR', 'GENERAR OP A RENOVAR', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_crear_renovacion_automatica', 1, NULL, @w_server, 'S', @w_path_fuente, NULL)
   
--PARAMETRO
delete cobis..ba_parametro where pa_batch = 7080
insert into ba_parametro (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,pa_nombre,pa_tipo,pa_valor)
values(0,7080,0,1,'FECHA_PROCESO','D',getdate())
INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (3, 7080, 45, 1, 'FECHA_PROCESO','D',getdate())

--SARTA_BATCH
delete cobis..ba_sarta_batch where sb_sarta = 3 and sb_batch = 7080
   insert into ba_sarta_batch(sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_left, sb_top, sb_lote_inicio, sb_habilitado)
   values(3,7080,45,NULL,'S','N',450,1170,3,'S')

--ENLACE
delete cobis..ba_enlace where en_batch_inicio =7080
insert into cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
values(3, 7080, 45, 7117, 3, 'S', NULL, 'N')
go

