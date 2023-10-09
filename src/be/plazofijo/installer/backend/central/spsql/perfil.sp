/************************************************************************/
/*  Archivo               : perfil.sp                                   */
/*  Stored procedure      : sp_perfil                                   */
/*  Base de datos         : cobis                                       */
/*  Producto              : Plazo Fijo                                  */
/*  Disenado por          : Miguel Viejo M.                             */
/*  Fecha de documentacion: 05/Dic/95                                   */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                          PROPOSITO                                   */
/*  Realiza operaciones de consulta de los perfiles contables           */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR              RAZON                               */
/*  05/Dic/1995  M. Viejo           Emision Inicial                     */
/*  14-Jun-2016  N. Silva           Porting DAVIVIENDA                  */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where name = 'sp_perfil' )
   drop proc sp_perfil
go

create proc sp_perfil (
@s_ssn             int         = null,
@s_user            login       = null,
@s_ofi             smallint    = null,
@s_date            datetime    = null,
@s_srv             varchar(30) = null,
@s_term            varchar(30) = null,
@t_file            varchar(10) = null,
@t_from            varchar(32) = null,
@t_debug           char(1)     = 'N',
@t_rty             char(1)     = 'N', 
@t_trn             int,
@i_empresa         tinyint,
@i_operacion       char(1), 
@i_tran            smallint    = null,
@i_perfil          varchar(10) = null,
@i_estado          char(1)     = null,
@i_tipo_trn        varchar(10) = null,
@i_trn_rec         varchar(10) = null,
@i_descripcion     varchar(64) = null)
with encryption
as
declare
@w_sp_name         descripcion,
@w_return          tinyint,
@w_existe          tinyint,
@w_error           int
 
select @w_sp_name = 'sp_perfil'

if @t_trn <> 14935
begin
   select @w_error =  141018
   GOTO ERROR
end

if exists(select * 
          from pf_tranperfil 
          where tp_tran   = @i_tran 
            and tp_estado = @i_estado) 
   select @w_existe = 1
else 
   select @w_existe = 0

if @i_operacion = 'I'
begin
   if @w_existe =  1
   begin
      select @w_error =  149058
      GOTO ERROR
   end
   else begin
  
      begin tran 

         insert into pf_tranperfil (tp_tran   , tp_estado, tp_perfil, tp_tipo_trn,                                                                                                                                                                                                                                                              
                                    tp_trn_rec)
                            values (@i_tran   , @i_estado, @i_perfil, @i_tipo_trn,
                                    @i_trn_rec) 
         if @@error <> 0
         begin
            select @w_error =  149059
            GOTO ERROR
         end
     
      commit tran 
      return 0
   end
end

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin 
      select @w_error =  149060
      GOTO ERROR
   end
   else begin

      begin tran 

         delete from pf_tranperfil 
          where tp_tran   = @i_tran
            and tp_perfil = @i_perfil 
            and tp_estado = @i_estado 
         
         if @@error <> 0
         begin
            select @w_error =  149061
            GOTO ERROR
         end
        
      commit tran 
      return 0
   end
end
if @i_operacion = 'A'
begin
   select 'TIPO TRANS'  = eq_valor_arch, 
          'DESCRIPCION' = eq_descripcion
     from cob_conta_super..sb_equivalencias
    where eq_catalogo  = 'CATEXTERNO'
      and eq_valor_cat = 'TIPTRANS'
    order by eq_valor_arch
   return 0
end

if @i_operacion = 'R' 
begin
   select eq_descripcion
     from cob_conta_super..sb_equivalencias
    where eq_catalogo   = 'CATEXTERNO'
      and eq_valor_cat  = 'TIPTRANS'
      and eq_valor_arch = @i_trn_rec
   if @@rowcount = 0 
   begin
      select @w_error = 141040
      goto ERROR
   end
   return 0
end  
if @i_operacion = 'S'
begin
   select 'CODIGO DE OPERACION'   = tp_tran,
          'DESCRIPCION OPERACION' = tn_descripcion,
          'PERFIL CONTABLE'       = tp_perfil,
          'DESCRIPCION PERFIL'    = pe_descripcion,
          'TIPO'                  = tp_estado,
          'TIPO TRN.'             = tp_tipo_trn,                                                                                                                                                                                                                                                              
          'TRN. REC'              = tp_trn_rec
     from pf_tranperfil, 
          cobis..cl_ttransaccion, 
          cob_conta..cb_perfil
    where tp_tran     = tn_trn_code 
      and tp_perfil   = pe_perfil 
      and pe_empresa  = @i_empresa 
      and pe_producto = 14 
    order by tp_perfil, tp_tran 

   return 0 
end


if @i_operacion = 'V'
begin 
   select substring(pe_descripcion,1,50)
     from cob_conta..cb_perfil
    where pe_empresa  = @i_empresa 
      and pe_producto = 14 
      and pe_perfil   = @i_perfil

   if @@rowcount = 0  
   begin
      select @w_error =  149078
      GOTO ERROR
   end 
   
   return 0
end


if @i_operacion = 'H' 
begin 
   select 'PERFIL'      = pe_perfil,
          'DESCRIPCION' = pe_descripcion 
     from cob_conta..cb_perfil
    where pe_empresa  = @i_empresa 
      and pe_producto = 14 
    order by pe_perfil 
 
   return 0
end


                                                                                                                                                                                                                                                         
if @i_operacion = 'B'
begin                                                                                                                                                                                                                                                         
   select 'PERFIL'      = pe_perfil,                                                                                                                                                                                                                                 
          'DESCRIPCION' = pe_descripcion                                                                                                                                                                                                                             
     from cob_conta..cb_perfil
    where pe_empresa     = @i_empresa
      and pe_producto    = 14
      and pe_descripcion like @i_descripcion
    order by pe_perfil    
   return 0                                                                                                                                                                                                                                     
end 

ERROR:
   exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = @w_error
   return @w_error
go
