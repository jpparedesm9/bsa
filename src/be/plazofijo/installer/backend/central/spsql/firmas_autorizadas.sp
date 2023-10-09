/************************************************************************/
/*      Archivo:                firmasaut.sp                            */
/*      Stored procedure:       sp_firmas_autorizadas                   */
/*      Base de datos:          cob_pfijo                               */
/*      Disenado por:           Ximena Cartagena U                      */
/*      Fecha de documentacion: 21/Marz/05                              */
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
/*      Este programa procesa las transacciones de INSERT y DELETE      */
/*      a la tabla 'pf_firmas_autorizadas'                              */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR          RAZON                                 */
/*                                Emision Inicial                       */
/*      20/Abr/05  Katty Tamayo   Operaci¢n Search GB-GAPDP00012        */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_firmas_autorizadas')
   drop proc sp_firmas_autorizadas
go

create proc sp_firmas_autorizadas (
@s_ssn                  int         = NULL,
@s_user                 login       = NULL,
@s_sesn                 int         = NULL,
@s_term                 varchar(30) = NULL,
@s_date                 datetime    = NULL,
@s_srv                  varchar(30) = NULL,
@s_lsrv                 varchar(30) = NULL,
@s_ofi                  smallint    = NULL,
@s_rol                  smallint    = NULL,
@t_debug                char(1)     = 'N',
@t_file                 varchar(10) = NULL,
@t_from                 varchar(32) = NULL,
@t_trn                  smallint    = NULL,
@i_operacion            char(1),
@i_cuenta               cuenta,
@i_ente                 int         = NULL,
@i_tipo                 char(1)     = 'A',
@i_modo                 smallint    = NULL,
@i_codigo               int         = NULL,
@i_rol                  char(1)     = NULL,
@i_elimina              char(1)     = 'N'
)
with encryption
as
declare
@w_operacionpf          int,
@w_sp_name              varchar(32),
@w_fecha_crea           datetime,
@w_fecha_mod            datetime,
@w_ced_ruc              numero,
@w_return               int

select @w_sp_name = 'sp_firmas_aut'

------------------------------------
--  VERIFICAR CODIGO DE TRANSACCION 
------------------------------------
if (@i_operacion <> 'I' or @t_trn <> 14162) and 
   (@i_operacion <> 'U' or @t_trn <> 14239) and
   (@i_operacion <> 'D' or @t_trn <> 14345) and
   (@i_operacion <> 'S' or @t_trn <> 14551) and
   (@i_operacion <> 'H' or @t_trn <> 14645)
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 1
end

select @w_ced_ruc = en_ced_ruc     
  from cobis..cl_ente
 where en_ente = @i_ente


if @i_operacion = 'I'
begin
   --------------------------------------------------------
   -- Verificar Existencia de la Operacion de Plazo Fijo --
   --------------------------------------------------------
   select @w_operacionpf = ot_operacion
     from pf_operacion_tmp
    where ot_usuario   = @s_user
      and ot_sesion    = @s_sesn
      and ot_num_banco = @i_cuenta
      
   if @@rowcount = 0
   begin
      --ERROR : NO EXISTE OPERACION DE PLAZO FIJO
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141004
      return 1
   end

   --------------------------------
   -- Insertar en Tabla Temporal --
   --------------------------------
   insert into pf_firmas_autorizadas_tmp(ft_usuario,   ft_sesion,  ft_operacion,
                                         ft_ente,      ft_estado,  ft_fecha_crea,   
                                         ft_fecha_mod, ft_ced_ruc, ft_rol)
                                  values(@s_user,      @s_sesn,    @w_operacionpf,   
                                         @i_ente,      'I',        @s_date,   
                                         @s_date,      @w_ced_ruc, 'F')
   if @@error <> 0
   begin
      exec cobis..sp_cerror 
           @t_debug = @t_debug,    
           @t_file  = @t_file,
           @t_from  = @w_sp_name, 
           @i_num   = 143059

      select @w_return = 1
      rollback tran
      return @w_return
   end   
end

if @i_operacion = 'H'
begin
   select @w_operacionpf = op_operacion
     from pf_operacion
    where op_num_banco = @i_cuenta
         
   if @@rowcount = 0
   begin
      --ERROR : NO EXISTE OPERACION DE PLAZO FIJO
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141004
      return 1
   end
   else   --Operacion si existe
   begin
      if @i_tipo = 'A'
      begin
         set rowcount 20
         if @i_modo = 0
         begin
            /* Extrae los primeros veinte beneficiarios  */
            select 'CONDICION'  = df_descondi, 
                   'CLIENTE'    = fi_ente,
                   'NOMBRE'     = ltrim(rtrim(p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre)),
                   'CEDULA'     = fi_ced_ruc,
                   'NUM. CONDICION' = df_condicion
              from pf_firmas_autorizadas,pf_det_condfirmas, cobis..cl_ente
             where fi_operacion = @w_operacionpf
               and fi_ente      = en_ente 
               and fi_operacion = df_operacion
               and df_ente      = fi_ente
             order by df_condicion 
         end
         if @i_modo = 1
         begin
            select 'CONDICION'  = df_descondi, 
                   'CLIENTE'    = fi_ente,
                   'NOMBRE'     = ltrim(rtrim(p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre)),
                   'CEDULA'     = fi_ced_ruc  
              from pf_firmas_autorizadas, pf_det_condfirmas, cobis..cl_ente
             where fi_operacion = @w_operacionpf
               and fi_ente      = en_ente  
               and fi_operacion = df_operacion
               and df_ente      = fi_ente
               and fi_ente      > @i_codigo
             order by df_condicion
         end
         set rowcount 0 
         return 0   
      end
            
      if @i_tipo = 'V'
      begin
         select ltrim(rtrim(p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre))
           from pf_firmas_autorizadas, pf_det_condfirmas, cobis..cl_ente
          where fi_operacion = @w_operacionpf
            and fi_ente      = en_ente  
            and fi_operacion = df_operacion
            and df_ente      = fi_ente
            and fi_ente      = @i_codigo
          order by df_condicion
               
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 141130
                 /* 'No existe dato solicitado ' */
            return 1
         end
         return 0
      end 
   end
end


if @i_operacion = 'S'
begin
   select @w_operacionpf = op_operacion
     from pf_operacion
    where op_num_banco   = @i_cuenta
         
   if @@rowcount = 0
   begin
      --ERROR : NO EXISTE OPERACION DE PLAZO FIJO
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141004
      return 1
   end
   else   --Operacion si existe
   begin
      select 'CONDICION'  = be_condicion, 
             'CLIENTE'    = be_ente,
             'NOMBRE'     = case when en_nomlar = '' 
                            then ltrim(rtrim(p_p_apellido +' '+ p_s_apellido + ' '+ en_nombre))
                            else en_nomlar
                            end,
             'CEDULA'     = en_ced_ruc
--             'NUM. CONDICION' = df_condicion
        from pf_beneficiario, cobis..cl_ente
       where be_operacion = @w_operacionpf
         and be_ente      = en_ente 
         and be_tipo      = 'F'
         and be_estado   <> 'E'
         and be_estado_xren = 'N'
       order by be_secuencia --CVA
      return 0   
   end
end

go 
