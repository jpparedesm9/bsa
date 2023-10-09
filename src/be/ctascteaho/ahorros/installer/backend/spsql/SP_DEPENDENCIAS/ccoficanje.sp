/************************************************************************/
/*  Archivo:                ccoficanje.sp                               */
/*  Stored procedure:       sp_ofi_canje                                */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas Corrientes                          */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Mantenimiento de Oficinas de Centros de Canje.                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  01/07/2016      Jorge Salazar   Migracion a CEN                     */
/************************************************************************/
use cob_cuentas
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

if object_id('sp_ofi_canje') is not null
    drop procedure sp_ofi_canje
go

create proc sp_ofi_canje (
        @s_ssn          int,
        @s_date         datetime,
        @s_ofi          smallint,
        @s_user         varchar(30),
        @s_term         varchar(10),
        @s_srv          varchar(16) = null,
        @t_debug        char(1) = 'N', 
        @t_file         varchar(14) = null,
        @t_from         varchar(32) = null,
        @t_trn          smallint,
        @i_filial       tinyint = 1,
        @i_opcion       char(2),
        @i_centro       int = null,
        @i_oficina      int = null,       
        @i_ciudad       int = null       
)
as

declare @w_sp_name        varchar(64),
        @w_return         int,
        @w_ruta           int       

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_ofi_canje'

/*  Valida codigo de Transaccion  */
if @t_trn != 2811
  begin
  /*  Error en codigo de transaccion  */
    exec cobis..sp_cerror
     @t_debug= @t_debug,
     @t_file= @t_file,
     @t_from= @t_from,
     @i_num = 201048
     return 201048
  end

/* Se verifica la opcion*/

begin tran
if @i_opcion = 'I' /*Insertar registro*/
   begin       
   
     if exists (select 1 from cob_cuentas..cc_ofi_centro
                where oc_oficina = @i_oficina)
        begin
          /*  Error registro ya existe  */
           exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file= @t_file,
          @t_from= @t_from,
          @i_num    = 351047
          return 351047          
        end
     else
        begin              

          /*Se busca la ruta*/

          select @w_ruta = ci_cod_remesas
          from cobis..cl_ciudad
          where ci_ciudad = @i_ciudad

          if @@error <> 0 or @@rowcount = 0
             begin
             /*  Error registro no existe  */
               exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @t_from,
              @i_num= 351049
              return 351049          
             end

          insert into cob_cuentas..cc_ofi_centro
          values (@i_oficina,@i_centro,@i_ciudad,@w_ruta)

          if @@error <> 0
             begin
          /*  Error insertando relacion oficina - centro de canje  */
               exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @t_from,
              @i_num= 203050
              return 203050         
             end
        end 
        
    /* CLE 09-Nov-05 Registro de transacción de servicio */ 
        insert into cob_cuentas..cc_tran_servicio
               (ts_secuencial,  ts_terminal,    ts_tipo_transaccion, 
        ts_tsfecha,     ts_usuario,     ts_oficina,
        ts_fecha,   ts_remoto_ssn,  ts_cheque_rec, 
        ts_ctacte,  ts_hora)
        values (@s_ssn,     @s_term,    @t_trn, 
        @s_date,        @s_user,    @i_oficina, 
        @s_date,    @i_centro,  @i_ciudad,
        @w_ruta,    getdate()) 
               
        if @@error != 0
    begin
         /* Error en creacion de registro en transaccion de servicio */
         exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 353515
         return 353515
        end  

   end
