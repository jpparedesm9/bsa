/*bt_actasa.sp*/
/************************************************************************/
/*      Archivo:                bt_actasa.sp                            */
/*      Stored procedure:       sp_informa_cambio_tasa                  */
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           CLOTILDE VARGAS                         */
/*      Fecha de documentacion: 21/Dic/06                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      GLOBAL BANK,                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de GLOBAL BANK o su representante.        */
/************************************************************************/
/*                              PROPOSITO                               */
/************************************************************************/
/*      Este procedimiento permite informar a credito que un dpf ha     */
/*      sufrido un cambio de tasa, en los procesos batch de prorroga    */
/*      e intrucciones de renovacion                                    */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/************************************************************************/

use cob_pfijo
go

if exists ( select 1 from sysobjects where name = 'sp_informa_cambio_tasa' and type = 'P')
   drop proc sp_informa_cambio_tasa
go
create proc sp_informa_cambio_tasa (
       @s_ssn                  int             = NULL,
       @s_user                 login           = 'sa',
       @s_term                 varchar(30)     = 'consola',
       @s_date                 datetime        = NULL,
       @s_srv                  varchar(30)     = 'PRESRV',
       @s_lsrv                 varchar(30)     = 'PRESRV',
       @s_org                  char(1)         = NULL,
       @s_ofi                  smallint        = NULL,
       @s_rol                  smallint        = NULL,
       @t_debug                char(1)         = 'N',
       @t_file                 varchar(10)     = NULL,
       @t_from                 varchar(32)     = NULL,
       @t_trn                  int             = 14470,
       @i_fecha_proceso        datetime        = NULL,
       @i_num_banco            cuenta          = NULL,
       @i_en_linea             char(1)         = 'S'
)
as
declare @w_sp_name              descripcion,
        @w_return               int,
        @w_string               descripcion,
        @w_mensaje              varchar(25),
        @w_error                int,
        @w_fecha_proceso        datetime,
        @w_fecha_hoy            datetime,
        @w_flag                 tinyint, 
        @w_ofi_ant              int,
        @w_user                 login,
        @w_operacion            int,
        @w_estado               catalogo, 
        @w_num_banco            cuenta,
        @w_fecha_crea           datetime,
        @w_fecha_mod            datetime,   
        @w_tasa_ant             float,
        @w_tasa_act             float,
        @w_pdias_upd            int,
        @w_ssn                  int --CVA Abr-3-07

select @w_pdias_upd = pa_int 
from cobis..cl_parametro 
where pa_nemonico = 'DACT'
and   pa_producto = 'PFI'                           

if @@rowcount = 0
   select @w_pdias_upd = 10

--Actualizar el estado de los regitros que ya no se 
--deben seguir intentando procesar
update pf_cambio_tasa
set ct_estado = 'E'
where ct_estado = 'I'
and   datediff(dd,ct_fecha_crea,@i_fecha_proceso) > @w_pdias_upd

select @w_sp_name = 'sp_informa_cambio_tasa',
       @s_user    = isnull(@s_user,'sa'),
       @s_term    = isnull(@s_term,'CONSOLA'),
       @s_date    = isnull(@s_date,@i_fecha_proceso),
       @s_srv     = isnull(@s_srv,@@servername),
       @s_lsrv    = isnull(@s_lsrv,@@servername),
       @s_ofi     = isnull(@s_ofi,99),
       @s_rol     = isnull(@s_rol,1),
       @t_debug   = isnull(@t_debug,'N'),
       @t_file    = isnull(@t_file,'SQR'),
       @t_trn     = isnull(@t_trn,14470)


select @w_fecha_proceso = @i_fecha_proceso,
       @s_date          = @i_fecha_proceso,
       @w_error         = 0

create table #ca_operacion_aux (
op_operacion         int,
op_banco             varchar(24), 
op_toperacion        varchar(10),
op_moneda            tinyint,
op_oficina           int,
op_fecha_ult_proceso datetime ,
op_dias_anio         int,
op_estado            int,
op_sector            varchar(10),
op_cliente           int,
op_fecha_liq         datetime,
op_fecha_ini         datetime ,
op_cuota_menor       char(1),
op_tipo              char(1),
op_saldo             money,     -- LuisG 04.06.2001
op_fecha_fin         datetime,   -- LuisG 04.06.2001
op_base_calculo      char(1) , --lre version estandar 05/06/2001
op_periodo_int       smallint, --lre version estandar 05/06/2001
op_tdividendo        varchar(10)  --lre version estandar 05/06/2001
)

