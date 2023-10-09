/******************************************************************/ 
/*  Archivo:              i_transferencia.sp                      */
/*  Stored procedure:     sp_ins_transferencias                   */
/*  Base de datos:        cob_pfijo                               */
/*  Producto:             Plazo Fijo                              */
/*  Disenado por:         N. Silva                                */
/*  Fecha:                21-Abr-2003                             */
/******************************************************************/
/*                         IMPORTANTE                             */
/*  Esta Aplicacion es parte de los paquetes bancarios propiedad  */
/*  de MACOSA, representantes exclusivos para  el Ecuador de  la  */
/*  NCR CORPORATION.  Su uso  no  autorizado queda  expresamente  */
/*  prohibido asi como cualquier alteracion o agregado hecho por  */
/*  alguno  de sus  usuarios  sin el debido  consentimiento  por  */
/*  escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su  */
/*  representante                                                 */
/******************************************************************/
/*                          PROPOSITO                             */
/*  Este stored procedure inserta el detalle de transferencias    */
/*  las mismas que serviran para ingresar operativamente los      */
/*  mensajes Swift.                                               */
/******************************************************************/
/*                       MODIFICACIONES                           */
/*  FECHA          AUTOR           RAZON                          */
/*  21-Abr-2003    N. Silva        Emision Inicial                */
/*  21-Feb-2007    H.Ayarza        Aumento @w_tr_cta_corresp      */
/*                                 varchar(34).                   */
/******************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_ins_transferencias')
   drop proc sp_ins_transferencias
go

create proc sp_ins_transferencias
(
   @s_ssn        int          = NULL,
   @s_date       datetime     = NULL,
   @s_user       login        = NULL,
   @s_term       descripcion  = NULL,
   @s_corr       char(1)      = NULL,
   @s_sesn       int          = NULL,
   @s_ssn_corr   int          = NULL,
   @s_ofi        smallint     = NULL,        -- GAL 31/AGO/2009 - RVVUNICA
   @t_rty        char(1)      = NULL,
   @t_trn        smallint     = NULL,
   @t_debug      char(1)      = 'N',
   @t_file       varchar(14)  = NULL,
   @t_from       varchar(30)  = NULL,
   @i_cuenta     cuenta       = '0',     -- Codigo de Operacion
   @i_moneda     tinyint      = 0,       -- Moneda en la que se negocia la operacion
   @i_tipo_oper  char(1)      = NULL,    -- Si la operacion es modificacion de datos.
   @i_accion     char(1)      = NULL,    -- Si la accion realizada es incremento de capital.
   @i_tipo_pago  char(1)      = 'I',     -- Tipo de pago que se esta haciendo Interes, Capital
   @i_param1     varchar(255) = NULL, -- Parametro 1
   @i_param2     varchar(255) = NULL, -- Parametro 2 
   @i_param3     varchar(255) = NULL, -- Parametro 3 
   @i_param4     varchar(255) = NULL, -- Parametro 4 
   @i_param5     varchar(255) = NULL, -- Parametro 5 
   @i_param6     varchar(255) = NULL, -- Parametro 6 
   @i_param7     varchar(255) = NULL, -- Parametro 7 
   @i_param8     varchar(255) = NULL, -- Parametro 8 
   @i_param9     varchar(255) = NULL, -- Parametro 9 
   @i_param10    varchar(255) = NULL, -- Parametro 10
   @i_param11    varchar(255) = NULL, -- Parametro 11
   @i_param12    varchar(255) = NULL  -- Parametro 12
)
with encryption
as 
/* Declaracion de variables de uso Interno */ 
declare  @w_return      int,            -- valor que retorna
   @w_sp_name     varchar(32),    -- nombre del stored procedure 
   @w_cont        tinyint,        -- contador numero de registros
   @w_cadena      varchar(255),   -- registro de proceso 
   @w_parametro      tinyint,        -- contador numero de campos 
   @w_posicion    smallint,       -- posicion del separador 
   @w_token    varchar(255),   -- campo de proceso 
        @w_cta_corresp          varchar(34),
        @w_cod_corresp          catalogo,
        @w_benef_corresp        varchar(64),
        @w_ofic_corresp         int,
        @w_operacionpf          int,
        @w_secuencial           int,
        @w_monto                money,
        @w_sec_pago             int,
        @w_porcentaje           float
/* Asignar el nombre del stored procedure */
select  @w_sp_name = 'sp_ins_transferencias'
/*------------------------*/
/*  TIPO DE TRANSACCION   */
/*------------------------*/
if @t_trn <> 14299
begin
    /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 14299
    return 1
end


-----------------------------------------------
-- Obtener el codigo de operacion de Depositos
-----------------------------------------------


select @w_operacionpf = op_operacion
from pf_operacion
where op_num_banco = @i_cuenta 
if @@rowcount = 0
begin
  /**  ERROR : NO EXISTE OPERACION DE PLAZO FIJO  **/
  exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 141051
  return 1