else if @i_opcion = 'U' /*Actualizar relacion oficina - centro de canje*/
   begin
   
     if not exists (select 1 from cob_cuentas..cc_ofi_centro
                    where oc_oficina = @i_oficina)
        begin
          /*  Error registro no existe  */
           exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file= @t_file,
          @t_from= @t_from,
          @i_num    = 351049
          return 351049          
        end
      else
        begin

          /*Se busca la ruta*/

          select @w_ruta = ci_cod_remesas
          from cobis..cl_ciudad
          where ci_ciudad = @i_ciudad

          if @@error <> 0 or @@rowcount = 0
             begin
             /*  Error registro no existe  */
               exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @t_from,
              @i_num= 351049
              return 351049          
             end

          update cob_cuentas..cc_ofi_centro
          set oc_centro = @i_centro,
              oc_ciudad = @i_ciudad,
              oc_ruta   = @w_ruta
          where oc_oficina = @i_oficina

          if @@error <> 0
             begin
          /*  Error actualizando relacion oficina - centro de canje  */
               exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @t_from,
              @i_num= 205043
              return 205043       
             end

      /* CLE 09-Nov-05 Registro de transacción de servicio */
          insert into cob_cuentas..cc_tran_servicio
                 (ts_secuencial,    ts_terminal,    ts_tipo_transaccion, 
          ts_tsfecha,       ts_usuario,     ts_oficina,
          ts_fecha,     ts_remoto_ssn,  ts_cheque_rec, 
          ts_ctacte,        ts_hora)
          values (@s_ssn,       @s_term,    @t_trn, 
          @s_date,          @s_user,    @i_oficina, 
          @s_date,      @i_centro,  @i_ciudad,
          @w_ruta,      getdate()) 
               
           if @@error != 0
           begin
            /* Error en creacion de registro en transaccion de servicio */
            exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
                @i_num     = 353515
            return 353515
           end  

        end
   end
else if @i_opcion = 'D' /*Eliminar relacion oficina - centro de canje*/
   begin
     if not exists (select 1 from cob_cuentas..cc_ofi_centro
                    where oc_oficina = @i_oficina)
        begin
          /*  Error registro no existe  */
           exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file= @t_file,
          @t_from= @t_from,
          @i_num    = 351049
          return 351049          
        end
      else
        begin

          /*Eliminando relacion oficina-centro de canje*/

          delete from cob_cuentas..cc_ofi_centro
          where oc_oficina = @i_oficina

          if @@error <> 0
             begin
          /*  Error eliminando relacion oficina - centro de canje  */
               exec cobis..sp_cerror
              @t_debug= @t_debug,
              @t_file= @t_file,
              @t_from= @t_from,
              @i_num= 207018
              return 207018       
             end          

      /* CLE 09-Nov-05 Registro de transacción de servicio */
          insert into cob_cuentas..cc_tran_servicio
                 (ts_secuencial,    ts_terminal,    ts_tipo_transaccion, 
          ts_tsfecha,       ts_usuario,     ts_oficina,
          ts_fecha,     ts_hora)
          values (@s_ssn,       @s_term,    @t_trn, 
          @s_date,          @s_user,    @i_oficina, 
          @s_date,      getdate())
               
           if @@error != 0
           begin
            /* Error en creacion de registro en transaccion de servicio */
            exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = @w_sp_name,
                @i_num     = 353515
            return 353515
           end  

        end
   end
else if @i_opcion = 'S' /*Busqueda de informacion*/
   begin
     
     select '503203'      = oc_oficina,
            '509096' = oc_centro,
            '509092'       = oc_ciudad,
            '509097'         = oc_ruta
     from cob_cuentas..cc_ofi_centro
     where oc_oficina = @i_oficina 
     order by oc_oficina

   end
   
if  @i_opcion = 'S1' /*Busqueda de informacion*/
begin
   set rowcount 20
   
   if @i_oficina is null
      select @i_oficina = 0
      
   select '503203'      = oc_oficina,
          '509096' = oc_centro,
          '509092'       = oc_ciudad,
          '509097'         = oc_ruta
   from  cob_cuentas..cc_ofi_centro
   where oc_oficina > @i_oficina 
   order by oc_oficina
   
   set rowcount 0
end
   
commit tran
return 0
go