create table #ca_abonos (
ab_secuencial_ing    int,
ab_dias_retencion    int         null,
ab_estado            varchar(10) null,
ab_cuota_completa    char(1)     null
)

CREATE TABLE #det_cus_garantias (            --LIM 01/FEB/2006
       garantia                varchar(64)     NOT NULL,
       tipo                    varchar(64)     NOT NULL,
       tasa                    float           NULL,
       cuenta                  varchar(24)          NULL)   

CREATE TABLE #det_oper_relacion (            --LIM 01/FEB/2006
       op_garantia                varchar(64)     NOT NULL,
       op_tramite                 int             NOT NULL,
       op_tipo                    char(1)         NOT NULL,
       op_toperacion              varchar(10)         NULL,
       op_producto                varchar(10)         NULL,
       op_tasa_asoc               char(1)             NULL,
       op_cuenta                  varchar(24)         NULL)

/* ALMACENA LAS DIFERENCIAS DE INTERES EN LOS REAJUSTES */
create table #interes_proyectado (           --LIM 01/FEB/2006
concepto        varchar(10),
valor           money
)

-------------------------------------------------------------
-- Declaracion de cursor para acceso a la tabla pf_cambio_tasa
-------------------------------------------------------------
declare cursor_ctasa cursor
for select ct_operacion, ct_fecha_crea, ct_num_banco, 
      ct_tasa_ant , ct_tasa_act , ct_fecha_mod , 
           ct_estado
      from pf_cambio_tasa
     where ct_fecha_crea <= @w_fecha_proceso 
       and ct_estado      = 'I'
for read only

open cursor_ctasa
fetch cursor_ctasa into 
      @w_operacion,   @w_fecha_crea,   @w_num_banco, 
      @w_tasa_ant ,   @w_tasa_act  ,   @w_fecha_mod,
      @w_estado   
  

while @@fetch_status != -1
begin
   if @@fetch_status = -2
   begin
     close cursor_ctasa
     deallocate cursor_ctasa
     raiserror ('200001 - Fallo lectura del cursor ', 16, 1)
     return 0
   end  
        --I. CVA Abr-03-07 implementacion para obtener seqnos del kernel
        exec @w_ssn = ADMIN...rp_ssn

        --F. CVA Abr-03-07 implementacion para obtener seqnos del kernel

        select @w_return = 0

     BEGIN TRAN

      exec @w_return = cob_interfase..sp_icredito   -- BRON: 15/07/09  cob_credito..sp_pignoracion_dpf
           @i_operacion      = 'A',
           @s_ssn            = @w_ssn, --CVA Abr-3-07
           @s_user           = @s_user,
           @s_term           = @s_term,
           @s_srv            = @s_srv,
           @s_ofi            = @s_ofi,
           @s_org            = @s_org,
           @s_lsrv           = @s_lsrv,
           @s_rol            = @s_rol,
           @s_date           = @s_date, 
           @i_modo           = 1,
           @i_tasa_actual    = @w_tasa_act,
           @i_tasa_ant       = @w_tasa_ant,
           @i_num_operacion  = @w_num_banco,
           @i_producto       = 14 
                                                 
      if @w_return <> 0
      begin
         select @w_mensaje = 'Error cob_credito..sp_pignoracion_dpf'
         select @w_error   = @w_return
         goto ERROR
      end

      delete from #det_cus_garantias

      delete from #det_oper_relacion

      delete from #ca_operacion_aux

      delete from #ca_abonos

      delete from #interes_proyectado        


      update pf_cambio_tasa
      set ct_estado    = 'P',  --Procesado
          ct_fecha_mod = @i_fecha_proceso
      where ct_operacion = @w_operacion
        and ct_estado    = 'I'
      
      COMMIT TRAN


   --------------------------------
   -- Acceso al siguiente registro
   --------------------------------   
   SIGUIENTE:

   fetch cursor_ctasa into 
      @w_operacion,   @w_fecha_crea,   @w_num_banco, 
      @w_tasa_ant ,   @w_tasa_act  ,   @w_fecha_mod,
      @w_estado
      
end /* fin del while de cursor de tasas */

close cursor_ctasa
deallocate cursor_ctasa    

return @w_error

-------------------
-- Manejo de Error
-------------------
ERROR:

   rollback tran

   exec  sp_errorlog 
         @i_fecha       = @s_date,
         @s_date        = @s_date,
         @i_error       = @w_error, 
         @i_usuario     = @s_user,
         @i_tran        = @t_trn,
         @i_cuenta      = @w_num_banco,
         @i_cta_pagrec  = @w_mensaje, 
         @i_descripcion = @w_sp_name

   GOTO SIGUIENTE

go

