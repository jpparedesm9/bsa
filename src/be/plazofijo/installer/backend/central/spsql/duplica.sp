/************************************************************************/
/*      Archivo:                duplica.sp                              */
/*      Stored procedure:       sp_duplica                              */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Myriam Davila                           */
/*      Fecha de documentacion: 10/Nov/94                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      para la emision de un duplicado del documento de apertura de    */
/*      un certificado de depositos a plazo.                            */
/*                                                                      */
/*                                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*      FECHA                   AUTOR              RAZON                */
/*     10/Nov/94            Roxana Serrano     Emision Inicial          */
/*     14/Oct/98            Dolores Guerrero   Actualiza preimpreso     */
/*                                                                      */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_duplica')
   drop proc sp_duplica
go


create proc sp_duplica (
      @s_ssn                  int         = NULL,
      @s_user                 login       = NULL,
      @s_term                 varchar(30) = NULL,
      @s_date                 datetime    = NULL,
      @s_srv                  varchar(30) = NULL,
      @s_lsrv                 varchar(30) = NULL,
      @s_ofi                  smallint    = NULL,
      @s_rol                  smallint    = NULL,
      @t_debug                char(1)     = 'N',
      @t_file                 varchar(10) = NULL,
      @t_from                 varchar(32) = NULL,
      @t_trn                  smallint,
      @i_num_banco            cuenta,
      @i_preimpreso           int         = NULL,
      @i_observacion          descripcion = NULL,
      @i_actualiza_imp_orig   char(1)     = NULL,
      @i_autorizado           login       = '',       -- GES 05/16/01 CUZ-012-005
      @i_filial               int         = 1,        -- JSA 14/01/2002 ingresando si es bco o off
      @i_operacion            char(1)     = NULL,     -- GAR 16-feb-2005
      @i_serienum             money       = NULL,     -- GAL 17/SEP/2009 - INTERFAZ - INVCERT
      @o_npreimpreso          int         = NULL out, -- GAR 16-feb-2005
      @o_validado             char(1)     = NULL out  -- GAL 17/SEP/2009 - INTERFAZ - INVCERT
)
with encryption
as
declare         
   @w_sp_name              varchar(32),
   @w_codigo               int,
   @w_operacionpf          int,
   @w_op_fecha_valor       datetime,
   @w_fecha_mod            datetime,
   @w_duplicados           int,
   @w_op_historia          int,
   @w_num_imp_orig         int,
   @w_op_ley               char,
   @w_operacion            int,
   @w_op_toperacion        catalogo,    -- DP000024-018
   @w_return               int,
   @w_instr_cdt            tinyint,     -- GAL 17/SEP/2009 - INTERFAZ - INVCERT
   @w_subtipo_instr_cdt    tinyint      -- GAL 17/SEP/2009 - INTERFAZ - INVCERT

select @w_sp_name = 'sp_duplica'

if @t_trn <> 14902 and @t_trn <> 14944 and @t_trn <> 14456
begin
   exec cobis..sp_cerror
      @t_debug      = @t_debug,
      @t_file       = @t_file,
      @t_from       = @w_sp_name,
      @i_num        = 141018

   /*  'Error en codigo de transaccion' */
   return 1
end

-- INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO CERTIFICADOS DE DEPOSITO A TERMINO - GAL 17/SEP/2009 - INTERFAZ - INVCERT
select @w_instr_cdt = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'INCDT'
and   pa_producto = 'PFI'

-- SUBTIPO DE INSTRUMENTO DE SERVICIOS BANCARIOS ASOCIADO A CERTIFICADOS DE DEPOSITO A TERMINO - GAL 17/SEP/2009 - INTERFAZ - INVCERT
select @w_subtipo_instr_cdt = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'SINCDT'
and   pa_producto = 'PFI'


/* Verificacion de la existencia de la operacion y conversion a entero */

select @w_operacionpf    = op_operacion,
       @w_duplicados     = op_duplicados,
       @w_op_historia    = op_historia,
       @w_fecha_mod      = op_fecha_mod,
       @w_num_imp_orig   = op_num_imp_orig,
       @w_operacion      = op_operacion,
       @w_op_fecha_valor = op_fecha_valor,
       @w_op_ley         = isnull(op_ley, 'S'),
       @w_op_toperacion  = op_toperacion,    -- GES 06/08/01 DP000024-017
       @w_duplicados     = isnull(op_duplicados,1)
from cob_pfijo..pf_operacion
where op_num_banco = @i_num_banco

if @@rowcount = 0
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name, 
    @i_num   = 141051
  return 1
end
--GAR 16-feb-2005

if @i_operacion = 'I'
begin
   exec @w_return = cobis..sp_cseqnos
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_tabla     = 'pf_npreimpreso',
      @o_siguiente = @o_npreimpreso out

   if @w_return <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141174
         
      return 1
   end

   select @o_npreimpreso = @o_npreimpreso + 1
   select @o_npreimpreso 
   return 0
end

