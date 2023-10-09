/************************************************************************/
/*  Archivo:                aniadir_campo_cu_tipo_custodia.sql          */
/*  Stored procedure:                                                   */
/*  Base de Datos:          cobis                                       */
/*  Producto:               admin                                       */
/*  Disenado por:           MPI                                         */
/*  Fecha de Documentacion: 19/Octubre/2015                              */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/*Ingresa un nuevo campo en la tabla cl_oficina 			*/
/*of_barrio  							        */			                                         
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR           RAZON                                   */
/*  19/10/15    RLA                 Emision Inicial                     */
/* **********************************************************************/

-- Agregar campo en la pantalla de mantenimiento
USE cobis
go

If not exists(select 1 from sysobjects a, syscolumns b
          where a.name = 'cl_oficina'
          and b.name = 'of_barrio')
                ALTER TABLE cl_oficina  ADD of_barrio int null
print 'Se añadio la colunna'
go



--***************************************************************************************
--Agregar campo en la pantalla de consulta grid 

USE cobis
go

If not exists(select 1 from sysobjects a, syscolumns b
          where a.name = 'cl_det_oficina'
          and b.name = 'do_barrio')
               ALTER TABLE cl_det_oficina  ADD do_barrio varchar (64) NULL 
print 'Se añadio la columna'
go

--*********************************************************************************************



USE cobis
go


if exists (select * from sysobjects where name = 'ts_oficina')
    DROP VIEW ts_oficina
go

go

CREATE VIEW ts_oficina (
   secuencia,        tipo_transaccion,   clase,          fecha,             oficina_s,
   usuario,            terminal_s,     srv,              lsrv,             hora,
   filial,             oficina,        nombre,           direccion,        ciudad,
   telefono,           subtipo,        sucursal,         area,             regional,
   tipo_punto,         obs_horario,    circular_comun,   nombre_enc,       ci_encargado,
   horario,            tipo_horario,   jefe_agencia,     cod_fie_asfi,     fecha_aut_asfi,
   sector,             depart_pais,    provincia,        relacion_ofic,    sub_regional,
   barrio) 
as
select ts_secuencia,    ts_tipo_transaccion,   ts_clase,         ts_fecha,         ts_ofi,
      ts_user,          ts_term,               ts_srv,           ts_lsrv,          ts_fecha_ult_mod,
      ts_filial,        ts_oficina,            ts_descripcion,   ts_direc,         ts_money,
      ts_int,           ts_tipo,               ts_procedure,     ts_char,          ts_regional,
      ts_tip_punt_at,   ts_obs_horario,        ts_cir_comunic,   ts_nomb_encarg,   ts_ci_encarg,
      ts_horario,       ts_tipo_horar,         ts_jefe_agenc,    ts_cod_fie_asf,   ts_fec_aut_asf,
      ts_sector,        ts_depart_pais,        ts_provincia,     ts_tamanio,       ts_subregional,
      ts_ambito_sec
from   ad_tran_servicio
where  ts_tipo_transaccion = 1513 
or     ts_tipo_transaccion = 1514 
go




--*************************************************************************************************

































