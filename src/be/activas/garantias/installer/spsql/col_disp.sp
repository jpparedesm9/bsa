/************************************************************************/
/*   Archivo:              col_disp.sp                                  */
/*   Stored procedure:     sp_colateral_disp                            */
/*   Disenado por:         Monica Vidal                                 */
/*   Fecha de escritura:   Feb. 2009                                    */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/* Listar las operaciones disponibles para colaterales                  */
/************************************************************************/

use cob_custodia
go


if exists (select 1 from sysobjects where name = 'sp_colateral_disp')
   drop proc sp_colateral_disp
go


create proc sp_colateral_disp
@i_fecha_proc         datetime     = null,    --FECHA DE PROCESO
@i_simulacion         char(1)      = 'S'
as
declare
@w_error             int,
@w_sp_name           varchar(30),
@w_msg               varchar(130),
@w_fecha_ant         datetime,
@w_fecha_hora        datetime


select
@w_sp_name        = 'sp_colateral_disp',
@w_fecha_hora     = getdate()

select @i_fecha_proc = isnull(@i_fecha_proc, fp_fecha)
from   cobis..ba_fecha_proceso

if @i_simulacion = 'N' begin

   /* INGRESO EL UNIVERSO DE OPERACIONES ACTIVAS A TENER EN CUENTA*/
   insert into cu_colateral_det_tmp(
   cdt_ente_pas,       cdt_codigo_pas,
   cdt_banco_act,      cdt_toperacion,     cdt_cliente,
   cdt_oficina,        cdt_monto,          cdt_tasa,
   cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
   cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
   cdt_amor_int,       cdt_fecha_proc,     cdt_accion)
   select
   0,                   '',
   un_banco,           un_toperacion,      un_cliente,
   un_oficina,         un_monto,           un_tasa,
   un_calificacion,    un_fecha_ini,       un_fecha_fin,
   un_saldo_cap,       un_saldo_int,       un_amor_cap,
   un_amor_int,        @i_fecha_proc,      'L' --LISTADO
   from   cu_universo_pagares_col

   if @@error <> 0 begin
      select @w_msg   = 'ERROR AL INSERTAR PAGARES DISPONIBLES LA TABLA TEMPORAL'
      goto ERROR
   end


   /* BORRO LAS QUE YA TENGO ASOCIADAS PARA QUE ME QUEDEN LAS DISPONIBLES */
   delete cu_colateral_det_tmp
   from   cu_colateral_det
   where  cd_banco_act     = cdt_banco_act
   and    cd_fecha_proc    = @i_fecha_proc
   and    cdt_accion       = 'L'

   if @@error <> 0 begin
      select @w_msg   = 'ERROR AL ELIMINAR PAGARES EN CUSTODIA DE LA TABLA TEMPORAL'
      goto ERROR
   end

   /* INSERTO LOS PAGARES QUE QUEDARON PARA RESUMEN */
   insert into cu_colateral_det_tmp(
   cdt_ente_pas,       cdt_codigo_pas,
   cdt_banco_act,      cdt_toperacion,     cdt_cliente,
   cdt_oficina,        cdt_monto,          cdt_tasa,
   cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
   cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
   cdt_amor_int,       cdt_fecha_proc,     cdt_accion)
   select
   cd_ente_pas,        cd_codigo_pas,
   cd_banco_act,       cd_toperacion,      cd_cliente,
   cd_oficina,         cd_monto,           cd_tasa,
   cd_calificacion,    cd_fecha_ini,       cd_fecha_fin,
   cd_saldo_cap,       cd_saldo_int,       cd_amor_cap,
   cd_amor_int,        cd_fecha_proc,      'R'
   from  cu_colateral_det
   where cd_fecha_proc = @i_fecha_proc


   if @@error <> 0 begin
      select @w_msg   = 'ERROR AL INSERTAR PAGARES EN CUSTODIA PARA CERTIFICADO EN LA TABLA TEMPORAL'
      goto ERROR
   end

end else begin         --SI NO ES SIMULACION USO LO DE LA TABLA DEFINITIVA 
   /* INSERTO LOS PAGARES QUE QUEDARON PARA RESUMEN */
   insert into cu_colateral_det_tmp(
   cdt_ente_pas,       cdt_codigo_pas,
   cdt_banco_act,      cdt_toperacion,     cdt_cliente,
   cdt_oficina,        cdt_monto,          cdt_tasa,
   cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
   cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
   cdt_amor_int,       cdt_fecha_proc,     cdt_accion)
   select
   cdt_ente_pas,       cdt_codigo_pas,
   cdt_banco_act,      cdt_toperacion,     cdt_cliente,
   cdt_oficina,        cdt_monto,          cdt_tasa,
   cdt_calificacion,   cdt_fecha_ini,      cdt_fecha_fin,
   cdt_saldo_cap,      cdt_saldo_int,      cdt_amor_cap,
   cdt_amor_int,       @i_fecha_proc,      'R'
   from  cu_colateral_det_tmp
   where cdt_accion = 'T'


   if @@error <> 0 begin
      select @w_msg   = 'ERROR AL INSERTAR PAGARES EN CUSTODIA PARA CERTIFICADO EN LA TABLA TEMPORAL'
      goto ERROR
   end

end

/* LLAMO AL SP QUE LLENA LAS TABLAS PARA HACER EL BCP */
exec @w_error = sp_carga_bcps_consolidado
@i_fecha_proc  = @i_fecha_proc,
@o_msg         = @w_msg out

if @w_error <> 0 goto ERROR

truncate table cu_universo_pagares_col

return 0
ERROR:

   exec  sp_errorlog
   @i_fecha_proc    = @w_fecha_hora,
   @i_tran          = 19057,
   @i_garantia      = 'ERROR GENERAL',
   @i_descripcion   = @w_msg

return 1
go