end

if @i_tipo_oper = 'D' 
begin
   BEGIN TRAN
   delete cob_pfijo..pf_transferencias_tmp
   where tr_cod_operacion = @w_operacionpf
     and tr_usuario       = @s_user 
     and tr_sesion        = @s_sesn
     and tr_tipo_pago     = @i_tipo_pago

   COMMIT TRAN
   return 0
end

if @i_tipo_oper = 'R' 
begin
   BEGIN TRAN
   delete cob_pfijo..pf_transferencias_tmp
   where tr_cod_operacion = @w_operacionpf
     and tr_tipo_pago     = @i_tipo_pago

   COMMIT TRAN
   return 0
end

select @w_cont = 1
begin tran
    ----------------------------------
    -- Lazo para proceso de registros
    ----------------------------------
    while @w_cont <= 12
    begin
        if @w_cont = 1
            select @w_cadena = @i_param1
        else
        if @w_cont = 2
            select @w_cadena = @i_param2
        else
        if @w_cont = 3
            select @w_cadena = @i_param3   
        else
        if @w_cont = 4
            select @w_cadena = @i_param4
        else
        if @w_cont = 5
            select @w_cadena = @i_param5
        else
        if @w_cont = 6
            select @w_cadena = @i_param6
        else
        if @w_cont = 7
            select @w_cadena = @i_param7
        else
        if @w_cont = 8
            select @w_cadena = @i_param8
        else
        if @w_cont = 9
            select @w_cadena = @i_param9
        else
        if @w_cont = 10
            select @w_cadena = @i_param10
        else
        if @w_cont = 11
            select @w_cadena = @i_param11
        else
        if @w_cont = 12
            select @w_cadena = @i_param12
        ------------------------------------
        -- si la cadena es no nula procesar
        ------------------------------------
        if @w_cadena is not null
        begin
            select @w_parametro = 0
            while @w_parametro < 7     /* 5 columnas del grid */
            begin
                select @w_parametro = @w_parametro + 1
                select @w_posicion = charindex('@', @w_cadena)
                select @w_token = substring(@w_cadena, 1, @w_posicion-1)
                if @w_parametro = 1
                    select @w_cod_corresp = @w_token
                if @w_parametro = 2
                    select @w_cta_corresp = @w_token
                if @w_parametro = 3
                    select @w_benef_corresp = @w_token
                if @w_parametro = 4
                    select @w_ofic_corresp = convert(smallint, @w_token)
                if @w_parametro = 5
                    select @w_monto = convert(money, @w_token)
                if @w_parametro = 6 
                    select @w_sec_pago = convert(int, @w_token)
                if @w_parametro = 7
                    select @w_porcentaje = convert(float, @w_token)
                select @w_cadena = substring(@w_cadena, @w_posicion+1, datalength(rtrim(@w_cadena)))
            end     /* fin del while -numero de campos a procesar- */
            ---------------------------------------------------------------
       -- Se determina un secuencial para cada registro en esta tabla
            ---------------------------------------------------------------
       exec @w_return = cobis..sp_cseqnos
                 @t_debug     = @t_debug,
                 @t_file      = @t_file,
                 @t_from      = @t_from,
                 @i_tabla     = 'pf_transferencias',
                 @o_siguiente = @w_secuencial out
         
            ----------------------------------------------------
            -- Insertar en la tabla temporal el registro actual
            ----------------------------------------------------
            insert into pf_transferencias_tmp 
                   (tr_cod_transf , tr_cod_operacion, tr_moneda       , tr_fecha,
                    tr_cod_corresp, tr_cta_corresp  , tr_benef_corresp, tr_ofic_corresp,
                    tr_estado     , tr_monto        , tr_accion       , tr_sec_pago,
                    tr_act_sec    , tr_porcentaje   , tr_sec_mov      , tr_act_sec_mm,
                    tr_usuario    , tr_sesion       , tr_tipo_pago)
            values (@w_secuencial , @w_operacionpf  , @i_moneda       , @s_date,
                    @w_cod_corresp, @w_cta_corresp  , @w_benef_corresp, @w_ofic_corresp,
                    'V'           , @w_monto        , @i_accion       , @w_sec_pago,
                    'N'           , @w_porcentaje   , @w_sec_pago     , 'N',
                    @s_user       , @s_sesn         , @i_tipo_pago)
            /* Si se produce un error en la insercion */
            if @@error <> 0
            begin
                /* 'Error en insercion de detalle temporal de titulos' */
                exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @t_from,
                @i_num    = 143052
                rollback
                return 1
            end            
        end    /* fin del if -cadena no nula- */
        select @w_cont = @w_cont + 1
    end  /* fin del while -numero de registros a procesar- */

commit tran

return 0
go