-- INICIO - GAL 17/SEP/2009 - INTERFAZ - INVCERT
if @i_operacion = 'V'               -- VALIDA QUE EL NUMERO DE SERIE ESTE DISPONIBLE
begin
   
   exec @w_return = cob_sbancarios..sp_buscar_series
      @s_user        = @s_user,
      @s_ofi         = @s_ofi,
      @t_trn         = 29300,
      @i_operacion   = 'V',
      @i_producto    = 4,                       -- SERVICIOS BANCARIOS
      @i_instrumento = @w_instr_cdt, 
      @i_subtipo     = @w_subtipo_instr_cdt,
      @i_serienum    = @i_serienum
     
   if @w_return <> 0
   begin
      select @o_validado = 'N'
         
      return 1
   end

   select @o_validado = 'S'
   
   return 0
end

if @i_operacion = 'D'               -- DESCUENTA DEL INVENTARIO EL CDT CON LA SERIE INDICADA
begin
   
   exec @w_return = cob_sbancarios..sp_invent_utl
      @s_date         = @s_date,
      @s_user         = @s_user, 
      @s_ssn          = @s_ssn,
      @s_term         = @s_term,
      @s_srv          = @s_srv,
      @s_lsrv         = @s_lsrv,
      @s_ofi          = @s_ofi,
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_trn          = 29350,
      @i_instrumento  = @w_instr_cdt,            -- COD. DE INSTRUMENTO CDT
      @i_subtipo      = @w_subtipo_instr_cdt,    -- COD. DE SUBTIPO DE INSTR CDT
      @i_serie_desde  = @i_serienum,             -- SERIE DESDE
      @i_serie_hasta  = @i_serienum,             -- SERIE HASTA
      @i_prod_destino = 14                       -- MOD.COBIS QUE USO EL INSTRUMENTO

     
   if @w_return <> 0
   begin
      return 1
   end

end
 
begin tran

      

/* transaccion de servicio con los datos anteriores - pf_operacion */
insert into ts_operacion (
secuencial, 	tipo_transaccion, 	clase, 
fecha, 		usuario,		terminal, 
srv, 		lsrv,			duplicados,
historia,	fecha_mod,		operacion,
descripcion)
values     
(@s_ssn, 	@t_trn, 		'A', 
@s_date, 	@s_user, 		@s_term,
@s_srv, 	@s_lsrv,		@w_duplicados, 
@w_op_historia, @w_fecha_mod,		@w_operacionpf,
convert(varchar(30), @i_serienum))

/* Si no se puede insertar transaccion de servicio, ERROR */
if @@error <> 0 begin 
     exec cobis..sp_cerror
     @t_debug  = @t_debug,
     @t_file   = @t_file,
     @t_from   = @w_sp_name,
     @i_num = 143005
     return 1
end


select @i_observacion = 'Imp.No. ' + convert(varchar(20),@i_serienum) + ' ' + @i_observacion

/* Creacion del registro en pf_historia */
insert into pf_historia (hi_operacion, 
hi_secuencial,	hi_fecha,	hi_trn_code,  
hi_valor,	hi_funcionario,	hi_oficina,
hi_fecha_crea,  hi_fecha_mod,	hi_observacion)
values  
(@w_operacionpf,	@w_op_historia, 	@s_date,
@t_trn,			null,			@s_user,
@s_ofi,			@s_date,		@s_date,
@i_observacion)

if @@error <> 0 begin
  /* 'Error en creacion de registro en pf_historia' */
  exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file     = @t_file,
   @t_from     = @w_sp_name,
   @i_num      = 143006
  return 1
end 

if @w_duplicados = 99
   select @w_duplicados = 1
else
   select @w_duplicados = @w_duplicados + 1

 /* INSERTAR EN LA TABLA DE NUMEROS PREIMPRESOS */
insert into pf_npreimpreso(
np_operacion, 		np_secuencial, 		np_preimpreso, 
np_observacion, 	np_toperacion, 		np_hora, 
np_usuario, 		np_fecha) 
values
(@w_operacion, 		@w_duplicados , 	@i_serienum, 
@i_observacion, 	@w_op_toperacion, 			convert(varchar, datepart(hh, getdate())) + ':' + convert(varchar, datepart(mm, getdate())),	
@s_user, 		@s_date)

if @@error <> 0 begin
  /* 'Error en creacion de registro en pf_npreimpreso' */
  exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file     = @t_file,
   @t_from     = @w_sp_name,
   @i_num      = 143024
  return 1
end 


select @w_op_historia = @w_op_historia + 1

update pf_operacion
   set op_duplicados = @w_duplicados,
       op_historia   = @w_op_historia,
       op_preimpreso = @i_serienum,
       op_fecha_mod  = @s_date
 where op_operacion = @w_operacionpf

/* Si no se puede modificar, error */
if @@rowcount <> 1  
begin
   /* Error en actualizacion de pf_operacion */
   exec cobis..sp_cerror
   @t_debug    = @t_debug,
   @t_file     = @t_file,
   @t_from     = @w_sp_name,
   @i_num      = 145001
   
   return 1
end 

commit tran

return 0   

go

